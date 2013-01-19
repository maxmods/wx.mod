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
bbdoc: wxSymbolPickerDialog
End Rem
Module wx.wxSymbolPickerDialog

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
bbdoc: Presents the user with a choice of fonts and a grid of available characters.
about: This modal dialog provides the application with a selected symbol and optional font
selection.
<p>
Although this dialog is contained in the rich text library, the dialog is generic and can be
used in other contexts.
</p>
<p>
To use the dialog, pass a default symbol specified as a string, an initial font name, and a
current font name. The difference between the initial font and current font is that the
initial font determines what the font control will be set to when the dialog shows - an empty
string will show the selection normal text. The current font, on the other hand, is used by
the dialog to determine what font to display the characters in, even when no initial font is
selected. This allows the user (and application) to distinguish between inserting a symbol in
the current font, and inserting it with a specified font.
</p>
<p>
When the dialog is dismissed, the application can get the selected symbol with GetSymbol and
test whether a font was specified with UseNormalFont, fetching the specified font with
GetFontName.
</p>
End Rem
Type wxSymbolPickerDialog Extends wxDialog

	Function CreateSymbolPickerDialog:wxSymbolPickerDialog()
	End Function
	
	Method Create:wxSymbolPickerDialog()
	End Method
	
	Method GetFontName:String()
	End Method
	
	Method GetFromUnicode:Int()
	End Method
	
	Method GetNormalTextFontName:String()
	End Method
	
	Method GetSymbol:String()
	End Method
	
	Method GetSymbolChar:Int()
	End Method
	
	Method HasSelection:Int()
	End Method
	
	Method SetFontName(value:String)
	End Method
	
	Method SetFromUnicode(value:Int)
	End Method
	
	Method SetNormalTextFontName(value:String)
	End Method
	
	Method SetSymbol(value:String)
	End Method
	
	Method SetUnicodeMode(mode:Int)
	End Method
	
	Method UseNormalFont:Int()
	End Method

End Type


