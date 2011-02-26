' Copyright (c) 2007-2011 Bruce A Henderson
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
bbdoc: wxPickerBase
End Rem
Module wx.wxPickerBase

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: Base abstract type for all pickers which support an auxiliary text control.
about: This type handles all positioning and sizing of the text control like a an horizontal wxBoxSizer
would do, with the text control on the left of the picker button. The proportion (see wxSizer
documentation for more info about proportion values) of the picker control defaults to 1 when there
isn't a text control associated (see wxPB_USE_TEXTCTRL style) and to 0 otherwise.
End Rem
Type wxPickerBase Extends wxControl Abstract

	Rem
	bbdoc: Sets the margin (in pixel) between the picker and the text control.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method SetInternalMargin(margin:Int)
		bmx_wxpickerbase_setinternalmargin(wxObjectPtr, margin)
	End Method
	
	Rem
	bbdoc: Returns the margin (in pixel) between the picker and the text control.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method GetInternalMargin:Int()
		Return bmx_wxpickerbase_getinternalmargin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the proportion value of the text control.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method SetTextCtrlProportion(prop:Int)
		bmx_wxpickerbase_settextctrlproportion(wxObjectPtr, prop)
	End Method
	
	Rem
	bbdoc: Sets the proportion value of the picker.
	End Rem
	Method SetPickerCtrlProportion(prop:Int)
		bmx_wxpickerbase_setpickerctrlproportion(wxObjectPtr, prop)
	End Method
	
	Rem
	bbdoc: Returns the proportion value of the text control.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method GetTextCtrlProportion:Int()
		Return bmx_wxpickerbase_gettextctrlproportion(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the proportion value of the picker.
	End Rem
	Method GetPickerCtrlProportion:Int()
		Return bmx_wxpickerbase_getpickerctrlproportion(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this window has a valid text control (i.e. if the wxPB_USE_TEXTCTRL style was given when creating this control).
	End Rem
	Method HasTextCtrl:Int()
		Return bmx_wxpickerbase_hastextctrl(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a pointer to the text control handled by this window or Null if the wxPB_USE_TEXTCTRL style was not specified when this control was created.
	about: Very important: the contents of the text control could be containing an invalid
	representation of the entity which can be chosen through the picker (e.g. the user entered an
	invalid colour syntax because of a typo). Thus you should never parse the content of the
	textctrl to get the user's input; rather use the derived-class getter (e.g.
	wxColourPickerCtrl::GetColour, wxFilePickerCtrl::GetPath, etc).
	End Rem
	Method GetTextCtrl:wxTextCtrl()
		Return wxTextCtrl._create(bmx_wxpickerbase_gettextctrl(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns true if the text control is growable.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method IsTextCtrlGrowable:Int()
		Return bmx_wxpickerbase_istextctrlgrowable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the picker control as growable when grow is true.
	End Rem
	Method SetPickerCtrlGrowable(grow:Int = True)
		bmx_wxpickerbase_setpickerctrlgrowable(wxObjectPtr, grow)
	End Method
	
	Rem
	bbdoc: Sets the text control as growable when grow is true.
	about: This method can be used only when HasTextCtrl returns true.
	End Rem
	Method SetTextCtrlGrowable(grow:Int = True)
		bmx_wxpickerbase_settextctrlgrowable(wxObjectPtr, grow)
	End Method
	
	Rem
	bbdoc: Returns true if the picker control is growable.
	End Rem
	Method IsPickerCtrlGrowable:Int()
		Return bmx_wxpickerbase_ispickerctrlgrowable(wxObjectPtr)
	End Method
	
End Type
