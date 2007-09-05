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
ModuleInfo "License:"
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
	bbdoc: 
	End Rem
	Method AppendToPage:Int(source:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInternalRepresentation()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOpenedAnchor:String()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOpenedPage:String()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOpenedPageTitle:String()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRelatedFrame:wxFrame()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HistoryBack:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HistoryCanBack:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HistoryCanForward:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HistoryClear()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HistoryForward:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadFile:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadPage:Int(location:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method OnOpeningURL:String(urlType:Int, url:String, returnStatus:Int Ptr)
		returnStatus[0] = wxHTML_OPEN
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method OnSetTitle(title:String)
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
	End Method
	
	Rem
	bbdoc: <b>After</b> calling SetRelatedFrame, this sets statusbar slot where messages will be displayed.
	about: (Default is -1 = no messages.)
	End Rem
	Method SetRelatedStatusBar(bar:Int)
	End Method
	
	Rem
	bbdoc: Returns content of currently displayed page as plain text.
	End Rem
	Method ToText:String()
	End Method
	
	Function _cbopeningurl:String(obj:wxHtmlWindow, urlType:Int, url:String, returnStatus:Int Ptr)
		Return obj.OnOpeningURL(urlType, url, returnStatus)
	End Function
	
	Function _cbonsettitle(obj:wxHtmlWindow, title:String)
		obj.OnSetTitle(title)
	End Function

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


