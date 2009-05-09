' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxFindReplaceDialog
End Rem
Module wx.wxFindReplaceDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: wxFindReplaceDialog is a standard modeless dialog which is used to allow the user to search for some text (and possibly replace it with something else).
about: The actual searching is supposed to be done in the owner window which is the parent of this dialog. Note that it
means that unlike for the other standard dialogs this one must have a parent window. Also note that there is no way to
use this dialog in a modal way; it is always, by design and implementation, modeless.
End Rem
Type wxFindReplaceDialog Extends wxDialog

	Field _data:wxFindReplaceData

	Function CreateFindReplaceDialog:wxFindReplaceDialog(parent:wxWindow, data:wxFindReplaceData, title:String = "", style:Int = 0)
		Return New wxFindReplaceDialog.Create(parent, data, title, style)
	End Function
	
	Method Create:wxFindReplaceDialog(parent:wxWindow, data:wxFindReplaceData, title:String = "", style:Int = 0)
		wxObjectPtr = bmx_wxfindreplacedialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr, title, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Get the wxFindReplaceData object used by this dialog
	End Rem
	Method GetData:wxFindReplaceData()
		Return _data
	End Method

	' soft linking
	Function _create:wxFindReplaceDialog(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFindReplaceDialog = New wxFindReplaceDialog
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxFindReplaceDialog(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local dialog:wxFindReplaceDialog = wxFindReplaceDialog(wxfind(wxObjectPtr))
			If Not dialog Then
				Return wxFindReplaceDialog._create(wxObjectPtr)
			End If
			Return dialog
		End If
	End Function

End Type

Rem
bbdoc: wxFindReplaceData holds the data for wxFindReplaceDialog.
about: It is used to initialize the dialog with the default values and will keep the last values from the dialog
when it is closed. It is also updated each time a wxFindDialogEvent is generated so instead of using the
wxFindDialogEvent methods you can also directly query this object.
<p>
Note that all SetXXX() methods may only be called before showing the dialog and calling them has no effect later.
</p>
<p>
Flags used by wxFindReplaceData::GetFlags() and wxFindDialogEvent::GetFlags()
<ul>
<li>wxFR_DOWN -  downward search/replace selected (otherwise - upwards)</li>
<li>wxFR_WHOLEWORD - whole word search/replace selected</li>
<li>wxFR_MATCHCASE - case sensitive search/replace selected (otherwise - case insensitive)</li>
</ul>
</p>
<p>
These flags can be specified in wxFindReplaceDialog constructor or Create():
<ul>
<li>wxFR_REPLACEDIALOG - replace dialog (otherwise find dialog)</li>
<li>wxFR_NOUPDOWN - don't allow changing the search direction</li>
<li>wxFR_NOMATCHCASE - don't allow case sensitive searching</li>
<li>wxFR_NOWHOLEWORD - don't allow whole word searching</li>
</ul>
</p>
End Rem
Type wxFindReplaceData Extends wxObject

	Rem
	bbdoc: Constructor.
	about: Initializes the flags to default value (0).
	End Rem
	Function CreateFindReplaceData:wxFindReplaceData(flags:Int = 0)
		Return New wxFindReplaceData.Create(flags)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Initializes the flags to default value (0).
	End Rem
	Method Create:wxFindReplaceData(flags:Int = 0)
		wxObjectPtr = bmx_wxfindreplacedata_create(Self, flags)
		Return Self
	End Method

	Rem
	bbdoc: Get the string to find.
	End Rem
	Method GetFindString:String()
		Return bmx_wxfindreplacedata_getfindstring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the replacement string.
	End Rem
	Method GetReplaceString:String()
		Return bmx_wxfindreplacedata_getreplacestring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the combination of flag values. (see #wxFindReplaceData)
	End Rem
	Method GetFlags:Int()
		Return bmx_wxfindreplacedata_getflags(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the flags to use to initialize the controls of the dialog.
	End Rem
	Method SetFlags(flags:Int)
		bmx_wxfindreplacedata_setflags(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Set the string to find (used as initial value by the dialog).
	End Rem
	Method SetFindString(s:String)
		bmx_wxfindreplacedata_setfindstring(wxObjectPtr, s)
	End Method
	
	Rem
	bbdoc: Set the replacement string (used as initial value by the dialog).
	End Rem
	Method SetReplaceString(s:String)
		bmx_wxfindreplacedata_setreplacestring(wxObjectPtr, s)
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxfindreplacedata_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

Rem
bbdoc: wxFindReplaceDialog events
End Rem
Type wxFindDialogEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxFindDialogEvent = New wxFindDialogEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Get the currently selected flags: this is the combination of wxFR_DOWN, wxFR_WHOLEWORD and wxFR_MATCHCASE flags.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxfinddialogevent_getflags(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Return the string to find (never empty).
	End Rem
	Method GetFindString:String()
		Return bmx_wxfinddialogevent_getfindstring(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Return the string to replace the search string with (only for replace and replace all events).
	End Rem
	Method GetReplaceString:String()
		Return bmx_wxfinddialogevent_getreplacestring(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Return the dialog which generated this event.
	End Rem
	Method GetDialog:wxFindReplaceDialog()
		Return wxFindReplaceDialog._find(bmx_wxfinddialogevent_getdialog(wxEventPtr))
	End Method
	
End Type


Type TFindDialogEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_FIND, ..
					wxEVT_COMMAND_FIND_NEXT, ..
					wxEVT_COMMAND_FIND_REPLACE, ..
					wxEVT_COMMAND_FIND_REPLACE_ALL, ..
					wxEVT_COMMAND_FIND_CLOSE
				Return wxFindDialogEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_FIND, ..
					wxEVT_COMMAND_FIND_NEXT, ..
					wxEVT_COMMAND_FIND_REPLACE, ..
					wxEVT_COMMAND_FIND_REPLACE_ALL, ..
					wxEVT_COMMAND_FIND_CLOSE
				Return bmx_wxfindreplacedialog_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TFindDialogEventFactory

