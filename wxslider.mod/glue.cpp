/*
  Copyright (c) 2007-2011 Bruce A Henderson
 
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

MaxSlider::MaxSlider(BBObject * handle, wxWindow * parent, wxWindowID id, int value, int minValue,
		int maxValue, int x, int y, int w, int h, long style)
	: wxSlider(parent, id, value, minValue, maxValue, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxSlider::MaxSlider()
{}

MaxSlider::~MaxSlider() {
	wxunbind(this);
}

void MaxSlider::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxSliderXmlHandler, wxSliderXmlHandler)

MaxSliderXmlHandler:: MaxSliderXmlHandler()
	: wxSliderXmlHandler()
{}


wxObject * MaxSliderXmlHandler::DoCreateResource()
{
    XRC_MAKE_INSTANCE(control, MaxSlider)

    control->Create(m_parentAsWindow,
                    GetID(),
                    GetLong(wxT("value"), 0),
                    GetLong(wxT("min"), 0),
                    GetLong(wxT("max"), 100),
                    GetPosition(), GetSize(),
                    GetStyle(),
                    wxDefaultValidator,
                    GetName());


	control->MaxBind(_wx_wxslider_wxSlider__xrcNew(control));

    if( HasParam(wxT("tickfreq")))
    {
        control->SetTickFreq(GetLong(wxT("tickfreq")), 0);
    }
    if( HasParam(wxT("pagesize")))
    {
        control->SetPageSize(GetLong(wxT("pagesize")));
    }
    if( HasParam(wxT("linesize")))
    {
        control->SetLineSize(GetLong(wxT("linesize")));
    }
    if( HasParam(wxT("thumb")))
    {
        control->SetThumbLength(GetLong(wxT("thumb")));
    }
    if( HasParam(wxT("tick")))
    {
        control->SetTick(GetLong(wxT("tick")));
    }
    if( HasParam(wxT("selmin")) && HasParam(wxT("selmax")))
    {
        control->SetSelection(GetLong(wxT("selmin")), GetLong(wxT("selmax")));
    }

    SetupWindow(control);

    return control;


}

// *********************************************

BEGIN_EVENT_TABLE(MaxSlider, wxSlider)
END_EVENT_TABLE()

MaxSlider * bmx_wxslider_create(BBObject * handle, wxWindow * parent, int id, int value,
		int minValue, int maxValue, int x, int y, int w, int h, long style) {
	return new MaxSlider(handle, parent, id, value, minValue, maxValue, x, y, w, h, style);
}

int bmx_wxslider_getlinesize(wxSlider * slider) {
	return slider->GetLineSize();
}

int bmx_wxslider_getmax(wxSlider * slider) {
	return slider->GetMax();
}

int bmx_wxslider_getmin(wxSlider * slider) {
	return slider->GetMin();
}

int bmx_wxslider_getpagesize(wxSlider * slider) {
	return slider->GetPageSize();
}

int bmx_wxslider_getvalue(wxSlider * slider) {
	return slider->GetValue();
}

void bmx_wxslider_setlinesize(wxSlider * slider, int size) {
	slider->SetLineSize(size);
}

void bmx_wxslider_setpagesize(wxSlider * slider, int size) {
	slider->SetPageSize(size);
}

void bmx_wxslider_setrange(wxSlider * slider, int minValue, int maxValue) {
	slider->SetRange(minValue, maxValue);
}

void bmx_wxslider_setvalue(wxSlider * slider, int value) {
	slider->SetValue(value);
}

// *********************************************

void bmx_wxslider_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxSliderXmlHandler);
}
