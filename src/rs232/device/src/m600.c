/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 14:00:09 2009 texane
** Last update Sat Nov 21 16:25:10 2009 texane
*/



#include <pic18fregs.h>
#include "serial.h"
#include "stdint.h"
#include "../../../common/m600_types.h"



/* m600 globals */

static m600_request_t m600_request = M600_REQ_INVALID;

static m600_reply_t m600_reply;


/* m600 pinouts */

#define M600_PORT_DATA_LOW PORTB
#define M600_TRIS_DATA_LOW TRISB

/* note: some PORTA high bits not
   available and will be read as
   0. since we need to read 12bits
   values, we only care about the
   first nibble.
 */

#define M600_PORT_DATA_HIGH PORTA
#define M600_TRIS_DATA_HIGH TRISA

#define M600_PORT_ALARMS PORTD
#define M600_TRIS_ALARMS TRISD
#define M600_PIN_ERROR PORTDbits.RD0
#define M600_PIN_HOPPER_CHECK PORTDbits.RD1
#define M600_PIN_MOTION_CHECK PORTDbits.RD2

#define M600_TRIS_PICK_CMD TRISDbits.TRISD3
#define M600_PIN_PICK_CMD LATDbits.LATD3

#define M600_TRIS_INDEX_MARK TRISCbits.TRISC0
#define M600_PIN_INDEX_MARK PORTCbits.RC0

#define M600_TRIS_READY TRISCbits.TRISC1
#define M600_PIN_READY PORTCbits.RC1

#define M600_TRIS_BUSY TRISCbits.TRISC2
#define M600_PIN_BUSY PORTCbits.RC2


/* read alarm signals */

static m600_alarms_t m600_read_alarms(void)
{
  m600_alarms_t alarms = M600_ALARM_NONE;

#define SET_ALARM_IF_ASSERTED(E, C)		\
  do {						\
    if (M600_PIN_ ## C)				\
      M600_SET_ALARM(E, C);			\
  } while (0)

  SET_ALARM_IF_ASSERTED(alarms, ERROR);
  SET_ALARM_IF_ASSERTED(alarms, HOPPER_CHECK);
  SET_ALARM_IF_ASSERTED(alarms, MOTION_CHECK);

  return alarms;
}


/* read the 12bits data register */

static uint16_t read_data_reg(void)
{
  return
    (((unsigned int)M600_PORT_DATA_HIGH << 8) |
     M600_PORT_DATA_LOW) & 0x0fff;
}


/* initiate a read cycle and read card contents */

static m600_alarms_t m600_read_card(uint16_t* col_data)
{
  unsigned int col_count = M600_COLUMN_COUNT;

  /* wait for the ready conditions(p.38) */
  while (!M600_PIN_READY)
    ;

  /* wait for previous cycle to end */
  while (M600_PIN_BUSY)
    ;

  /* initiate a read cycle. according
     to the documentation (p.38), it
     is better to wait for the busy
     condition than idling for 1usecs
   */
  M600_PIN_PICK_CMD = 1;

  /* wait for the cycle to start */
  while (M600_PIN_BUSY)
    {
      /* an error occured. 6 attempts are made
	 every 50 ms, for a total of 300ms max
       */

      if (M600_PIN_ERROR)
	{
	  M600_PIN_PICK_CMD = 0;
	  return m600_read_alarms();
	}
    }

  M600_PIN_PICK_CMD = 0;

  /* read the data */
  while (col_count)
    {
      /* wait for the INDEX_MARK signal to
	 become true. it indicates data is
	 available (ie. storage completed).
	 the mark are generated periodically
	 every 864 usecs on the M600.
      */

      if (M600_PIN_INDEX_MARK)
	{
	  /* data available. the index mark
	     signal held true for 6 usecs
	  */
	  while (M600_PIN_INDEX_MARK)
	    ;

	  *col_data = read_data_reg();

	  ++col_data;
	  --col_count;
	}
    }

  return M600_ALARM_NONE;
}


/* exported */

void m600_setup(void)
{
  /* have to do configure the ports as digital
     io, otherwise they will be in analog mode
     esp. PORTA on my own pic18f...
   */

  ADCON0 = 0;
  ADCON1 = 0xf;
  ADCON2 = 0;

  SPPCON = 0;

  /* inputs */
  M600_TRIS_DATA_LOW = 1;
  M600_TRIS_DATA_HIGH = 1;
  M600_TRIS_ALARMS = 1;
  M600_TRIS_INDEX_MARK = 1;
  M600_TRIS_READY = 1;
  M600_TRIS_BUSY = 1;

  /* outputs */

  /* note: must come after the
     alarm tris is set since this
     overlap with same register */

  M600_TRIS_PICK_CMD = 0;

  /* automaton state */

  m600_request = M600_REQ_INVALID;
}


void m600_start_request(m600_request_t req)
{
  m600_request = req;
}


void m600_schedule(void)
{
  unsigned char do_reply;

  switch (m600_request)
    {
    case M600_REQ_READ_CARD:
      {
	m600_reply.alarms = m600_read_card(m600_reply.card_data);

	do_reply = 1;

	break;
      }

    case M600_REQ_READ_ALARMS:
      {
	m600_reply.alarms = m600_read_alarms();

	do_reply = 1;

	break;
      }

    case M600_REQ_FILL_DATA:
      {
	uint16_t i;

	for (i = 0; i < M600_COLUMN_COUNT; ++i)
	  m600_reply.card_data[i] = i;

	do_reply = 1;

	break;
      }

    case M600_REQ_READ_PINS:
      {
	uint8_t* const p = (uint8_t*)m600_reply.card_data;

	p[0] = PORTA;
	p[1] = PORTB;
	p[2] = PORTC;
	p[3] = PORTD;

	do_reply = 1;

	break;
      }

    case M600_REQ_INVALID:
    default:
      {
	do_reply = 0;

	break;
      }

    }

  m600_request = M600_REQ_INVALID;

  if (!do_reply)
    return ;

  /* reply to the host */

  serial_write((unsigned char*)&m600_reply, sizeof(m600_reply_t));
}
