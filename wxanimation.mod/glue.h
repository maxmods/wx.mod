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

#ifndef _WX_MAX_ANIMATION_H_
#define _WX_MAX_ANIMATION_H_

#include "wxglue.h"
#include "../wximage.mod/glue.h"
#include "../wxstream.mod/glue.h"
#include "wx/animate.h"

class MaxAnimation;

extern "C" {

#include <blitz.h>

	MaxAnimation * bmx_wxanimation_createnull();
	MaxAnimation * bmx_wxanimation_create(BBString * name, int animType);
	int bmx_wxanimation_getdelay(MaxAnimation * anim, int frame);
	MaxImage * bmx_wxanimation_getframe(MaxAnimation * anim, int frame);
	int bmx_wxanimation_getframecount(MaxAnimation * anim);
	void bmx_wxanimation_getsize(MaxAnimation * anim, int * w, int * h);
	int bmx_wxanimation_isok(MaxAnimation * anim);
	int bmx_wxanimation_loadfromstream(MaxAnimation * anim, MaxInputStream * stream, int animType);
	int bmx_wxanimation_loadfile(MaxAnimation * anim, BBString * name, int animType);
	void bmx_wxanimation_free(MaxAnimation * anim);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxAnimation
{
public:
	MaxAnimation();
	MaxAnimation(const wxAnimation & anim);
	~MaxAnimation();
	wxAnimation & Animation();

private:
	wxAnimation animation;
};

#endif
