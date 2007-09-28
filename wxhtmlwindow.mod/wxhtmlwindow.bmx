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
	bbdoc: Creation method, for two-step construction. For details see CreateButton.
	End Rem
	Method Create:wxHtmlWindow(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxHW_DEFAULT_STYLE)
			
		wxObjectPtr = bmx_wxhtmlwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		Return Self
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
	Method OnOpeningURL:String(urlType:Int, url:String, returnStatus:Int Ptr)
		returnStatus[0] = wxHTML_OPEN
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
	bbdoc: 
	End Rem
	Method SetBorders(size:Int)
		bmx_wxhtmlwindow_setborders(wxObjectPtr, size)
	End Method
	
	Rem
	bbdoc: 
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
	
	Function _cbopeningurl:String(obj:wxHtmlWindow, urlType:Int, url:String, returnStatus:Int Ptr)
		Return obj.OnOpeningURL(urlType, url, returnStatus)
	End Function
	
	Function _cbonsettitle(obj:wxHtmlWindow, title:String)
		obj.OnSetTitle(title)
	End Function

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

End Type


Rem
bbdoc: This event type is used for the events generated by wxHtmlWindow.
End Rem
Type wxHtmlLinkEvent Extends wxCommandEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxHtmlLinkEvent = New wxHtmlLinkEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
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

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxHtmlCellEvent = New wxHtmlCellEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

	'Method GetCell:wxHtmlCell()
	'End Method
	
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


Type THtmlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType 
			Case wxEVT_COMMAND_HTML_CELL_CLICKED
				Return wxHtmlLinkEvent.create(wxEventPtr, evt)
			Case wxEVT_COMMAND_HTML_CELL_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_HOVER
				Return wxHtmlCellEvent.create(wxEventPtr, evt)				
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_HTML_CELL_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_CLICKED, ..
					wxEVT_COMMAND_HTML_CELL_HOVER
				Return bmx_wxhtmlevent_geteventtype(eventType)
		End Select
	End Method
		
End Type

New THtmlEventFactory


