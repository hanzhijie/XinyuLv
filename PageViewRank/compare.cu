

#ifndef __COMPARE_CU__
#define __COMPARE_CU__
#include "MarsInc.h"

__device__ int compare(const void *d_a, int len_a, const void *d_b, int len_b)
{
	int	h1 = *(int*)d_a;
	int	h2 = *(int*)d_b;

	if (h1 > h2) return -1;
	if (h1 < h2) return 1;
	return 0;
}

#endif //__COMPARE_CU__
