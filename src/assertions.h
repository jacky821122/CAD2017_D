#ifndef ASSERTIONS_H
#define ASSERTIONS_H

#include <string>

struct assertions
{
	int id;
	bool trigger, response;
	std::string triSignal, resSignal;
	std::string triSignal_text, resSignal_text;
	int delayFirst, delaySecond;
}; typedef struct assertions assertions;

#endif
