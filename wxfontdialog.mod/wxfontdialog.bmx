' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxFontDialog
End Rem
Module wx.wxFontDialog

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: This type represents the font chooser dialog.
End Rem
Type wxFontDialog Extends wxDialog

	Rem
	bbdoc: Constructor.
	about: Pass a parent window, and optionally the font data object to be used to initialize the dialog
	controls.
	End Rem
	Function CreateFontDialog:wxFontDialog(parent:wxWindow, data:wxFontData = Null)
		Return New wxFontDialog.CreateFD(parent, data)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass a parent window, and optionally the font data object to be used to initialize the dialog
	controls.
	End Rem
	Method CreateFD:wxFontDialog(parent:wxWindow, data:wxFontData = Null)
		If data Then
			wxObjectPtr = bmx_wxfontdialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxfontdialog_create(Self, parent.wxObjectPtr, Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Returns the font data associated with the font dialog.
	End Rem
	Method GetFontData:wxFontData()
		Return wxFontData._create(bmx_wxfontdialog_getfontdata(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Shows the dialog, returning wxID_OK if the user pressed Ok, and wxID_CANCEL otherwise.
	about: If the user cancels the dialog (ShowModal returns wxID_CANCEL), no font will be created.
	If the user presses OK, a new wxFont will be created and stored in the font dialog's wxFontData
	structure.
	End Rem
	Method ShowModal:Int()
		Return bmx_wxfontdialog_showmodal(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: This type holds a variety of information related to font dialogs.
End Rem
Type wxFontData Extends wxObject

	Function _create:wxFontData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFontData = New wxFontData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructor.
	about: Initializes fontColour to black, showHelp to black, allowSymbols to true, enableEffects to true,
	minSize to 0 and maxSize to 0.
	End Rem
	Function CreateFontData:wxFontData()
		Return New wxFontData.Create()
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Initializes fontColour to black, showHelp to black, allowSymbols to true, enableEffects to true,
	minSize to 0 and maxSize to 0.
	End Rem
	Method Create:wxFontData()
		wxObjectPtr = bmx_wxfontdata_create()
		Return Self
	End Method

	Rem
	bbdoc: Enables or disables 'effects' under MS Windows or generic only.
	about: This refers to the controls for manipulating colour, strikeout and underline properties.
	<p>
	The default value is true.
	</p>
	End Rem
	Method EnableEffects(enable:Int)
		bmx_wxfontdata_enableeffects(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: Under MS Windows, returns a flag determining whether symbol fonts can be selected.
	about: Has no effect on other platforms.
	<p>
	The default value is true.
	</p>
	End Rem
	Method GetAllowSymbols:Int()
		Return bmx_wxfontdata_getallowsymbols(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the colour associated with the font dialog.
	about: The default value is black.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxfontdata_getcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the font chosen by the user if the user pressed OK (wxFontDialog::ShowModal returned wxID_OK).
	End Rem
	Method GetChosenFont:wxFont()
		Return wxFont._create(bmx_wxfontdata_getchosenfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Determines whether 'effects' are enabled under Windows.
	about: This refers to the controls for manipulating colour, strikeout and underline properties.
	<p>
	The default value is true.
	</p>
	End Rem
	Method GetEnableEffects:Int()
		Return bmx_wxfontdata_getenableeffects(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the font that will be initially used by the font dialog.
	about: This should have previously been set by the application.
	End Rem
	Method GetInitialFont:wxFont()
		Return wxFont._create(bmx_wxfontdata_getinitialfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns true if the Help button will be shown (Windows only).
	about: The default value is false.
	End Rem
	Method GetShowHelp:Int()
		Return bmx_wxfontdata_getshowhelp(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Under MS Windows, determines whether symbol fonts can be selected.
	about: Has no effect on other platforms.
	<p>
	The default value is true.
	</p>
	End Rem
	Method SetAllowSymbols(allowSymbols:Int)
		bmx_wxfontdata_setallowsymbols(wxObjectPtr, allowSymbols)
	End Method
	
	Rem
	bbdoc: Sets the font that will be returned to the user (for internal use only).
	End Rem
	Method SetChosenFont(font:wxFont)
		bmx_wxfontdata_setchosenfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the colour that will be used for the font foreground colour.
	about: The default colour is black.
	End Rem
	Method SetColour(colour:wxColour)
		bmx_wxfontdata_setcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font that will be initially used by the font dialog.
	End Rem
	Method SetInitialFont(font:wxFont)
		bmx_wxfontdata_setinitialfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the valid range for the font point size (Windows only).
	about: The default is 0, 0 (unrestricted range).
	End Rem
	Method SetRange(minSize:Int, maxSize:Int)
		bmx_wxfontdata_setrange(wxObjectPtr, minSize, maxSize)
	End Method
	
	Rem
	bbdoc: Determines whether the Help button will be displayed in the font dialog (Windows only).
	about: The default value is false.
	End Rem
	Method SetShowHelp(showHelp:Int)
		bmx_wxfontdata_setshowhelp(wxObjectPtr, showhelp)
	End Method
	
End Type

Rem
bbdoc: Shows the font selection dialog and returns the font selected by user or invalid font (use wxFont:IsOk to test whether a font is valid) if the dialog was cancelled.
End Rem
Function wxGetFontFromUser:wxFont(parent:wxWindow, font:wxFont = Null, caption:String = "")

	If parent Then
		If font Then
			Return wxFont._create(bmx_wxgetfontfromuser(parent.wxObjectPtr, font.wxObjectPtr, caption))
		Else
			Return wxFont._create(bmx_wxgetfontfromuser(parent.wxObjectPtr, Null, caption))
		End If
	Else
		If font Then
			Return wxFont._create(bmx_wxgetfontfromuser(Null, font.wxObjectPtr, caption))
		Else
			Return wxFont._create(bmx_wxgetfontfromuser(Null, Null, caption))
		End If
	End If
	
End Function


