#ifndef __GLOBAL_H__
#define __GLOBAL_H__

typedef struct
{
	char* ptrFile;
	char* ptrKeyword;
} SM_KEY_T;

typedef __align__(16) struct
{
	int keyword_size;
	int linebuf_offset;
	int linebuf_size;
} SM_VAL_T;

#endif
