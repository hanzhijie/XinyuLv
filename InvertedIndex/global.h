
#ifndef __GLOBAL__
#define __GLOBAL__

#define __HASH__
typedef struct
{
	char* file_buf;
	int url_offset;
	int url_hash;
} II_KEY_T;

typedef struct
{
	int  block_offset;
	int block_size;
	int file_id;
} II_VAL_T;

#endif
