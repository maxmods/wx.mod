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
bbdoc: wxPickerBase
End Rem
Module wx.wxPickerBase

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
bbdoc: Base abstract type for all pickers which support an auxiliary text control.
about: This type handles all positioning and sizing of the text control like a an horizontal wxBoxSizer
would do, with the text control on the left of the picker button. The proportion (see wxSizer
documentation for more info about proportion values) of the picker control defaults to 1 when there
isn't a text control associated (see wxPB_USE_TEXTCTRL style) and to 0 otherwise.
End Rem
Type wxPickerBase Extends wxControl Abstract

	Method SetInternalMargin(margin:Int)
	End Method
	
	Method GetInternalMargin:Int()
	End Method
	
	Method SetTextCtrlProportion(prop:Int)
	End Method
	
	Method SetPickerCtrlProportion(prop:Int)
	End Method
	
	Method GetTextCtrlProportion:Int()
	End Method
	
	Method GetPickerCtrlProportion:Int()
	End Method
	
	Method HasTextCtrl:Int()
	End Method
	
	Method GetTextCtrl:wxTextCtrl()
	End Method
	
	Method IsTextCtrlGrowable:Int()
	End Method
	
	Method SetPickerCtrlGrowable(grow:Int = True)
	End Method
	
	Method SetTextCtrlGrowable(grow:Int = True)
	End Method
	
	Method IsPickerCtrlGrowable:Int()
	End Method
	
End Type
