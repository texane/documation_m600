/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 14:20:06 2009 texane
** Last update Sat Nov 14 11:36:07 2009 texane
*/



#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "m600.h"
#include "../../common/m600_types.h"



static void print_usage(const char* s)
{
  printf("usage: %s <read_card [card_count]>|<read_alarms>\n", s);
}


static const char* alarm_to_string(unsigned int a)
{
  const char* s = "UNKNOWN_ALARM";

  switch (a)
    {
#define ALARM_CASE(E)				\
    case M600_ALARM_ ## E:			\
      s = #E;					\
      break

      ALARM_CASE(ERROR);
      ALARM_CASE(HOPPER_CHECK);
      ALARM_CASE(MOTION_CHECK);

    default: break;
    }

  return s;
}


static void print_alarms(m600_alarms_t alarms)
{
  unsigned int a;

  printf("alarms:\n");
  for (a = 0; a < M600_ALARM_MAX; ++a)
    {
      if (alarms & (1 << a))
	printf(" %s\n", alarm_to_string(a));
    }
}


static int on_card(const uint16_t* data, m600_alarms_t alarms, void* ctx)
{
  /* called for each read card
     data the card column data
   */

  unsigned int i;

  /* unused */
  ctx = ctx;

  if (alarms)
    {
      print_alarms(alarms);

      /* stop reading */
      return -1;
    }

  for (i = 0; i < M600_COLUMN_COUNT; ++i, ++data)
    {
      if (!(i % 10))
	{
	  if (i)
	    printf("\n");
	  printf("[%02x]: ", i);
	}
      printf(" %03x", *data);
    }
  printf("\n");

  /* continue reading */
  return 0;
}


int main(int ac, char** av)
{
  int res = -1;

  if (m600_initialize("/dev/ttyUSB0") == -1)
    goto on_error;

  if (ac == 1)
    {
      print_usage(av[0]);
      goto on_error;
    }

  if (!strcmp(av[1], "read_card"))
    {
      unsigned int count = 1;

      if (ac >= 3)
	count = atoi(av[2]);

      if (m600_read_card(count, on_card, NULL) == -1)
	goto on_error;
    }
  else if (!strcmp(av[1], "read_alarms"))
    {
      m600_alarms_t alarms;

      if (m600_read_alarms(&alarms) == -1)
	goto on_error;

      print_alarms(alarms);
    }
  else
    {
      print_usage(av[0]);
      goto on_error;
    }

  res = 0;

 on_error:

  m600_cleanup();

  return res;
}
