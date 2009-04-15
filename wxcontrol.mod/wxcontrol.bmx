' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxControl
End Rem
Module wx.wxControl

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
bbdoc: This is the base type for a control or "widget''.
about: A control is generally a small window which processes user input and/or displays one or more item of data.
End Rem
Type wxControl Extends wxWindow

	Function _create:wxControl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxControl = New wxControl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates a new generic control
	End Rem
	Method CreateControl:wxControl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxcontrol_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Returns the control's text.
	about: Note that the returned string contains the mnemonics (& characters) if any, use wxControl::GetLabelText
	if they are undesired.
	End Rem
	Method GetLabel:String()
		Return bmx_wxcontrol_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the control's label or the given label string for the static version without the mnemonics characters.
	End Rem
	Method GetLabelText:String()
		Return bmx_wxcontrol_getlabeltext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the item's text.
	about: The &amp; characters in the label are special and indicate that the following character is a mnemonic
	for this control and can be used to activate it from the keyboard (typically by using Alt key in
	combination with it). To insert a literal ampersand character, you need to double it, i.e. use "&amp;&amp;".
	End Rem
	Method SetLabel(label:String)
		bmx_wxcontrol_setlabel(wxObjectPtr, label)
	End Method
	
End Type


Rem
bbdoc: General purpose message dialog.
returns: One of: wxYES, wxNO, wxCANCEL or wxOK.
about: @style may be a bit list of the following identifiers:
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxYES_NO</td><td>Puts Yes and No buttons on the message box. May be combined with wxCANCEL. </td></tr>
<tr><td>wxCANCEL </td><td>Puts a Cancel button on the message box. May only be combined with wxYES_NO or wxOK. </td></tr>
<tr><td>wxOK </td><td>Puts an Ok button on the message box. May be combined with wxCANCEL. </td></tr>
<tr><td>wxICON_EXCLAMATION </td><td>Displays an exclamation mark symbol. </td></tr>
<tr><td>wxICON_HAND </td><td>Displays an error symbol. </td></tr>
<tr><td>wxICON_ERROR </td><td>Displays an error symbol - the same as wxICON_HAND. </td></tr>
<tr><td>wxICON_QUESTION </td><td>Displays a question mark symbol. </td></tr>
<tr><td>wxICON_INFORMATION </td><td>Displays an information symbol. </td></tr>
</table>
End Rem
Function wxMessageBox:Int(message:String, caption:String = "Message", style:Int = wxOK, parent:wxWindow = Null, ..
		x:Int = -1, y:Int = -1)
		
	If parent Then
		Return bmx_wxmessagebox(message, caption, style, parent.wxObjectPtr, x, y)
	Else
		Return bmx_wxmessagebox(message, caption, style, Null, x, y)
	End If
		
End Function

