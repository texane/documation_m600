/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 16:48:44 2009 texane
** Last update Sat Nov 21 16:19:26 2009 texane
*/



#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/select.h>
#include "serial.h"
#include "m600.h"
#include "debug.h"
#include "../../../common/m600_types.h"



/* wraps serial handle */

struct m600_handle
{
  serial_handle_t serial_handle;
};


/* m600 command */

union m600_cmd
{
  m600_request_t req;
  m600_reply_t rep;
};

typedef union m600_cmd m600_cmd_t;


/* read recv */

static int wait_for_read(serial_handle_t* handle)
{
  /* 2 seconds timeout */

  struct timeval tm;
  int nfds;
  fd_set rds;

  FD_ZERO(&rds);
  FD_SET(handle->fd, &rds);

  tm.tv_sec = 2;
  tm.tv_usec = 0;

  nfds = select(handle->fd + 1, &rds, NULL, NULL, &tm);
  if (nfds != 1)
    return -1;

  return 0;
}


static m600_error_t send_recv_cmd
(
 m600_handle_t* handle,
 m600_cmd_t* cmd
)
{

#define GOTO_ERROR(E)	\
  do {			\
    error = E;		\
    goto on_error;	\
  } while (0)

  m600_error_t error;
  size_t size;

  DEBUG_PRINTF("-- serial_write()\n");

  if (serial_write(&handle->serial_handle, &cmd->req, sizeof(cmd->req), &size) == -1)
    {
      DEBUG_ERROR("serial_write()\n");
      GOTO_ERROR(M600_ERROR_IO);
    }

  if (size != sizeof(cmd->req))
    {
      DEBUG_ERROR("size != sizeof(cmd->req)\n");
      GOTO_ERROR(M600_ERROR_IO);
    }

  DEBUG_PRINTF("-- wait_for_read()\n");

  if (wait_for_read(&handle->serial_handle) == -1)
    {
      DEBUG_ERROR("wait_for_read() == -1\n");
      GOTO_ERROR(M600_ERROR_IO);
    }

  DEBUG_PRINTF("-- serial_read()\n");

  if (serial_readn(&handle->serial_handle, (void*)&cmd->rep, sizeof(cmd->rep)) == -1)
    {
      DEBUG_ERROR("serial_readn() == -1\n");
      GOTO_ERROR(M600_ERROR_IO);
    }

  error = M600_ERROR_SUCCESS;

 on_error:

  return error;
}


/* exported */

m600_error_t m600_initialize(void)
{
  return M600_ERROR_SUCCESS;
}


void m600_cleanup(void)
{
}


m600_error_t m600_open(m600_handle_t** handle /* , const char* devname */ )
{
  static const char* const devname = "/dev/ttyUSB0";

  static serial_conf_t conf =
    { 9600, 8, SERIAL_PARITY_DISABLED, 1 };

  m600_error_t error;

  *handle = malloc(sizeof(m600_handle_t));
  if (*handle == NULL)
    GOTO_ERROR(M600_ERROR_MEMORY);

  if (serial_open(&(*handle)->serial_handle, devname) == -1)
    GOTO_ERROR(M600_ERROR_LIBSERIAL);

  if (serial_set_conf(&(*handle)->serial_handle, &conf) == -1)
    GOTO_ERROR(M600_ERROR_LIBSERIAL);

  return M600_ERROR_SUCCESS;

 on_error:

  if (*handle != NULL)
    {
      m600_close(*handle);
      *handle = NULL;
    }

  return error;
}


void m600_close(m600_handle_t* handle)
{
  serial_close(&handle->serial_handle);
  free(handle);
}


m600_error_t m600_read_alarms
(
 m600_handle_t* handle,
 m600_alarms_t* alarms
)
{
  m600_cmd_t cmd;
  m600_error_t error;

  *alarms = 0;

  cmd.req = M600_REQ_READ_ALARMS;

  error = send_recv_cmd(handle, &cmd);
  if (error != M600_ERROR_SUCCESS)
    return error;

  *alarms = cmd.rep.alarms;

  return M600_ERROR_SUCCESS;
}


m600_error_t m600_read_cards
(
 m600_handle_t* handle,
 unsigned int count,
 m600_cardfn_t on_card,
 void* ctx
)
{
  m600_error_t error;
  m600_cmd_t cmd;

  for (; count; --count)
    {
      cmd.req = M600_REQ_READ_CARD;

      error = send_recv_cmd(handle, &cmd);
      if (error != M600_ERROR_SUCCESS)
	break;

      if (on_card(cmd.rep.card_data, cmd.rep.alarms, ctx))
	break;
    }

  return error;
}


m600_error_t m600_fill_data
(
 m600_handle_t* handle,
 uint16_t* data
)
{
  m600_error_t error;
  m600_cmd_t cmd;

  cmd.req = M600_REQ_FILL_DATA;

  error = send_recv_cmd(handle, &cmd);
  if (error != M600_ERROR_SUCCESS)
    return error;

  memcpy(data, cmd.rep.card_data, sizeof(cmd.rep.card_data));

  return M600_ERROR_SUCCESS;
}


m600_error_t m600_read_pins
(
 m600_handle_t* handle,
 uint8_t* data
)
{
  m600_error_t error;
  m600_cmd_t cmd;

  cmd.req = M600_REQ_READ_PINS;

  error = send_recv_cmd(handle, &cmd);
  if (error != M600_ERROR_SUCCESS)
    return error;

  memcpy(data, cmd.rep.card_data, M600_PIN_COUNT / 8);

  return M600_ERROR_SUCCESS;
}
