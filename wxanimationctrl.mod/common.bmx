' Copyright (c) 2007-2015 Bruce A Henderson
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

Import wx.wx
Import wx.wxAnimation
Import wx.wxBitmap
Import wx.wxControl
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "glue.cpp"

Extern

	Function bmx_wxanimationctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, anim:Byte Ptr, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxanimationctrl_getanimation:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxanimationctrl_getinactivebitmap:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxanimationctrl_isplaying:Int(handle:Byte Ptr)
	Function bmx_wxanimationctrl_loadfile:Int(handle:Byte Ptr, file:String, animType:Int)
	Function bmx_wxanimationctrl_load:Int(handle:Byte Ptr, stream:Byte Ptr, animType:Int)
	Function bmx_wxanimationctrl_play:Int(handle:Byte Ptr)
	Function bmx_wxanimationctrl_setanimation(handle:Byte Ptr, anim:Byte Ptr)
	Function bmx_wxanimationctrl_setinactivebitmap(handle:Byte Ptr, bitmap:Byte Ptr)
	Function bmx_wxanimationctrl_stop(handle:Byte Ptr)

	Function bmx_wxanimationctrl_addresourcehandler()

End Extern

Rem
bbdoc: Do not autoresize to the animation's size when SetAnimation() is called
End Rem
Const wxAC_NO_AUTORESIZE:Int = $0010

Rem
bbdoc: Default style does not include wxAC_NO_AUTORESIZE, that is, the control auto-resizes by default to fit the new animation when SetAnimation() is called
End Rem
Const wxAC_DEFAULT_STYLE:Int = wxBORDER_NONE

