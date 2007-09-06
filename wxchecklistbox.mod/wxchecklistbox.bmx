' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: wxCheckListBox
End Rem
Module wx.wxCheckListBox

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
bbdoc: A checklistbox is like a listbox, but allows items to be checked or unchecked.
about: See also #wxListBox.
<p>
Please note that wxCheckListBox uses client data in its implementation, and therefore this is not available to the
application.
</p>
<p><b>Styles</b>
See #wxListBox.
</p>
<p><b>Event Handling</b>
<ul>
<li><tt>wxEVT_COMMAND_CHECKLISTBOX_TOGGLE</tt> - handle list item check or uncheck.</li>
</ul>
</p>
End Rem
Type wxCheckListBox Extends wxListBox

	Rem
	bbdoc: Constructor, creating and showing a check list box.
	End Rem
	Function CreateCheckListBox:wxCheckListBox(parent:wxWindow, id:Int, choices:String[], x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Local this:wxCheckListBox = New wxCheckListBox
		
		this.wxObjectPtr = bmx_wxchecklistbox_create(this, parent.wxObjectPtr, id, choices, x, y, w, h, style)
		
		Return this
	End Function
	
	Rem
	bbdoc: Checks the given item.
	about: Note that calling this method doesn't result in wxEVT_COMMAND_CHECKLISTBOX_TOGGLE being emitted.
	End Rem
	Method Check(item:Int, check:Int = True)
		bmx_wxchecklistbox_check(wxObjectPtr, item, check)
	End Method
	
	Rem
	bbdoc: Returns True if the given item is checked, False otherwise.
	End Rem
	Method IsChecked:Int(item:Int)
		Return bmx_wxchecklistbox_ischecked(wxObjectPtr, item)
	End Method

	Rem
	bbdoc: Adds the item to the end of the list box.
	End Rem
	Method Append:Int(item:String, clientData:Object = Null)
		Return bmx_wxchecklistbox_append(wxObjectPtr, item)
	End Method

End Type


Type TCheckListBoxEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_CHECKLISTBOX_TOGGLED Then
			Return wxCommandEvent.create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_CHECKLISTBOX_TOGGLED Then
			Return bmx_wxchecklistbox_geteventtype(eventType)
		End If
	End Method

End Type

New TCheckListBoxEventFactory
