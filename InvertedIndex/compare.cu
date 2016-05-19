#ifndef __COMPARE_CU__
#define __COMPARE_CU__
#include "MarsInc.h"
#include "global.h"

__device__ int compare(const void *d_a, int len_a, const void *d_b, int len_b)
{
	II_KEY_T* a = (II_KEY_T*)d_a;
	II_KEY_T* b = (II_KEY_T*)d_b;

#ifdef __HASH__
	if (a->url_hash > b->url_hash) return 1;
	if (a->url_hash < b->url_hash) return -1;
#endif

	char* url1 = a->file_buf + a->url_offset;
	char* url2 = b->file_buf + b->url_offset;

	for (; *url1 == *url2 && *url1 != '\0' && *url2 != '\0'; url1++, url2++);

	if (*url1 > *url2) return 1;
	if (*url1 < *url2) return -1;
	return 0;
}

#endif //__COMPARE_CU__
