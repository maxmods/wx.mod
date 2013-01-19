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
bbdoc: wxHtmlHelpController
End Rem
Module wx.wxHtmlHelpController

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
bbdoc: 
End Rem
Type wxHtmlHelpController Extends wxHelpControllerBase

	Rem
	bbdoc: Creates a new wxHtmlHelpController.
	End Rem
	Function CreateHtmlHelpController:wxHtmlHelpController(style:Int = wxHF_DEFAULT_STYLE, parentWindow:wxWindow = Null)
		Return New wxHtmlHelpController.Create(style, parentWindow)
	End Function
	
	Rem
	bbdoc: Creates a new wxHtmlHelpController.
	End Rem
	Method Create:wxHtmlHelpController(style:Int = wxHF_DEFAULT_STYLE, parentWindow:wxWindow = Null)
		If parentWindow Then
			wxObjectPtr = bmx_wxhtmlhelpcontroller_create(Self, style, parentWindow.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxhtmlhelpcontroller_create(Self, style, Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: Adds book (.hhp file - HTML Help Workshop project file) into the list of loaded books.
	about: This must be called at least once before displaying any help.
	<p>
	@bookUrl may be either .hhp file or ZIP archive that contains arbitrary number of .hhp
	files in top-level directory. This ZIP archive must have .zip or .htb extension (the
	latter stands for "HTML book"). In other words, AddBook(wxFileName("help.zip")) is
	possible and is the recommended way.
	</p>
	<p>
	Note : Don't forget to install the archive wxFileSystem handler with
	wxFileSystem::AddHandler(new wxArchiveFSHandler); before calling this method on a .zip
	or .htb file!
	</p>
	End Rem
	Method AddBook:Int(bookUrl:String, showWaitMsg:Int)
		Return bmx_wxhtmlhelpcontroller_addbook(wxObjectPtr, bookUrl, showWaitMsg)
	End Method
	
	Rem
	bbdoc: Adds book (.hhp file - HTML Help Workshop project file) into the list of loaded books.
	about: This must be called at least once before displaying any help.
	<p>
	@bookfile may be either .hhp file or ZIP archive that contains arbitrary number of .hhp
	files in top-level directory. This ZIP archive must have .zip or .htb extension (the
	latter stands for "HTML book"). In other words, AddBook(wxFileName("help.zip")) is
	possible and is the recommended way.
	</p>
	<p>
	Note : Don't forget to install the archive wxFileSystem handler with
	wxFileSystem::AddHandler(new wxArchiveFSHandler); before calling this method on a .zip
	or .htb file!
	</p>
	End Rem
	Method AddBookFile:Int(bookfile:wxFileName, showWaitMsg:Int)
		Return bmx_wxhtmlhelpcontroller_addbookfile(wxObjectPtr, bookfile.wxObjectPtr, showWaitMsg)
	End Method
	
	Rem
	bbdoc: Displays page @x.
	about: This is THE important method - it is used to display the help in application.
	<p>
	You can specify the page in many ways:
	<ul>
	<li>as direct filename of HTML document </li>
	<li>as chapter name (from contents) or as a book name</li>
	<li>as some word from index </li>
	<li>even as any word (will be searched)</li>
	</ul>
	Looking for the page runs in these steps:
	<ol>
	<li>try to locate file named x (if x is for example "doc/howto.htm") </li>
	<li>try to open starting page of book named x </li>
	<li>try to find x in contents (if x is for example "How To ...") </li>
	<li>try to find x in index (if x is for example "How To ...") </li>
	<li>switch to Search panel and start searching </li>
	</ul>
	End Rem
	Method Display(x:String)
		bmx_wxhtmlhelpcontroller_display(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisplayId(id:Int)
		bmx_wxhtmlhelpcontroller_displayid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Displays help window and focuses contents panel.
	End Rem
	Method DisplayContents()
		bmx_wxhtmlhelpcontroller_displaycontents(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Displays help window and focuses index panel.
	End Rem
	Method DisplayIndex()
		bmx_wxhtmlhelpcontroller_displayindex(wxObjectPtr)
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
		Return bmx_wxhtmlhelpcontroller_keywordsearch(wxObjectPtr, keyword, mode)
	End Method
	
	Rem
	bbdoc: Reads the controller's setting (position of window, etc.)
	End Rem
	Method ReadCustomization(config:wxConfigBase, path:String = "")
		bmx_wxhtmlhelpcontroller_readcustomization(wxObjectPtr, config.wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets the path for storing temporary files - cached binary versions of index and contents files.
	about: These binary forms are much faster to read. Default value is empty string
	(empty string means that no cached data are stored). Note that these files are not
	deleted when program exits.
	<p>
	Once created these cached files will be used in all subsequent executions of your
	application. If cached files become older than corresponding .hhp file (e.g. if you
	regenerate documentation) it will be refreshed.
	</p>
	End Rem
	Method SetTempDir(path:String)
		bmx_wxhtmlhelpcontroller_settempdir(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets format of title of the frame.
	about: Must contain exactly one "%s" (for title of displayed HTML page).
	End Rem
	Method SetTitleFormat(format:String)
		bmx_wxhtmlhelpcontroller_settitleformat(wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: Associates config object with the controller.
	about: If there is associated config object, wxHtmlHelpController automatically reads
	and writes settings (including wxHtmlWindow's settings) when needed.
	<p>
	The only thing you must do is create wxConfig object and call UseConfig.
	</p>
	<p>
	If you do not use UseConfig, wxHtmlHelpController will use default wxConfig object if
	available (for details see wxConfigBase::Get and wxConfigBase::Set).
	</p>
	End Rem
	Method UseConfig(config:wxConfigBase, rootpath:String = "")
		bmx_wxhtmlhelpcontroller_useconfig(wxObjectPtr, config.wxObjectPtr, rootpath)
	End Method
	
	Rem
	bbdoc: Stores controllers setting (position of window etc.)
	End Rem
	Method WriteCustomization(config:wxConfigBase, path:String = "")
		bmx_wxhtmlhelpcontroller_writecustomization(wxObjectPtr, config.wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets the associated help window.
	End Rem
	Method SetHelpWindow(helpWindow:wxHtmlHelpWindow)
		bmx_wxhtmlhelpcontroller_sethelpwindow(wxObjectPtr, helpWindow.wxObjectPtr)
	End Method

End Type


