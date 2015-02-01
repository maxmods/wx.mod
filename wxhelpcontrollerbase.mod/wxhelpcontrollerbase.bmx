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
bbdoc: wxHelpControllerBase
End Rem
Module wx.wxHelpControllerBase

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
bbdoc: 
End Rem
Type wxHelpControllerBase Extends wxObject

	' soft linking
	Function _create:wxHelpControllerBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this: wxHelpControllerBase = New wxHelpControllerBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxHelpControllerBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local controller:wxHelpControllerBase = wxHelpControllerBase(wxfind(wxObjectPtr))
			If Not controller Then
				Return wxHelpControllerBase._create(wxObjectPtr)
			End If
			Return controller
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Initialize:Int(file:String)
		Return bmx_wxhelpcontrollerbase_initialize(wxObjectPtr, file)
	End Method

	Method DisplayBlock:Int(blockNo:Int)
		Return bmx_wxhelpcontrollerbase_displayBlock(wxObjectPtr, blockNo)
	End Method
	
	Method DisplayContextPopup:Int(contextId:Int)
		Return bmx_wxhelpcontrollerbase_displaycontextpopup(wxObjectPtr, contextId)
	End Method
	
	Method DisplaySection:Int(sectionNo:Int)
		Return bmx_wxhelpcontrollerbase_displaysection(wxObjectPtr, sectionNo)
	End Method
	
	Method DisplaySectionByName:Int(section:String)
		Return bmx_wxhelpcontrollerbase_displaysectionbyname(wxObjectPtr, section)
	End Method
	
	Method DisplayTextPopup:Int(text:String, x:Int, y:Int)
		Return bmx_wxhelpcontrollerbase_displaytextpopup(wxObjectPtr, text,x, y)
	End Method
	
	Method GetParentWindow:wxWindow()
		Return wxWindow._find(bmx_wxhelpcontrollerbase_getparentwindow(wxObjectPtr))
	End Method
	
	Method Quit:Int()
		Return bmx_wxhelpcontrollerbase_quit(wxObjectPtr)
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
		Return bmx_wxhelpcontrollerbase_keywordsearch(wxObjectPtr, keyword, mode)
	End Method

	Rem
	bbdoc: Displays help window and focuses contents panel.
	End Rem
	Method DisplayContents()
		bmx_wxhelpcontrollerbase_displaycontents(wxObjectPtr)
	End Method
	
End Type


