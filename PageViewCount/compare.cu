


#ifndef __COMPARE_CU__
#define __COMPARE_CU__
#include "MarsInc.h"
#include "global.h"

__device__ int compare(const void *d_a, int len_a, const void *d_b, int len_b)
{
	PVC_KEY_T* a = (PVC_KEY_T*)d_a;
	PVC_KEY_T* b = (PVC_KEY_T*)d_b;

	int hash1 = a->entry_hash;
	int hash2 = b->entry_hash;
	if (hash1 > hash2) return 1;
	else if (hash1 < hash2) return -1;

	char* entry1 = a->file_buf + a->entry_offset;	
	char* entry2 = b->file_buf + b->entry_offset;	

	for (; *entry1 == *entry2 && *entry1 != '\0' && *entry2 != '\0'; entry1++, entry2++);

	if (*entry1 > *entry2) return 1;
	if (*entry1 < *entry2) return -1;

	return 0;
}

#endif
