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
bbdoc: wxHtmlHelpWindow
End Rem
Module wx.wxHtmlHelpWindow

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
bbdoc: This type is used by wxHtmlHelpController to display help within a frame or dialog,
but you can use it yourself to create an embedded HTML help window.
End Rem
Type wxHtmlHelpWindow Extends wxWindow

	Rem
	bbdoc: Creates a new wxHtmlHelpWindow
	about: For the values of helpStyle, please see the documentation for wxHtmlHelpController.
	End Rem
	Function CreateHtmlHelpWindow:wxHtmlHelpWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTAB_TRAVERSAL|wxNO_BORDER, ..
			helpStyle:Int = wxHF_DEFAULT_STYLE)
		Return New wxHtmlHelpWindow.Create(parent, id, x, y, w, h, style, helpStyle)
	End Function
	
	Rem
	bbdoc: Creates a new wxHtmlHelpWindow
	about: For the values of helpStyle, please see the documentation for wxHtmlHelpController.
	End Rem
	Method Create:wxHtmlHelpWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTAB_TRAVERSAL|wxNO_BORDER, ..
			helpStyle:Int = wxHF_DEFAULT_STYLE)
		wxObjectPtr = bmx_wxhtmlhelpwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style, helpStyle)
		Return Self
	End Method
	
	Rem
	bbdoc: Displays page @x.
	about: If not found it will give the user the choice of searching books. Looking for
	the page runs in these steps:
	<ol>
	<li>try to locate file named @x (if @x is for example "doc/howto.htm")</li>
	<li>try to open starting page of book @x</li>
	<li>try to find @x in contents (if @x is for example "How To ...")</li>
	<li>try to find @x in index (if @x is for example "How To ...")</li>
	</ol>
	End Rem
	Method Display:Int(x:String)
		Return bmx_wxhtmlhelpwindow_display(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Display using the provided @id.
	End Rem
	Method DisplayId:Int(id:Int)
		Return bmx_wxhtmlhelpwindow_displaywithid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Displays contents panel.
	End Rem
	Method DisplayContents:Int()
		Return bmx_wxhtmlhelpwindow_displaycontents(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Displays index panel.
	End Rem
	Method DisplayIndex:Int()
		Return bmx_wxhtmlhelpwindow_displayindex(wxObjectPtr)
	End Method
	
	'Method GetData()
	'End Method

	Rem
	bbdoc: Search for given keyword.
	about: Optionally it searches through the index (mode = wxHELP_SEARCH_INDEX), default
	the content (mode = wxHELP_SEARCH_ALL).
	End Rem
	Method KeywordSearch:Int(keyword:String, mode:Int = wxHELP_SEARCH_ALL)
		Return bmx_wxhtmlhelpwindow_keywordsearch(wxObjectPtr, keyword, mode)
	End Method
	
	Rem
	bbdoc: Reads the user's settings for this window.
	about: see wxHtmlHelpController::ReadCustomization.
	End Rem
	Method ReadCustomization(config:wxConfigBase, path:String = "")
		bmx_wxhtmlhelpwindow_readcustomization(wxObjectPtr, config.wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Refresh all panels.
	about: This is necessary if a new book was added.
	End Rem
	Method RefreshLists()
		bmx_wxhtmlhelpwindow_refreshlists(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Associates a wxConfig object with the help window.
	about: It is recommended that you use wxHtmlHelpController::UseConfig instead.
	End Rem
	Method UseConfig(config:wxConfigBase, rootpath:String = "")
		bmx_wxhtmlhelpwindow_useconfig(wxObjectPtr, config.wxObjectPtr, rootpath)
	End Method
	
	Rem
	bbdoc: Saves the user's settings for this window.
	about: see wxHtmlHelpController::WriteCustomization.
	End Rem
	Method WriteCustomization(config:wxConfigBase, path:String = "")
		bmx_wxhtmlhelpwindow_writecustomization(wxObjectPtr, config.wxObjectPtr, path)
	End Method
	
	'Method AddToolbarButtons()
	'End Method


End Type

