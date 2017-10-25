#ifndef PARSER_H
#define PARSER_H

#include "assertions.h"
#include <vector>

using namespace std;

int removeLatch(const char* file);
bool parse(const char* file, string &fsm, string &declarations, vector<assertions*> &vassertions);

#endif
