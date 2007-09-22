/*
  Copyright (c) 2007 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#ifndef _WX_MAX_IMAGE_H_
#define _WX_MAX_IMAGE_H_

#include "wxglue.h"
#include "../wxpalette.mod/glue.h"

class MaxImage;

extern "C" {

#include <blitz.h>

	MaxImage * bmx_wximage_createempty(int width, int height);
	void bmx_wximage_delete(MaxImage * image);
	MaxImage * bmx_wximage_create(BBString * name, long flag, int index);
	MaxImage * bmx_wximage_createnull();
	
	void bmx_wximage_setrgb(MaxImage * image, int x, int y, int r, int g, int b);
	void bmx_wximage_rescale(MaxImage * image, int width, int height, int quality);
	int bmx_wximage_getwidth(MaxImage * image);
	void bmx_wximage_resize(MaxImage * image, int width, int height, int x, int y, int red, int green, int blue);
	MaxImage * bmx_wximage_rotate(MaxImage * image, double angle, int centreX, int centreY, bool interpolating, int * offsetX, int * offsetY);

	MaxImage * bmx_wximage_blur(MaxImage * image, int blurRadius);
	MaxImage * bmx_wximage_blurhorizontal(MaxImage * image, int blurRadius);
	MaxImage * bmx_wximage_blurvertical(MaxImage * image, int blurRadius);
	bool bmx_wximage_convertalphatomask(MaxImage * image, int threshold);
	MaxImage * bmx_wximage_converttogreyscale(MaxImage * image, double lr, double lg, double lb);
	MaxImage * bmx_wximage_converttomono(MaxImage * image, int r, int g, int b);
	MaxImage * bmx_wximage_copy(MaxImage * image);
	void bmx_wximage_destroy(MaxImage * image);
	bool bmx_wximage_findfirstunusedcolour(MaxImage * image, int * r, int * g, int * b, int startR, int startG, int startB);
	BBString * bmx_wximage_getimageextwildcard();
	int bmx_wximage_getalpha(MaxImage * image, int x, int y);
	int bmx_wximage_getblue(MaxImage * image, int x, int y);
	unsigned char* bmx_wximage_getdata(MaxImage * image);
	int bmx_wximage_getgreen(MaxImage * image, int x, int y);
	int bmx_wximage_getheight(MaxImage * image);
	int bmx_wximage_getmaskblue(MaxImage * image);
	int bmx_wximage_getmaskgreen(MaxImage * image);
	int bmx_wximage_getmaskred(MaxImage * image);
	bool bmx_wximage_getorfindmaskcolour(MaxImage * image, int * r, int * g, int * b);
	int bmx_wximage_getred(MaxImage * image, int x, int y);
	MaxImage * bmx_wximage_getsubimage(MaxImage * image, int x, int y, int w, int h);
	bool bmx_wximage_hasalpha(MaxImage * image);
	bool bmx_wximage_hasmask(MaxImage * image);
	BBString * bmx_wximage_getoption(MaxImage * image, BBString * name);
	int bmx_wximage_getoptionint(MaxImage * image, BBString * name);
	bool bmx_wximage_hasoption(MaxImage * image, BBString * name);
	void bmx_wximage_initalpha(MaxImage * image);
	bool bmx_wximage_istransparent(MaxImage * image, int x, int y, int threshold);
	bool bmx_wximage_isok(MaxImage * image);
	bool bmx_wximage_removehandler(BBString * name);

	MaxImage * bmx_wximage_mirror(MaxImage * image, bool horizontally);
	void bmx_wximage_replace(MaxImage * image, int r1, int g1, int b1, int r2, int g2, int b2);
	void bmx_wximage_setrgbrange(MaxImage * image, int x, int y, int w, int h, int red, int green, int blue);
	void bmx_wximage_setpalette(MaxImage * image, MaxPalette * palette);
	void bmx_wximage_setoption(MaxImage * image, BBString * name, BBString * value);
	void bmx_wximage_setoptionint(MaxImage * image, BBString * name, int value);
	void bmx_wximage_setalpha(MaxImage * image, int x, int y, int alpha);
	void bmx_wximage_setdata(MaxImage * image, unsigned char * data);
	void bmx_wximage_setmask(MaxImage * image, bool hasMask);
	void bmx_wximage_setmaskcolour(MaxImage * image, int red, int green, int blue);
	bool bmx_wximage_setmaskfromimage(MaxImage * image, MaxImage * mask, int mr, int mg, int mb);
	MaxImage * bmx_wximage_scale(MaxImage * image, int width, int height, int quality);
	MaxImage * bmx_wximage_size(MaxImage * image, int width, int height, int x, int y, int red, int green, int blue);
	void bmx_wximage_rotatehue(MaxImage * image, double angle);
	MaxImage * bmx_wximage_rotate90(MaxImage * image, bool clockwise);

	void bmx_wximage_addhandler(wxImageHandler * handler);
	void bmx_wximage_inserthandler(wxImageHandler * handler);
	wxPNGHandler * bmx_wxpnghandler_create();
	wxXPMHandler * bmx_wxxpmhandler_create();
	
	MaxImage * bmx_wximage_createfromstream(wxInputStream * stream, long kind, int index);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxImage
{
public:
	MaxImage();
	MaxImage(const wxImage & image);
	~MaxImage();
	wxImage & Image();

private:
	wxImage image;
};


#endif // _WX_MAX_IMAGE_H_
