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

MaxCommand::MaxCommand(BBObject * handle, bool canUndo,  const wxString& name)
	: maxHandle(handle), wxCommand(canUndo, name)
{
	wxbind(this, handle);
}

MaxCommand::~MaxCommand()
{
	wxunbind(this);
}

bool MaxCommand::Do() {
	return static_cast<bool>(_wx_wxcommand_wxCommand__Do(maxHandle));
}

bool MaxCommand::Undo() {
	return static_cast<bool>(_wx_wxcommand_wxCommand__Undo(maxHandle));
}

bool MaxCommand::CanUndo() {
	return static_cast<bool>(_wx_wxcommand_wxCommand__CanUndo(maxHandle));
}

bool MaxCommand::CanUndo_default() {
	return wxCommand::CanUndo();
}


// *********************************************


MaxCommand * bmx_wxcommand_create(BBObject * handle, int canUndo, BBString * name) {
	return new MaxCommand(handle, static_cast<bool>(canUndo), wxStringFromBBString(name));
}

int bmx_wxcommand_canundo(MaxCommand * command) {
	return static_cast<int>(command->CanUndo());
}

BBString * bmx_wxcommand_getname(wxCommand * command) {
	return bbStringFromWxString(command->GetName());
}

void bmx_wxcommand_delete(wxCommand * command) {
	delete command;
}
