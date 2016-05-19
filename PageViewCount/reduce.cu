

#ifndef __REDUCE_CU__
#define __REDUCE_CU__

#include "MarsInc.h"
#include "global.h"

__device__ void REDUCE_COUNT_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
	EMIT_COUNT_FUNC(sizeof(PVC_KEY_T), sizeof(PVC_VAL_T));
}

__device__ void REDUCE_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
	PVC_VAL_T* pVal = (PVC_VAL_T*)vals;
	pVal->phase = 1;
	EMIT_FUNC(key, vals, sizeof(PVC_KEY_T), sizeof(PVC_VAL_T));
}
#endif //__REDUCE_CU__
