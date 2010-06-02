/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 17:09:47 2009 texane
** Last update Wed Jun  2 21:41:10 2010 texane
*/


#ifndef M600_H_INCLUDED
# define M600_H_INCLUDED



#include <stdint.h>
#include "../../common/m600.h"
#include "../../../common/m600_types.h"



/* forward decls */

typedef struct m600_handle m600_handle_t;


/* error types */

enum m600_error
  {
    M600_ERROR_SUCCESS = 0,
    
    M600_ERROR_ALREADY_INIT,
    M600_ERROR_LIBUSB,
    M600_ERROR_NOT_INIT,
    M600_ERROR_NOT_FOUND,
    M600_ERROR_MEMORY,
    M600_ERROR_TIMEOUT,
    M600_ERROR_IO,

    M600_ERROR_MAX
  };

typedef enum m600_error m600_error_t;

/* error bitmap */
typedef unsigned int m600_bitmap_t;

#define M600_BIT_UNDEF (1 << 0) /* undefined error */
#define M600_BIT_IO (1 << 1) /* communication (usb) error */
#define M600_BIT_M600_ERROR (1 << 2) /* m600 generic error */
#define M600_BIT_HOPPER_CHECK (1 << 3) /* hopper is empty */
#define M600_BIT_MOTION_CHECK (1 << 4) /* */
#define M600_BIT_NOT_CONNECTED (1 << 5) /* device not connected */
#define M600_BIT_NOT_READY (1 << 6) /* device not ready */


/* card callback */

typedef int (*m600_cardfn_t)(const uint16_t*, m600_alarms_t, void*);


/* interface */

m600_error_t m600_initialize(void);
void m600_cleanup(void);
m600_error_t m600_open(m600_handle_t**);
void m600_close(m600_handle_t*);
m600_error_t m600_reset(m600_handle_t*);
m600_error_t m600_read_alarms(m600_handle_t*, m600_alarms_t*);
m600_error_t m600_read_cards(m600_handle_t*, unsigned int, m600_cardfn_t, void*);
m600_bitmap_t m600_read_card(m600_handle_t*);
void m600_get_card_buffer(const void**);
m600_bitmap_t m600_get_state(m600_handle_t*);
m600_error_t m600_fill_data(m600_handle_t*, uint16_t*);
m600_error_t m600_read_pins(m600_handle_t*, uint8_t*);



#endif /* ! M600_H_INCLUDED */
