#include "StdAfx.h"
#include "FindPersons.h"

#include <cv.h>
#include <cvaux.h>
#include <cxcore.h>
#include <highgui.h>

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <string>

#include <iostream>
#include <sstream>
#include <fstream>

using namespace cv;
using namespace std;

FindPersons::FindPersons(void)
{
}

FindPersons::~FindPersons(void)
{
}

string FindPersons::stringify(int x)
{
	std::ostringstream o;
	o << x;
	return o.str();
}

void FindPersons::detectPersons(string filename)
{
	
	Mat img, img1;

	HOGDescriptor hog;
	hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
	namedWindow("people detector", 1);
	
	img1 = imread(filename);
	Size s( img1.size().width * 2, img1.size().height * 2 );
	resize( img1, img, s, 0, 0, CV_INTER_AREA );
	imshow("people detector", img1);
	waitKey(0);

	fflush(stdout);
	vector<Rect> found;
	vector<Rect> found_filtered;
	
	hog.detectMultiScale(img, found, 0, Size(8,8), Size(32, 32), 1.05, 2);
	size_t i, j;
	for( i = 0; i< found.size(); i++)
	{
		Rect r = found[i];
		for(j=0;j<found.size();j++)
			if(j!= i && (r & found[j]) == r)
				break;

		if( j == found.size())
			found_filtered.push_back(r);
	}

	ofstream inFile;
	inFile.open("info.csv");

	

	for(i = 0; i<found_filtered.size(); i++)
	{
		Rect r = found_filtered[i];
		r.x += cvRound(r.width*0.1);
		r.width = cvRound(r.width*0.8);
		r.y += cvRound(r.height*0.07);
		r.height = cvRound(r.height*0.8);
		rectangle(img, r.tl(), r.br(), cv::Scalar(0,255,0), 3);
		inFile << stringify(r.x/2);
		inFile << ",";
		inFile << stringify(r.y/2);
		inFile << ",";
		inFile << stringify(r.width/2);
		inFile << ",";
		inFile << stringify(r.height/2);
		inFile << endl;
	}

	inFile.close();

	imshow("people detector", img);
	rectangle(img,
		cvPoint(0,283),
		cvPoint(0+64,283+128),
		cvScalar(0,0,0),
		5);
	imwrite("peopleDetect.png", img);
	waitKey(0);
	
}

int main(int argc, char** argv)
{
	FindPersons* findPersons = new FindPersons();
	findPersons->detectPersons("Demo4_d.jpg");
}