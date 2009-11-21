/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Sun Sep 20 14:08:30 2009 texane
** Last update Wed Nov 11 18:57:28 2009 texane
*/



#include <pic18fregs.h>
#include "config.h"
#include "int.h"
#include "osc.h"
#include "serial.h"
#include "m600.h"



static void toggle_led(unsigned int i)
{
  static unsigned char led = 0;

  led ^= (1 << i);

  TRISA = 0;
  LATA = led;
}



int main(void)
{
  volatile int is_done = 0;

  osc_setup();
  int_setup();
  serial_setup();
  m600_setup();

  while (!is_done)
    {
      m600_request_t req;
      m600_reply_t rep;

      if (m600_read_request(&req) == -1)
	continue ;

      switch (req)
	{
	case M600_REQ_READ_CARD:
	  {
	    toggle_led(0);

	    rep.alarms = m600_read_card(rep.card_data);
	    break;
	  }

	case M600_REQ_READ_ALARMS:
	  {
	    toggle_led(1);

	    rep.alarms = m600_read_alarms();
	    break;
	  }

	default:
	  {
	    break;
	  }
	}

      m600_write_reply(&rep);
    }

  return 0;
}
