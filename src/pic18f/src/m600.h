/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 13:59:45 2009 texane
** Last update Wed Nov 11 17:21:15 2009 texane
*/



#ifndef M600_H_INCLUDED
# define M600_H_INCLUDED



#include "stdint.h"
#include "../../common/m600_types.h"



void m600_setup(void);
m600_alarms_t m600_read_card(uint16_t*);
int m600_is_empty(void);
int m600_read_request(m600_request_t*);
void m600_write_reply(m600_reply_t*);
m600_alarms_t m600_read_alarms(void);



#endif /* ! M600_H_INCLUDED */
