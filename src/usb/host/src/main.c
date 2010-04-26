/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 18 15:55:52 2009 texane
** Last update Mon Apr 26 20:03:15 2010 texane
*/



#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "m600.h"
#include "../../../common/m600_types.h"



static const char* __attribute__((unused))
alarm_to_string(unsigned int a)
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


static int on_card(const uint16_t* data, m600_alarms_t alarm, void* ctx)
{
  unsigned int i;

  for (i = 0; i < 80; ++i)
  {
    if (!(i % 8))
      printf("\n");
    printf(" %03x", ((uint16_t)~(data[i])) & 0xfff);
  }

  for (i = 0; i < 80; ++i)
  {
    if (!(i % 10))
      printf("\n");
    printf("%c", ~(data[i]));
  }

  return 0;
}


static void __attribute__((unused))
print_alarms(m600_alarms_t alarms)
{
  unsigned int a;

  printf("alarms:\n");
  for (a = 0; a < M600_ALARM_MAX; ++a)
  {
    if (alarms & (1 << a))
      printf(" %s\n", alarm_to_string(a));
  }
}


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


int main(int ac, char** av)
{
  int error = -1;
  m600_handle_t* handle = NULL;
  const char* const opt = ac == 1 ? "test" : av[1];

  if (m600_initialize() != M600_ERROR_SUCCESS)
    goto on_error;

  if (m600_open(&handle) != M600_ERROR_SUCCESS)
    goto on_error;

  if (!strcmp(opt, "card"))
  {
    if (m600_read_cards(handle, 1, on_card, NULL) != M600_ERROR_SUCCESS)
      printf("error\n");
    else
      printf("succes\n");
  }
  else if (!strcmp(opt, "alarm"))
  {
    m600_alarms_t alarms;

    if (m600_read_alarms(handle, &alarms) != M600_ERROR_SUCCESS)
      goto on_error;

    print_alarms(alarms);
  }
  else if (!strcmp(opt, "test"))
  {
    uint16_t data[M600_COLUMN_COUNT];

    clear_buffer(data);

    if (m600_fill_data(handle, data) != M600_ERROR_SUCCESS)
      goto on_error;

    if (check_buffer(data))
      printf("invalidBuffer\n");
    else
      printf("bufferOk\n");

    clear_buffer(data);

    if (m600_read_pins(handle, (uint8_t*)data) != M600_ERROR_SUCCESS)
      goto on_error;

    print_pins((const uint8_t*)data);
  }
  else
  {
    printf("invalidOption: %s\n", opt);
  }

  error = 0;

 on_error:

  if (handle != NULL)
    m600_close(handle);

  m600_cleanup();

  return error;
}
