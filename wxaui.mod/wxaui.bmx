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
bbdoc: wxAUI
End Rem
Module wx.wxAUI

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
bbdoc: wxAuiManager is the central type of the wxAUI type framework.
about: wxAuiManager manages the panes associated with it for a particular wxFrame, using a pane's
wxAuiPaneInfo information to determine each pane's docking and floating behavior. wxAuiManager uses
wxWidgets' sizer mechanism to plan the layout of each frame. It uses a replaceable dock art class to do all
drawing, so all drawing is localized in one area, and may be customized depending on an application's specific needs.
<p>
wxAuiManager works as follows: the programmer adds panes to the class, or makes changes to existing pane
properties (dock position, floating state, show state, etc.). To apply these changes, wxAuiManager's Update()
function is called. This batch processing can be used to avoid flicker, by modifying more than one pane at a time,
and then "committing" all of the changes at once by calling Update().
</p>
<p>
Panes can be added quite easily:
<pre>
	Local text1:wxTextCtrl = new wxTextCtrl.Create(Self)
	Local text2:wxTextCtrl = new wxTextCtrl.Create(Self)
	m_mgr.AddPane(text1, wxLEFT, "Pane Caption")
	m_mgr.AddPane(text2, wxBOTTOM, "Pane Caption")
	m_mgr.Update()
</pre>
Later on, the positions can be modified easily. The following will float an existing pane in a tool window:
<pre>
	m_mgr.GetPane(text1).Float()
</pre>
</p>
<h3>Layers, Rows and Directions, Positions</h3>
<p>
Inside wxAUI, the docking layout is figured out by checking several pane parameters. Four of these are important
for determining where a pane will end up:
<ul>
<li><b>Direction:</b> Each docked pane has a direction, Top, Bottom, Left, Right, or Center. This is fairly
self-explanatory. The pane will be placed in the location specified by this variable.</li>
<li><b>Position:</b> More than one pane can be placed inside of a dock. Imagine two panes being docked on the left
side of a window. One pane can be placed over another. In proportionally managed docks, the pane position indicates
its sequential position, starting with zero. So, in our scenario with two panes docked on the left side, the top
pane in the dock would have position 0, and the second one would occupy position 1.</li>
<li><b>Row:</b> A row can allow for two docks to be placed next to each other. One of the most common places for
this to happen is in the toolbar. Multiple toolbar rows are allowed, the first row being row 0, and the second row
1. Rows can also be used on vertically docked panes.</li>
<li><b>Layer:</b> A layer is akin to an onion. Layer 0 is the very center of the managed pane. Thus, if a pane
is in layer 0, it will be closest to the center window (also sometimes known as the "content window"). Increasing
layers "swallow up" all layers of a lower value. This can look very similar to multiple rows, but is different
because all panes in a lower level yield to panes in higher levels. The best way to understand layers is by running
the wxAUI sample.
</li>
</ul>
</p>
End Rem
Type wxAuiManager Extends wxEvtHandler

	' soft linking
	Function _create:wxAuiManager(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxAuiManager = New wxAuiManager
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxAuiManager(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local manager:wxAuiManager = wxAuiManager(wxfind(wxObjectPtr))
			If Not manager Then
				Return wxAuiManager._create(wxObjectPtr)
			End If
			Return manager
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateAuiManager:wxAuiManager(managedWindow:wxWindow = Null, flags:Int = wxAUI_MGR_DEFAULT)
		Return New wxAuiManager.Create(managedWindow, flags)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxAuiManager(managedWindow:wxWindow = Null, flags:Int = wxAUI_MGR_DEFAULT)
		If managedWindow Then
			wxObjectPtr = bmx_wxauimanager_create(Self, managedWindow.wxObjectPtr, flags)
		Else
			wxObjectPtr = bmx_wxauimanager_create(Self, Null, flags)
		End If
		
		Return Self
	End Method

	Rem
	bbdoc: Tells the frame manager to start managing a child window.
	End Rem
	Method AddPane:Int(window:wxWindow, direction:Int = wxLEFT, caption:String = "")
		Return bmx_wxauimanager_addpane(wxObjectPtr, window.wxObjectPtr, direction, caption)
	End Method
	
	Rem
	bbdoc: Tells the frame manager to start managing a child window.
	about: Allows an optional drop position to be specified, which will determine where the pane will be added.
	End Rem
	Method AddPaneInfo:Int(window:wxWindow, paneInfo:wxAuiPaneInfo, dpX:Int = -1, dpY:Int = -1)
		Return bmx_wxauimanager_addpaneinfo(wxObjectPtr, window.wxObjectPtr, paneInfo.wxAuiPaneInfoPtr, dpX, dpY)
	End Method
	
	Rem
	bbdoc: Tells the wxAuiManager to stop managing the pane specified by window.
	about: The window, if in a floated frame, is reparented to the frame managed by wxAuiManager.
	End Rem
	Method DetachPane:Int(window:wxWindow)
		Return bmx_wxauimanager_detachpane(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns an array of all panes managed by the frame manager.
	End Rem
	Method GetAllPanes:wxAuiPaneInfo[]()
		Return bmx_wxauimanager_getallpanes(wxObjectPtr)
	End Method
	
	Function _createpanearray:wxAuiPaneInfo[](size:Int)
		Return New wxAuiPaneInfo[size]
	End Function
	
	Function _setpanevalue(arr:wxAuiPaneInfo[], index:Int, info:Byte Ptr)
		arr[index] = wxAuiPaneInfo._create(info)
	End Function
	
	Rem
	bbdoc: Returns the current art provider being used.
	End Rem
	Method GetArtProvider:wxAuiDockArt()
		Return wxAuiDockArt._create(bmx_wxauimanager_getartprovider(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the current dock constraint values.
	about: See SetDockSizeConstraint() for more information.
	End Rem
	Method GetDockSizeConstraint(widthpct:Double Var, heightpct:Double Var)
		bmx_wxauimanager_getdocksizeconstraint(wxObjectPtr, Varptr widthpct, Varptr heightpct)
	End Method
	
	Rem
	bbdoc: Returns the current manager's flags.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxauimanager_getflags(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the frame currently being managed by wxAuiManager.
	End Rem
	Method GetManagedWindow:wxWindow()
		Return wxWindow(wxfind(bmx_wxauimanager_getmanagedwindow(wxObjectPtr)))
	End Method
	
	Rem
	bbdoc: Returns the wxAuiManager for a given window.
	about: The window parameter should specify any child window or sub-child window of the frame or window
	managed by wxAuiManager. The window parameter need not be managed by the manager itself, nor does it even
	need to be a child or sub-child of a managed window. It must however be inside the window hierarchy
	underneath the managed window.
	End Rem
	Function GetManager:wxAuiManager(window:wxWindow)
		Return wxAuiManager(wxfind(bmx_wxauimanager_getmanager(window.wxObjectPtr)))
	End Function
	
	Rem
	bbdoc: Used to lookup a wxAuiPaneInfo object by pane name, which acts as a unique id for a window pane.
	about: The returned wxAuiPaneInfo object may then be modified to change a pane's look, state or position.
	After one or more modifications to wxAuiPaneInfo, wxAuiManager::Update() should be called to commit the
	changes to the user interface. If the lookup failed (meaning the pane could not be found in the manager),
	a call to the returned wxAuiPaneInfo's IsOk() method will return false.
	End Rem
	Method GetPane:wxAuiPaneInfo(name:String)
		Return wxAuiPaneInfo._create(bmx_wxauimanager_getpane(wxObjectPtr, name))
	End Method
	
	Rem
	bbdoc: Used to lookup a wxAuiPaneInfo object either by a window, which acts as a unique id for a window pane.
	about: The returned wxAuiPaneInfo object may then be modified to change a pane's look, state or position.
	After one or more modifications to wxAuiPaneInfo, wxAuiManager::Update() should be called to commit the
	changes to the user interface. If the lookup failed (meaning the pane could not be found in the manager),
	a call to the returned wxAuiPaneInfo's IsOk() method will return false.
	End Rem
	Method GetPaneWindow:wxAuiPaneInfo(window:wxWindow)
		Return wxAuiPaneInfo._create(bmx_wxauimanager_getpanewindow(wxObjectPtr, window.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Hides any docking hint that may be visible.
	End Rem
	Method HideHint()
		bmx_wxauimanager_hidehint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Used to insert either a previously unmanaged pane window into the frame manager, or to insert a currently managed pane somewhere else.
	about: InsertPane will push all panes, rows, or docks aside and insert the window into the position
	specified by insert_location. Because insert_location can specify either a pane, dock row, or dock layer,
	the insert_level parameter is used to disambiguate this. The parameter insert_level can take a value of
	wxAUI_INSERT_PANE, wxAUI_INSERT_ROW or wxAUI_INSERT_DOCK.
	End Rem
	Method InsertPane:Int(window:wxWindow, insertLocation:wxAuiPaneInfo, insertLevel:Int = wxAUI_INSERT_PANE)
		Return bmx_wxauimanager_insertpane(wxObjectPtr, window.wxObjectPtr, insertLocation.wxAuiPaneInfoPtr, insertLevel)
	End Method
	
	Rem
	bbdoc: Similar to to LoadPerspective, with the exception that it only loads information about a single pane.
	about: It is used in combination with SavePaneInfo().
	End Rem
	Method LoadPaneInfo:wxAuiPaneInfo(panePart:String)
		Return wxAuiPaneInfo._create(bmx_wxauimanager_loadpaneinfo(wxObjectPtr, panePart))
	End Method
	
	Rem
	bbdoc: Loads a saved perspective.
	about: If update is true, wxAuiManager::Update() is automatically invoked, thus realizing the saved
	perspective on screen.
	End Rem
	Method LoadPerspective:Int(perspective:String, update:Int = True)
		Return bmx_wxauimanager_loadperspective(wxObjectPtr, perspective, update)
	End Method
	
	Rem
	bbdoc: Similar to SavePerspective, with the exception that it only saves information about a single pane.
	about: It is used in combination with LoadPaneInfo().
	End Rem
	Method SavePaneInfo:String(pane:wxAuiPaneInfo)
		Return bmx_wxauimanager_savepaneinfo(wxObjectPtr, pane.wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Saves the entire user interface layout into an encoded wxString, which can then be stored by the application (probably using wxConfig).
	about: When a perspective is restored using LoadPerspective(), the entire user interface will return to
	the state it was when the perspective was saved.
	End Rem
	Method SavePerspective:String()
		Return bmx_wxauimanager_saveperspective(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Instructs wxAuiManager to use art provider specified by parameter @artProvider for all drawing calls.
	about: This allows plugable look-and-feel features. The previous art provider object, if any, will be deleted by
	wxAuiManager.
	End Rem
	Method SetArtProvider(artProvider:wxAuiDockArt)
		bmx_wxauimanager_setartprovider(wxObjectPtr, artProvider.wxAuiDockArtPtr)
	End Method
	
	Rem
	bbdoc: When a user creates a new dock by dragging a window into a docked position, often times the large size of the window will create a dock that is unwieldly large.
	about: wxAuiManager by default limits the size of any new dock to 1/3 of the window size. For horizontal
	docks, this would be 1/3 of the window height. For vertical docks, 1/3 of the width. Calling this function
	will adjust this constraint value. The numbers must be between 0.0 and 1.0. For instance, calling
	SetDockSizeConstraint with 0.5, 0.5 will cause new docks to be limited to half of the size of the entire
	managed window. 
	End Rem
	Method SetDockSizeConstraint(widthpct:Double, heightpct:Double)
		bmx_wxauimanager_setdocksizeconstraint(wxObjectPtr, widthpct, heightpct)
	End Method
	
	Rem
	bbdoc: This method is used to specify wxAuiManager's settings flags.
	about: @flags specifies options which allow the frame management behavior to be modified.
	End Rem
	Method SetFlags(flags:Int)
		bmx_wxauimanager_setflags(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Called to specify the frame or window which is to be managed by wxAuiManager.
	about: Frame management is not restricted to just frames. Child windows or custom controls are also allowed.
	End Rem
	Method SetManagedWindow(window:wxWindow)
		bmx_wxauimanager_setmanagedwindow(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Used by controls to explicitly show a hint window at the specified rectangle.
	about: It is rarely called, and is mostly used by controls implementing custom pane drag/drop behaviour.
	The specified rectangle should be in screen coordinates.
	End Rem
	Method ShowHint(x:Int, y:Int, w:Int, h:Int)
		bmx_wxauimanager_showhint(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Uninitializes the framework and should be called before a managed frame or window is destroyed.
	about: Usually called in the managed wxFrame's destructor. It is necessary to call this function
	before the managed frame or window is destroyed, otherwise the manager cannot remove its custom event handlers
	from a window.
	End Rem
	Method UnInit()
		bmx_wxauimanager_uninit(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: This method is called after any number of changes are made to any of the managed panes.
	about: Must be invoked after AddPane() or InsertPane() are called in order to "realize" or "commit"
	the changes. In addition, any number of changes may be made to wxAuiPaneInfo structures (retrieved with
	wxAuiManager::GetPane), but to realize the changes, Update() must be called. This construction allows pane
	flicker to be avoided by updating the whole layout at one time.
	End Rem
	Method Update()
		bmx_wxauimanager_update(wxObjectPtr)
	End Method

End Type

Rem
bbdoc: wxAuiNotebook is part of the wxAUI type framework.
about: wxAuiNotebook is a notebook control which implements many features common in applications
with dockable panes. Specifically, wxAuiNotebook implements functionality which allows the user to
rearrange tab order via drag-and-drop, split the tab window into many different splitter configurations,
and toggle through different themes to customize the control's look and feel.
<p>
An effort has been made to try to maintain an API as similar to that of wxNotebook.
</p>
<p><b>Styles</b>
<table width="90%" align="center">
<tr><th>Constant</th><th>Description</th></tr>
<tr><td>wxAUI_NB_DEFAULT_STYLE </td><td>Defined as wxAUI_NB_TOP | wxAUI_NB_TAB_SPLIT | wxAUI_NB_TAB_MOVE | wxAUI_NB_SCROLL_BUTTONS | wxAUI_NB_CLOSE_ON_ACTIVE_TAB . </td></tr>
<tr><td>wxAUI_NB_TAB_SPLIT </td><td>Allows the tab control to be split by dragging a tab.  </td></tr>
<tr><td>wxAUI_NB_TAB_MOVE </td><td>Allows a tab to be moved horizontally by dragging.  </td></tr>
<tr><td>wxAUI_NB_TAB_EXTERNAL_MOVE </td><td>Allows a tab to be moved to another tab control.  </td></tr>
<tr><td>wxAUI_NB_TAB_FIXED_WIDTH </td><td>With this style, all tabs have the same width.  </td></tr>
<tr><td>wxAUI_NB_SCROLL_BUTTONS </td><td>With this style, left and right scroll buttons are displayed.  </td></tr>
<tr><td>wxAUI_NB_WINDOWLIST_BUTTON </td><td>With this style, a drop-down list of windows is available.  </td></tr>
<tr><td>wxAUI_NB_CLOSE_BUTTON </td><td>With this style, a close button is available on the tab bar.  </td></tr>
<tr><td>wxAUI_NB_CLOSE_ON_ACTIVE_TAB </td><td>With this style, the close button is visible on the active tab.  </td></tr>
<tr><td>wxAUI_NB_CLOSE_ON_ALL_TABS </td><td>With this style, the close button is visible on all tabs.  </td></tr>
<tr><td>wxAUI_NB_TOP </td><td>With this style, tabs are drawn along the top of the notebook.  </td></tr>
<tr><td>wxAUI_NB_BOTTOM </td><td>With this style, tabs are drawn along the bottom of the notebook.  </td></tr>
</table>
</p>
End Rem
Type wxAuiNotebook Extends wxControl

	Rem
	bbdoc: Constructor. Creates a wxAuiNotebok control.
	End Rem
	Function CreateAuiNoteBook:wxAuiNotebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxAUI_NB_DEFAULT_STYLE)
			
		Return New wxAuiNotebook.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateAuiNoteBook.
	End Rem
	Method Create:wxAuiNotebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxAUI_NB_DEFAULT_STYLE)
			
		wxObjectPtr = bmx_wxauinotebook_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: Sets the selection to the next or previous page.
	End Rem
	Method AdvanceSelection(forward:Int = True)
		bmx_wxauinotebook_advanceselection(wxObjectPtr, forward)
	End Method

	Rem
	bbdoc: Adds a page.
	about: If the @sel parameter is true, calling this will generate a page change event.
	End Rem
	Method AddPage:Int(page:wxWindow, caption:String, sel:Int = False, bitmap:wxBitmap = Null)
		If bitmap Then
			Return bmx_wxauinotebook_addpage(wxObjectPtr, page.wxObjectPtr, caption, sel, bitmap.wxObjectPtr)
		Else
			Return bmx_wxauinotebook_addpage(wxObjectPtr, page.wxObjectPtr, caption, sel, Null)
		End If
	End Method
	
	Rem
	bbdoc: Deletes a page at the given index.
	about: Calling this method will generate a page change event.
	End Rem
	Method DeletePage:Int(page:Int)
		Return bmx_wxauinotebook_deletepage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the associated art provider.
	End Rem
	Method GetArtProvider:wxAuiTabArt()
		Return wxAuiTabArt._create(bmx_wxauinotebook_getartprovider(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the desired height of the notebook for the given page height.
	about: Use this to fit the notebook to a given page size.
	End Rem
	Method GetHeightForPageHeight:Int(pageHeight:Int)
		Return bmx_wxauinotebook_getheightforpageheight(wxObjectPtr, pageHeight)
	End Method
	
	Rem
	bbdoc: Returns the page specified by the given index.
	End Rem
	Method GetPage:wxWindow(page:Int)
		Return wxWindow._find(bmx_wxauinotebook_getpage(wxObjectPtr, page))
	End Method
	
	Rem
	bbdoc: Returns the tab bitmap for the page.
	End Rem
	Method GetPageBitmap:wxBitmap(page:Int)
		Return wxBitmap._create(bmx_wxauinotebook_getpagebitmap(wxObjectPtr, page))
	End Method
	
	Rem
	bbdoc: Returns the number of pages in the notebook.
	End Rem
	Method GetPageCount:Int()
		Return bmx_wxauinotebook_getpagecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page index for the specified window.
	about: If the window is not found in the notebook, wxNOT_FOUND is returned.
	End Rem
	Method GetPageIndex:Int(page:wxWindow)
		Return bmx_wxauinotebook_getpageindex(wxObjectPtr, page.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the tab label for the page.
	End Rem
	Method GetPageText:String(page:Int)
		Return bmx_wxauinotebook_getpagetext(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the currently selected page.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxauinotebook_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the height of the tab control.
	End Rem
	Method GetTabCtrlHeight:Int()
		Return bmx_wxauinotebook_gettabctrlheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Similar to AddPage, but allows the ability to specify the insert location.
	about: If the @sel parameter is True, calling this will generate a page change event.
	End Rem
	Method InsertPage:Int(index:Int, page:wxWindow, caption:String, sel:Int = False, bitmap:wxBitmap = Null)
		If bitmap Then
			Return bmx_wxauinotebook_insertpage(wxObjectPtr, index, page.wxObjectPtr, caption, sel, bitmap.wxObjectPtr)
		Else
			Return bmx_wxauinotebook_insertpage(wxObjectPtr, index, page.wxObjectPtr, caption, sel, Null)
		End If
	End Method
	
	Rem
	bbdoc: Removes a page, without deleting the window reference.
	End Rem
	Method RemovePage:Int(page:Int)
		Return bmx_wxauinotebook_removepage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the art provider to be used by the notebook.
	End Rem
	Method SetArtProvider(art:wxAuiTabArt)
		bmx_wxauinotebook_setartprovider(wxObjectPtr, art.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for drawing the tab labels, using a bold version of the font for selected tab labels.
	End Rem
	Method SetFont:Int(font:wxFont)
		Return bmx_wxauinotebook_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for drawing unselected tab labels.
	End Rem
	Method SetNormalFont(font:wxFont)
		bmx_wxauinotebook_setnormalfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for drawing selected tab labels.
	End Rem
	Method SetSelectedFont(font:wxFont)
		bmx_wxauinotebook_setselectedfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the font for measuring tab labels.
	End Rem
	Method SetMeasuringFont(font:wxFont)
		bmx_wxauinotebook_setmeasuringfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the page.
	about: To remove a bitmap from the tab caption, pass wxNullBitmap.
	End Rem
	Method SetPageBitmap:Int(page:Int, bitmap:wxBitmap)
		Return bmx_wxauinotebook_setpagebitmap(wxObjectPtr, page, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the tab label for the page.
	End Rem
	Method SetPageText:Int(page:Int, text:String)
		Return bmx_wxauinotebook_setpagetext(wxObjectPtr, page, text)
	End Method
	
	Rem
	bbdoc: Sets the page selection.
	about: Calling this method will generate a page change event.
	End Rem
	Method SetSelection:Int(page:Int)
		Return bmx_wxauinotebook_setselection(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the tab height.
	about: By default, the tab control height is calculated by measuring the text height and bitmap
	sizes on the tab captions. Calling this method will override that calculation and set the tab
	control to the specified height parameter. A call to this method will override any call to
	SetUniformBitmapSize(). Specifying -1 as the height will return the control to its default
	auto-sizing behaviour.
	End Rem
	Method SetTabCtrlHeight(height:Int)
		bmx_wxauinotebook_settabctrlheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: Ensures that all tabs will have the same height, even if some tabs don't have bitmaps.
	about: Passing wxDefaultSize to this function will instruct the control to use dynamic tab height,
	which is the default behaviour. Under the default behaviour, when a tab with a large bitmap is
	added, the tab control's height will automatically increase to accommodate the larger bitmap.
	End Rem
	Method SetUniformBitmapSize(w:Int, h:Int)
		bmx_wxauinotebook_setuniformbitmapsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Split performs a split operation programmatically.
	about: The argument page indicates the page that will be split off. This page will also become
	the active page after the split. The direction argument specifies where the pane should go,
	it should be one of the following: wxTOP, wxBOTTOM, wxLEFT, or wxRIGHT.
	End Rem
	Method Split(page:Int, direction:Int)
		bmx_wxauinotebook_split(wxObjectPtr, page, direction)
	End Method
	
	Rem
	bbdoc: Shows the window menu for the active tab control associated with this notebook, and returns true if a selection was made.
	End Rem
	Method ShowWindowMenu:Int()
		Return bmx_wxauinotebook_showwindowmenu(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: wxAuiPaneInfo is part of the wxAUI type framework.
about: wxAuiPaneInfo specifies all the parameters for a pane. These parameters specify where the pane is on the
screen, whether it is docked or floating, or hidden. In addition, these parameters specify the pane's docked
position, floating position, preferred size, minimum size, caption text among many other parameters.
End Rem
Type wxAuiPaneInfo

	Field wxAuiPaneInfoPtr:Byte Ptr

	Function _create:wxAuiPaneInfo(wxAuiPaneInfoPtr:Byte Ptr)
		If wxAuiPaneInfoPtr Then
			Local this:wxAuiPaneInfo = New wxAuiPaneInfo
			this.wxAuiPaneInfoPtr = wxAuiPaneInfoPtr
			Return this
		End If
		
		Return Null
	End Function
	
	Rem
	bbdoc: Constructs a new wxAuiPaneInfo object.
	End Rem
	Function CreateAuiPanelInfo:wxAuiPaneInfo()
		Return New wxAuiPaneInfo.Create()	
	End Function
	
	Rem
	bbdoc: Constructs a new wxAuiPaneInfo object.
	End Rem
	Method Create:wxAuiPaneInfo()
		wxAuiPaneInfoPtr = bmx_wxauipaneinfo_create()
		
		Return Self
	End Method
	
	Method Delete()
		If wxAuiPaneInfoPtr Then
			bmx_wxauipaneinfo_delete(wxAuiPaneInfoPtr)
			wxAuiPaneInfoPtr = Null
		End If
	End Method

	Rem
	bbdoc: Sets the ideal size for the pane.
	about: The docking manager will attempt to use this size as much as possible when docking or
	floating the pane.
	End Rem
	Method BestSize:wxAuiPaneInfo(w:Int, h:Int)
		bmx_wxauipaneinfo_bestsize(wxAuiPaneInfoPtr, w, h)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the bottom side of the frame.
	about: This is the same thing as calling Direction(wxAUI_DOCK_BOTTOM).
	End Rem
	Method Bottom:wxAuiPaneInfo()
		bmx_wxauipaneinfo_bottom(wxAuiPaneInfoPtr)
		Return Self
	End Method
		
	Rem
	bbdoc: Indicates whether a pane can be docked at the bottom of the frame.
	End Rem
	Method BottomDockable:wxAuiPaneInfo(dockable:Int = True)
		bmx_wxauipaneinfo_bottomdockable(wxAuiPaneInfoPtr, dockable)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the caption of the pane.
	End Rem
	Method Caption:wxAuiPaneInfo(text:String)
		bmx_wxauipaneinfo_caption(wxAuiPaneInfoPtr, text)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a pane caption should be visible.
	about: If false, no pane caption is drawn.
	End Rem
	Method CaptionVisible:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_captionvisible(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the left side of the frame.
	about: The centre pane is the space in the middle after all border panes (left, top, right, bottom)
	are subtracted from the layout.
	<p>
	This is the same thing as calling Direction(wxAUI_DOCK_CENTRE).
	</p>
	End Rem
	Method Centre:wxAuiPaneInfo()
		bmx_wxauipaneinfo_centre(wxAuiPaneInfoPtr)
		Return Self
	End Method

	Rem
	bbdoc: Sets the pane dock position to the left side of the frame.
	about: The centre pane is the space in the middle after all border panes (left, top, right, bottom)
	are subtracted from the layout.
	<p>
	This is the same thing as calling Direction(wxAUI_DOCK_CENTER).
	</p>
	End Rem
	Method Center:wxAuiPaneInfo()
		bmx_wxauipaneinfo_center(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default center pane settings.
	about: Centre panes usually do not have caption bars. This function provides an easy way of
	preparing a pane to be displayed in the center dock position.
	End Rem
	Method CentrePane:wxAuiPaneInfo()
		bmx_wxauipaneinfo_centrepane(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default center pane settings.
	about: Centre panes usually do not have caption bars. This function provides an easy way of
	preparing a pane to be displayed in the center dock position.
	End Rem
	Method CenterPane:wxAuiPaneInfo()
		bmx_wxauipaneinfo_centerpane(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a close button should be drawn for the pane.
	End Rem
	Method CloseButton:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_closebutton(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default pane settings.
	End Rem
	Method DefaultPane:wxAuiPaneInfo()
		bmx_wxauipaneinfo_defaultpane(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates whether a pane should be detroyed when it is closed.
	about: Normally a pane is simply hidden when the close button is clicked. Setting
	DestroyOnClose to true will cause the window to be destroyed when the user clicks the
	pane's close button.
	End Rem
	Method DestroyOnClose:wxAuiPaneInfo(dest:Int = True)
		bmx_wxauipaneinfo_destroyonclose(wxAuiPaneInfoPtr, dest)
		Return Self
	End Method
	
	Rem
	bbdoc: Determines the direction of the docked pane.
	about: It is functionally the same as calling Left(), Right(), Top() or Bottom(),
	except that docking direction may be specified programmatically via the parameter.
	End Rem
	Method Direction:wxAuiPaneInfo(dir:Int)
		bmx_wxauipaneinfo_direction(wxAuiPaneInfoPtr, dir)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a pane should be docked.
	about: It is the opposite of Float().
	End Rem
	Method Dock:wxAuiPaneInfo()
		bmx_wxauipaneinfo_dock(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: causes the containing dock to have no resize sash.
	about: This is useful for creating panes that span the entire width or height of a dock, but should not be resizable in the other direction.
	End Rem
	Method DockFixed:wxAuiPaneInfo()
		bmx_wxauipaneinfo_dockfixed(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Specifies whether a frame can be docked or not.
	about: It is the same as specifying TopDockable(b).BottomDockable(b).LeftDockable(b).RightDockable(b).
	End Rem
	Method Dockable:wxAuiPaneInfo(dock:Int = True)
		bmx_wxauipaneinfo_dockable(wxAuiPaneInfoPtr, dock)
		Return Self
	End Method
	
	Rem
	bbdoc: Forces a pane to be fixed size so that it cannot be resized.
	about: After calling Fixed(), IsFixed() will return true.
	End Rem
	Method Fixed:wxAuiPaneInfo()
		bmx_wxauipaneinfo_fixed(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a pane should be floated.
	End Rem
	Method FloatPane:wxAuiPaneInfo()
		bmx_wxauipaneinfo_floatpane(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets whether the user will be able to undock a pane and turn it into a floating window.
	End Rem
	Method Floatable:wxAuiPaneInfo(value:Int = True)
		bmx_wxauipaneinfo_floatable(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the position of the floating pane.
	End Rem
	Method FloatingPosition:wxAuiPaneInfo(x:Int, y:Int)
		bmx_wxauipaneinfo_floatingposition(wxAuiPaneInfoPtr, x, y)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the size of the floating pane.
	End Rem
	Method FloatingSize:wxAuiPaneInfo(w:Int, h:Int)
		bmx_wxauipaneinfo_floatingsize(wxAuiPaneInfoPtr, w, h)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the caption displayed on the window.
	End Rem
	Method GetCaption:String()
		Return bmx_wxauipaneinfo_getcaption(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the dock direction (top, bottom, left, right, center).
	End Rem
	Method GetDirection:Int()
		Return bmx_wxauipaneinfo_getdirection(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFloatingPosition(x:Int Var, y:Int Var)
		bmx_wxauipaneinfo_getfloatingpos(wxAuiPaneInfoPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFloatingSize(w:Int Var, h:Int Var)
		bmx_wxauipaneinfo_getfloatingsize(wxAuiPaneInfoPtr, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the layer number (0 = innermost layer).
	End Rem
	Method GetLayer:Int()
		Return bmx_wxauipaneinfo_getlayer(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the row number on the docking bar (0 = first row).
	End Rem
	Method GetRow:Int()
		Return bmx_wxauipaneinfo_getrow(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the position inside the row (0 = first position).
	End Rem
	Method GetPos:Int()
		Return bmx_wxauipaneinfo_getpos(wxAuiPaneInfoPtr)
	End Method
	
		
	Rem
	bbdoc: Returns the name of the pane.
	End Rem
	Method GetName:String()
		Return bmx_wxauipaneinfo_getname(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns the state: a combination of wxPaneState values.
	End Rem
	Method GetState:Int()
		Return bmx_wxauipaneinfo_getstate(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns the window that is in this pane.
	End Rem
	Method GetWindow:wxWindow()
		Return wxWindow._find(bmx_wxauipaneinfo_getwindow(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Indicates that a gripper should be drawn for the pane.
	End Rem
	Method Gripper:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_gripper(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc:  Indicates that a gripper should be drawn at the top of the pane.
	End Rem
	Method GripperTop:wxAuiPaneInfo(attop:Int = True)
		bmx_wxauipaneinfo_grippertop(wxAuiPaneInfoPtr, attop)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a border.
	End Rem
	Method HasBorder:Int()
		Return bmx_wxauipaneinfo_hasborder(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a caption.
	End Rem
	Method HasCaption:Int()
		Return bmx_wxauipaneinfo_hascaption(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a button to close the pane.
	End Rem
	Method HasCloseButton:Int()
		Return bmx_wxauipaneinfo_hasclosebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the the property specified by flag is active for the pane.
	End Rem
	Method HasFlag:Int(flag:Int)
		Return bmx_wxauipaneinfo_hasflag(wxAuiPaneInfoPtr, flag)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a gripper.
	End Rem
	Method HasGripper:Int()
		Return bmx_wxauipaneinfo_hasgripper(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a gripper at the top.
	End Rem
	Method HasGripperTop:Int()
		Return bmx_wxauipaneinfo_hasgrippertop(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a button to maximize the pane.
	End Rem
	Method HasMaximizeButton:Int()
		Return bmx_wxauipaneinfo_hasmaximizebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a button to minimize the pane.
	End Rem
	Method HasMinimizeButton:Int()
		Return bmx_wxauipaneinfo_hasminimizebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane displays a button to float the pane.
	End Rem
	Method HasPinButton:Int()
		Return bmx_wxauipaneinfo_haspinbutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Indicates that a pane should be hidden.
	End Rem
	Method Hide:wxAuiPaneInfo()
		bmx_wxauipaneinfo_hide(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be docked at the bottom of the managed frame.
	End Rem
	Method IsBottomDockable:Int()
		Return bmx_wxauipaneinfo_isbottomdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane is docked.
	End Rem
	Method IsDocked:Int()
		Return bmx_wxauipaneinfo_isdocked(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane cannot be resized.
	End Rem
	Method IsFixed:Int()
		Return bmx_wxauipaneinfo_isfixed(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be undocked and displayed as a floating window.
	End Rem
	Method IsFloatable:Int()
		Return bmx_wxauipaneinfo_isfloatable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane is floating.
	End Rem
	Method IsFloating:Int()
		Return bmx_wxauipaneinfo_isfloating(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be docked on the left of the managed frame.
	End Rem
	Method IsLeftDockable:Int()
		Return bmx_wxauipaneinfo_isleftdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the docked frame can be undocked or moved to another dock position.
	End Rem
	Method IsMovable:Int()
		Return bmx_wxauipaneinfo_ismovable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the wxAuiPaneInfo structure is valid. A pane structure is valid if it has an associated window.
	End Rem
	Method IsOk:Int()
		Return bmx_wxauipaneinfo_isok(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be resized.
	End Rem
	Method IsResizable:Int()
		Return bmx_wxauipaneinfo_isresizable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be docked on the right of the managed frame.
	End Rem
	Method IsRightDockable:Int()
		Return bmx_wxauipaneinfo_isrightdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane is currently shown.
	End Rem
	Method IsShown:Int()
		Return bmx_wxauipaneinfo_isshown(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane contains a toolbar.
	End Rem
	Method IsToolbar:Int()
		Return bmx_wxauipaneinfo_istoolbar(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pane can be docked at the top of the managed frame.
	End Rem
	Method IsTopDockable:Int()
		Return bmx_wxauipaneinfo_istopdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Determines the layer of the docked pane.
	about: The dock layer is similar to an onion, the inner-most layer being layer 0. Each shell moving in the outward
	direction has a higher layer number. This allows for more complex docking layout formation.
	End Rem
	Method Layer:wxAuiPaneInfo(value:Int)
		bmx_wxauipaneinfo_layer(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the left side of the frame.
	about: This is the same thing as calling Direction(wxAUI_DOCK_LEFT).
	End Rem
	Method Left:wxAuiPaneInfo()
		bmx_wxauipaneinfo_left(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates whether a pane can be docked on the left of the frame.
	End Rem
	Method LeftDockable:wxAuiPaneInfo(dockable:Int = True)
		bmx_wxauipaneinfo_leftdockable(wxAuiPaneInfoPtr, dockable)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the maximum size of the pane.
	End Rem
	Method MaxSize:wxAuiPaneInfo(w:Int, h:Int)
		bmx_wxauipaneinfo_maxsize(wxAuiPaneInfoPtr, w, h)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a maximize button should be drawn for the pane.
	End Rem
	Method MaximizeButton:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_maximizebutton(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the minimum size of the pane.
	about: Please note that this is only partially supported as of this writing.
	End Rem
	Method MinSize:wxAuiPaneInfo(w:Int, h:Int)
		bmx_wxauipaneinfo_minsize(wxAuiPaneInfoPtr, w, h)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a minimize button should be drawn for the pane.
	End Rem
	Method MinimizeButton:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_minimizebutton(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates whether a frame can be moved.
	End Rem
	Method Movable:wxAuiPaneInfo(move:Int = True)
		bmx_wxauipaneinfo_movable(wxAuiPaneInfoPtr, move)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the name of the pane so it can be referenced in lookup functions.
	about: If a name is not specified by the user, a random name is assigned to the pane when it is added to the manager.
	End Rem
	Method Name:wxAuiPaneInfo(n:String)
		bmx_wxauipaneinfo_name(wxAuiPaneInfoPtr, n)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a border should be drawn for the pane.
	End Rem
	Method PaneBorder:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_paneborder(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a pin button should be drawn for the pane.
	End Rem
	Method PinButton:wxAuiPaneInfo(visible:Int = True)
		bmx_wxauipaneinfo_pinbutton(wxAuiPaneInfoPtr, visible)
		Return Self
	End Method
	
	Rem
	bbdoc: Determines the position of the docked pane.
	End Rem
	Method Position:wxAuiPaneInfo(pos:Int)
		bmx_wxauipaneinfo_position(wxAuiPaneInfoPtr, pos)
		Return Self
	End Method
	
	Rem
	bbdoc: Allows a pane to be resized if the parameter is true, and forces it to be a fixed size if the parameter is false.
	about: This is simply an antonym for Fixed().
	End Rem
	Method Resizable:wxAuiPaneInfo(value:Int = True)
		bmx_wxauipaneinfo_resizable(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the right side of the frame.
	End Rem
	Method Right:wxAuiPaneInfo()
		bmx_wxauipaneinfo_right(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates whether a pane can be docked on the right of the frame.
	End Rem
	Method RightDockable:wxAuiPaneInfo(dockable:Int = True)
		bmx_wxauipaneinfo_rightdockable(wxAuiPaneInfoPtr, dockable)
		Return Self
	End Method
	
	Rem
	bbdoc: Determines the row of the docked pane.
	End Rem
	Method Row:wxAuiPaneInfo(value:Int)
		bmx_wxauipaneinfo_row(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Write the safe parts of a newly loaded PaneInfo structure @source into this object.
	about: Used on loading perspectives etc.
	End Rem
	Method SafeSet(source:wxAuiPaneInfo)
		bmx_wxauipaneinfo_safeset(wxAuiPaneInfoPtr, source.wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Turns the property given by flag on or off with the @optionState parameter.
	End Rem
	Method SetFlag:wxAuiPaneInfo(flag:Int, optionState:Int)
		bmx_wxauipaneinfo_setflag(wxAuiPaneInfoPtr, flag, optionState)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates that a pane should be shown.
	End Rem
	Method Show:wxAuiPaneInfo(value:Int = True)
		bmx_wxauipaneinfo_show(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default toolbar pane settings.
	End Rem
	Method ToolbarPane:wxAuiPaneInfo()
		bmx_wxauipaneinfo_toolbarpane(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the top of the frame.
	End Rem
	Method Top:wxAuiPaneInfo()
		bmx_wxauipaneinfo_top(wxAuiPaneInfoPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Indicates whether a pane can be docked at the top of the frame.
	End Rem
	Method TopDockable:wxAuiPaneInfo(value:Int = True)
		bmx_wxauipaneinfo_topdocakable(wxAuiPaneInfoPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: Assigns the window pointer that the wxAuiPaneInfo should use.
	about: This normally does not need to be specified, as the window pointer is automatically assigned to the
	wxAuiPaneInfo structure as soon as it is added to the manager.
	End Rem
	Method Window:wxAuiPaneInfo(w:wxWindow)
		bmx_wxauipaneinfo_window(wxAuiPaneInfoPtr, w.wxObjectPtr)
		Return Self
	End Method

End Type

Rem
bbdoc: Tab art type.
End Rem
Type wxAuiTabArt

	Field wxObjectPtr:Byte Ptr

	Function _create:wxAuiTabArt(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxAuiTabArt = New wxAuiTabArt
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
		Return Null
	End Function

End Type

Rem
bbdoc: wxAuiDockArt is part of the wxAUI type framework.
about: Dock art provider code - a dock provider provides all drawing functionality to the wxAui dock manager.
This allows the dock manager to have a plugable look-and-feel.
<p>
By default, a wxAuiManager uses an instance of this class called wxAuiDefaultDockArt which provides bitmap art
and a colour scheme that is adapted to the major platforms' look. You can either derive from that class to
alter its behaviour or write a completely new dock art class. Call wxAuiManager::SetArtProvider to make use
this new dock art.
</p>
End Rem
Type wxAuiDockArt

	Field wxAuiDockArtPtr:Byte Ptr

	Function _create:wxAuiDockArt(wxAuiDockArtPtr:Byte Ptr)
		Local this:wxAuiDockArt = New wxAuiDockArt
		
		this.wxAuiDockArtPtr = wxAuiDockArtPtr
		
		Return this
	End Function

	Rem
	bbdoc: Get the value of a certain setting.
	End Rem
	Method GetMetric:Int(id:Int)
		Return bmx_wxauidockart_getmetric(wxAuiDockArtPtr, id)
	End Method
	
	Rem
	bbdoc: Get the colour of a certain setting.
	End Rem
	Method GetColor:wxColour(id:Int)
		Return wxColour._create(bmx_wxauidockart_getcolor(wxAuiDockArtPtr, id))
	End Method
	
	Rem
	bbdoc: Get the colour of a certain setting.
	End Rem
	Method GetColour:wxColour(id:Int)
		Return wxColour._create(bmx_wxauidockart_getcolour(wxAuiDockArtPtr, id))
	End Method
	
	Rem
	bbdoc: Get a font setting.
	End Rem
	Method GetFont:wxFont(id:Int)
		Return wxFont._create(bmx_wxauidockart_getfont(wxAuiDockArtPtr, id))
	End Method
	
	Rem
	bbdoc: Set a certain setting with @value.
	End Rem
	Method SetMetric(id:Int, value:Int)
		bmx_wxauidockart_setmetric(wxAuiDockArtPtr, id, value)
	End Method
	
	Rem
	bbdoc: Set a certain setting with @colour.
	End Rem
	Method SetColor(id:Int, colour:wxColour)
		bmx_wxauidockart_setcolor(wxAuiDockArtPtr, id, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: Set a certain setting with @colour.
	End Rem
	Method SetColour(id:Int, colour:wxColour)
		bmx_wxauidockart_setcolour(wxAuiDockArtPtr, id, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set a font setting.
	End Rem
	Method SetFont(id:Int, font:wxFont)
		bmx_wxauidockart_setfont(wxAuiDockArtPtr, id, font.wxObjectPtr)
	End Method

	Method Delete()
		If wxAuiDockArtPtr Then
			'bmx_wxauidockart_delete(wxAuiDockArtPtr)
			wxAuiDockArtPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: wxAuiToolBar is a dockable toolbar, part of the wxAUI class framework.
End Rem
Type wxAuiToolBar Extends wxControl

	Rem
	bbdoc: Constructor. Creates a wxAuiToolBar control.
	End Rem
	Function CreateAuiToolBar:wxAuiToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxAUI_TB_DEFAULT_STYLE)
			
		Return New wxAuiToolBar.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see wxAuiToolBar.
	End Rem
	Method Create:wxAuiToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxAUI_TB_DEFAULT_STYLE)
			
		wxObjectPtr = bmx_wxauitoolbar_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method

End Type


Rem
bbdoc: 
End Rem
Type wxAuiToolBarItem

	Field wxAuiToolBarItemPtr:Byte Ptr
	
	Function _create:wxAuiToolBarItem(wxAuiToolBarItemPtr:Byte Ptr)
		If wxAuiToolBarItemPtr Then
			Local this:wxAuiToolBarItem = New wxAuiToolBarItem
			this.wxAuiToolBarItemPtr = wxAuiToolBarItemPtr
			Return this
		End If
		Return Null
	End Function

	Method SetWindow(w:wxWindow)
		bmx_wxauitoolbaritem_setwindow(wxAuiToolBarItemPtr, w.wxObjectPtr)
	End Method

	Method GetWindow:wxWindow()
		Return wxWindow._find(bmx_wxauitoolbaritem_getwindow(wxAuiToolBarItemPtr))
	End Method

	Method SetId(newId:Int)
		bmx_wxauitoolbaritem_setid(wxAuiToolBarItemPtr, newId)
	End Method

	Method GetId:Int()
		Return bmx_wxauitoolbaritem_getid(wxAuiToolBarItemPtr)
	End Method

	Method SetKind(newKind:Int)
		bmx_wxauitoolbaritem_setkind(wxAuiToolBarItemPtr, newKind)
	End Method

	Method GetKind:Int()
		Return bmx_wxauitoolbaritem_getkind(wxAuiToolBarItemPtr)
	End Method

	Method SetState(newState:Int)
		bmx_wxauitoolbaritem_setstate(wxAuiToolBarItemPtr, newState)
	End Method

	Method GetState:Int()
		Return bmx_wxauitoolbaritem_getstate(wxAuiToolBarItemPtr)
	End Method

	Method SetSizerItem(s:wxSizerItem)
		bmx_wxauitoolbaritem_setSizerItem(wxAuiToolBarItemPtr, s.wxSizerItemPtr)
	End Method

	Method GetSizerItem:wxSizerItem()
		Return wxSizerItem._create(bmx_wxauitoolbaritem_getsizeritem(wxAuiToolBarItemPtr))
	End Method

	Method SetLabel(s:String)
		bmx_wxauitoolbaritem_setlabel(wxAuiToolBarItemPtr, s)
	End Method

	Method GetLabel:String()
		Return bmx_wxauitoolbaritem_getlabel(wxAuiToolBarItemPtr)
	End Method

	Method SetBitmap(bmp:wxBitmap)
		bmx_wxauitoolbaritem_setbitmap(wxAuiToolBarItemPtr, bmp.wxObjectPtr)
	End Method

	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxauitoolbaritem_getbitmap(wxAuiToolBarItemPtr))
	End Method

	Method SetDisabledBitmap(bmp:wxBitmap)
		bmx_wxauitoolbaritem_setdisabledbitmap(wxAuiToolBarItemPtr, bmp.wxObjectPtr)
	End Method

	Method GetDisabledBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxauitoolbaritem_getdisabledbitmap(wxAuiToolBarItemPtr))
	End Method

	Method SetHoverBitmap(bmp:wxBitmap)
		bmx_wxauitoolbaritem_sethoverbitmap(wxAuiToolBarItemPtr, bmp.wxObjectPtr)
	End Method

	Method GetHoverBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxauitoolbaritem_gethoverbitmap(wxAuiToolBarItemPtr))
	End Method

	Method SetShortHelp(s:String)
		bmx_wxauitoolbaritem_setshorthelp(wxAuiToolBarItemPtr, s)
	End Method

	Method GetShortHelp:String()
		Return bmx_wxauitoolbaritem_getshorthelp(wxAuiToolBarItemPtr)
	End Method

	Method SetLongHelp(s:String)
		bmx_wxauitoolbaritem_setlonghelp(wxAuiToolBarItemPtr, s)
	End Method

	Method GetLongHelp:String()
		Return bmx_wxauitoolbaritem_getlonghelp(wxAuiToolBarItemPtr)
	End Method

	Method SetMinSize(w:Int, h:Int)
		bmx_wxauitoolbaritem_setminsize(wxAuiToolBarItemPtr, w, h)
	End Method

	Method GetMinSize(w:Int Var, h:Int Var)
		bmx_wxauitoolbaritem_getminsize(wxAuiToolBarItemPtr, Varptr w, Varptr h)
	End Method

	Method SetSpacerPixels(s:Int)
		bmx_wxauitoolbaritem_setspacerpixels(wxAuiToolBarItemPtr, s)
	End Method

	Method GetSpacerPixels:Int()
		Return bmx_wxauitoolbaritem_getspacerpixels(wxAuiToolBarItemPtr)
	End Method

	Method SetProportion(p:Int)
		bmx_wxauitoolbaritem_setproportion(wxAuiToolBarItemPtr, p)
	End Method

	Method GetProportion:Int()
		Return bmx_wxauitoolbaritem_getproportion(wxAuiToolBarItemPtr)
	End Method

	Method SetActive(active:Int)
		bmx_wxauitoolbaritem_setactive(wxAuiToolBarItemPtr, active)
	End Method

	Method IsActive:Int()
		Return bmx_wxauitoolbaritem_isactive(wxAuiToolBarItemPtr)
	End Method

	Method SetHasDropDown(value:Int)
		bmx_wxauitoolbaritem_sethasdropdown(wxAuiToolBarItemPtr, value)
	End Method

	Method HasDropDown:Int()
		Return bmx_wxauitoolbaritem_hasdropdown(wxAuiToolBarItemPtr)
	End Method

	Method SetSticky(value:Int)
		bmx_wxauitoolbaritem_setsticky(wxAuiToolBarItemPtr, value)
	End Method

	Method IsSticky:Int()
		Return bmx_wxauitoolbaritem_issticky(wxAuiToolBarItemPtr)
	End Method

	Method SetUserData(data:Int)
		bmx_wxauitoolbaritem_setuserdata(wxAuiToolBarItemPtr, data)
	End Method

	Method GetUserData:Int()
		Return bmx_wxauitoolbaritem_getuserdata(wxAuiToolBarItemPtr)
	End Method

	Method SetAlignment(value:Int)
		bmx_wxauitoolbaritem_setalignment(wxAuiToolBarItemPtr, value)
	End Method

	Method GetAlignment:Int()
		Return bmx_wxauitoolbaritem_getalignment(wxAuiToolBarItemPtr)
	End Method

End Type

Rem
bbdoc: An aui manager event.
End Rem
Type wxAuiManagerEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxAuiManagerEvent = New wxAuiManagerEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the manager associated with this event.
	End Rem
	Method GetManager:wxAuiManager()
		Return wxAuiManager._find(bmx_wxauimanagerevent_getmanager(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Returns the pane associated with this event.
	End Rem
	Method GetPane:wxAuiPaneInfo()
		Return wxAuiPaneInfo._create(bmx_wxauimanagerevent_getpane(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Returns the button id associated with this event.
	End Rem
	Method GetButton:Int()
		Return bmx_wxauimanagerevent_getbutton(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the DC associated with this event.
	End Rem
	Method GetDC:wxDC()
		Return wxDC._create(bmx_wxauimanagerevent_getdc(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Attempts to veto the event
	End Rem
	Method Veto(_veto:Int = True)
		bmx_wxauimanagerevent_veto(wxEventPtr, _veto)
	End Method
	
	Rem
	bbdoc: Returns the current veto status.
	End Rem
	Method GetVeto:Int()
		Return bmx_wxauimanagerevent_getveto(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the event can be vetoed.
	End Rem
	Method CanVeto:Int()
		Return bmx_wxauimanagerevent_canveto(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCanVeto(canVeto:Int)
		bmx_wxauimanagerevent_setcanveto(wxEventPtr, canVeto)
	End Method
	
End Type

Rem
bbdoc: A wxAuiNotebook event.
End Rem
Type wxAuiNotebookEvent Extends wxBookCtrlEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxAuiNotebookEvent = New wxAuiNotebookEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

End Type

Rem
bbdoc: A wxAuiToolBarEvent event.
End Rem
Type wxAuiToolBarEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxAuiToolBarEvent = New wxAuiToolBarEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns whether the drop down menu has been clicked.
	End Rem
	Method IsDropDownClicked:Int()
		Return bmx_wxauitoolbarevent_isdropdownclicked(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns the point where the user clicked with the mouse.
	End Rem
	Method GetClickPoint(x:Int Var, y:Int Var)
		bmx_wxauitoolbarevent_getclickpoint(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns the wxAuiToolBarItem rectangle bounding the mouse click point. 
	End Rem
	Method GetItemRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxauitoolbarevent_getitemrect(wxEventPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the wxAuiToolBarItem identifier.
	End Rem
	Method GetToolId:Int()
		Return bmx_wxauitoolbarevent_gettoolid(wxEventPtr)
	End Method

End Type

Type TAuiEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_AUINOTEBOOK_BUTTON, ..
					wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_END_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION, ..
					wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_DOWN, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_UP, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_DOWN, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_UP, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_DONE, ..
					wxEVT_COMMAND_AUINOTEBOOK_BG_DCLICK
				Return wxAuiNotebookEvent.Create(wxEventPtr, evt)
			Case wxEVT_AUI_PANE_BUTTON, ..
					wxEVT_AUI_PANE_CLOSE, ..
					wxEVT_AUI_PANE_MAXIMIZE, ..
					wxEVT_AUI_PANE_RESTORE, ..
					wxEVT_AUI_RENDER, ..
					wxEVT_AUI_FIND_MANAGER
				Return wxAuiManagerEvent.Create(wxEventPtr, evt)
			Case wxEVT_AUITOOLBAR_TOOL_DROPDOWN, ..
					wxEVT_AUITOOLBAR_OVERFLOW_CLICK, ..
					wxEVT_AUITOOLBAR_RIGHT_CLICK, ..
					wxEVT_AUITOOLBAR_MIDDLE_CLICK, ..
					wxEVT_AUITOOLBAR_BEGIN_DRAG
				Return wxAuiToolBarEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_AUINOTEBOOK_BUTTON, ..
					wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_END_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION, ..
					wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_DOWN, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_UP, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_DOWN, ..
					wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_UP, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_DONE, ..
					wxEVT_COMMAND_AUINOTEBOOK_BG_DCLICK, ..
					wxEVT_AUI_PANE_BUTTON, ..
					wxEVT_AUI_PANE_CLOSE, ..
					wxEVT_AUI_PANE_MAXIMIZE, ..
					wxEVT_AUI_PANE_RESTORE, ..
					wxEVT_AUI_RENDER, ..
					wxEVT_AUI_FIND_MANAGER, ..
					wxEVT_AUITOOLBAR_TOOL_DROPDOWN, ..
					wxEVT_AUITOOLBAR_OVERFLOW_CLICK, ..
					wxEVT_AUITOOLBAR_RIGHT_CLICK, ..
					wxEVT_AUITOOLBAR_MIDDLE_CLICK, ..
					wxEVT_AUITOOLBAR_BEGIN_DRAG
				Return bmx_wxaui_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TAuiEventFactory

Extern
	Function bmx_wxauimanager_getallpanes:wxAuiPaneInfo[](handle:Byte Ptr)
End Extern
