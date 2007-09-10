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

Module wx.wxIcon

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
bbdoc: An icon is a small rectangular bitmap usually used for denoting a minimized application.
about: It differs from a wxBitmap in always having a mask associated with it for transparent drawing.
On some platforms, icons and bitmaps are implemented identically, since there is no real distinction
between a wxBitmap with a mask and an icon; and there is no specific icon format on some platforms
(X-based applications usually standardize on XPMs for small bitmaps and icons). However, some platforms
(such as Windows) make the distinction, so a separate class is provided.
End Rem
Type wxIcon Extends wxBitmap
Rem
	Function CreateIconURL
	
		Local str$=String( url ),proto$,path$
	If str
		Local i=str.Find( "::",0 )
		If i=-1 Return TCStream.OpenFile( str,readable,writeable )
		proto$=str[..i].ToLower()
		path$=str[i+2..]
	EndIf
	

		If proto="incbin" And writeable=False
			Local buf:Byte Ptr=IncbinPtr( path )
			If Not buf Return
			Local size=IncbinLen( path )
			Return TRamStream.Create( buf,size,readable,writeable )
		EndIf

End Rem

	Function _create:wxIcon(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxIcon = New wxIcon
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

End Type

