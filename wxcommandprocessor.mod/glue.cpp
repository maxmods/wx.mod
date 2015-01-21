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

MaxCommandProcessor::MaxCommandProcessor(BBObject * handle, int maxCommands)
	: maxHandle(handle), wxCommandProcessor(maxCommands)
{
	wxbind(this, handle);
}

MaxCommandProcessor::~MaxCommandProcessor()
{
	wxunbind(this);
}


// *********************************************

wxCommandProcessor * bmx_wxcommandprocessor_create(BBObject * handle, int maxCommands) {
	return new MaxCommandProcessor(handle, maxCommands);
}

int bmx_wxcommandprocessor_canundo(wxCommandProcessor * proc) {
	return static_cast<int>(proc->CanUndo());
}

void bmx_wxcommandprocessor_clearcommands(wxCommandProcessor * proc) {
	proc->ClearCommands();
}

int bmx_wxcommandprocessor_redo(wxCommandProcessor * proc) {
	return static_cast<int>(proc->Redo());
}

int bmx_wxcommandprocessor_getmaxcommands(wxCommandProcessor * proc) {
	return proc->GetMaxCommands();
}

wxMenu * bmx_wxcommandprocessor_geteditmenu(wxCommandProcessor * proc) {
	return proc->GetEditMenu();
}

BBString * bmx_wxcommandprocessor_getredoaccelerator(wxCommandProcessor * proc) {
	return bbStringFromWxString(proc->GetRedoAccelerator());
}

BBString * bmx_wxcommandprocessor_getredomenulabel(wxCommandProcessor * proc) {
	return bbStringFromWxString(proc->GetRedoMenuLabel());
}

BBString * bmx_wxcommandprocessor_getundoaccelerator(wxCommandProcessor * proc) {
	return bbStringFromWxString(proc->GetUndoAccelerator());
}

BBString * bmx_wxcommandprocessor_getundomenulabel(wxCommandProcessor * proc) {
	return bbStringFromWxString(proc->GetUndoMenuLabel());
}

void bmx_wxcommandprocessor_initialize(wxCommandProcessor * proc) {
	proc->Initialize();
}

int bmx_wxcommandprocessor_isdirty(wxCommandProcessor * proc) {
	return static_cast<int>(proc->IsDirty());
}

void bmx_wxcommandprocessor_markassaved(wxCommandProcessor * proc) {
	proc->MarkAsSaved();
}

void bmx_wxcommandprocessor_seteditmenu(wxCommandProcessor * proc, wxMenu * menu) {
	proc->SetEditMenu(menu);
}

void bmx_wxcommandprocessor_setmenustrings(wxCommandProcessor * proc) {
	proc->SetMenuStrings();
}

void bmx_wxcommandprocessor_setredoaccelerator(wxCommandProcessor * proc, BBString * accel) {
	proc->SetRedoAccelerator(wxStringFromBBString(accel));
}

void bmx_wxcommandprocessor_setundoaccelerator(wxCommandProcessor * proc, BBString * accel) {
	proc->SetUndoAccelerator(wxStringFromBBString(accel));
}

int bmx_wxcommandprocessor_submit(wxCommandProcessor * proc, wxCommand * command, int storeIt) {
	return static_cast<int>(proc->Submit(command, static_cast<bool>(storeIt)));
}

int bmx_wxcommandprocessor_undo(wxCommandProcessor * proc) {
	return static_cast<int>(proc->Undo());
}


