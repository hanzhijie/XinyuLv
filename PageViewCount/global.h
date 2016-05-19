
#ifndef __GLOBAL_H__
#define __GLOBAL_H__

typedef struct
{
	char* file_buf;
	int entry_offset;
	int entry_hash;
} PVC_KEY_T;

typedef struct
{
	int entry_size;
	int phase;
} PVC_VAL_T;

#endif
