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

Import "core.bmx"


Rem
bbdoc: This is the base type for a control or "widget''.
about: A control is generally a small window which processes user input and/or displays one or more item of data.
End Rem
Type wxControl Extends wxWindow

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

Type wxBookCtrlBase Extends wxControl

End Type

