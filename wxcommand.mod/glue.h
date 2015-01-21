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

#include "wxglue.h"
#include "wx/cmdproc.h"

class MaxCommand;

extern "C" {

#include <blitz.h>

	int CB_PREF(wx_wxcommand_wxCommand__CanUndo)(BBObject * handle);
	int CB_PREF(wx_wxcommand_wxCommand__Do)(BBObject * handle);
	int CB_PREF(wx_wxcommand_wxCommand__Undo)(BBObject * handle);

	MaxCommand * bmx_wxcommand_create(BBObject * handle, int canUndo, BBString * name);
	int bmx_wxcommand_canundo(MaxCommand * command);
	BBString * bmx_wxcommand_getname(wxCommand * command);
	void bmx_wxcommand_delete(wxCommand * command);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCommand : public wxCommand
{
public:

	MaxCommand(BBObject * handle, bool canUndo,  const wxString& name);
	~MaxCommand();
	bool Do();
	bool Undo();
	bool CanUndo();
	bool CanUndo_default();

private:
	BBObject * maxHandle;
};

