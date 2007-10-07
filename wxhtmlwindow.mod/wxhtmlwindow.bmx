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
bbdoc: wxHtmlWindow
End Rem
Module wx.wxHtmlWindow

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
bbdoc: The purpose of this type is to display HTML pages (either local file or downloaded via HTTP protocol) in a window.
about: The width of the window is constant - given in the constructor - and virtual height is changed
dynamically depending on page size. Once the window is created you can set its content by calling
SetPage(text), LoadPage(filename) or LoadFile.
<p>
wxHtmlWindow uses the wxImage class for displaying images. Don't forget to initialize all image formats
you need before loading any page! (See wxInitAllImageHandlers and wxImage::AddHandler.)
</p>
End Rem
Type wxHtmlWindow Extends wxScrolledWindow

	Rem
	bbdoc: Constructor.
	End Rem
	Function CreateHtmlWindow:wxHtmlWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxHW_DEFAULT_STYLE)
			
		Return New wxHtmlWindow.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateHtmlWindow.
	End Rem
	Method Create:wxHtmlWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxHW_DEFAULT_STYLE)
			
		wxObjectPtr = bmx_wxhtmlwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Adds an HTML processor to this instance of wxHtmlWindow.
	End Rem
	Method AddProcessor(processor:wxHtmlProcessor)
		bmx_wxhtmlwindow_addprocessor(wxObjectPtr, processor.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function AddFilter()
	End Function
	
	Rem
	bbdoc: Appends HTML fragment to currently displayed text and refreshes the window.
	returns: False if an error occurred, True otherwise.
	End Rem
	Method AppendToPage:Int(source:String)
		Return bmx_wxhtmlwindow_appendtopage(wxObjectPtr, source)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInternalRepresentation()
	End Method
	
	Rem
	bbdoc: Returns anchor within currently opened page (see GetOpenedPage).
	about: If no page is opened or if the displayed page wasn't produced by call to LoadPage, empty string is
	returned.
	End Rem
	Method GetOpenedAnchor:String()
		Return bmx_wxhtmlwindow_getopenedanchor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns full location of the opened page.
	about: If no page is opened or if the displayed page wasn't produced by call to LoadPage, empty string is
	returned.
	End Rem
	Method GetOpenedPage:String()
		Return bmx_wxhtmlwindow_getopenedpage(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns title of the opened page or wxEmptyString if current page does not contain <TITLE> tag.
	End Rem
	Method GetOpenedPageTitle:String()
		Return bmx_wxhtmlwindow_getopenedpagetitle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the related frame.
	End Rem
	Method GetRelatedFrame:wxFrame()
		Return wxFrame._find(bmx_wxhtmlwindow_getrelatedframe(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Moves back to the previous page.
	about: Each page displayed using LoadPage is stored in history list.
	End Rem
	Method HistoryBack:Int()
		Return bmx_wxhtmlwindow_historyback(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if it is possible to go back in the history (i.e. HistoryBack() won't fail).
	End Rem
	Method HistoryCanBack:Int()
		Return bmx_wxhtmlwindow_hisotrycanback(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if it is possible to go forward in the history (i.e. HistoryBack() won't fail).
	End Rem
	Method HistoryCanForward:Int()
		Return bmx_wxhtmlwindow_historycanforward(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Clears history.
	End Rem
	Method HistoryClear()
		bmx_wxhtmlwindow_historyclear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves to next page in history.
	End Rem
	Method HistoryForward:Int()
		Return bmx_wxhtmlwindow_historyforward(wxObjectPtr)
	End Method
	
	'Rem
	'bbdoc:
	'End Rem
	'Method LoadFile:Int()
	'End Method
	
	Rem
	bbdoc: Unlike SetPage this method first loads HTML page from location and then displays it.
	returns: False if an error occurred, True otherwise
	about: See example:
	<pre>
	htmlwin.LoadPage("help/myproject/index.htm")
	</pre>
	End Rem
	Method LoadPage:Int(location:String)
		Return bmx_wxhtmlwindow_loadpage(wxObjectPtr, location)
	End Method
	
	Rem
	bbdoc: Called when an URL is being opened (either when the user clicks on a link or an image is loaded).
	about: The URL will be opened only if @returnStatus is wxHTML_OPEN. This method is called by
	wxHtmlParser::OpenURL. You can override OnOpeningURL to selectively block some URLs (e.g. for security reasons)
	or to redirect them elsewhere (by passing back the redirect URL). Default behaviour is to always set
	@returnStatus to  wxHTML_OPEN.
	End Rem
	Method OnOpeningURL:String(urlType:Int, url:String, returnStatus:Int Var)
		returnStatus = wxHTML_OPEN
	End Method
	
	Rem
	bbdoc: Called on parsing <TITLE> tag.
	End Rem
	Method OnSetTitle(title:String)
	End Method
	
	Rem
	bbdoc: Selects all text in the window.
	End Rem
	Method SelectAll()
		bmx_wxhtmlwindow_selectall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns current selection as plain text.
	about: Returns empty string if no text is currently selected.
	End Rem
	Method SelectionToText:String()
		Return bmx_wxhtmlwindow_selectiontotext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Selects the line of text that pos points at.
	about: Note that pos is relative to the top of displayed page, not to window's origin, use
	CalcUnscrolledPosition to convert physical coordinate.
	End Rem
	Method SelectLine(x:Int, y:Int)
		bmx_wxhtmlwindow_selectline(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Selects the word at position pos.
	about: Note that pos is relative to the top of displayed page, not to window's origin, use
	CalcUnscrolledPosition to convert physical coordinate.
	End Rem
	Method SelectWord(x:Int, y:Int)
		bmx_wxhtmlwindow_selectword(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: This function sets the space between border of window and HTML contents.
	End Rem
	Method SetBorders(size:Int)
		bmx_wxhtmlwindow_setborders(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: This method sets font sizes and faces.
	End Rem
	Method SetFonts(normalFace:String, fixedFace:String, sizes:Int[] = Null)
		If sizes Then
			Assert sizes.length = 7, "Sizes should contain 7 values"
		End If
		bmx_wxhtmlwindow_setfonts(wxObjectPtr, normalFace, fixedFace, sizes)
	End Method
	
	Rem
	bbdoc: Sets HTML page and display it.
	about: This won't load the page!! It will display the source. See example:
	<pre>
	htmlwin.SetPage("&lt;html&gt;&lt;body&gt;Hello, world!&lt;/body&gt;&lt;/html&gt;");
	</pre>
	If you want to load a document from some location use LoadPage instead.
	End Rem
	Method SetPage:Int(source:String)
		Return bmx_wxhtmlwindow_setpage(wxObjectPtr, source)
	End Method
	
	Rem
	bbdoc: Sets the frame in which page title will be displayed.
	about: @format is format of frame title, e.g. "HtmlHelp : %s". It must contain exactly one %s.
	This %s is substituted with HTML page title.
	End Rem
	Method SetRelatedFrame(frame:wxFrame, format:String)
		bmx_wxhtmlwindow_setrelatedframe(wxObjectPtr, frame.wxObjectPtr, format)
	End Method
	
	Rem
	bbdoc: <b>After</b> calling SetRelatedFrame, this sets statusbar slot where messages will be displayed.
	about: (Default is -1 = no messages.)
	End Rem
	Method SetRelatedStatusBar(bar:Int)
		bmx_wxhtmlwindow_setrelatedstatusbar(wxObjectPtr, bar)
	End Method
	
	Rem
	bbdoc: Returns content of currently displayed page as plain text.
	End Rem
	Method ToText:String()
		Return bmx_wxhtmlwindow_totext(wxObjectPtr)
	End Method
	
	Function _OnOpeningURL:String(obj:wxHtmlWindow, urlType:Int, url:String, returnStatus:Int Var)
		Return obj.OnOpeningURL(urlType, url, returnStatus)
	End Function
	
	Function _OnSetTitle(obj:wxHtmlWindow, title:String)
		obj.OnSetTitle(title)
	End Function

End Type

Rem
bbdoc: Internal data structure.
about: It represents fragments of parsed HTML page, the so-called cell - a word, picture, table,
horizontal line and so on. It is used by wxHtmlWindow and wxHtmlWinParser to represent HTML page in memory.
<p>
You can divide cells into two groups : visible cells with non-zero width and height and helper cells
(usually with zero width and height) that perform special actions such as color or font change.
</p>
End Rem
Type wxHtmlCell Extends wxObject

	Function _create:wxHtmlCell(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlCell = New wxHtmlCell
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: This method is used to adjust pagebreak position.
	about: The parameter is variable that contains y-coordinate of page break (= horizontal line that
	should not be crossed by words, images etc.). If this cell cannot be divided into two pieces (each
	one on another page) then it moves the pagebreak few pixels up.
	End Rem
	Method AdjustPagebreak:Int(pageBreak:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Draw()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DrawInvisible()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Find:wxHtmlCell(condition:Int, param:Object)
	End Method
	
	Rem
	bbdoc: Returns descent value of the cell.
	End Rem
	Method GetDescent:Int()
	End Method
	
	Rem
	bbdoc: Returns height of the cell.
	End Rem
	Method GetHeight:Int()
	End Method
	
	Rem
	bbdoc: Returns unique cell identifier if there is any, empty string otherwise.
	End Rem
	Method GetId:String()
	End Method
	
	Rem
	bbdoc: Returns hypertext link if associated with this cell or NULL otherwise.
	about: See wxHtmlLinkInfo. (Note: this makes sense only for visible tags).
	End Rem
	Method GetLink:wxHtmlLinkInfo(x:Int = 0, y:Int = 0)
	End Method
	
	Rem
	bbdoc: Returns cursor to show when mouse pointer is over the cell.
	End Rem
	Method GetMouseCursor:wxCursor(window:wxHtmlWindowInterface)
	End Method
	
	Rem
	bbdoc: Returns the next cell in list
	End Rem
	Method GetNext:wxHtmlCell()
	End Method
	
	Rem
	bbdoc: Returns the parent container.
	End Rem
	Method GetParent:wxHtmlContainerCell()
	End Method
	
	Rem
	bbdoc: Returns X position within parent (the value is relative to parent's upper left corner).
	about: The returned value is meaningful only if parent's Layout was called before!
	End Rem
	Method GetPosX:Int()
	End Method
	
	Rem
	bbdoc: Returns Y position within parent (the value is relative to parent's upper left corner).
	about: The returned value is meaningful only if parent's Layout was called before!
	End Rem
	Method GetPosY:Int()
	End Method
	
	Rem
	bbdoc: Returns width of the cell.
	End Rem
	Method GetWidth:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Layout(width:Int)
	End Method
	
	Rem
	bbdoc: Sets unique cell identifier.
	about: Default value is no identifier, i.e. empty string.
	End Rem
	Method SetId(id:String)
	End Method
	
	Rem
	bbdoc: Sets the hypertext link associated with this cell.
	about: (Default value is wxHtmlLinkInfo("", "") (no link))
	End Rem
	Method SetLink(link:wxHtmlLinkInfo)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetParent(parent:wxHtmlContainerCell)
	End Method
	
	Rem
	bbdoc: Sets the cell's position within parent container.
	End Rem
	Method SetPos(x:Int, y:Int)
	End Method
	
End Type

Rem
bbdoc: This type stores all necessary information about hypertext links (as represented by <A> tag in HTML documents).
about: In current implementation it stores URL and target frame name. <b>Note that frames are not currently supported by wxHTML!</b>
End Rem
Type wxHtmlLinkInfo Extends wxObject

	Field userData:Object
	Field parent:wxEvtHandler

	Function _createLink:wxHtmlLinkInfo(wxObjectPtr:Byte Ptr, userData:Object, parent:wxEvtHandler)
		If wxObjectPtr Then
			Local this:wxHtmlLinkInfo = New wxHtmlLinkInfo
			this.wxObjectPtr = wxObjectPtr
			this.userData = userData
			this.parent = parent
			Return this
		End If
	End Function

	Rem
	bbdoc: Return pointer to event that generated OnLinkClicked event.
	about: Valid only within wxHtmlWindow::OnLinkClicked, NULL otherwise.
	End Rem
	Method GetEvent:wxMouseEvent()
		Return wxMouseEvent._create(bmx_wxhtmllinkinfo_getevent(wxObjectPtr), userData, parent)
	End Method
	
	'Method GetHtmlCell:wxHtmlCell()
	'End Method
	
	Rem
	bbdoc: Return HREF value of the <A> tag.
	End Rem
	Method GetHref:String()
		Return bmx_wxhtmllinkinfo_gethref(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return TARGET value of the <A> tag 
	End Rem
	Method GetTarget:String()
		Return bmx_wxhtmllinkinfo_gettarget(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxhtmllinkinfo_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
End Type


Rem
bbdoc: This event type is used for the events generated by wxHtmlWindow.
End Rem
Type wxHtmlLinkEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxHtmlLinkEvent = New wxHtmlLinkEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the wxHtmlLinkInfo which contains info about the cell clicked and the hyperlink it contains.
	End Rem
	Method GetLinkInfo:wxHtmlLinkInfo()
		Return wxHtmlLinkInfo._createLink(bmx_wxhtmllinkevent_getlinkinfo(wxEventPtr), userData, parent)
	End Method

End Type

Rem
bbdoc: This event type is used for the events generated by wxHtmlWindow.
End Rem
Type wxHtmlCellEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxHtmlCellEvent = New wxHtmlCellEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the wxHtmlCell associated with the event.
	End Rem
	Method GetCell:wxHtmlCell()
		Return wxHtmlCell._create(bmx_wxhtmlcellevent_getcell(wxEventPtr))
	End Method
	
	Rem
	bbdoc: returns the point associated with the event.
	End Rem
	Method GetPoint(x:Int Var, y:Int Var)
		bmx_wxhtmlcellevent_getpoint(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Call this with @clicked set to true if the cell which has been clicked contained a link or false otherwise (which is the default).
	about: With this method the event handler can return info to the wxHtmlWindow which sent the event.
	End Rem
	Method SetLinkClicked(clicked:Int)
		bmx_wxhtmlcellevent_setlinkclicked(wxEventPtr, clicked)
	End Method
	
	Rem
	bbdoc: Returns true if SetLinkClicked(true) has previously been called; false otherwise.
	End Rem
	Method GetLinkClicked:Int()
		bmx_wxhtmlcellevent_getlinkclicked(wxEventPtr)
	End Method
	
End Type

Rem
bbdoc: Types derived from this class serve as simple text processors for wxHtmlWindow.
about: wxHtmlWindow runs HTML markup through all registered processors before displaying it, thus allowing
for on-the-fly modifications of the markup.
End Rem
Type wxHtmlProcessor Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateHtmlProcessor:wxHtmlProcessor()
		Return New wxHtmlProcessor.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxHtmlProcessor()
		wxObjectPtr = bmx_wxhtmlprocessor_create(Self)
		Return Self
	End Method
	
	Rem
	bbdoc: Enable/disable the processor.
	about: wxHtmlWindow won't use a disabled processor even if it is in its processors queue.
	End Rem
	Method Enable(value:Int = True)
		bmx_wxhtmlprocessor_enable(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Returns the enabled state of the processor.
	End Rem
	Method IsEnabled:Int()
		Return bmx_wxhtmlprocessor_isenabled(wxObjectPtr)
	End Method

	Rem
	bbdoc: Process input text and return processed result.
	End Rem
	Method Process:String(text:String)
		Return text
	End Method

	Function _Process:String(obj:Object, text:String)
		Return wxHtmlProcessor(obj).Process(text)
	End Function
	
End Type

Rem
bbdoc: This type provides easy way of filling wxHtmlWinParser's table of tag handlers.
End Rem
Type wxHtmlTagsModule

	Field wxObjectPtr:Byte Ptr
	
	Method Create:wxHtmlTagsModule()
		wxObjectPtr = bmx_wxhtmltagsmodule_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: You must override this method.
	about: In most common case its body consists only of lines of the following type:
	<pre>
	parser.AddTagHandler(new MyHandler.Create())
	</pre>
	End Rem
	Method FillHandlersTable(parser:wxHtmlWinParser)
	End Method
	
	Function _FillHandlersTable(obj:wxHtmlTagsModule, parserPtr:Byte Ptr)
		obj.FillHandlersTable(wxHtmlWinParser._create(parserPtr))
	End Function
	
End Type

Rem
bbdoc: This type is derived from wxHtmlParser and its main goal is to parse HTML input so that it can be displayed in wxHtmlWindow.
End Rem
Type wxHtmlWinParser Extends wxHtmlParser

	Function _create:wxHtmlWinParser(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlWinParser = New wxHtmlWinParser
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Method CloseContainer:wxHtmlContainerCell()
	End Method
	
	Method CreateCurrentFont:wxFont()
	End Method
	
	Method GetActualColor:wxColour()
	End Method
	
	Method GetAlign:Int()
	End Method
	
	Method GetCharHeight:Int()
	End Method
	
	Method GetCharWidth:Int()
	End Method
	
	Method GetContainer:wxHtmlContainerCell()
		Return wxHtmlContainerCell._create(bmx_wxhtmlwinparser_getcontainer(wxObjectPtr))
	End Method
	
	Method GetDC:wxDC()
	End Method
	
	Method GetFontBold:Int()
	End Method
	
	Method GetFontFace:String()
	End Method
	
	Method GetFontFixed:Int()
	End Method
	
	Method GetFontItalic:Int()
	End Method
	
	Method GetFontSize:Int()
	End Method
	
	Method GetFontUnderlined:Int()
	End Method
	
	Method GetInputEncoding:Int()
	End Method
	
	Method GetLink:wxHtmlLinkInfo()
	End Method
	
	Method GetLinkColor:wxColour()
	End Method
	
	Method GetOutputEncoding:Int()
	End Method
	
	Method GetWindowInterface:wxHtmlWindowInterface()
		Return wxHtmlWindowInterface._create(bmx_wxhtmlwinparser_getwindowinterface(wxObjectPtr))
	End Method
	
	
End Type

Rem
bbdoc: 
End Rem
Type wxHtmlParser Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Method AddTagHandler(handler:wxHtmlTagHandler)
		bmx_wxhtmlparser_addtaghandler(wxObjectPtr, handler.wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: A Tag handler.
about: You should override GetSupportedTags and HandleTag methods.
End Rem
Type wxHtmlTagHandler Extends wxObject

	Function CreateHtmlTagHandler:wxHtmlTagHandler()
		Return New wxHtmlTagHandler.Create()
	End Function
	
	Method Create:wxHtmlTagHandler()
		wxObjectPtr = bmx_wxhtmltaghandler_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: Returns list of supported tags.
	about: The list is in uppercase and tags are delimited by ','. Example : "I,B,FONT,P"
	End Rem
	Method GetSupportedTags:String()
	End Method
	
	Function _GetSupportedTags:String(obj:wxHtmlTagHandler)
		Return obj.GetSupportedTags()
	End Function
	
	Rem
	bbdoc: This is the core method of the handler.
	about: It is called each time one of supported tags is detected. @tag contains all necessary info
	(see wxHtmlTag for details).
	End Rem
	Method HandleTag:Int(tag:wxHtmlTag)
	End Method
	
	Function _HandleTag:Int(obj:wxHtmlTagHandler, tag:Byte Ptr)
		Return obj.HandleTag(wxHtmlTag._create(tag))
	End Function
	
	Rem
	bbdoc: This method calls parser's DoParsing method for the string between this tag and the paired ending tag
	End Rem
	Method ParseInner(tag:wxHtmlTag)
		bmx_wxhtmltaghandler_parseinner(wxObjectPtr, tag.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the wxHtmlWinParser object
	End Rem
	Method GetParser:wxHtmlWinParser()
		Return wxHtmlWinParser._create(bmx_wxhtmltaghandler_getparser(wxObjectPtr))
	End Method
	
End Type

Rem
bbdoc: Abstract interface to a HTML rendering window (such as wxHtmlWindow or wxHtmlListBox) that is passed to wxHtmlWinParser.
about: It encapsulates all communication from the parser to the window.
End Rem
Type wxHtmlWindowInterface

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxHtmlWindowInterface(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlWindowInterface = New wxHtmlWindowInterface
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Method HTMLCoordsToWindow(cell:wxHtmlCell, hx:Int, hy:Int, x:Int Var, y:Int Var)
		
	End Method

	Rem
	bbdoc: Returns the window used For rendering (May be Null).
	End Rem
	Method GetHTMLWindow:wxWindow()
		Return wxWindow._find(bmx_wxhtmlwindowinterface_gethtmlwindow(wxObjectPtr))
	End Method

	Rem
	bbdoc:  Returns background colour To use by Default.
	End Rem
	Method GetHTMLBackgroundColour:wxColour()
	End Method


	
End Type

Rem
bbdoc: The wxHtmlContainerCell class is an implementation of a cell that may contain more cells in it.
about: It is heavily used in the wxHTML layout algorithm.
End Rem
Type wxHtmlContainerCell Extends wxHtmlCell

	Function _create:wxHtmlContainerCell(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlContainerCell = New wxHtmlContainerCell
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method InsertCell(cell:wxHtmlCell)
		bmx_wxhtmlcontainercell_insertcell(wxObjectPtr, cell.wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: This cell changes the colour of either the background or the foreground.
End Rem
Type wxHtmlColourCell Extends wxHtmlCell

	Function _create:wxHtmlColourCell(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlColourCell = New wxHtmlColourCell
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function CreateColourCell:wxHtmlColourCell(colour:wxColour, flags:Int = wxHTML_CLR_FOREGROUND)
		Return New wxHtmlColourCell.Create(colour, flags)
	End Function
	
	Method Create:wxHtmlColourCell(colour:wxColour, flags:Int = wxHTML_CLR_FOREGROUND)
	End Method

End Type

Rem
bbdoc: wxHtmlWidgetCell is a type that provides a connection between HTML cells and widgets (an object derived from wxWindow).
about: You can use it to display things like forms, input boxes etc. in an HTML window.
<p>
wxHtmlWidgetCell takes care of resizing and moving window.
</p>
End Rem
Type wxHtmlWidgetCell Extends wxHtmlCell

	Function _create:wxHtmlWidgetCell(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlWidgetCell = New wxHtmlWidgetCell
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a widget cell.
	about: The window parent <b>must</b> be the wxHtmlWindow object within which it is displayed!!
	End Rem
	Function CreateHtmlWidgetCell:wxHtmlWidgetCell(window:wxWindow, foatingWidth:Int = 0)
		Return New wxHtmlWidgetCell.Create(window, foatingWidth)
	End Function
	
	Rem
	bbdoc: Constructs a widget cell.
	about: The window parent <b>must</b> be the wxHtmlWindow object within which it is displayed!!
	End Rem
	Method Create:wxHtmlWidgetCell(window:wxWindow, foatingWidth:Int = 0)
		wxObjectPtr = bmx_wxhtmlwidgetcell_create(window.wxObjectPtr, foatingWidth)
		Return Self
	End Method
	
End Type


Rem
bbdoc: This type represents a single HTML tag.
about: It is used by tag handlers.
End Rem
Type wxHtmlTag Extends wxObject

	Function _create:wxHtmlTag(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxHtmlTag = New wxHtmlTag
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns a string containing all parameters.
	about: Example : tag contains <FONT SIZE=+2 COLOR="#000000">. Call to tag.GetAllParams() would return SIZE=+2 COLOR="#000000".
	End Rem
	Method GetAllParams:String()
		Return bmx_wxhtmltag_getallparams(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns beginning position of the text between this tag and paired ending tag.
	about: See explanation (returned position is marked with '|'):
	<pre>
	bla bla bla &lt;MYTAG&gt; bla bla internal text&lt;/MYTAG&gt; bla bla
	                   | 
	</pre>
	End Rem
	Method GetBeginPos:Int()
		Return bmx_wxhtmltag_getbeginpos(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns ending position of the text between this tag and paired ending tag.
	about: See explanation (returned position is marked with '|'):
	<pre>
	bla bla bla &lt;MYTAG&gt; bla bla internal text&lt;/MYTAG&gt; bla bla 
	                                        | 
	</pre>
	End Rem
	Method GetEndPos1:Int()
		Return bmx_wxhtmltag_getendpos1(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns ending position 2 of the text between this tag and paired ending tag.
	about: See explanation (returned position is marked with '|'):
	<pre>
	bla bla bla &lt;MYTAG&gt; bla bla internal text&lt;/MYTAG&gt; bla bla 
	                                               | 
	</pre>
	End Rem
	Method GetEndPos2:Int()
		Return bmx_wxhtmltag_getendpos2(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns tag's name.
	about: The name is always in uppercase and it doesn't contain '<' or '/' characters. (So the name
	of <FONT SIZE=+2> tag is "FONT" and name of </table> is "TABLE")
	End Rem
	Method GetName:String()
		Return bmx_wxhtmltag_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the value of the parameter.
	about: You should check whether the parameter exists or not (use HasParam) first.
	End Rem
	Method GetParam:String(par:String, withCommas:Int = False)
		Return bmx_wxhtmltag_getparam(wxObjectPtr, par, withCommas)
	End Method
	
	Rem
	bbdoc: Interprets tag parameter par as colour specification and returns as a wxColour object.
	End Rem
	Method GetParamAsColour:wxColour(par:String)
		Return wxColour._create(bmx_wxhtmltag_getparamascolour(wxObjectPtr, par))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetParamAsInt:Int(par:String, value:Int Var)
		Return bmx_wxhtmltag_getparamasint(wxObjectPtr, par, Varptr value)
	End Method
	
	Rem
	bbdoc: Returns true if this tag is paired with ending tag, false otherwise.
	End Rem
	Method HasEnding:Int()
		Return bmx_wxhtmltag_hasending(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasParam:Int(par:String)
		Return bmx_wxhtmltag_hasparam(wxObjectPtr, par)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxhtmltag_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Type THtmlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType 
			Case wxEVT_COMMAND_HTML_LINK_CLICKED
				Return wxHtmlLinkEvent.Create(wxEventPtr, evt)
			Case wxEVT_COMMAND_HTML_CELL_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_HOVER
				Return wxHtmlCellEvent.Create(wxEventPtr, evt)				
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_HTML_LINK_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_HOVER
				Return bmx_wxhtmlevent_geteventtype(eventType)
		End Select
	End Method
		
End Type

New THtmlEventFactory


