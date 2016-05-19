
#ifndef __MAP_CU__
#define __MAP_CU__

#include "MarsInc.h"

__device__ void MAP_COUNT_FUNC//(void *key, void *val, size_t keySize, size_t valSize)
{
	EMIT_INTER_COUNT_FUNC(sizeof(int), sizeof(int));
}

__device__ void MAP_FUNC//(void *key, void val, size_t keySize, size_t valSize)
{
	int* o_rank = (int*)GET_OUTPUT_BUF(0);
	int* o_offset = (int*)GET_OUTPUT_BUF(sizeof(int));
	*o_rank = *(int*)key;
	*o_offset = *(int*)val;
	EMIT_INTERMEDIATE_FUNC(o_rank, o_offset, sizeof(int), sizeof(int));
}
#endif //__MAP_CU__
