/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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

MaxImage::MaxImage()
	: image(wxNullImage)
{
	image = wxImage();
}

MaxImage::MaxImage(const wxImage & img)
	: image(img)
{
}

wxImage & MaxImage::Image() {
	return image;
}

MaxImage::~MaxImage() {
//	delete &image;
}


// *********************************************


MaxImage * bmx_wximage_createempty(int width, int height) {
	wxImage i = wxImage(width, height);
	return new MaxImage(i);
}

MaxImage * bmx_wximage_create(BBString * name, long flag, int index) {
	wxImage i(wxStringFromBBString(name), flag, index);
	return new MaxImage(i);
}

MaxImage * bmx_wximage_createnull() {
	return new MaxImage(wxNullImage);
}


void bmx_wximage_delete(MaxImage * image) {
	delete image;
}

void bmx_wximage_setrgb(MaxImage * image, int x, int y, int r, int g, int b) {
	image->Image().SetRGB(x, y, static_cast<unsigned char>(r), static_cast<unsigned char>(g), static_cast<unsigned char>(b));
}

void bmx_wximage_rescale(MaxImage * image, int width, int height, int quality) {
	image->Image().Rescale(width, height, (wxImageResizeQuality)quality);
}

int bmx_wximage_getwidth(MaxImage * image) {
	return image->Image().GetWidth();
}

void bmx_wximage_resize(MaxImage * image, int width, int height, int x, int y, int red, int green, int blue) {
	image->Image().Resize(wxSize(width, height), wxPoint(x, y), red, green, blue);
}

MaxImage * bmx_wximage_rotate(MaxImage * image, double angle, int centreX, int centreY, bool interpolating, int * offsetX, int * offsetY) {
	wxPoint offset;
	wxImage i = image->Image().Rotate(angle, wxPoint(centreX, centreY), interpolating, &offset);
	*offsetX = offset.x;
	*offsetY = offset.y;
	return new MaxImage(i);
}


MaxImage * bmx_wximage_blur(MaxImage * image, int blurRadius) {
	wxImage i(image->Image().Blur(blurRadius));
	return new MaxImage(i);
}

MaxImage * bmx_wximage_blurhorizontal(MaxImage * image, int blurRadius) {
	wxImage i(image->Image().BlurHorizontal(blurRadius));
	return new MaxImage(i);
}

MaxImage * bmx_wximage_blurvertical(MaxImage * image, int blurRadius) {
	wxImage i(image->Image().BlurVertical(blurRadius));
	return new MaxImage(i);
}

bool bmx_wximage_convertalphatomask(MaxImage * image, int threshold) {
	return image->Image().ConvertAlphaToMask(static_cast<unsigned char>(threshold));
}

MaxImage * bmx_wximage_converttogreyscale(MaxImage * image, double lr, double lg, double lb) {
	wxImage i(image->Image().ConvertToGreyscale(lr, lg, lb));
	return new MaxImage(i);
}

MaxImage * bmx_wximage_converttomono(MaxImage * image, int r, int g, int b) {
	wxImage i(image->Image().ConvertToMono(static_cast<unsigned char>(r), static_cast<unsigned char>(g), static_cast<unsigned char>(b)));
	return new MaxImage(i);
}

MaxImage * bmx_wximage_copy(MaxImage * image) {
	wxImage i(image->Image().Copy());
	return new MaxImage(i);
}

void bmx_wximage_destroy(MaxImage * image) {
	image->Image().Destroy();
}

bool bmx_wximage_findfirstunusedcolour(MaxImage * image, int * r, int * g, int * b, int startR, int startG, int startB) {
	unsigned char pr, pg, pb;
	bool ret = image->Image().FindFirstUnusedColour(&pr, &pg, &pb, static_cast<unsigned char>(startR), static_cast<unsigned char>(startG), static_cast<unsigned char>(startB));
	*r = static_cast<int>(pr);
	*g = static_cast<int>(pg);
	*b = static_cast<int>(pb);
	return ret;
}

BBString * bmx_wximage_getimageextwildcard() {
	return bbStringFromWxString(wxImage::GetImageExtWildcard());
}

int bmx_wximage_getalpha(MaxImage * image, int x, int y) {
	return static_cast<int>(image->Image().GetAlpha(x, y));
}

int bmx_wximage_getblue(MaxImage * image, int x, int y) {
	return static_cast<int>(image->Image().GetBlue(x, y));
}

unsigned char* bmx_wximage_getdata(MaxImage * image) {
	return image->Image().GetData();
}

int bmx_wximage_getgreen(MaxImage * image, int x, int y) {
	return static_cast<int>(image->Image().GetGreen(x, y));
}

int bmx_wximage_getheight(MaxImage * image) {
	return image->Image().GetHeight();
}

int bmx_wximage_getmaskblue(MaxImage * image) {
	return static_cast<int>(image->Image().GetMaskBlue());
}

int bmx_wximage_getmaskgreen(MaxImage * image) {
	return static_cast<int>(image->Image().GetMaskGreen());
}

int bmx_wximage_getmaskred(MaxImage * image) {
	return static_cast<int>(image->Image().GetMaskRed());
}

bool bmx_wximage_getorfindmaskcolour(MaxImage * image, int * r, int * g, int * b) {
	unsigned char pr, pg, pb;
	bool ret = image->Image().GetOrFindMaskColour(&pr, &pg, &pb);
	*r = static_cast<int>(pr);
	*g = static_cast<int>(pg);
	*b = static_cast<int>(pb);
	return ret;
}

int bmx_wximage_getred(MaxImage * image, int x, int y) {
	return image->Image().GetRed(x, y);
}

MaxImage * bmx_wximage_getsubimage(MaxImage * image, int x, int y, int w, int h) {
	wxImage i(image->Image().GetSubImage(wxRect(x, y, w, h)));
	return new MaxImage(i);
}

bool bmx_wximage_hasalpha(MaxImage * image) {
	return image->Image().HasAlpha();
}

bool bmx_wximage_hasmask(MaxImage * image) {
	return image->Image().HasMask();
}

BBString * bmx_wximage_getoption(MaxImage * image, BBString * name) {
	return bbStringFromWxString(image->Image().GetOption(wxStringFromBBString(name)));
}

int bmx_wximage_getoptionint(MaxImage * image, BBString * name) {
	return image->Image().GetOptionInt(wxStringFromBBString(name));
}

bool bmx_wximage_hasoption(MaxImage * image, BBString * name) {
	return image->Image().HasOption(wxStringFromBBString(name));
}

void bmx_wximage_initalpha(MaxImage * image) {
	image->Image().InitAlpha();
}

bool bmx_wximage_istransparent(MaxImage * image, int x, int y, int threshold) {
	return image->Image().IsTransparent(x, y, static_cast<unsigned char>(threshold));
}

bool bmx_wximage_isok(MaxImage * image) {
	return image->Image().IsOk();
}

bool bmx_wximage_removehandler(BBString * name) {
	return wxImage::RemoveHandler(wxStringFromBBString(name));
}



MaxImage * bmx_wximage_mirror(MaxImage * image, bool horizontally) {
	wxImage i(image->Image().Mirror(horizontally));
	return new MaxImage(i);
}

void bmx_wximage_replace(MaxImage * image, int r1, int g1, int b1, int r2, int g2, int b2) {
	image->Image().Replace(static_cast<unsigned char>(r1), static_cast<unsigned char>(g1), static_cast<unsigned char>(b1),
		static_cast<unsigned char>(r2), static_cast<unsigned char>(g2), static_cast<unsigned char>(b2));
}

void bmx_wximage_setrgbrange(MaxImage * image, int x, int y, int w, int h, int red, int green, int blue) {
	image->Image().SetRGB(wxRect(x, y, w, h), static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wximage_setrgbrect(MaxImage * image, MaxRect * rect, int red, int green, int blue) {
	image->Image().SetRGB(rect->Rect(), static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

void bmx_wximage_setpalette(MaxImage * image, MaxPalette * palette) {
	image->Image().SetPalette(palette->Palette());
}

void bmx_wximage_setoption(MaxImage * image, BBString * name, BBString * value) {
	image->Image().SetOption(wxStringFromBBString(name), wxStringFromBBString(value));
}

void bmx_wximage_setoptionint(MaxImage * image, BBString * name, int value) {
	image->Image().SetOption(wxStringFromBBString(name), value);
}

void bmx_wximage_setalpha(MaxImage * image, int x, int y, int alpha) {
	image->Image().SetAlpha(x, y, static_cast<unsigned char>(alpha));
}

void bmx_wximage_setdata(MaxImage * image, unsigned char * data) {
	image->Image().SetData(data);
}

void bmx_wximage_setmask(MaxImage * image, bool hasMask) {
	image->Image().SetMask(hasMask);
}

void bmx_wximage_setmaskcolour(MaxImage * image, int red, int green, int blue) {
	image->Image().SetMaskColour(static_cast<unsigned char>(red), static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

bool bmx_wximage_setmaskfromimage(MaxImage * image, MaxImage * mask, int mr, int mg, int mb) {
	return image->Image().SetMaskFromImage(mask->Image(), static_cast<unsigned char>(mr), static_cast<unsigned char>(mg), static_cast<unsigned char>(mb));
}

MaxImage * bmx_wximage_scale(MaxImage * image, int width, int height, int quality) {
	wxImage i(image->Image().Scale(width, height, (wxImageResizeQuality)quality));
	return new MaxImage(i);
}

MaxImage * bmx_wximage_size(MaxImage * image, int width, int height, int x, int y, int red, int green, int blue) {
	wxImage i(image->Image().Size(wxSize(width, height), wxPoint(x, y), red, green, blue));
	return new MaxImage(i);
}

void bmx_wximage_rotatehue(MaxImage * image, double angle) {
	image->Image().RotateHue(angle);
}

MaxImage * bmx_wximage_rotate90(MaxImage * image, bool clockwise) {
	wxImage i(image->Image().Rotate90(clockwise));
	return new MaxImage(i);
}



void bmx_wximage_addhandler(wxImageHandler * handler) {
	wxImage::AddHandler(handler);
}

void bmx_wximage_inserthandler(wxImageHandler * handler) {
	wxImage::InsertHandler(handler);
}

wxPNGHandler * bmx_wxpnghandler_create() {
	return new wxPNGHandler();
}

wxXPMHandler * bmx_wxxpmhandler_create() {
	return new wxXPMHandler();
}

wxGIFHandler * bmx_wxgifhandler_create() {
	return new wxGIFHandler();
}

wxBMPHandler * bmx_wxbmphandler_create() {
	return new wxBMPHandler();
}

wxJPEGHandler * bmx_wxjpeghandler_create() {
	return new wxJPEGHandler();
}

wxPCXHandler * bmx_wxpcxhandler_create() {
	return new wxPCXHandler();
}

wxPNMHandler * bmx_wxpnmhandler_create() {
	return new wxPNMHandler();
}

/*wxTIFFHandler * bmx_wxtiffhandler_create() {
	return new wxTIFFHandler();
}*/

wxTGAHandler * bmx_wxtgahandler_create() {
	return new wxTGAHandler();
}

wxICOHandler * bmx_wxicohandler_create() {
	return new wxICOHandler();
}

wxCURHandler * bmx_wxcurhandler_create() {
	return new wxCURHandler();
}

wxANIHandler * bmx_wxanihandler_create() {
	return new wxANIHandler();
}

MaxImage * bmx_wximage_createfromstream(wxInputStream * stream, long kind, int index) {
	wxImage i(*stream, kind, index);
	return new MaxImage(i);
}

bool bmx_wximage_savefiletype(MaxImage * image, BBString * name, int type) {
	return image->Image().SaveFile(wxStringFromBBString(name), type);
}

bool bmx_wximage_savefilemimetype(MaxImage * image, BBString * name, BBString * mimeType) {
	return image->Image().SaveFile(wxStringFromBBString(name), wxStringFromBBString(mimeType));
}

bool bmx_wximage_savefile(MaxImage * image, BBString * name) {
	return image->Image().SaveFile(wxStringFromBBString(name));
}

MaxPalette * bmx_wximage_getpalette(MaxImage * image) {
	return new MaxPalette(image->Image().GetPalette());
}

wxImageHandler * bmx_wximage_findhandler(BBString * name) {
	return wxImage::FindHandler(wxStringFromBBString(name));
}

wxImageHandler * bmx_wximage_findhandlerbyextension(BBString * extension, long imageType) {
	return wxImage::FindHandler(wxStringFromBBString(extension), imageType);
}

wxImageHandler * bmx_wximage_findhandlerbytype(long imageType) {
	return wxImage::FindHandler(imageType);
}

wxImageHandler * bmx_wximage_findhandlermime(BBString * mimeType) {
	return wxImage::FindHandlerMime(wxStringFromBBString(mimeType));
}


// *********************************************

BBString * bmx_wximagehandler_getname(wxImageHandler * handler) {
	return bbStringFromWxString(handler->GetName());
}

BBString * bmx_wximagehandler_getextension(wxImageHandler * handler) {
	return bbStringFromWxString(handler->GetExtension());
}

long bmx_wximagehandler_gettype(wxImageHandler * handler) {
	return handler->GetType();
}

BBString * bmx_wximagehandler_getmimetype(wxImageHandler * handler) {
	return bbStringFromWxString(handler->GetMimeType());
}

