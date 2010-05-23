/*
** Made by fabien le mentec <texane@gmail.com>
** 
** Started on  Wed Nov 11 13:59:45 2009 texane
** Last update Thu Apr 29 17:06:48 2010 texane
*/



#ifndef M600_H_INCLUDED
# define M600_H_INCLUDED



#include "stdint.h"
#include "../../../common/m600_types.h"


void m600_setup(void);
void m600_start_request(m600_request_t);
void m600_schedule(void);
void m600_print_signals(void);



#endif /* ! M600_H_INCLUDED */
