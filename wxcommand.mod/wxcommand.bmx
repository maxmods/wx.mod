' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxCommand
End Rem
Module wx.wxCommand

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: wxCommand is a base type for modelling an application command, which is an action usually performed by selecting a menu item, pressing a toolbar button or any other means provided by the application to change the data or view.
End Rem
Type wxCommand Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateCommand:wxCommand(canUndo:Int = False, name:String = "")
		Return New wxCommand.create(canUndo, name)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method create:wxCommand(canUndo:Int = False, name:String = "")
		wxObjectPtr = bmx_wxcommand_create(Self, canUndo, name)
		Return Self
	End Method

	Rem
	bbdoc: Returns true if the command can be undone, false otherwise.
	about: Override this method to provide a custom response.
	End Rem
	Method CanUndo:Int()
		Return bmx_wxcommand_canundo(wxObjectPtr)
	End Method
	
	Function _CanUndo:Int(command:wxCommand)
		Return command.CanUndo()
	End Function
	
	Rem
	bbdoc: Executes an action.
	returns: True to indicate that the action has taken place, False otherwise.
	about: Returning false will indicate to the command processor that the action is not undoable
	and should not be added to the command history.
	<p>
	Override this method to execute the appropriate action when called.
	</p>
	End Rem
	Method Do:Int()
		Return False
	End Method
	
	Function _Do:Int(command:wxCommand)
		Return command.Do()
	End Function

	Rem
	bbdoc: Returns the command name.
	End Rem
	Method GetName:String()
		Return bmx_wxcommand_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Un-executes a previous Do.
	returns: True to indicate that the action has taken place, False otherwise.
	about: Override this method to un-execute a previous Do.
	<p>
	Returning false will indicate to the command processor that the action is not redoable and
	no change should be made to the command history.
	</p>
	<p>
	How you implement this command is totally application dependent, but typical strategies include:
	<ul>
	<li>
	Perform an inverse operation on the last modified piece of data in the document. When redone, a
	copy of data stored in command is pasted back or some operation reapplied. This relies on the
	fact that you know the ordering of Undos; the user can never Undo at an arbitrary position
	in the command history. 
	</li>
	<li>
	Restore the entire document state (perhaps using document transactioning). Potentially very
	inefficient, but possibly easier to code if the user interface and data are complex, and an
	'inverse execute' operation is hard to write. 
	</li>
	<</ul>
	</p>
	End Rem
	Method Undo:Int()
		Return False
	End Method
	
	Function _Undo:Int(command:wxCommand)
		Return command.Undo()
	End Function

	Method Delete()
		If wxObjectPtr Then
			bmx_wxcommand_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


