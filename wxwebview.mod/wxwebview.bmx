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
bbdoc: wxWebView
End Rem
Module wx.wxWebView

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
bbdoc: This control may be used to render web (HTML / CSS / javascript) documents.
about: It is designed to allow the creation of multiple backends for each port, although currently just one is available.
It differs from wxHtmlWindow in that each backend is actually a full rendering engine, Trident on MSW and Webkit on OSX and GTK.
This allows the correct viewing complex pages with javascript and css.
End Rem
Type wxWebView Extends wxControl

	Rem
	bbdoc: 
	End Rem
	Function CreateWebView:wxWebView(parent:wxWindow, id:Int, url:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxWebView.Create(parent, id, url, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxWebView(parent:wxWindow, id:Int, url:String = Null, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxwebview_create(Self, parent.wxObjectPtr, id, url, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Gets the title of the current web page, or its URL/path if title is not available.
	End Rem
	Method GetCurrentTitle:String()
		Return bmx_wxwebview_getcurrenttitle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the URL of the currently displayed document.
	End Rem
	Method GetCurrentURL:String()
		Return bmx_wxwebview_getcurrenturl(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the HTML source code of the currently displayed document.
	End Rem
	Method GetPageSource:String()
		Return bmx_wxwebview_getpagesource(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the text of the current page.
	End Rem
	Method GetPageText:String()
		Return bmx_wxwebview_getpagetext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns whether the web control is currently busy (e.g. loading a page).
	End Rem
	Method IsBusy:Int()
		Return bmx_wxwebview_isbusy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns whether the web control is currently editable.
	End Rem
	Method IsEditable:Int()
		Return bmx_wxwebview_iseditable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Load a web page from a URL.
	about: Web engines generally report errors asynchronously, so if you wish to know whether loading the URL was successful,
	register to receive navigation error events.
	End Rem
	Method LoadURL(url:String)
		bmx_wxwebview_loadurl(wxObjectPtr, url)
	End Method
	
	Rem
	bbdoc: Opens a print dialog so that the user may print the currently displayed page.
	End Rem
	Method Print()
		bmx_wxwebview_print(wxObjectPtr)
	End Method
	
	'Method RegisterHandler()
	'End Method

	Rem
	bbdoc: Reloads the currently displayed URL.
	End Rem
	Method Reload(flags:Int = wxWEB_VIEW_RELOAD_DEFAULT)
		bmx_wxwebview_reload(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Runs the given javascript code.
	about: When using wxWEBVIEW_BACKEND_IE you must wait for the current page to finish loading before calling RunScript().
	End Rem
	Method RunScript(script:String)
		bmx_wxwebview_runscript(wxObjectPtr, script)
	End Method
	
	Rem
	bbdoc: Sets the editable property of the web control.
	about: Enabling allows the user to edit the page even if the contenteditable attribute is not set.
	The exact capabilities vary with the backend being used.
	End Rem
	Method SetEditable(enable:Int = True)
		bmx_wxwebview_seteditable(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: Sets the displayed page source to the contents of the given string.
	about: When using wxWEBVIEW_BACKEND_IE you must wait for the current page to finish loading before calling SetPage().
	End Rem
	Method SetPage(html:String, baseUrl:String)
		bmx_wxwebview_setpage(wxObjectPtr, html, baseUrl)
	End Method
	
	Rem
	bbdoc: Sets the displayed page source to the contents of the given stream.
	End Rem
	Method SetPageStream(html:wxInputStream, baseUrl:String)
		bmx_wxwebview_setpagestream(wxObjectPtr, html.wxStreamPtr, baseUrl)
	End Method
	
	Rem
	bbdoc: Stops the current page loading process, if any.
	about: May trigger an error event of type wxWEBVIEW_NAV_ERR_USER_CANCELLED.
	TODO: make wxWEBVIEW_NAV_ERR_USER_CANCELLED errors uniform across ports.
	End Rem
	Method Stop()
		bmx_wxwebview_stop(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the current selection can be copied.
	about: This always returns true on the OSX WebKit backend.
	End Rem
	Method CanCopy:Int()
		Return bmx_wxwebview_cancopy(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if the current selection can be cut.
	about: This always returns true on the OSX WebKit backend.
	End Rem
	Method CanCut:Int()
		Return bmx_wxwebview_cancut(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if data can be pasted.
	about: This always returns true on the OSX WebKit backend.
	End Rem
	Method CanPaste:Int()
		Return bmx_wxwebview_canpaste(wxObjectPtr)
	End Method

	Rem
	bbdoc: Copies the current selection.
	End Rem
	Method Copy()
		bmx_wxwebview_copy(wxObjectPtr)
	End Method

	Rem
	bbdoc: Cuts the current selection.
	End Rem
	Method Cut()
		bmx_wxwebview_cut(wxObjectPtr)
	End Method

	Rem
	bbdoc: Pastes the current data.
	End Rem
	Method Paste()
		bmx_wxwebview_paste(wxObjectPtr)
	End Method

	Rem
	bbdoc: Enables or disables the right click context menu.
	about: By default the standard context menu is enabled, this method can be used to disable it or re-enable it later.
	End Rem
	Method EnableContextMenu(enable:Int = True)
		bmx_wxwebview_enablecontextmenu(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: Returns true if a context menu will be shown on right click.
	End Rem
	Method IsContextMenuEnabled:Int()
		Return bmx_wxwebview_iscontextmenuenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if it is possible to navigate backward in the history of visited pages.
	End Rem
	Method CanGoBack:Int()
		Return bmx_wxwebview_cangoback(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if it is possible to navigate forward in the history of visited pages.
	End Rem
	Method CanGoForward:Int()
		Return bmx_wxwebview_cangoforward(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Clear the history, this will also remove the visible page.
	End Rem
	Method ClearHistory()
		bmx_wxwebview_clearhistory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Enables or disables the history.
	about: This will also clear the history.
	End Rem
	Method EnableHistory(enable:Int = True)
		bmx_wxwebview_enablehistory(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: Returns a list of items in the back history.
	about: The first item in the list is the first page that was loaded by the control.
	End Rem
	Method GetBackwardHistory:wxWebViewHistoryItem[]()
		Return bmx_wxwebview_getbackwardhistory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a list of items in the forward history.
	about: The first item in the list is the next item in the history with respect to the curently loaded page.
	End Rem
	Method GetForwardHistory:wxWebViewHistoryItem[]()
		Return bmx_wxwebview_getforwardhistory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Navigates back in the history of visited pages.
	about: Only valid if CanGoBack() returns true.
	End Rem
	Method GoBack()
		bmx_wxwebview_goback(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Navigates forward in the history of visited pages.
	about: Only valid if CanGoForward() returns true.
	End Rem
	Method GoForward()
		bmx_wxwebview_goforward(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Loads a history item.
	End Rem
	Method LoadHistoryItem(item:wxWebViewHistoryItem)
		bmx_wxwebview_loadhistoryitem(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Clears the current selection.
	End Rem
	Method ClearSelection()
		bmx_wxwebview_clearselection(wxObjectPtr)
	End Method

	Rem
	bbdoc: Deletes the current selection.
	about: Note that for wxWEBVIEW_BACKEND_WEBKIT the selection must be editable, either through SetEditable or the correct HTML attribute.
	End Rem
	Method DeleteSelection()
		bmx_wxwebview_deleteselection(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the currently selected source, if any.
	End Rem
	Method GetSelectedSource:String()
		Return bmx_wxwebview_getselectedsource(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns the currently selected text, if any.
	End Rem
	Method GetSelectedText:String()
		Return bmx_wxwebview_getselectedtext(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if there is a current selection.
	End Rem
	Method HasSelection:Int()
		Return bmx_wxwebview_hasselection(wxObjectPtr)
	End Method

	Rem
	bbdoc: Selects the entire page.
	End Rem
	Method SelectAll()
		bmx_wxwebview_selectall(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns true if there is an action to redo.
	End Rem
	Method CanRedo:Int()
		Return bmx_wxwebview_canredo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if there is an action to undo.
	End Rem
	Method CanUndo:Int()
		Return bmx_wxwebview_canundo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Redos the last action.
	End Rem
	Method Redo()
		bmx_wxwebview_redo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Undos the last action.
	End Rem
	Method Undo()
		bmx_wxwebview_undo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds a phrase on the current page and if found, the control will scroll the phrase into view and select it.
	returns: If search phrase was not found in combination with the flags then wxNOT_FOUND is returned. If called for the first time with search phrase then the total number of results will be returned. Then for every time its called with the same search phrase it will return the number of the current match.
	about: This method will restart the search if the flags wxWEBVIEW_FIND_ENTIRE_WORD or wxWEBVIEW_FIND_MATCH_CASE are changed,
	since this will require a new search. To reset the search, for example reseting the highlights call
	the method with an empty search phrase. This always returns wxNOT_FOUND on the OSX WebKit backend.
	End Rem
	Method Find:Int(text:String, flags:Int = wxWEB_VIEW_FIND_DEFAULT)
		Return bmx_wxwebview_find(wxObjectPtr, text, flags)
	End Method
	
	Rem
	bbdoc: Retrieves whether the current HTML engine supports a zoom type.
	returns: Whether this type of zoom is supported by this HTML engine (and thus can be set through SetZoomType()).
	End Rem
	Method CanSetZoomType:Int(zoomType:Int)
		Return bmx_wxwebview_cansetzoomtype(wxObjectPtr, zoomtype)
	End Method
	
	Rem
	bbdoc: Gets the zoom factor of the page.
	returns: The current level of zoom.
	End Rem
	Method GetZoom:Int()
		Return bmx_wxwebview_getzoom(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets how the zoom factor is currently interpreted.
	returns: How the zoom factor is currently interpreted by the HTML engine.
	End Rem
	Method GetZoomType:Int()
		Return bmx_wxwebview_getzoomtype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the zoom factor of the page.
	End Rem
	Method SetZoom(zoom:Int)
		bmx_wxwebview_setzoom(wxObjectPtr, zoom)
	End Method
	
	Rem
	bbdoc: Sets how to interpret the zoom factor.
	about: Invoke CanSetZoomType() first, some HTML renderers may not support all zoom types.
	End Rem
	Method SetZoomType(zoomType:Int)
		bmx_wxwebview_setzoomtype(wxObjectPtr, zoomType)
	End Method
	
End Type

Extern
	Function bmx_wxwebview_getbackwardhistory:wxWebViewHistoryItem[](handle:Byte Ptr)
	Function bmx_wxwebview_getforwardhistory:wxWebViewHistoryItem[](handle:Byte Ptr)
End Extern

Rem
bbdoc: A simple type that contains the URL and title of an element of the history of a wxWebView.
End Rem
Type wxWebViewHistoryItem

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxWebViewHistoryItem(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxWebViewHistoryItem = New wxWebViewHistoryItem
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _newArray:wxWebViewHistoryItem[](size:Int)
		Return New wxWebViewHistoryItem[size]
	End Function
	
	Function _setArrayValue(arr:wxWebViewHistoryItem[], index:Int, item:Byte Ptr)
		arr[index] = _create(item)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateItem:wxWebViewHistoryItem(url:String, title:String)
		Return New wxWebViewHistoryItem.Create(url, title)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxWebViewHistoryItem(url:String, title:String)
		wxObjectPtr = bmx_wxwebviewhistoryitem_create(url, title)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the URL of the page.
	End Rem
	Method GetURL:String()
		Return bmx_wxwebviewhistoryitem_geturl(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the title of the page.
	End Rem
	Method GetTitle:String()
		Return bmx_wxwebviewhistoryitem_gettitle(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxwebviewhistoryitem_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: A navigation event holds information about events associated with wxWebView objects.
End Rem
Type wxWebViewEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxWebViewEvent = New wxWebViewEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Gets the name of the target frame which the url of this event has been or will be loaded into.
	End Rem
	Method GetTarget:String()
		Return bmx_wxwebviewevent_gettarget(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Gets the URL being visited.
	End Rem
	Method GetURL:String()
		Return bmx_wxwebviewevent_geturl(wxEventPtr)
	End Method
	
End Type


Type TWebViewEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_WEBVIEW_NAVIGATING, wxEVT_WEBVIEW_NAVIGATED, ..
					wxEVT_WEBVIEW_LOADED, wxEVT_WEBVIEW_ERROR, wxEVT_WEBVIEW_NEWWINDOW, ..
					wxEVT_WEBVIEW_TITLE_CHANGED
				Return wxWebViewEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_WEBVIEW_NAVIGATING, wxEVT_WEBVIEW_NAVIGATED, ..
					wxEVT_WEBVIEW_LOADED, wxEVT_WEBVIEW_ERROR, wxEVT_WEBVIEW_NEWWINDOW, ..
					wxEVT_WEBVIEW_TITLE_CHANGED
			Return bmx_wxwebview_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TWebViewEventFactory
