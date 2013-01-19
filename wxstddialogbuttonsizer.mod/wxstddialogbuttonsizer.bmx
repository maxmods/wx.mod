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
bbdoc: wxStdDialogButtonSizer
End Rem
Module wx.wxStdDialogButtonSizer

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


Rem
bbdoc: This type creates button layouts which conform to the standard button spacing and ordering defined by the platform or toolkit's user interface guidelines (if such things exist).
about: By using this type, you can ensure that all your standard dialogs look correct on all major
platforms. Currently it conforms to the Windows, GTK+ and Mac OS X human interface guidelines.
<p>
When there aren't interface guidelines defined for a particular platform or toolkit, wxStdDialogButtonSizer
reverts to the Windows implementation. 
</p>
<p>
To use this class, first add buttons to the sizer by calling AddButton (or SetAffirmativeButton,
SetNegativeButton, or SetCancelButton) and then call Realize in order to create the actual button
layout used. Other than these special operations, this sizer works like any other sizer. 
</p>
<p>
If you add a button with wxID_SAVE, on Mac OS X the button will be renamed to "Save" and the wxID_NO
button will be renamed to "Don't Save" in accordance with the Mac OS X Human Interface Guidelines.
</p>
End Rem
Type wxStdDialogButtonSizer Extends wxBoxSizer

	Function _create:wxStdDialogButtonSizer(wxSizerPtr:Byte Ptr)
		If wxSizerPtr Then
			Local this:wxStdDialogButtonSizer = New wxStdDialogButtonSizer
		
			this.wxSizerPtr = wxSizerPtr
		
			Return this
		End If
		
		Return Null
	End Function

	Function _xrcNew:wxStdDialogButtonSizer(wxObjectPtr:Byte Ptr)
		Return wxStdDialogButtonSizer._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Constructor for a wxStdDialogButtonSizer.
	End Rem
	Function CreateStdDialogButtonSizer:wxStdDialogButtonSizer()
		Return New wxStdDialogButtonSizer.CreateSIzer()
	End Function
	
	Rem
	bbdoc: Constructor for a wxStdDialogButtonSizer.
	End Rem
	Method CreateSizer:wxStdDialogButtonSizer()
		wxSizerPtr = bmx_wxstddialogbuttonsizer_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: Adds a button to the wxStdDialogButtonSizer.
	about: The button must have one of the following identifiers:
	<ul>
	<li>wxID_OK </li>
	<li>wxID_YES </li>
	<li>wxID_SAVE </li>
	<li>wxID_APPLY </li>
	<li>wxID_NO </li>
	<li>wxID_CANCEL </li>
	<li>wxID_HELP </li>
	<li>wxID_CONTEXT_HELP </li>
	</ul>
	End Rem
	Method AddButton(button:wxButton)
		bmx_wxstddialogbuttonsizer_addbutton(wxSizerPtr, button.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Rearranges the buttons and applies proper spacing between buttons to make them match the platform or toolkit's interface guidelines.
	End Rem
	Method Realize()
		bmx_wxstddialogbuttonsizer_realize(wxSizerPtr)
	End Method
	
	Rem
	bbdoc: Sets the affirmative button for the sizer.
	about: This allows you to use identifiers other than the standard identifiers outlined above.
	End Rem
	Method SetAffirmativeButton(button:wxButton)
		bmx_wxstddialogbuttonsizer_setaffirmativebutton(wxSizerPtr, button.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the cancel button for the sizer.
	about: This allows you to use identifiers other than the standard identifiers outlined above.
	End Rem
	Method SetCancelButton(button:wxButton)
		bmx_wxstddialogbuttonsizer_setcancelbutton(wxSizerPtr, button.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the negative button for the sizer.
	about: This allows you to use identifiers other than the standard identifiers outlined above.
	End Rem
	Method SetNegativeButton(button:wxButton)
		bmx_wxstddialogbuttonsizer_setnegativebutton(wxSizerPtr, button.wxObjectPtr)
	End Method
	
End Type


Type TStdDialogButtonSizerResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxstddialogbuttonsizer_addresourcehandler()
	End Method
		
End Type

New TStdDialogButtonSizerResourceFactory
