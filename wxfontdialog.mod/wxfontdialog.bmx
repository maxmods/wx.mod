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
bbdoc: wxFontDialog
End Rem
Module wx.wxFontDialog

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
bbdoc: This type represents the font chooser dialog.
End Rem
Type wxFontDialog Extends wxDialog

	

	Method GetFontData:wxFontData()
	End Method
	
End Type

Rem
bbdoc: This type holds a variety of information related to font dialogs.
End Rem
Type wxFontData Extends wxObject

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
		
		Return Self
	End Method

	Rem
	bbdoc: Enables or disables 'effects' under MS Windows or generic only.
	about: This refers to the controls for manipulating colour, strikeout and underline properties.
	<p>
	The default value is true.
	</p>
	End Rem
	Method EnableEffects:Int(enable:Int)
	End Method
	
	Rem
	bbdoc: Under MS Windows, returns a flag determining whether symbol fonts can be selected.
	about: Has no effect on other platforms.
	<p>
	The default value is true.
	</p>
	End Rem
	Method GetAllowSymbols:Int()
	End Method
	
	Rem
	bbdoc: Gets the colour associated with the font dialog.
	about: The default value is black.
	End Rem
	Method GetColour:wxColour()
	End Method
	
	Rem
	bbdoc: Gets the font chosen by the user if the user pressed OK (wxFontDialog::ShowModal returned wxID_OK).
	End Rem
	Method GetChosenFont:wxFont()
	End Method
	
	Rem
	bbdoc: Determines whether 'effects' are enabled under Windows.
	about: This refers to the controls for manipulating colour, strikeout and underline properties.
	<p>
	The default value is true.
	</p>
	End Rem
	Method GetEnableEffects:Int()
	End Method
	
	Rem
	bbdoc: Gets the font that will be initially used by the font dialog.
	about: This should have previously been set by the application.
	End Rem
	Method GetInitialFont:wxFont()
	End Method
	
	Rem
	bbdoc: Returns true if the Help button will be shown (Windows only).
	about: The default value is false.
	End Rem
	Method GetShowHelp:Int()
	End Method
	
	Rem
	bbdoc: Under MS Windows, determines whether symbol fonts can be selected.
	about: Has no effect on other platforms.
	<p>
	The default value is true.
	</p>
	End Rem
	Method SetAllowSymbols(allowSymbols:Int)
	End Method
	
	Rem
	bbdoc: Sets the font that will be returned to the user (for internal use only).
	End Rem
	Method SetChosenFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: Sets the colour that will be used for the font foreground colour.
	about: The default colour is black.
	End Rem
	Method SetColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: Sets the font that will be initially used by the font dialog.
	End Rem
	Method SetInitialFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: Sets the valid range for the font point size (Windows only).
	about: The default is 0, 0 (unrestricted range).
	End Rem
	Method SetRange(minSize:Int, maxSize:Int)
	End Method
	
	Rem
	bbdoc: Determines whether the Help button will be displayed in the font dialog (Windows only).
	about: The default value is false.
	End Rem
	Method SetShowHelp(showHelp:Int)
	End Method
	
End Type

Rem
bbdoc: Shows the font selection dialog and returns the font selected by user or invalid font (use wxFont:IsOk to test whether a font is valid) if the dialog was cancelled.
End Rem
Function wxGetFontFromUser:wxFont(parent:wxWindow, font:wxFont, caption:String = "")

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


