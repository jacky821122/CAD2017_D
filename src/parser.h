#ifndef PARSER_H
#define PARSER_H

#include "assertions.h"
#include <vector>

using namespace std;

void parse(char* file, string &fsm, string &declarations, vector<assertions*> &vassertions);

#endif