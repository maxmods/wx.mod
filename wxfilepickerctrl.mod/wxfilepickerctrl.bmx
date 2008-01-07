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
bbdoc: wxFilePickerCtrl
End Rem
Module wx.wxFilePickerCtrl

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
bbdoc: This control allows the user to select a file.
about: The generic implementation is a button which brings up a wxFileDialog when clicked. Native
implementation may differ but this is usually a (small) widget which give access to the file-chooser dialog.
End Rem
Type wxFilePickerCtrl Extends wxPickerBase

	Rem
	bbdoc: Creates a new wxFilePickerCtrl.
	End Rem
	Function CreateFilePicker:wxFilePickerCtrl(parent:wxWindow, id:Int, path:String = "", ..
			message:String = "Select a file", wildcard:String = "*.*", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxFLP_DEFAULT_STYLE)
		Return New wxFilePickerCtrl.Create(parent, id, path, message, wildcard, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxFilePickerCtrl.
	End Rem
	Method Create:wxFilePickerCtrl(parent:wxWindow, id:Int, path:String = "", ..
			message:String = "Select a file", wildcard:String = "*.*", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxFLP_DEFAULT_STYLE)
		wxObjectPtr = bmx_wxfilepickerctrl_create(Self, parent.wxObjectPtr, id, path, message, wildcard, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the absolute path of the currently selected file.
	End Rem
	Method GetPath:String()
		Return bmx_wxfilepickerctrl_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the absolute path of the currently selected file.
	about: This must be a valid file if the wxFLP_FILE_MUST_EXIST style was given.
	End Rem
	Method SetPath:String(filename:String)
		bmx_wxfilepickerctrl_setpath(wxObjectPtr, filename)
	End Method
	
End Type

Rem
bbdoc: This control allows the user to select a directory.
about: The generic implementation is a button which brings up a wxDirDialog when clicked. Native
implementation may differ but this is usually a (small) widget which give access to the dir-chooser
dialog.
End Rem
Type wxDirPickerCtrl Extends wxPickerBase

	Rem
	bbdoc: Creates a new wxDirPickerCtrl.
	End Rem
	Function CreateDirPicker:wxDirPickerCtrl(parent:wxWindow, id:Int, path:String = "", ..
			message:String = "Select a file", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDIRP_DEFAULT_STYLE)
		Return New wxDirPickerCtrl.Create(parent, id, path, message, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxDirPickerCtrl.
	End Rem
	Method Create:wxDirPickerCtrl(parent:wxWindow, id:Int, path:String = "", ..
			message:String = "Select a file", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDIRP_DEFAULT_STYLE)
		wxObjectPtr = bmx_wxdirpickerctrl_create(Self, parent.wxObjectPtr, id, path, message, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Returns the absolute path of the currently selected directory.
	End Rem
	Method GetPath:String()
		Return bmx_wxdirpickerctrl_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the absolute path of the currently selected directory.
	about: This must be a valid directory if wxDIRP_DIR_MUST_EXIST style was given.
	End Rem
	Method SetPath:String(dirname:String)
		bmx_wxdirpickerctrl_setpath(wxObjectPtr, dirname)
	End Method

End Type

Rem
bbdoc: This event type is used for the events generated by wxFilePickerCtrl and by wxDirPickerCtrl.
End Rem
Type wxFileDirPickerEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxFileDirPickerEvent = New wxFileDirPickerEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function
	
	Rem
	bbdoc: Retrieve the absolute path of the file/directory the user has just selected.
	End Rem
	Method GetPath:String()
		Return wx_wxfiledirpickerevent_getpath(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Set the absolute path of the file/directory associated with the event.
	End Rem
	Method SetPath(path:String)
		wx_wxfiledirpickerevent_setpath(wxEventPtr, path)
	End Method

End Type

Type TFileDirPickerEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_FILEPICKER_CHANGED, ..
					wxEVT_COMMAND_DIRPICKER_CHANGED
				Return wxFileDirPickerEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_FILEPICKER_CHANGED, ..
					wxEVT_COMMAND_DIRPICKER_CHANGED
				Return bmx_wxfilepickerctrl_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TFileDirPickerEventFactory
