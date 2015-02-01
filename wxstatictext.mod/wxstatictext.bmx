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

Rem
bbdoc: wxStaticText
End Rem
Module wx.wxStaticText

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
bbdoc: A static text control displays one or more lines of read-only text.
about:
<b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxALIGN_LEFT</td><td>Align the text to the left</td></tr>
<tr><td>wxALIGN_RIGHT</td><td>Align the text to the right</td></tr>
<tr><td>wxALIGN_CENTRE</td><td>Center the text (horizontally)</td></tr>
<tr><td>wxST_NO_AUTORESIZE</td><td>By default, the control will adjust its size to exactly fit to the size
of the text when SetLabel is called. If this style flag is given, the control will not change its size 
(this style is especially useful with controls which also have wxALIGN_RIGHT or CENTER style because
otherwise they won't make sense any longer after a call to SetLabel)</td></tr>
</table>
End Rem
Type wxStaticText Extends wxControl

	Function _create:wxStaticText(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxStaticText = New wxStaticText
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxStaticText(wxObjectPtr:Byte Ptr)
		Return wxStaticText._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor, creating and showing a text control.
	End Rem
	Function CreateStaticText:wxStaticText(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		Return New wxStaticText.Create(parent, id, label, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see #CreateStaticText.
	End Rem
	Method Create:wxStaticText(parent:wxWindow, id:Int, label:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		wxObjectPtr = bmx_wxstatictext_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the contents of the control.
	End Rem
	Method GetLabel:String()
		Return bmx_wxstatictext_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the static text label and updates the controls size to exactly fit the label unless the control has wxST_NO_AUTORESIZE flag.
	End Rem
	Method SetLabel(label:String)
		bmx_wxstatictext_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: This method wraps the controls label so that each of its lines becomes at most width pixels
	wide if possible (the lines are broken at words boundaries so it might not be the case if
	words are too long). If width is negative, no wrapping is done.
	End Rem
	Method Wrap(width:Int)
		bmx_wxstatictext_wrap(wxObjectPtr, width)
	End Method
	
End Type

Type TStaticTextResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxstatictext_addresourcehandler()
	End Method
		
End Type

New TStaticTextResourceFactory
