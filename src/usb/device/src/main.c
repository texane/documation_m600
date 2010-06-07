/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Thu Nov 19 20:03:19 2009 texane
** Last update Mon Jun  7 19:12:04 2010 texane
*/



#pragma stack 0x200 255

#include <pic18fregs.h>
#include "common_types.h"
#include "m600.h"
#include "usb.h"
#include "usb_descriptors.h"



static void initialize(void)
{
  ADCON1 = 0x0F;
  CMCON = 0x07;

  device_descriptor = &boot_device_descriptor;
  configuration_descriptor = boot_configuration_descriptor;
  string_descriptor = boot_string_descriptor;

  ep_init = boot_ep_init;
  ep_in = boot_ep_in;
  ep_out = boot_ep_out;
  ep_setup = boot_ep_setup;
}


#if 0

static void switch_led(void)
{
  static unsigned int ledv = 0;
  static unsigned int ledc = 0;

  ++ledc;

  if (ledc == 0x1000)
    {
      ledv ^= 1;
      ledc = 0;

      TRISAbits.TRISA0 = 0;
      PORTAbits.RA0 = ledv;
    }
}

#endif


void main(void)
{
  initialize();

  init_usb();

  m600_setup();

  while(1)
    {
      INTCON = 0;

      usb_sleep();
      dispatch_usb_event();

      m600_schedule();
    }
}
