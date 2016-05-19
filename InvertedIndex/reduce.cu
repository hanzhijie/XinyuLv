
#ifndef __REDUCE_CU__
#define __REDUCE_CU__

#include "MarsInc.h"

//---------------------------------------------------------------
//No Reduce in this application
//---------------------------------------------------------------

__device__ void REDUCE_COUNT_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
}

__device__ void REDUCE_FUNC//(void* key, void* vals, size_t keySize, size_t valCount)
{
}
#endif //__REDUCE_CU__
