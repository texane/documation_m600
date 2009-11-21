/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Tue Nov 17 04:21:01 2009 fabien le mentec
** Last update Sat Nov 21 08:56:37 2009 texane
*/



#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <libusb-1.0/libusb.h>
#include "debug.h"
#include "m600.h"
#include "../../common/m600.h"
#include "../../../common/m600_types.h"



/* m600 handle */

struct m600_handle
{
  libusb_device_handle* usb_handle;
  struct libusb_transfer* req_trans;
  struct libusb_transfer* rep_trans;
  unsigned int ep_req;
  unsigned int ep_rep;
};


/* m600 command */

union m600_cmd
{
  m600_request_t req;
  m600_reply_t rep;
};

typedef union m600_cmd m600_cmd_t;


/* internal globals */

libusb_context* libusb_ctx =  NULL;


/* allocation wrappers */

static m600_handle_t* alloc_m600_handle(void)
{
  m600_handle_t* handle = malloc(sizeof(m600_handle_t));
  if (handle == NULL)
    return NULL;

  handle->usb_handle = NULL;
  handle->req_trans = NULL;
  handle->rep_trans = NULL;

  return handle;
}


static void free_m600_handle(m600_handle_t* handle)
{
  free(handle);
}


/* translate libusb error */

static m600_error_t
 __attribute__((unused))
usb_to_m600_error(enum libusb_error ue)
{
  m600_error_t me;

  switch (ue)
    {
    case LIBUSB_SUCCESS:
      me = M600_ERROR_SUCCESS;
      break;

    case LIBUSB_ERROR_IO:
      me = M600_ERROR_IO;
      break;

    case LIBUSB_ERROR_NO_DEVICE:
    case LIBUSB_ERROR_NOT_FOUND:
      me = M600_ERROR_NOT_FOUND;
      break;

    case LIBUSB_ERROR_TIMEOUT:
      me = M600_ERROR_TIMEOUT;
      break;

    case LIBUSB_ERROR_NO_MEM:
      me = M600_ERROR_MEMORY;
      break;

    default:
      me = M600_ERROR_LIBUSB;
      break;
    }

  return me;
}


/* is the usb device a m600 card reader */

unsigned int is_m600_device(libusb_device* dev)
{
  struct libusb_device_descriptor desc;

  DEBUG_PRINTF("device: 0x%04x, 0x%04x\n", desc.idVendor, desc.idProduct);

  if (libusb_get_device_descriptor(dev, &desc))
    return 0;

  if (desc.idVendor != M600_USB_VENDOR_ID)
    return 0;

  if (desc.idProduct != M600_USB_PRODUCT_ID)
    return 0;

  return 1;
}


/* usb io wrapper */

struct trans_ctx
{
#define TRANS_FLAGS_IS_DONE (1 << 0)
#define TRANS_FLAGS_HAS_ERROR (1 << 1)
  volatile unsigned long flags;
};


static void on_trans_done(struct libusb_transfer* trans)
{
  struct trans_ctx* const ctx = trans->user_data;

  if (trans->status != LIBUSB_TRANSFER_COMPLETED)
    ctx->flags |= TRANS_FLAGS_HAS_ERROR;

  ctx->flags = TRANS_FLAGS_IS_DONE;
}


static m600_error_t submit_wait(struct libusb_transfer* trans)
{
  struct trans_ctx trans_ctx;
  enum libusb_error error;

  trans_ctx.flags = 0;

  /* brief intrusion inside the libusb interface */
  trans->callback = on_trans_done;
  trans->user_data = &trans_ctx;

  if ((error = libusb_submit_transfer(trans)))
    {
      DEBUG_ERROR("libusb_submit_transfer(%d)\n", error);
      return M600_ERROR_LIBUSB;
    }

  while (!(trans_ctx.flags & TRANS_FLAGS_IS_DONE))
    {
      if (libusb_handle_events(NULL))
	{
	  DEBUG_ERROR("libusb_handle_events()\n");
	  return M600_ERROR_IO;
	}
    }

  return M600_ERROR_SUCCESS;
}


static m600_error_t send_recv_cmd
(
 m600_handle_t* handle,
 m600_cmd_t* cmd
)
{
  /* endpoint 0: control, not used here
     endpoint 1: interrupt mode write
     endpoint 2: bulk transfer used since
     time delivery does not matter but data
     integrity and transfer completion
  */

#define GOTO_ERROR(E)	\
  do {			\
    error = E;		\
    goto on_error;	\
  } while (0)

  m600_error_t error;

  /* send the command */

#if 0
  libusb_fill_interrupt_transfer
    (
     handle->req_trans,
     handle->usb_handle,
     handle->ep_req,
     (void*)&cmd->req,
     sizeof(cmd->req),
     NULL, NULL,
     0
    );
#else
  libusb_fill_bulk_transfer
    (
     handle->req_trans,
     handle->usb_handle,
     handle->ep_req,
     (void*)&cmd->req,
     sizeof(cmd->req),
     NULL, NULL,
     0
    );
#endif

  DEBUG_PRINTF("-- req transfer\n");

  error = submit_wait(handle->req_trans);
  if (error)
    GOTO_ERROR(error);

  /* read the response */

  libusb_fill_bulk_transfer
    (
     handle->rep_trans,
     handle->usb_handle,
     handle->ep_rep,
     (void*)&cmd->rep,
     sizeof(cmd->rep),
     NULL, NULL,
     0
    );

  DEBUG_PRINTF("-- rep transfer\n");

  error = submit_wait(handle->rep_trans);
  if (error)
    GOTO_ERROR(error);

  /* success */

  error = M600_ERROR_SUCCESS;

 on_error:
  return error;
}


/* exported functions */

void m600_cleanup(void)
{
  if (libusb_ctx != NULL)
    {
      libusb_exit(libusb_ctx);
      libusb_ctx = NULL;
    }
}


m600_error_t m600_initialize(void)
{
  m600_error_t error;

  if (libusb_ctx != NULL)
    GOTO_ERROR(M600_ERROR_ALREADY_INIT);

  if (libusb_init(&libusb_ctx))
    GOTO_ERROR(M600_ERROR_LIBUSB);

  return M600_ERROR_SUCCESS;

 on_error:
  m600_cleanup();
  return error;
}


m600_error_t m600_open(m600_handle_t** m600_handle)
{
  m600_error_t error;
  ssize_t i;
  ssize_t count;
  libusb_device** devs = NULL;
  libusb_device* dev;

  *m600_handle = NULL;

  if (libusb_ctx == NULL)
    GOTO_ERROR(M600_ERROR_NOT_INIT);

  count = libusb_get_device_list(libusb_ctx, &devs);
  if (count < 0)
    GOTO_ERROR(M600_ERROR_LIBUSB);

  for (i = 0; i < count; ++i)
    {
      dev = devs[i];

      if (is_m600_device(dev))
	break;
    }

  if (i == count)
    GOTO_ERROR(M600_ERROR_NOT_FOUND);

  /* open and init the device */

  *m600_handle = alloc_m600_handle();
  if (*m600_handle == NULL)
    GOTO_ERROR(M600_ERROR_MEMORY);

  if (libusb_open(dev, &(*m600_handle)->usb_handle))
    GOTO_ERROR(M600_ERROR_LIBUSB);

  if (libusb_set_configuration((*m600_handle)->usb_handle, 2))
    {
      DEBUG_ERROR("libusb_set_configuration()\n");
      GOTO_ERROR(M600_ERROR_LIBUSB);
    }

  if (libusb_claim_interface((*m600_handle)->usb_handle, 0))
    {
      DEBUG_ERROR("libusb_claim_interface()\n");
      GOTO_ERROR(M600_ERROR_LIBUSB);
    }

  (*m600_handle)->req_trans = libusb_alloc_transfer(0);
  if ((*m600_handle)->req_trans == NULL)
    GOTO_ERROR(M600_ERROR_MEMORY);

  (*m600_handle)->rep_trans = libusb_alloc_transfer(0);
  if ((*m600_handle)->rep_trans == NULL)
    GOTO_ERROR(M600_ERROR_MEMORY);

  (*m600_handle)->ep_req = M600_USB_EP_REQ | LIBUSB_ENDPOINT_OUT;
  (*m600_handle)->ep_rep = M600_USB_EP_REP | LIBUSB_ENDPOINT_IN;

  error = M600_ERROR_SUCCESS;
  
 on_error:

  if (devs != NULL)
    libusb_free_device_list(devs, 1);

  if (error != M600_ERROR_SUCCESS)
    {
      if (*m600_handle != NULL)
	{
	  m600_close(*m600_handle);
	  *m600_handle = NULL;
	}
    }

  return error;
}


void m600_close(m600_handle_t* handle)
{
  if (handle->req_trans != NULL)
    libusb_free_transfer(handle->req_trans);

  if (handle->rep_trans != NULL)
    libusb_free_transfer(handle->rep_trans);

  if (handle->usb_handle != NULL)
    libusb_close(handle->usb_handle);

  free_m600_handle(handle);
}


m600_error_t m600_read_alarms
(
 m600_handle_t* handle,
 m600_alarms_t* alarms
)
{
  m600_error_t error;
  m600_cmd_t cmd;

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
 m600_cardfn_t fn,
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

      if (fn(cmd.rep.card_data, cmd.rep.alarms, ctx))
	break;
    }

  return error;
}


/* testing */

static void __attribute__((unused)) print_reply(const m600_reply_t* rep)
{
  const unsigned char* p = (const unsigned char*)rep;
  unsigned int i;

  for (i = 0; i < 32; ++i, ++p)
    {
      if (i && !(i % 8))
	printf("\n");

      printf(" %02x", *p);
    }

  printf("\n");
}


m600_error_t m600_fill_data(m600_handle_t* handle, uint16_t* data)
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


m600_error_t m600_read_pins(m600_handle_t* handle, uint8_t* data)
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
