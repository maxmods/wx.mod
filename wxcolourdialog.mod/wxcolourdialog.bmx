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
bbdoc: wxColourDialog
End Rem
Module wx.wxColourDialog

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
bbdoc: This type represents the colour chooser dialog.
End Rem
Type wxColourDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Pass a parent window, and optionally a pointer to a block of colour data, which will
	be copied to the colour dialog's colour data. Custom colours from colour data object will be be
	used in dialog's colour palette. Invalid entries in custom colours list will be ignored on some
	platforms (GTK) or replaced with white colour on platforms where custom colours palette has
	fixed size (MSW).
	End Rem
	Function CreateColourDialog:wxColourDialog(parent:wxWindow, data:wxColourData = Null)
		Return New wxColourDialog.Create(parent, data)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxColourDialog(parent:wxWindow, data:wxColourData = Null)
		If parent Then
			If data Then
				wxObjectPtr = bmx_wxcolourdialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr)
			Else
				wxObjectPtr = bmx_wxcolourdialog_create(Self, parent.wxObjectPtr, Null)
			End If
		Else
			If data Then
				wxObjectPtr = bmx_wxcolourdialog_create(Self, Null, data.wxObjectPtr)
			Else
				wxObjectPtr = bmx_wxcolourdialog_create(Self, Null, Null)
			End If
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the colour data associated with the colour dialog.
	End Rem
	Method GetColourData:wxColourData()
		Return wxColourData._create(bmx_wxcolourdialog_getcolourdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: ()Shows the dialog, returning wxID_OK if the user pressed OK, and wxID_CANCEL otherwise.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxcolourdialog_showmodal(wxObjectPtr)
	End Method

End Type

Rem
bbdoc: This type holds a variety of information related to colour dialogs.
End Rem
Type wxColourData Extends wxObject

	Function _create:wxColourData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxColourData = New wxColourData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructor.
	about: Initializes the custom colours to wxNullColour, the data colour setting to black,
	and the choose full setting to true.
	End Rem
	Function CreateColourData:wxColourData()
		Return New wxColourData.Create()
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Initializes the custom colours to wxNullColour, the data colour setting to black,
	and the choose full setting to true.
	End Rem
	Method Create:wxColourData()
		wxObjectPtr = bmx_wxcolourdata_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Under Windows, determines whether the Windows colour dialog will display the full dialog with custom colour selection controls. Has no meaning under other platforms.
	about: The default value is true.
	End Rem
	Method GetChooseFull:Int()
		Return bmx_wxcolourdata_getchoosefull(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the current colour associated with the colour dialog.
	about: The default colour is black.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxcolourdata_getcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the ith custom colour associated with the colour dialog.
	about: @i should be an integer between 0 and 15.
	<p>
	The default custom colours are invalid colours.
	</p>
	End Rem
	Method GetCustomColour:wxColour(i:Int)
		Return wxColour._create(bmx_wxcolourdata_getcustomcolour(wxObjectPtr, i))
	End Method
	
	Rem
	bbdoc: Under Windows, tells the Windows colour dialog to display the full dialog with custom colour selection controls. Under other platforms, has no effect.
	about: The default value is true.
	End Rem
	Method SetChooseFull(flag:Int)
		bmx_wxcolourdata_setchoosefull(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets the default colour for the colour dialog.
	about: The default colour is black.
	End Rem
	Method SetColour(colour:wxColour)
		bmx_wxcolourdata_setcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the ith custom colour for the colour dialog.
	about: @i should be an integer between 0 and 15.
	<p>
	The default custom colours are invalid colours.
	</p>
	End Rem
	Method SetCustomColour(i:Int, colour:wxColour)
		bmx_wxcolourdata_setcustomcolour(wxObjectPtr, i, colour.wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcolourdata_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Shows the colour selection dialog and returns the colour selected by user or invalid colour (use wxColour:IsOk to test whether a colour is valid) if the dialog was cancelled.
End Rem
Function wxGetColourFromUser:wxColour(parent:wxWindow, init:wxColour = Null, caption:String = "")

	If parent Then
		If init Then
			Return wxColour._create(bmx_wxgetcolourfromuser(parent.wxObjectPtr, init.wxObjectPtr, caption))
		Else
			Return wxColour._create(bmx_wxgetcolourfromuser(parent.wxObjectPtr, Null, caption))
		End If
	Else
		If init Then
			Return wxColour._create(bmx_wxgetcolourfromuser(Null, init.wxObjectPtr, caption))
		Else
			Return wxColour._create(bmx_wxgetcolourfromuser(Null, Null, caption))
		End If
	End If

End Function

