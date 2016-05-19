
/********************************************************************
 *Page View Rank (PVR): With the output of the
 *Page View Count, the Map in Page View Rank takes
 *the pair of the page access count as the key and the
 *URL as the value, and obtains the top ten URLs that are
 *most frequently accessed. No Reduce stage is required.
 ********************************************************************/

#include "MarsInc.h"

#define __OUTPUT__

void printFun(void* key, void* val, int keySize, int valSize)
{
	int count = *(int*)key;
	int offset = *(int*)val;

	printf("count: %d, offset: %d\n", count, offset);
}

void validate(Spec_t* spec, int num)
{
	PrintOutputRecords(spec, num, printFun);
}

//-----------------------------------------------------------------
//usage: PageViewRank datafile 
//param: datafile
//-----------------------------------------------------------------
int main( int argc, char** argv) 
{
	if (argc != 2) 
	{
		printf("usage: %s filename\n", argv[0]);
		exit(-1);
	}

	TimeVal_t timer;
	startTimer(&timer);

	Spec_t *spec = GetDefaultSpec();
	spec->workflow = MAP_GROUP;
#ifdef __OUTPUT__
	spec->outputToHost = 1;
#endif
		
	//-----------------------------------------------------
	//make map input
	//-----------------------------------------------------
	TimeVal_t loadtimer;
	startTimer(&loadtimer);
	char *filename = argv[1];
	FILE* fp = fopen(filename, "r");
	fseek(fp, 0, SEEK_END);
	int fileSize = ftell(fp) + 1;
	rewind(fp);
    	char *h_filebuf = (char*)malloc(fileSize);
	fread(h_filebuf, fileSize, 1, fp);
	fclose(fp);

	int offset = 0;
	char* p = h_filebuf;
	char* start = h_filebuf;
	int cur = 0;
	while (1)
	{
		int lineSize = 0;
		for (; *p != '\t'; ++p, ++lineSize, ++cur);
		char* rankString = p + 1;
		for (; *p != '\n' && *p != '\0'; ++p, ++lineSize, ++cur);	

		*p = '\0';
		++p;
		lineSize = (int)(p - start);
		int rank = atoi(rankString);
		//printf("%s\n", rankString);
		AddMapInputRecord(spec, &rank, &offset, sizeof(int), sizeof(int));	
		offset += lineSize; 
		start = p;

		if (offset >= fileSize-1) break;
	}
	endTimer("io-test", &loadtimer);

	//------------------------------------------------------
	//main MapReduce procedure
	//------------------------------------------------------
	MapReduce(spec);

	//------------------------------------------------------
	//further processing
	//------------------------------------------------------
#ifdef __OUTPUT__
	validate(spec, 10);
#endif

	//------------------------------------------------------
	//finish
	//------------------------------------------------------
	FinishMapReduce(spec);
	free(h_filebuf);
	endTimer("all-test", &timer);
	return 0;
}
