

#ifndef __GLOBAL_H__
#define __GLOBAL_H__

typedef struct
{
	char* file; 
} WC_KEY_T;

typedef __align__(16) struct
{
	int line_offset;
	int line_size;
} WC_VAL_T;

#endif
