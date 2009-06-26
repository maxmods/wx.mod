/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
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

#include "glue.h"

// ---------------------------------------------------------------------------------------

//MaxBitmap::MaxBitmap()
//	: bitmap(wxNullBitmap)
//{
//}

MaxBitmap::MaxBitmap(const wxBitmap& b)
{
	bitmap = wxBitmap(b);
}

wxBitmap & MaxBitmap::Bitmap() {
	return bitmap;
}

void MaxBitmap::SetBitmap(const wxBitmap & b) {
	bitmap = wxBitmap(b);
}

// *********************************************

MaxBitmap * bmx_wxbitmap_create(int makeNull) {
	if (!makeNull) {
		wxBitmap b;
		return new MaxBitmap(b);
	} else {
		return new MaxBitmap();
	}
}

void bmx_wxbitmap_delete(MaxBitmap * bitmap) {
	delete bitmap;
}

MaxBitmap * bmx_wxbitmap_createfromimage(MaxImage * image, int depth) {
	wxBitmap b(image->Image(), depth);
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmap_createempty(int width, int height, int depth) {
	wxBitmap b(width, height, depth);
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmap_createfromfile(BBString * name, wxBitmapType flag) {
	wxBitmap b(wxStringFromBBString(name), flag);
	return new MaxBitmap(b);
}

int bmx_wxbitmap_loadfile(MaxBitmap * bitmap, BBString * name, wxBitmapType type) {
	return static_cast<int>(bitmap->Bitmap().LoadFile(wxStringFromBBString(name), type));
}

MaxImage * bmx_wxbitmap_converttoimage(MaxBitmap * bitmap) {
	wxImage i(bitmap->Bitmap().ConvertToImage());
	return new MaxImage(i);
}

int bmx_wxbitmap_getdepth(MaxBitmap * bitmap) {
	return bitmap->Bitmap().GetDepth();
}

int bmx_wxbitmap_getheight(MaxBitmap * bitmap) {
	return bitmap->Bitmap().GetHeight();
}

int bmx_wxbitmap_getwidth(MaxBitmap * bitmap) {
	return bitmap->Bitmap().GetWidth();
}

void bmx_wxbitmap_setdepth(MaxBitmap * bitmap, int depth) {
	bitmap->Bitmap().SetDepth(depth);
}

void bmx_wxbitmap_setheight(MaxBitmap * bitmap, int height) {
	bitmap->Bitmap().SetHeight(height);
}

void bmx_wxbitmap_setwidth(MaxBitmap * bitmap, int width) {
	bitmap->Bitmap().SetWidth(width);
}

MaxPalette * bmx_wxbitmap_getpalette(MaxBitmap * bitmap) {
	//wxPalette p(*bitmap->Bitmap().GetPalette());
	return new MaxPalette(*bitmap->Bitmap().GetPalette());
}

void bmx_wxbitmap_setpalette(MaxBitmap * bitmap, MaxPalette * palette) {
	bitmap->Bitmap().SetPalette(palette->Palette());
}

MaxBitmap * bmx_wxbitmap_getsubbitmap(MaxBitmap * bitmap, int x, int y, int w, int h) {
	wxBitmap b(bitmap->Bitmap().GetSubBitmap(wxRect(x, y, w, h)));
	return new MaxBitmap(b);
}

MaxBitmap * bmx_wxbitmap_getsubbitmaprect(MaxBitmap * bitmap, MaxRect * rect) {
	wxBitmap b(bitmap->Bitmap().GetSubBitmap(rect->Rect()));
	return new MaxBitmap(b);
}

wxMask * bmx_wxmask_create(MaxBitmap * bitmap, MaxColour * colour) {
	if (colour) {
		return new wxMask(bitmap->Bitmap(), colour->Colour());
	} else {
		return new wxMask(bitmap->Bitmap());
	}
}

void bmx_wxmask_delete(wxMask * mask) {
	delete mask;
}

wxMask * bmx_wxbitmap_getmask(MaxBitmap * bitmap) {
	return bitmap->Bitmap().GetMask();
}

void bmx_wxbitmap_setmask(MaxBitmap * bitmap, wxMask * mask) {
	bitmap->Bitmap().SetMask(mask);
}

int bmx_wxbitmap_isok(MaxBitmap * bitmap) {
	return static_cast<int>(bitmap->Bitmap().IsOk());
}

MaxBitmap * bmx_wxbitmap_createfrompixmap(void * pixels, int width, int height, int pitch, int bytesPerPixel, int bitsPerPixel) {

	wxImage image(width, height);
	image.InitAlpha();

	unsigned char * data = image.GetData();

	for (int row = 0; row < height; row++) {
		int drow = row * (3 * width);
		int prow = row * pitch;
		for (int col = 0; col < width; col++) {
			int dpos = drow + col * 3;
			int ppos = prow + col * bytesPerPixel;
			data[dpos] = ((unsigned char*)pixels)[ppos];
			data[dpos+1] = ((unsigned char*)pixels)[ppos+1];
			data[dpos+2] = ((unsigned char*)pixels)[ppos+2];
			
			image.SetAlpha(col, row, ((unsigned char*)pixels)[ppos+3]);
		}
	}

	return new MaxBitmap(wxBitmap(image));
}

void bmx_wxbitmap_colourize(MaxBitmap * bitmap, MaxColour * colour) {

	wxImage image = bitmap->Bitmap().ConvertToImage();
	int width = image.GetWidth();
	int height = image.GetHeight();
	unsigned char r = colour->Colour().Red();
	unsigned char g = colour->Colour().Green();
	unsigned char b = colour->Colour().Blue();
	
	unsigned char* data = image.GetData();
	
	for (int row = 0; row < height; row++) {
		int drow = row * (3 * width);
		for (int col = 0; col < width; col++) {
			int dpos = drow + col * 3;
			
			data[dpos] &= r;
			data[dpos+1] &= g;
			data[dpos+2] &= b;
		}
	}
	
	bitmap->SetBitmap(wxBitmap(image));

}

