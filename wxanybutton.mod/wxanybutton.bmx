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
bbdoc: wxAnyButton
End Rem
Module wx.wxAnyButton

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

Type wxAnyButton Extends wxControl

	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmap(wxObjectPtr))
	End Method
	
	Method GetBitmapCurrent:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmapcurrent(wxObjectPtr))
	End Method

	Method GetBitmapDisabled:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmapdisabled(wxObjectPtr))
	End Method

	Method GetBitmapFocus:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmapfocus(wxObjectPtr))
	End Method

	Method GetBitmapLabel:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmaplabel(wxObjectPtr))
	End Method

	Method GetBitmapPressed:wxBitmap()
		Return wxBitmap._create(bmx_wxanybutton_getbitmappressed(wxObjectPtr))
	End Method
	
	Method SetBitmap(bitmap:wxBitmap, dir:Int = wxLEFT)
		bmx_wxanybutton_setbitmap(wxObjectPtr, bitmap.wxObjectPtr, dir)
	End Method

	Method SetBitmapCurrent(bitmap:wxBitmap)
		bmx_wxanybutton_setbitmapcurrent(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Method SetBitmapDisabled(bitmap:wxBitmap)
		bmx_wxanybutton_setbitmapdisabled(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Method SetBitmapFocus(bitmap:wxBitmap)
		bmx_wxanybutton_setbitmapfocus(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Method SetBitmapLabel(bitmap:wxBitmap)
		bmx_wxanybutton_setbitmaplabel(wxObjectPtr, bitmap.wxObjectPtr)
	End Method

	Method SetBitmapPressed(bitmap:wxBitmap)
		bmx_wxanybutton_setbitmappressed(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Method GetBitmapMargins(x:Int Var, y:Int Var)
		bmx_wxanybutton_getbitmapmargins(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Method SetBitmapPosition(dir:Int)
		bmx_wxanybutton_setbitmapposition(wxObjectPtr, dir)
	End Method
	
	Method SetBitmapMargins(x:Int, y:Int)
		bmx_wxanybutton_setbitmapmargins(wxObjectPtr, x, y)
	End Method

End Type


