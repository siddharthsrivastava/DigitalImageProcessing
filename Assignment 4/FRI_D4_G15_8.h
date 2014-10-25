#pragma once

#include <cv.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <string>

using namespace std;
using namespace cv;

class FindPersons
{
public:
	FindPersons(void);
	~FindPersons(void);
	static string stringify(int);
	void detectPersons(string);
};
