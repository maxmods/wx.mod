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

