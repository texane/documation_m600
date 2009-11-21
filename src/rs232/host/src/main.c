/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 14:20:06 2009 texane
** Last update Sat Nov 21 16:21:20 2009 texane
*/



#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "m600.h"
#include "../../../common/m600_types.h"



static void clear_buffer(uint16_t* buffer)
{
  unsigned int i;

  for (i = 0; i < M600_COLUMN_COUNT; ++i)
    buffer[i] = 0xffff;
}


static int check_buffer(const uint16_t* buffer)
{
  unsigned int i;

  for (i = 0; i < M600_COLUMN_COUNT; ++i)
    {
      if (buffer[i] != (uint16_t)i)
	{
	  printf("@%u 0x%04x\n", i, buffer[i]);
	  return -1;
	}
    }

  return 0;
}


static void print_pins(const uint8_t* buffer)
{
  unsigned int j;

#if 0 /* inline printing */

#define GET_LAST_BIT(N) (((N) & (1 << 7)) >> 7)

  unsigned int i;

  for (i = 0; i < M600_PIN_COUNT / 8; ++i, ++buffer)
    {
      uint8_t n = *buffer;

      for (j = 0; j < 8; ++j, n <<= 1)
	printf("%c", '0' + GET_LAST_BIT(n));

      printf(" ");
    }
#else /* port like printing */

#define GET_FIRST_BIT(N) ((N) & 1)

  int i;
  int k;

  for (k = 1; k >= 0; --k)
    {
      for (i = M600_PIN_COUNT / 8 - 1; i >= 0; --i)
	{
	  uint8_t n = buffer[i] >> k;

	  for (j = 0; j < 4; ++j, n >>= 2)
	    printf("%c", '0' + GET_FIRST_BIT(n));
	  printf(" ");
	}

      printf("\n");
    }
  
#endif

  printf("\n");
}


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
  m600_handle_t* handle = NULL;
  int error = -1;
  uint16_t data[M600_COLUMN_COUNT];

  if (ac == 1)
    {
      print_usage(av[0]);
      goto on_error;
    }

  if (m600_initialize() != M600_ERROR_SUCCESS)
    goto on_error;

  if (m600_open(&handle) != M600_ERROR_SUCCESS)
    goto on_error;

  if (!strcmp(av[1], "read_card"))
    {
      unsigned int count = 1;

      if (ac >= 3)
	count = atoi(av[2]);

      if (m600_read_cards(handle, count, on_card, NULL) != M600_ERROR_SUCCESS)
	goto on_error;
    }
  else if (!strcmp(av[1], "read_alarms"))
    {
      m600_alarms_t alarms;

      if (m600_read_alarms(handle, &alarms) != M600_ERROR_SUCCESS)
	goto on_error;

      print_alarms(alarms);
    }
  else if (!strcmp(av[1], "fill_data"))
    {
      clear_buffer(data);

      if (m600_fill_data(handle, data) != M600_ERROR_SUCCESS)
	goto on_error;

      if (check_buffer(data))
	printf("invalidBuffer\n");
      else
	printf("bufferOk\n");
    }
  else if (!strcmp(av[1], "read_pins"))
    {
      clear_buffer(data);

      if (m600_read_pins(handle, (uint8_t*)data) != M600_ERROR_SUCCESS)
	goto on_error;

      print_pins((const uint8_t*)data);
    }
  else
    {
      print_usage(av[0]);
      goto on_error;
    }

  error = 0;

 on_error:

  if (handle != NULL)
    m600_close(handle);

  m600_cleanup();

  return error;
}
