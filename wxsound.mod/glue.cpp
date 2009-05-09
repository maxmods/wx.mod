/*
  Copyright (c) 2007-2009 Bruce A Henderson & Oliver Skawronek
 
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


MaxSound::MaxSound(BBObject * handle, BBString * fileName, bool isResource)
	: wxSound(wxStringFromBBString(fileName), isResource)
{
	wxbind(this, handle);
}

MaxSound::~MaxSound() {
	wxunbind(this);
}

// *********************************************


MaxSound * bmx_wxsound_create(BBObject * handle, BBString * fileName, bool isResource) {
	return new MaxSound(handle, fileName, isResource);
}

bool bmx_wxsound_isok(wxSound * sound) {
	return sound->IsOk();
}

/*
bool bmx_wxsound_isplaying(wxSound * sound) {
	return sound->IsPlaying();
}
*/

bool bmx_wxsound_play(wxSound * sound, unsigned flags) {
	return sound->Play(flags);
}

void bmx_wxsound_stop(wxSound * sound) {
	return sound->Stop();
}

void bmx_wxsound_free(wxSound * sound) {
	delete sound;
}
