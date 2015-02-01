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
Import wx.wxImage
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

	Function bmx_wxanimation_createnull:Byte Ptr()
	Function bmx_wxanimation_create:Byte Ptr(name:String, animType:Int)
	Function bmx_wxanimation_getdelay:Int(handle:Byte Ptr, frame:Int)
	Function bmx_wxanimation_getframe:Byte Ptr(handle:Byte Ptr, frame:Int)
	Function bmx_wxanimation_getframecount:Int(handle:Byte Ptr)
	Function bmx_wxanimation_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxanimation_isok:Int(handle:Byte Ptr)
	Function bmx_wxanimation_loadfromstream:Int(handle:Byte Ptr, stream:Byte Ptr, animType:Int)
	Function bmx_wxanimation_loadfile:Int(handle:Byte Ptr, name:String, animType:Int)
	Function bmx_wxanimation_free(handle:Byte Ptr)

End Extern


Rem
bbdoc: 
End Rem
Const wxANIMATION_TYPE_INVALID:Int = 0
Rem
bbdoc: Represents an animated GIF file.
End Rem
Const wxANIMATION_TYPE_GIF:Int = 1
Rem
bbdoc: Represents an ANI file.
End Rem
Const wxANIMATION_TYPE_ANI:Int = 2
Rem
bbdoc: Autodetect the filetype.
End Rem
Const wxANIMATION_TYPE_ANY:Int = 3
