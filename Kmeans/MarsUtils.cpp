#ifndef __MRUTILS_CU__
#define __MRUTILS_CU__

#include "MarsInc.h"

//--------------------------------------------------------
//start a timer
//
//param	: start_tv
//--------------------------------------------------------
void startTimer(TimeVal_t *start_tv)
{
   gettimeofday((struct timeval*)start_tv, NULL);
}

//--------------------------------------------------------
//end a timer, and print out a message
//
//param	: msg message to print out
//param	: start_tv
//--------------------------------------------------------
void endTimer(char *msg, TimeVal_t *start_tv)
{
	cudaThreadSynchronize();
   struct timeval end_tv;

   gettimeofday(&end_tv, NULL);

   time_t sec = end_tv.tv_sec - start_tv->tv_sec;
   time_t ms = end_tv.tv_usec - start_tv->tv_usec;

   time_t diff = sec * 1000000 + ms;

   printf("%10s:\t\t%fms\n", msg, (double)((double)diff/1000.0));
}


//----------------------------------------------------------
//print output records
//
//param: spec
//param: num -- maximum number of output records to print
//param: printFunc -- a function pointer
//	void printFunc(void* key, void* val, int keySize, int valSize)
//----------------------------------------------------------
void PrintOutputRecords(Spec_t* spec, int num, PrintFunc_t printFunc)
{
	int maxNum = num;
	if (maxNum > spec->outputRecordCount || maxNum < 0) maxNum = spec->outputRecordCount;
	for (int i = 0; i < maxNum; ++i)
	{
		int4 index = spec->outputOffsetSizes[i];
		printFunc((char*)spec->outputKeys + index.x, (char*)spec->outputVals + index.z, index.y, index.w);
	}
}

#endif //__MRUTILS_CU__
