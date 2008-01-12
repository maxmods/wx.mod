' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxFlatNotebook
End Rem
Module wx.wxFlatNotebook

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

' Changed wxFlatNotebook.cpp
'     Fixed SetFont() to skip m_pages-> bit if it is NULL. (for OS X)
'

Rem
bbdoc: Nice cross-platform flat notebook with X-button, navigation arrows and much more
End Rem
Type wxFlatNotebook Extends wxPanel

	Field imageListPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Function CreateFlatNotebook:wxFlatNotebook(parent:wxWindow, id:Int = wxID_ANY, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxFlatNotebook.CreateFNB(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method CreateFNB:wxFlatNotebook(parent:wxWindow, id:Int = wxID_ANY, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxflatnotebook_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Advance the current selection
	about: if @forward is set to true then selection should be advanced forward otherwise - backward
	End Rem
	Method AdvanceSelection(forward:Int)
		bmx_wxflatnotebook_advanceselection(wxObjectPtr, forward)
	End Method
	
	Rem
	bbdoc: Appends new notebook page
	End Rem
	Method AddPage:Int(window:wxWindow, caption:String, selected:Int = False, imgIndex:Int = -1)
		Return bmx_wxflatnotebook_addpage(wxObjectPtr, window.wxObjectPtr, caption, selected, imgIndex)
	End Method
	
	Rem
	bbdoc: Inserts new notebook page
	End Rem
	Method InsertPage:Int(index:Int, page:wxWindow, text:String, selected:Int = False, imgIndex:Int = -1)
		Return bmx_wxflatnotebook_insertpage(wxObjectPtr, index, page.wxObjectPtr, text, selected, imgIndex)
	End Method
	
	Rem
	bbdoc: Changes the selection from currently visible/selected page to the page given by index
	End Rem
	Method SetSelection(page:Int)
		bmx_wxflatnotebook_setselection(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Removes the window from the notebook, and destroys the window associated with that notebook page
	End Rem
	Method DeletePage(page:Int, _notify:Int = True)
		bmx_wxflatnotebook_deletepage(wxObjectPtr, page, _notify)
	End Method
	
	Rem
	bbdoc: Deletes all notebook pages and destroys all windows associated with pages
	End Rem
	Method DeleteAllPages:Int()
		Return bmx_wxflatnotebook_deleteallpages(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the total number of pages in the notebook
	End Rem
	Method GetPageCount:Int()
		Return bmx_wxflatnotebook_getpagecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the window object associated with selected notebook page
	End Rem
	Method GetCurrentPage:wxWindow()
		Return wxWindow._find(bmx_wxflatnotebook_getcurrentpage(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the window object associated with a notebook page
	End Rem
	Method GetPage:wxWindow(page:Int)
		Return wxWindow._find(bmx_wxflatnotebook_getpage(wxObjectPtr, page))
	End Method
	
	Rem
	bbdoc: Returns the page index of the window object
	End Rem
	Method GetPageIndex:Int(win:wxWindow)
		Return bmx_wxflatnotebook_getpageindex(wxObjectPtr, win.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the currently visible/selected notebook page 0 based index.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxflatnotebook_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the previous selection, useful when implementing smart tabulation
	End Rem
	Method GetPreviousSelection:Int()
		Return bmx_wxflatnotebook_getpreviousselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns tab header inclination angle of specified page
	End Rem
	Method GetPageShapeAngle:Int(page:Int, result:Int Var)
		Return bmx_wxflatnotebook_getpageshapeangle(wxObjectPtr, page, Varptr result)
	End Method
	
	Rem
	bbdoc: Sets tab header inclination angle of specified page
	End Rem
	Method SetPageShapeAngle(page:Int, angle:Int)
		bmx_wxflatnotebook_setpageshapeangle(wxObjectPtr, page, angle)
	End Method
	
	Rem
	bbdoc: Sets tab header inclination angle for all pages
	End Rem
	Method SetAllPagesShapeAngle(angle:Int)
		bmx_wxflatnotebook_setallpagesshapeangle(wxObjectPtr, angle)
	End Method
	
	Rem
	bbdoc: Returns the best size for a page
	End Rem
	Method GetPageBestSize(w:Int Var, h:Int Var)
		bmx_wxflatnotebook_getpagebestsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Sets the caption/text of the notebook page
	End Rem
	Method SetPageText:Int(page:Int, text:String)
		Return bmx_wxflatnotebook_setpagetext(wxObjectPtr, page, text)
	End Method
	
	Rem
	bbdoc: Removes the window from the notebook, and destroys the window associated with that notebook page
	End Rem
	Method RemovePage:Int(page:Int, _notify:Int = True)
		Return bmx_wxflatnotebook_removepage(wxObjectPtr, page, _notify)
	End Method
	
	Rem
	bbdoc: Sets the amount of space around each page's icon and label, in pixels
	End Rem
	Method SetPadding(padW:Int, padH:Int)
		bmx_wxflatnotebook_setpadding(wxObjectPtr, padW, padH)
	End Method
	
	Rem
	bbdoc: Alters the notebook style
	End Rem
	Method SetWindowStyleFlag(style:Int)
		bmx_wxflatnotebook_setwindowstyleflag(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Sets a right click menu to the notebook
	End Rem
	Method SetRightClickMenu(menu:wxMenu)
		bmx_wxflatnotebook_setrightclickmenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page text
	End Rem
	Method GetPageText:String(page:Int)
		Return bmx_wxflatnotebook_getpagetext(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets an image index of specified page
	End Rem
	Method SetPageImageIndex(page:Int, imgIndex:Int)
		bmx_wxflatnotebook_setpageimageindex(wxObjectPtr, page, imgIndex)
	End Method
	
	Rem
	bbdoc: Returns an image index of specified page
	End Rem
	Method GetPageImageIndex:Int(page:Int)
		Return bmx_wxflatnotebook_getpageimageindex(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets gradient colors (only applicable when using the wxFNB_FANCY_TABS)
	End Rem
	Method SetGradientColors(colFrom:wxColour, colTo:wxColour, border:wxColour)
		bmx_wxflatnotebook_setgradientcolors(wxObjectPtr, colFrom.wxObjectPtr, colTo.wxObjectPtr, border.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets first gradient colour
	End Rem
	Method SetGradientColorFrom(colour:wxColour)
		bmx_wxflatnotebook_setgradientcolorfrom(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets second gradient colour
	End Rem
	Method SetGradientColorTo(colour:wxColour)
		bmx_wxflatnotebook_setgradientcolorto(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the colour of page border
	End Rem
	Method SetGradientColorBorder(colour:wxColour)
		bmx_wxflatnotebook_setgradientcolorborder(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets an image list associated with notebook pages
	End Rem
	Method SetImageList(list:wxBitmap[])
		If list And list.length > 0 Then
'			Local bits:Byte Ptr[] = New Byte Ptr[list.length]
'			For Local i:Int = 0 Until list.length
'				bits[i] = list[i].wxObjectPtr
'			Next
			If imageListPtr Then
				bmx_wxflatnotebook_deleteimagelist(imageListPtr)
			End If
			imageListPtr = bmx_wxflatnotebook_setimagelist(wxObjectPtr, list)
		End If
	End Method
	
	Function _getbitmap:Byte Ptr(list:wxBitmap[], index:Int)
		Return list[index].wxObjectPtr
	End Function
	
	Rem
	bbdoc: Returns an image list object associated with wxFlatNotebook
	End Rem
	Method GetImageList:wxBitmap[]()
		Return bmx_wxflatnotebook_getimagelist(wxObjectPtr)
	End Method
	
	Function _newbitmaparray:wxBitmap[](size:Int)
		Return New wxBitmap[size]
	End Function
	
	Function _setbitmap(list:wxBitmap[], index:Int, bitmap:Byte Ptr)
		list[index] = wxBitmap._create(bitmap)
	End Function
	
	Rem
	bbdoc: Enable / Disable page
	End Rem
	Method EnablePage(page:Int, enabled:Int)
		bmx_wxflatnotebook_enablepage(wxObjectPtr, page, enabled)
	End Method

	Rem
	bbdoc: Return Returns true if if the page is enabled
	End Rem
	Method GetPageEnabled:Int(page:Int)
		Return bmx_wxflatnotebook_getpageenabled(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Set the active tab text
	End Rem
	Method SetActiveTabTextColour(colour:wxColour)
		bmx_wxflatnotebook_setactivetabtextcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets first gradient colour
	End Rem
	Method GetGradientColorFrom:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getgradientcolorfrom(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets second gradient colour
	End Rem
	Method GetGradientColorTo:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getgradientcolorto(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets the tab border colour
	End Rem
	Method GetGradientColorBorder:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getgradientcolorborder(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Get the active tab text
	End Rem
	Method GetActiveTabTextColour:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getactivetabtextcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Get the non-active tab text color
	End Rem
	Method GetNonActiveTabTextColour:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getnonactivetabtextcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set the non-active tab text color
	End Rem
	Method SetNonActiveTabTextColour(colour:wxColour)
		bmx_wxflatnotebook_setnonactivetabtextcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the tab area panel
	End Rem
	Method GetTabArea:wxPanel()
		Return wxPanel._create(bmx_wxflatnotebook_gettabarea(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Get the tab area background colour
	End Rem
	Method GetTabAreaColour:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_gettabareacolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set the tab area background colour
	End Rem
	Method SetTabAreaColour(colour:wxColour)
		bmx_wxflatnotebook_settabareacolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the active tab color
	End Rem
	Method GetActiveTabColour:wxColour()
		Return wxColour._create(bmx_wxflatnotebook_getactivetabcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set the active tab color
	End Rem
	Method SetActiveTabColour(colour:wxColour)
		bmx_wxflatnotebook_setactivetabcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the padding used between the text and icons, text and borders, etc
	End Rem
	Method GetPadding:Int()
		Return bmx_wxflatnotebook_getpadding(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the customization options available for this notebook, can be one of the wxFNB_CUSTOM_* values this values is by default set to wxFNB_CUSTOM_ALL
	End Rem
	Method SetCustomizeOptions(options:Int)
		bmx_wxflatnotebook_setcustomizeoptions(wxObjectPtr, options)
	End Method
	
	Rem
	bbdoc: Get the customization options available for this notebook
	End Rem
	Method GetCustomizeOptions:Int()
		Return bmx_wxflatnotebook_getcustomizeoptions(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets force selection
	End Rem
	Method SetForceSelection(force:Int)
		bmx_wxflatnotebook_setforceselection(wxObjectPtr, force)
	End Method
	
	Rem
	bbdoc: Gets force selection.
	End Rem
	Method GetForceSelection:Int()
		Return bmx_wxflatnotebook_getforceselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the main sizer.
	End Rem
	Method GetMainSizer:wxBoxSizer()
		Return wxBoxSizer._create(bmx_wxflatnotebook_getmainsizer(wxObjectPtr))
	End Method

	Method Delete()
		If imageListPtr Then
			bmx_wxflatnotebook_deleteimagelist(imageListPtr)
			imageListPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Holds information about events associated with wxFlatNotebook objects
End Rem
Type wxFlatNotebookEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxFlatNotebookEvent = New wxFlatNotebookEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Sets the value of current selection
	End Rem
	Method SetSelection(selection:Int)
		bmx_wxflatnotebookevent_setselection(wxEventPtr, selection)
	End Method
	
	Rem
	bbdoc: Sets the value of previous selection
	End Rem
	Method SetOldSelection(selection:Int)
		bmx_wxflatnotebookevent_setoldselection(wxEventPtr, selection)
	End Method
	
	Rem
	bbdoc: Returns the index of currently selected page
	End Rem
	Method GetSelection:Int()
		Return bmx_wxflatnotebookevent_getselection(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of previously selected page
	End Rem
	Method GetOldSelection:Int()
		Return bmx_wxflatnotebookevent_getoldselection(wxEventPtr)
	End Method
	
End Type

Type TFlatNotebookEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSING, ..
					wxEVT_COMMAND_FLATNOTEBOOK_CONTEXT_MENU, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSED
				Return wxFlatNotebookEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSING, ..
					wxEVT_COMMAND_FLATNOTEBOOK_CONTEXT_MENU, ..
					wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSED
				Return bmx_wxflatnotebook_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TFlatNotebookEventFactory
