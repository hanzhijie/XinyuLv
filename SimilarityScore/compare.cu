
#ifndef __COMPARE_CU__
#define __COMPARE_CU__
#include "MarsInc.h"

#define SMALL	0.0000001f
__device__ int compare(const void *d_a, int len_a, const void *d_b, int len_b)
{
	float a = *(float*)d_a;
	float b = *(float*)d_b;

	if (fabsf(a-b) < SMALL)  return 0;
	if (a < b) return 1;

	return -1;
}

#endif //__COMPARE_CU__
