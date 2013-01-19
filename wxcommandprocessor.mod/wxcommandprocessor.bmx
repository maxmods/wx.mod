' Copyright (c) 2007-2013 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxCommandProcessor
End Rem
Module wx.wxCommandProcessor

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxCommandProcessor is a type that maintains a history of wxCommands, with undo/redo functionality built-in.
End Rem
Type wxCommandProcessor Extends wxObject

	' soft linking
	Function _create:wxCommandProcessor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCommandProcessor = New wxCommandProcessor
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxCommandProcessor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxCommandProcessor = wxCommandProcessor(wxfind(wxObjectPtr))
			If Not window Then
				Return wxCommandProcessor._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateCommandProcessor:wxCommandProcessor(maxCommands:Int = -1)
		Return New wxCommandProcessor.create(maxCommands)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method create:wxCommandProcessor(maxCommands:Int = -1)
		wxObjectPtr = bmx_wxcommandprocessor_create(Self, maxCommands)
		Return Self
	End Method

	Rem
	bbdoc: Returns true if the currently-active command can be undone, false otherwise.
	End Rem
	Method CanUndo:Int()
		Return bmx_wxcommandprocessor_canundo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes all commands in the list and sets the current command pointer to NULL.
	End Rem
	Method ClearCommands()
		bmx_wxcommandprocessor_clearcommands(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Executes (redoes) the current command (the command that has just been undone if any).
	End Rem
	Method Redo:Int()
		Return bmx_wxcommandprocessor_redo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the list of commands.
	End Rem
	Method GetCommands:wxCommand[]()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns the maximum number of commands that the command processor stores.
	End Rem
	Method GetMaxCommands:Int()
		Return bmx_wxcommandprocessor_getmaxcommands(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the edit menu associated with the command processor.
	End Rem
	Method GetEditMenu:wxMenu()
		Return wxMenu._find(bmx_wxcommandprocessor_geteditmenu(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the string that will be appended to the Redo menu item.
	End Rem
	Method GetRedoAccelerator:String()
		Return bmx_wxcommandprocessor_getredoaccelerator(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string that will be shown for the redo menu item.
	End Rem
	Method GetRedoMenuLabel:String()
		Return bmx_wxcommandprocessor_getredomenulabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string that will be appended to the Undo menu item.
	End Rem
	Method GetUndoAccelerator:String()
		Return bmx_wxcommandprocessor_getundoaccelerator(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string that will be shown for the undo menu item.
	End Rem
	Method GetUndoMenuLabel:String()
		Return bmx_wxcommandprocessor_getundomenulabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Initializes the command processor, setting the current command to the last in the list (if any), and updating the edit menu (if one has been specified).
	End Rem
	Method Initialize()
		bmx_wxcommandprocessor_initialize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a boolean value that indicates if changes have been made since the last save operation.
	about: This only works if wxCommandProcessor::MarkAsSaved is called whenever the project is saved.
	End Rem
	Method IsDirty:Int()
		Return bmx_wxcommandprocessor_isdirty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: You must call this method whenever the project is saved if you plan to use wxCommandProcessor::IsDirty.
	End Rem
	Method MarkAsSaved()
		bmx_wxcommandprocessor_markassaved(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Tells the command processor to update the Undo and Redo items on this menu as appropriate.
	about: Set this to NULL if the menu is about to be destroyed and command operations may still be performed, or the command processor may try to access an invalid pointer.
	End Rem
	Method SetEditMenu(menu:wxMenu)
		If menu Then
			bmx_wxcommandprocessor_seteditmenu(wxObjectPtr, menu.wxObjectPtr)
		Else
			bmx_wxcommandprocessor_seteditmenu(wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Sets the menu labels according to the currently set menu and the current command state.
	End Rem
	Method SetMenuStrings()
		bmx_wxcommandprocessor_setmenustrings(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the string that will be appended to the Redo menu item.
	End Rem
	Method SetRedoAccelerator(accel:String)
		bmx_wxcommandprocessor_setredoaccelerator(wxObjectPtr, accel)
	End Method

	Rem
	bbdoc: Sets the string that will be appended to the Undo menu item.
	End Rem
	Method SetUndoAccelerator(accel:String)
		bmx_wxcommandprocessor_setundoaccelerator(wxObjectPtr, accel)
	End Method
	
	Rem
	bbdoc: Submits a new command to the command processor.
	about: The command processor calls wxCommand::Do to execute the command; if it succeeds, the
	command is stored in the history list, and the associated edit menu (if any) updated
	appropriately. If it fails, the command is deleted immediately.
	<p>
	@storeIt indicates whether the successful command should be stored in the history list.
	</p>
	End Rem
	Method Submit:Int(command:wxCommand, storeIt:Int = True)
		Local ret:Int = bmx_wxcommandprocessor_submit(wxObjectPtr, command.wxObjectPtr, storeIt)
		command.wxObjectPtr = Null
		Return ret
	End Method
	
	Rem
	bbdoc: Undoes the command just executed.
	End Rem
	Method Undo:Int()
		Return bmx_wxcommandprocessor_undo(wxObjectPtr)
	End Method
	
End Type


