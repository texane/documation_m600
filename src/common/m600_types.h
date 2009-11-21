/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 15:33:43 2009 texane
** Last update Sat Nov 21 08:55:33 2009 texane
*/



#ifndef M600_TYPES_H_INCLUDED
# define M600_TYPES_H_INCLUDED



/* include stdint before */


/* alarms */

#define M600_ALARM_NONE 0

#define M600_ALARM_ERROR 0
#define M600_ALARM_HOPPER_CHECK 1
#define M600_ALARM_MOTION_CHECK 2
#define M600_ALARM_MAX 3

#define M600_SET_ALARM(A, B) do { A |= 1 << M600_ALARM_ ## B; } while (0)
#define M600_IS_ALARM(A, B) ((A) & (1 << M600_ALARM_ ## B))

typedef uint16_t m600_alarms_t;


/* for testing, 4 ports * 8 pins */

#define M600_PIN_COUNT 32


/* protocol related types */

#define M600_REQ_READ_CARD 0
#define M600_REQ_READ_ALARMS 1
#define M600_REQ_FILL_DATA 2
#define M600_REQ_READ_PINS 3
#define M600_REQ_INVALID (m600_request_t)-1
typedef uint8_t m600_request_t;

struct m600_reply
{
  m600_alarms_t alarms;

  /* little endian */
#define M600_COLUMN_COUNT 80
  uint16_t card_data[M600_COLUMN_COUNT];

}
#ifndef SDCC
__attribute__((packed))
#endif
;

typedef struct m600_reply m600_reply_t;



#endif /* ! M600_TYPES_H_INCLUDED */
