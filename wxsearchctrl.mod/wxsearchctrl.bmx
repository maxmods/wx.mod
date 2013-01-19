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
bbdoc wxSearchCtrl
End Rem
Module wx.wxSearchCtrl

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
bbdoc: A search control is a composite control with a search button, a text control, and a cancel button.
End Rem
Type wxSearchCtrl Extends wxTextCtrl

	Rem
	bbdoc: Constructor, creating and showing a text control.
	End Rem
	Function CreateSearchCtrl:wxSearchCtrl(parent:wxWindow, id:Int, value:String = "", x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0, validator:wxValidator = Null)
		Return New wxSearchCtrl.Create(parent, id, value, x, y, w, h, style, validator)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSearchCtrl(parent:wxWindow, id:Int, value:String = "", x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0, validator:wxValidator = Null)
		If validator Then
			_validator = validator
			wxObjectPtr = bmx_wxsearchctrl_create(Self, parent.wxObjectPtr, id, value, x, y, w, h, style, validator.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxsearchctrl_create(Self, parent.wxObjectPtr, id, value, x, y, w, h, style, Null)
		End If
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Sets the search control's menu object.
	about: If there is already a menu associated with the search control it is deleted.
	End Rem
	Method SetMenu(menu:wxMenu)
		bmx_wxsearchctrl_setmenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the search control's menu object or Null if there is no menu attached.
	End Rem
	Method GetMenu:wxMenu()
		Local m:Byte Ptr = bmx_wxsearchctrl_getmenu(wxObjectPtr)
		If m Then
			Local menu:wxMenu = wxMenu(wxfind(m))
			If Not menu Then
				Return wxMenu._create(m)
			End If
			Return menu
		End If
	End Method
	
	Rem
	bbdoc: Sets the search button visibility value on the search control.
	about: If there is a menu attached, the search button will be visible regardless of the search button visibility value. 
	<p>
	This has no effect in Mac OS X v10.3
	</p>
	End Rem
	Method ShowSearchButton(show:Int)
		bmx_wxsearchctrl_showsearchbutton(wxObjectPtr, show)
	End Method
	
	Rem
	bbdoc: Returns the search button visibility value.
	about: If there is a menu attached, the search button will be visible regardless of the search button visibility value. 
	<p>
	This always returns false in Mac OS X v10.3
	</p>
	End Rem
	Method IsSearchButtonVisible:Int()
		Return bmx_wxsearchctrl_issearchbuttonvisible(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Shows or hides the cancel button.
	End Rem
	Method ShowCancelButton(show:Int)
		bmx_wxsearchctrl_showcancelbutton(wxObjectPtr, show)
	End Method
	
	Rem
	bbdoc: Indicates whether the cancel button is visible.
	End Rem
	Method IsCancelButtonVisible:Int()
		Return bmx_wxsearchctrl_iscancelbuttonvisible(wxObjectPtr)
	End Method

End Type


Type TSearchCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_SEARCHCTRL_CANCEL_BTN, ..
					wxEVT_COMMAND_SEARCHCTRL_SEARCH_BTN
				Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_SEARCHCTRL_CANCEL_BTN, ..
					wxEVT_COMMAND_SEARCHCTRL_SEARCH_BTN
				Return bmx_wxsearchctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TSearchCtrlEventFactory
