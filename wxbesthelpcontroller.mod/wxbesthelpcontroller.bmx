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
bbdoc: wxBestHelpController
End Rem
Module wx.wxBestHelpController

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

?win32
Import "common.bmx"


Type wxBestHelpController Extends wxHelpControllerBase

	Rem
	bbdoc: Creates a new wxchmhelpcontroller.
	End Rem
	Function CreateBestHelpController:wxBestHelpController(parentWindow:wxWindow = Null, style:Int = wxHF_DEFAULT_STYLE)
		Return New wxBestHelpController.Create(parentWindow, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxchmhelpcontroller.
	End Rem
	Method Create:wxBestHelpController(parentWindow:wxWindow = Null, style:Int = wxHF_DEFAULT_STYLE)
		If parentWindow Then
			wxObjectPtr = bmx_wxbesthelpcontroller_create(Self, parentWindow.wxObjectPtr, style)
		Else
			wxObjectPtr = bmx_wxbesthelpcontroller_create(Self, Null, style)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Displays help window and focuses contents panel.
	End Rem
	Method DisplayContents()
		bmx_wxbesthelpcontroller_displaycontents(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Displays help window, focuses search panel and starts searching.
	about: Returns true if the keyword was found. Optionally it searches through the index
	(mode = wxHELP_SEARCH_INDEX), default the content (mode = wxHELP_SEARCH_ALL).
	<p>
	Important: KeywordSearch searches only pages listed in .hhc file(s). You should list all pages in the contents file.
	</p>
	End Rem
	Method KeywordSearch:Int(keyword:String, mode:Int = wxHELP_SEARCH_ALL)
		Return bmx_wxbesthelpcontroller_keywordsearch(wxObjectPtr, keyword, mode)
	End Method

End Type
?
