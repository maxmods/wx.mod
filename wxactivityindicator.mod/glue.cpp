/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxActivityIndicator::MaxActivityIndicator(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxActivityIndicator(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxActivityIndicator::MaxActivityIndicator()
{}

MaxActivityIndicator::~MaxActivityIndicator() {
	wxunbind(this);
}

void MaxActivityIndicator::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxActivityIndicatorXmlHandler, wxActivityIndicatorXmlHandler)

MaxActivityIndicatorXmlHandler::MaxActivityIndicatorXmlHandler()
	: wxActivityIndicatorXmlHandler()
{}

wxObject * MaxActivityIndicatorXmlHandler::DoCreateResource()
{
	XRC_MAKE_INSTANCE(control, MaxActivityIndicator)
	
	control->Create(m_parentAsWindow,
		GetID(),
		GetPosition(), GetSize(),
		GetStyle(),
		GetName());
	
	SetupWindow(control);
	
	if ( GetBool(wxS("running")) )
		control->Start();

	return control;
}

// *********************************************

BEGIN_EVENT_TABLE(MaxActivityIndicator, wxActivityIndicator)
END_EVENT_TABLE()

wxActivityIndicator * bmx_wxactivityindicator_create(BBObject * handle, wxWindow * parent, int id, int x, int y, int w, int h, int style) {
	return new MaxActivityIndicator(handle, parent, id, x, y, w, h, style);
}

void bmx_wxactivityindicator_start(wxActivityIndicator * indicator) {
	indicator->Start();
}

void bmx_wxactivityindicator_stop(wxActivityIndicator * indicator) {
	indicator->Stop();
}

int bmx_wxactivityindicator_isrunning(wxActivityIndicator * indicator) {
	return static_cast<int>(indicator->IsRunning());	
}

// *********************************************

void bmx_wxactivityindicator_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxActivityIndicatorXmlHandler);
}

