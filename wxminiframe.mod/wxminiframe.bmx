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
bbdoc: wxMiniFrame
End Rem
Module wx.wxMiniFrame

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
bbdoc: A miniframe is a frame with a small title bar.
about: It is suitable for floating toolbars that must not take up too much screen area.
<p>
This type has miniframe functionality under Windows and GTK, i.e. the presence of mini frame will
not be noted in the task bar and focus behaviour is different. On other platforms, it behaves like a
normal frame.
</p>
End Rem
Type wxMiniFrame Extends wxFrame

	Rem
	bbdoc: Constructor, creating the window.
	End Rem
	Function CreateMiniFrame:wxMiniFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxCAPTION | wxRESIZE_BORDER)
	
		Return New wxMiniFrame.Create(parent, id, title, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Used in two-step frame construction. See CreateMiniFrame for further details.
	End Rem
	Method Create:wxMiniFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxCAPTION | wxRESIZE_BORDER)
	
		If parent Then
			wxObjectPtr = bmx_wxminiframe_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxminiframe_create(Self, Null, id, title, x, y, w, h, style)
		End If
		
		OnInit()
		Return Self
	End Method
	
End Type




