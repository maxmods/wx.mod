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
bbdoc: wxFileCtrl
End Rem
Module wx.wxFileCtrl

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
bbdoc: This control allows the user to select a file.
about: Two implementations of this class exist, one for Gtk and another generic one for all the other ports.
End Rem
Type wxFileCtrl Extends wxControl

	Function _create:wxFileCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFileCtrl = New wxFileCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxFileCtrl(wxObjectPtr:Byte Ptr)
		Return wxFileCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a check list box.
	End Rem
	Function CreateFileCtrl:wxFileCtrl(parent:wxWindow, id:Int, defaultDirectory:String = Null, defaultFilename:String = Null, wildcard:String = wxFileSelectorDefaultWildcard, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxFC_DEFAULT_STYLE)
		Return New wxFileCtrl.Create(parent, id, defaultDirectory, defaultFilename, wildcard, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxFileCtrl(parent:wxWindow, id:Int, defaultDirectory:String = Null, defaultFilename:String = Null, wildcard:String = wxFileSelectorDefaultWildcard, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxFC_DEFAULT_STYLE)
		wxObjectPtr = bmx_wxfilectrl_create(Self, parent.wxObjectPtr, id, defaultDirectory, defaultFilename, wildcard, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the current directory of the file control (i.e. the directory shown by it).
	End Rem
	Method GetDirectory:String()
		Return bmx_wxfilectrl_getdirectory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the currently selected filename.
	about: For the controls having the wxFC_MULTIPLE style, use GetFilenames() instead.
	End Rem
	Method GetFilename:String()
		Return bmx_wxfilectrl_getfilename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of filenames only of selected items.
	about: This method should only be used with the controls having the wxFC_MULTIPLE style, use GetFilename() for the others.
	End Rem
	Method GetFilenames:String[]()
		Return bmx_wxfilectrl_getfilenames(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the zero-based index of the currently selected filter.
	End Rem
	Method GetFilterIndex:Int()
		Return bmx_wxfilectrl_getfilterindex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the full path (directory and filename) of the currently selected file.
	about: For the controls having the wxFC_MULTIPLE style, use GetPaths() instead.
	End Rem
	Method GetPath:String()
		Return bmx_wxfilectrl_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of full paths of the files chosen.
	about: This method should be used with the controls having the wxFC_MULTIPLE style, use GetPath() otherwise.
	End Rem
	Method GetPaths:String[]()
		Return bmx_wxfilectrl_getpaths(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current wildcard.
	End Rem
	Method GetWildcard:String()
		Return bmx_wxfilectrl_getwildcard(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets(changes) the current directory displayed in the control.
	returns: Returns true on success, false otherwise.
	End Rem
	Method SetDirectory:Int(directory:String)
		Return bmx_wxfilectrl_setdirectory(wxObjectPtr, directory)
	End Method
	
	Rem
	bbdoc: Selects a certain file.
	returns: Returns true on success, false otherwise.
	End Rem
	Method SetFilename:Int(filename:String)
		Return bmx_wxfilectrl_setfilename(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Changes to a certain directory and selects a certain file.
	returns: Returns true on success, false otherwise
	about: In case the filename specified isn't found/couldn't be shown with currently selected filter, false is returned.
	End Rem
	Method SetPath:Int (path:String)
		Return bmx_wxfilectrl_setpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets the current filter index, starting from zero.
	End Rem
	Method SetFilterIndex(index:Int)
		bmx_wxfilectrl_setfilterindex(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Sets the wildcard, which can contain multiple file types, for example: "BMP files (*.bmp)|*.bmp|GIF files (*.gif)|*.gif".
	End Rem
	Method SetWildcard(wildcard:String)
		bmx_wxfilectrl_setwildcard(wxObjectPtr, wildcard)
	End Method
	
	Rem
	bbdoc: Sets whether hidden files and folders are shown or not.
	End Rem
	Method ShowHidden(show:Int)
		bmx_wxfilectrl_showhidden(wxObjectPtr, show)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxFileCtrlEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxFileCtrlEvent = New wxFileCtrlEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Method GetDirectory:String()
		Return bmx_wxfilectrlevent_getdirectory(wxEventPtr)
	End Method
	
	Method GetFile:String()
		Return bmx_wxfilectrlevent_getfile(wxEventPtr)
	End Method
	
	Method GetFiles:String[]()
		Return bmx_wxfilectrlevent_getfiles(wxEventPtr)
	End Method
	
	Method GetFilterIndex:Int()
		Return bmx_wxfilectrlevent_getfilterindex(wxEventPtr)
	End Method
	
	Method SetFiles(files:String[])
		bmx_wxfilectrlevent_setfiles(wxEventPtr, files)
	End Method
	
	Method SetDirectory(directory:String)
		bmx_wxfilectrlevent_setdirectory(wxEventPtr, directory)
	End Method
	
	Method SetFilterIndex(index:Int)
		bmx_wxfilectrlevent_setfilterindex(wxEventPtr, index)
	End Method
	
End Type

Type TFileCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_FILECTRL_SELECTIONCHANGED, ..
				wxEVT_FILECTRL_FILEACTIVATED, ..
				wxEVT_FILECTRL_FOLDERCHANGED, ..
				wxEVT_FILECTRL_FILTERCHANGED
					Return wxFileCtrlEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_FILECTRL_SELECTIONCHANGED, ..
				wxEVT_FILECTRL_FILEACTIVATED, ..
				wxEVT_FILECTRL_FOLDERCHANGED, ..
				wxEVT_FILECTRL_FILTERCHANGED
			Return bmx_wxfilectrl_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TFileCtrlEventFactory

Type TFileCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxfilectrl_addresourcehandler()
	End Method
		
End Type

New TFileCtrlResourceFactory
