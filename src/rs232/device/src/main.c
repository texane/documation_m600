/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Sun Sep 20 14:08:30 2009 texane
** Last update Sat Nov 21 17:01:20 2009 texane
*/



#include <pic18fregs.h>
#include "config.h"
#include "int.h"
#include "osc.h"
#include "serial.h"
#include "m600.h"



#if 0

static void toggle_led(void)
{
  static unsigned int ledc = 0;
  static unsigned char ledv = 0;

  if (++ledc < 0x4000)
    return ;

  ledv ^= 1;

  TRISA = 0;
  LATA = ledv;
}

#endif


int main(void)
{
  volatile int is_done = 0;
  m600_request_t req;

  osc_setup();
  int_setup();
  m600_setup();

  serial_setup();

  while (!is_done)
    {
      serial_sleep();

      /* not waken by a serial byte being avail */
      if (serial_pop_fifo((unsigned char*)&req) == -1)
	continue ;

      /* process request based on the usb model */
      m600_start_request(req);
      m600_schedule();
    }

  return 0;
}
