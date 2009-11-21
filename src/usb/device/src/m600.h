/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 13:59:45 2009 texane
** Last update Sat Nov 21 00:42:59 2009 texane
*/



#ifndef M600_H_INCLUDED
# define M600_H_INCLUDED



#include "stdint.h"
#include "../../../common/m600_types.h"


void m600_setup(void);
void m600_start_request(m600_request_t);
void m600_schedule(void);



#endif /* ! M600_H_INCLUDED */
