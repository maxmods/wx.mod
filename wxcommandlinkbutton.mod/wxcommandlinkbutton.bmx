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
bbdoc: wxCommandLinkButton
End Rem
Module wx.wxCommandLinkButton

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
bbdoc: Objects of this type are similar in appearance to the normal wxButtons but are similar to the links in a web page in functionality.
about: Pressing such button usually results in switching to another window of the program and so they can be used as a replacement for the "Next" button
in a multi-page dialog (such as wxWizard), for example.
<p>
Their advantage compared to the ordinary wxButtons is that they emphasize the action of switching the window and also that they allow to give more
detailed explanation to the user because, in addition to the short button label, they also show a longer description string.
</p>
<p>
The short, title-like, part of the label is called the main label and the longer description is the note. Both of them can be set and queried
independently using wxCommandLinkButton-specific methods such as SetMainLabel() or GetNote() or also via SetLabel() and GetLabel() methods
inherited from wxButton. When using the latter, the main label and the note are concatenated into a single string using a new line character
between them (notice that the note part can have more new lines in it).
</p>
<p>
wxCommandLinkButton generates the same event as wxButton but doesn't support any of wxButton-specific styles nor adds any new styles of its own.
</p>
<p>
Currently this class uses native implementation under Windows Vista and later versions and a generic implementation for the other platforms and earlier Windows versions.
</p>
End Rem
Type wxCommandLinkButton Extends wxButton

	Function _create:wxCommandLinkButton(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCommandLinkButton = New wxCommandLinkButton
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxCommandLinkButton(wxObjectPtr:Byte Ptr)
		Return wxCommandLinkButton._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateCommandLinkButton:wxCommandLinkButton(parent:wxWindow, id:Int, mainLabel:String = Null, note:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
			
		Return New wxCommandLinkButton.CreateLinkButton(parent, id, mainLabel, note, x, y, w, h, style)

	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateLinkButton:wxCommandLinkButton(parent:wxWindow, id:Int, mainLabel:String = Null, note:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxcommandlinkbutton_create(Self, parent.wxObjectPtr, id, mainLabel, note, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetLabel(label:String)
		bmx_wxcommandlinkbutton_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabel:String()
		Return bmx_wxcommandlinkbutton_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMainLabel(mainLabel:String)
		bmx_wxcommandlinkbutton_setmainlabel(wxObjectPtr, mainLabel)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetNote(note:String)
		bmx_wxcommandlinkbutton_setnote(wxObjectPtr, note)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMainLabel:String()
		Return bmx_wxcommandlinkbutton_getmainlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNote:String()
		Return bmx_wxcommandlinkbutton_getnote(wxObjectPtr)
	End Method

End Type

Type TCommandLinkButtonResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxcommandlinkbutton_addresourcehandler()
	End Method
		
End Type

New TCommandLinkButtonResourceFactory
