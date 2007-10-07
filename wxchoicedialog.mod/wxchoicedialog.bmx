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

Rem
bbdoc: wxChoiceDialog
End Rem
Module wx.wxChoiceDialog

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
bbdoc: This type represents a dialog that shows a list of strings, and allows the user to select one.
about: Double-clicking on a list item is equivalent to single-clicking and then pressing OK.
End Rem
Type wxSingleChoiceDialog Extends wxDialog

	Rem
	bbdoc: Constructor, taking an array of wxString choices
	End Rem
	Function CreateSingleChoiceDialog:wxSingleChoiceDialog(parent:wxWindow, message:String, ..
			caption:String, choices:String[], style:Int = wxCHOICEDLG_STYLE, x:Int = -1, y:Int = -1)
		Return New wxSingleChoiceDialog.Create(parent, message, caption, choices, style, x, y)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSingleChoiceDialog(parent:wxWindow, message:String, ..
			caption:String, choices:String[], style:Int = wxCHOICEDLG_STYLE, x:Int = -1, y:Int = -1)
		wxObjectPtr = bmx_wxsinglechoicedialog_create(Self, parent.wxObjectPtr, message, caption, choices, style, x, y)
		Return Self
	End Method

	Rem
	bbdoc: Returns the index of selected item.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxsinglechoicedialog_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the selected string.
	End Rem
	Method GetStringSelection:String()
		Return bmx_wxsinglechoicedialog_getstringselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the index of the initially selected item.
	End Rem
	Method SetSelection(index:Int)
		bmx_wxsinglechoicedialog_setselection(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning either wxID_OK or wxID_CANCEL.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxsinglechoicedialog_showmodal(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: This type represents a dialog that shows a list of strings, and allows the user to select one or more.
End Rem
Type wxMultiChoiceDialog Extends wxDialog

	Rem
	bbdoc: Constructor, taking an array of string choices
	End Rem
	Function CreateSingleChoiceDialog:wxMultiChoiceDialog(parent:wxWindow, message:String, ..
			caption:String, choices:String[], style:Int = wxCHOICEDLG_STYLE, x:Int = -1, y:Int = -1)
		Return New wxMultiChoiceDialog.Create(parent, message, caption, choices, style, x, y)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMultiChoiceDialog(parent:wxWindow, message:String, ..
			caption:String, choices:String[], style:Int = wxCHOICEDLG_STYLE, x:Int = -1, y:Int = -1)
		wxObjectPtr = bmx_wxmultichoicedialog_create(Self, parent.wxObjectPtr, message, caption, choices, style, x, y)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns array with indexes of selected items.
	End Rem
	Method GetSelections:Int[]()
		Return bmx_wxmultichoicedialog_getselections(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets selected items from the array of selected items' indexes.
	End Rem
	Method SetSelections(selections:Int[])
		bmx_wxmultichoicedialog_setselections(wxObjectPtr, selections)
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning either wxID_OK or wxID_CANCEL.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxmultichoicedialog_showmodal(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: Pops up a dialog box containing a message, OK/Cancel buttons and a single-selection listbox.
about: The user may choose an item and press OK to return a string or Cancel to return the empty string.
Use wxGetSingleChoiceIndex if empty string is a valid choice and if you want to be able to detect pressing
Cancel reliably.
<p>
If centre is True, the message text (which may include new line characters) is centred; if False,
the message is left-justified.
</p>
End Rem
Function wxGetSingleChoice:String(message:String, caption:String, choices:String[], parent:wxWindow = Null, ..
		x:Int = -1, y:Int = -1, centre:Int = True, width:Int = 150, height:Int = 200)

	If parent Then
		Return bmx_wxgetsinglechoice(message, caption, choices, parent.wxObjectPtr, x, y, centre, width, height)
	Else
		Return bmx_wxgetsinglechoice(message, caption, choices, Null, x, y, centre, width, height)
	End If

End Function

Rem
bbdoc: As wxGetSingleChoice but returns the index representing the selected string.
about: If the user pressed cancel, -1 is returned.
End Rem
Function wxGetSingleChoiceIndex:Int(message:String, caption:String, choices:String[], parent:wxWindow = Null, ..
		x:Int = -1, y:Int = -1, centre:Int = True, width:Int = 150, height:Int = 200)

	If parent Then
		Return bmx_wxgetsinglechoiceindex(message, caption, choices, parent.wxObjectPtr, x, y, centre, width, height)
	Else
		Return bmx_wxgetsinglechoiceindex(message, caption, choices, Null, x, y, centre, width, height)
	End If

End Function
