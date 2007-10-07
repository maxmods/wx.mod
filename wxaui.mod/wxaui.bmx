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
bbdoc: wxAUI
End Rem
Module wx.wxAUI

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
	bbdoc: 
	End Rem
	Method GetAllPanes()
	End Method
	
	Rem
	bbdoc: 
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
	bbdoc: 
	End Rem
	Method SetArtProvider(artProvider:wxAuiDockArt)
		'bmx_wxauimanager_setArtProvider(wxObjectPtr, artProvider
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
		
		Return Self
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
		'Return bmx_wxauinotebook_deletepage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the associated art provider.
	End Rem
	Method GetArtProvider:wxAuiTabArt()
	End Method
	
	Rem
	bbdoc: Returns the page specified by the given index.
	End Rem
	Method GetPage:wxWindow(page:Int)
		'Return bmx_wxauinotebook_getpage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the tab bitmap for the page.
	End Rem
	Method GetPageBitmap:wxBitmap(page:Int)
	End Method
	
	Rem
	bbdoc: Returns the number of pages in the notebook.
	End Rem
	Method GetPageCount:Int()
	End Method
	
	Rem
	bbdoc: Returns the page index for the specified window.
	about: If the window is not found in the notebook, wxNOT_FOUND is returned.
	End Rem
	Method GetPageIndex:Int(page:wxWindow)
	End Method
	
	Rem
	bbdoc: Returns the tab label for the page.
	End Rem
	Method GetPageText:String(page:Int)
	End Method
	
	Rem
	bbdoc: Returns the currently selected page.
	End Rem
	Method GetSelection:Int()
	End Method
	
	Rem
	bbdoc: Similar to AddPage, but allows the ability to specify the insert location.
	about: If the @sel parameter is True, calling this will generate a page change event.
	End Rem
	Method InsertPage:Int(index:Int, page:wxWindow, caption:String, sel:Int = False, bitmap:wxBitmap = Null)
	End Method
	
	Rem
	bbdoc: Removes a page, without deleting the window reference.
	End Rem
	Method RemovePage:Int(page:Int)
	End Method
	
	Rem
	bbdoc: Sets the art provider to be used by the notebook.
	End Rem
	Method SetArtProvider(art:wxAuiTabArt)
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the page.
	about: To remove a bitmap from the tab caption, pass wxNullBitmap.
	End Rem
	Method SetPageBitmap:Int(page:Int, bitmap:wxBitmap)
	End Method
	
	Rem
	bbdoc: Sets the tab label for the page.
	End Rem
	Method SetPageText:Int(page:Int, text:String)
	End Method
	
	Rem
	bbdoc: Sets the page selection.
	about: Calling this method will generate a page change event.
	End Rem
	Method SetSelection:Int(page:Int)
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
	End Method
	
	Rem
	bbdoc: Ensures that all tabs will have the same height, even if some tabs don't have bitmaps.
	about: Passing wxDefaultSize to this function will instruct the control to use dynamic tab height,
	which is the default behaviour. Under the default behaviour, when a tab with a large bitmap is
	added, the tab control's height will automatically increase to accommodate the larger bitmap.
	End Rem
	Method SetUniformBitmapSize(w:Int, h:Int)
	End Method
	
	Rem
	bbdoc: Split performs a split operation programmatically.
	about: The argument page indicates the page that will be split off. This page will also become
	the active page after the split. The direction argument specifies where the pane should go,
	it should be one of the following: wxTOP, wxBOTTOM, wxLEFT, or wxRIGHT.
	End Rem
	Method Split(page:Int, direction:Int)
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
	bbdoc: 
	End Rem
	Function CreateAuiPanelInfo:wxAuiPaneInfo()
		Return New wxAuiPaneInfo.Create()	
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_create())
	End Method
	
	Method Delete()
		If wxAuiPaneInfoPtr Then
			bmx_wxauipanelinfo_delete(wxAuiPaneInfoPtr)
			wxAuiPaneInfoPtr = Null
		End If
	End Method

	Rem
	bbdoc: Sets the ideal size for the pane.
	about: The docking manager will attempt to use this size as much as possible when docking or
	floating the pane.
	End Rem
	Method BestSize:wxAuiPaneInfo(w:Int, h:Int)
		Return _create(bmx_wxauipanelinfo_bestsize(wxAuiPaneInfoPtr, w, h))
	End Method
	
	Rem
	bbdoc: Sets the pane dock position to the bottom side of the frame.
	about: This is the same thing as calling Direction(wxAUI_DOCK_BOTTOM).
	End Rem
	Method Bottom:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_bottom(wxAuiPaneInfoPtr))
	End Method
		
	Rem
	bbdoc: Indicates whether a pane can be docked at the bottom of the frame.
	End Rem
	Method BottomDockable:wxAuiPaneInfo(dockable:Int = True)
		Return _create(bmx_wxauipanelinfo_bottomdockable(wxAuiPaneInfoPtr, dockable))
	End Method
	
	Rem
	bbdoc: Sets the caption of the pane.
	End Rem
	Method Caption:wxAuiPaneInfo(text:String)
		Return _create(bmx_wxauipanelinfo_caption(wxAuiPaneInfoPtr, text))
	End Method
	
	Rem
	bbdoc: Indicates that a pane caption should be visible.
	about: If false, no pane caption is drawn.
	End Rem
	Method CaptionVisible:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_captionvisible(wxAuiPaneInfoPtr, visible))
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
		Return _create(bmx_wxauipanelinfo_centre(wxAuiPaneInfoPtr))
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
		Return _create(bmx_wxauipanelinfo_center(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default center pane settings.
	about: Centre panes usually do not have caption bars. This function provides an easy way of
	preparing a pane to be displayed in the center dock position.
	End Rem
	Method CentrePane:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_centrepane(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default center pane settings.
	about: Centre panes usually do not have caption bars. This function provides an easy way of
	preparing a pane to be displayed in the center dock position.
	End Rem
	Method CenterPane:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_centerpane(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Indicates that a close button should be drawn for the pane.
	End Rem
	Method CloseButton:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_closebutton(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: Specifies that the pane should adopt the default pane settings.
	End Rem
	Method DefaultPane:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_defaultpane(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Indicates whether a pane should be detroyed when it is closed.
	about: Normally a pane is simply hidden when the close button is clicked. Setting
	DestroyOnClose to true will cause the window to be destroyed when the user clicks the
	pane's close button.
	End Rem
	Method DestroyOnClose:wxAuiPaneInfo(dest:Int = True)
		Return _create(bmx_wxauipanelinfo_destroyonclose(wxAuiPaneInfoPtr, dest))
	End Method
	
	Rem
	bbdoc: Determines the direction of the docked pane.
	about: It is functionally the same as calling Left(), Right(), Top() or Bottom(),
	except that docking direction may be specified programmatically via the parameter.
	End Rem
	Method Direction:wxAuiPaneInfo(dir:Int)
		Return _create(bmx_wxauipanelinfo_direction(wxAuiPaneInfoPtr, dir))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Dock:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_dock(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Specifies whether a frame can be docked or not.
	about: It is the same as specifying TopDockable(b).BottomDockable(b).LeftDockable(b).RightDockable(b).
	End Rem
	Method Dockable:wxAuiPaneInfo(dock:Int = True)
		Return _create(bmx_wxauipanelinfo_dockable(wxAuiPaneInfoPtr, dock))
	End Method
	
	Rem
	bbdoc: Forces a pane to be fixed size so that it cannot be resized.
	about: After calling Fixed(), IsFixed() will return true.
	End Rem
	Method Fixed:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_fixed(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Indicates that a pane should be floated.
	End Rem
	Method FloatPane:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_floatpane(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: Sets whether the user will be able to undock a pane and turn it into a floating window.
	End Rem
	Method Floatable:wxAuiPaneInfo(value:Int = True)
		Return _create(bmx_wxauipanelinfo_floatable(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: Sets the position of the floating pane.
	End Rem
	Method FloatingPosition:wxAuiPaneInfo(x:Int, y:Int)
		Return _create(bmx_wxauipanelinfo_floatingposition(wxAuiPaneInfoPtr, x, y))
	End Method
	
	Rem
	bbdoc: Sets the size of the floating pane.
	End Rem
	Method FloatingSize:wxAuiPaneInfo(w:Int, h:Int)
		Return _create(bmx_wxauipanelinfo_floatingsize(wxAuiPaneInfoPtr, w, h))
	End Method
	
	Rem
	bbdoc: Returns the caption displayed on the window.
	End Rem
	Method GetCaption:String()
		Return bmx_wxauipanelinfo_getcaption(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the dock direction (top, bottom, left, right, center).
	End Rem
	Method GetDirection:Int()
		Return bmx_wxauipanelinfo_getdirection(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFloatingPosition(x:Int Var, y:Int Var)
		bmx_wxauipanelinfo_getfloatingpos(wxAuiPaneInfoPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFloatingSize(w:Int Var, h:Int Var)
		bmx_wxauipanelinfo_getfloatingsize(wxAuiPaneInfoPtr, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the layer number (0 = innermost layer).
	End Rem
	Method GetLayer:Int()
		Return bmx_wxauipanelinfo_getlayer(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the row number on the docking bar (0 = first row).
	End Rem
	Method GetRow:Int()
		Return bmx_wxauipanelinfo_getrow(wxAuiPaneInfoPtr)
	End Method

	Rem
	bbdoc: Returns the position inside the row (0 = first position).
	End Rem
	Method GetPos:Int()
		Return bmx_wxauipanelinfo_getpos(wxAuiPaneInfoPtr)
	End Method
	
		
	Rem
	bbdoc: Returns the name of the pane.
	End Rem
	Method GetName:String()
		Return bmx_wxauipanelinfo_getname(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Returns the state: a combination of wxPaneState values.
	End Rem
	Method GetState:Int()
		Return bmx_wxauipanelinfo_getstate(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: Indicates that a gripper should be drawn for the pane.
	End Rem
	Method Gripper:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_gripper(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GripperTop:wxAuiPaneInfo(attop:Int = True)
		Return _create(bmx_wxauipanelinfo_grippertop(wxAuiPaneInfoPtr, attop))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasBorder:Int()
		Return bmx_wxauipanelinfo_hasborder(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasCaption:Int()
		Return bmx_wxauipanelinfo_hascaption(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasCloseButton:Int()
		Return bmx_wxauipanelinfo_hasclosebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasFlag:Int(flag:Int)
		Return bmx_wxauipanelinfo_hasflag(wxAuiPaneInfoPtr, flag)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasGripper:Int()
		Return bmx_wxauipanelinfo_hasgripper(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasGripperTop:Int()
		Return bmx_wxauipanelinfo_hasgrippertop(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasMaximizeButton:Int()
		Return bmx_wxauipanelinfo_hasmaximizebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasMinimizeButton:Int()
		Return bmx_wxauipanelinfo_hasminimizebutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasPinButton:Int()
		Return bmx_wxauipanelinfo_haspinbutton(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Hide:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_hide(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsBottomDockable:Int()
		Return bmx_wxauipanelinfo_isbottomdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsDocked:Int()
		Return bmx_wxauipanelinfo_isdocked(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsFixed:Int()
		Return bmx_wxauipanelinfo_isfixed(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsFloatable:Int()
		Return bmx_wxauipanelinfo_isfloatable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsFloating:Int()
		Return bmx_wxauipanelinfo_isfloating(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsLeftDockable:Int()
		Return bmx_wxauipanelinfo_isleftdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsMovable:Int()
		Return bmx_wxauipanelinfo_ismovable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsOk:Int()
		Return bmx_wxauipanelinfo_isok(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsResizable:Int()
		Return bmx_wxauipanelinfo_isresizable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsRightDockable:Int()
		Return bmx_wxauipanelinfo_isrightdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsShown:Int()
		Return bmx_wxauipanelinfo_isshown(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsToolbar:Int()
		Return bmx_wxauipanelinfo_istoolbar(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsTopDockable:Int()
		Return bmx_wxauipanelinfo_istopdockable(wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Layer:wxAuiPaneInfo(value:Int)
		Return _create(bmx_wxauipanelinfo_layer(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Left:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_left(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LeftDockable:wxAuiPaneInfo(dockable:Int = True)
		Return _create(bmx_wxauipanelinfo_leftdockable(wxAuiPaneInfoPtr, dockable))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MaxSize:wxAuiPaneInfo(w:Int, h:Int)
		Return _create(bmx_wxauipanelinfo_maxsize(wxAuiPaneInfoPtr, w, h))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MaximizeButton:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_maximizebutton(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MinSize:wxAuiPaneInfo(w:Int, h:Int)
		Return _create(bmx_wxauipanelinfo_minsize(wxAuiPaneInfoPtr, w, h))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MinimizeButton:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_minimizebutton(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Movable:wxAuiPaneInfo(move:Int = True)
		Return _create(bmx_wxauipanelinfo_movable(wxAuiPaneInfoPtr, move))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Name:wxAuiPaneInfo(n:String)
		Return _create(bmx_wxauipanelinfo_name(wxAuiPaneInfoPtr, n))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PaneBorder:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_paneborder(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PinButton:wxAuiPaneInfo(visible:Int = True)
		Return _create(bmx_wxauipanelinfo_pinbutton(wxAuiPaneInfoPtr, visible))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Position:wxAuiPaneInfo(pos:Int)
		Return _create(bmx_wxauipanelinfo_position(wxAuiPaneInfoPtr, pos))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Resizable:wxAuiPaneInfo(value:Int = True)
		Return _create(bmx_wxauipanelinfo_resizable(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Right:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_right(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RightDockable:wxAuiPaneInfo(dockable:Int = True)
		Return _create(bmx_wxauipanelinfo_rightdockable(wxAuiPaneInfoPtr, dockable))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Row:wxAuiPaneInfo(value:Int)
		Return _create(bmx_wxauipanelinfo_row(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SafeSet(source:wxAuiPaneInfo)
		bmx_wxauipanelinfo_safeset(wxAuiPaneInfoPtr, source.wxAuiPaneInfoPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFlag:wxAuiPaneInfo(flag:Int, optionState:Int)
		Return _create(bmx_wxauipanelinfo_setflag(wxAuiPaneInfoPtr, flag, optionState))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Show:wxAuiPaneInfo(value:Int = True)
		Return _create(bmx_wxauipanelinfo_show(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToolbarPane:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_toolbarpane(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Top:wxAuiPaneInfo()
		Return _create(bmx_wxauipanelinfo_top(wxAuiPaneInfoPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TopDockable:wxAuiPaneInfo(value:Int = True)
		Return _create(bmx_wxauipanelinfo_topdocakable(wxAuiPaneInfoPtr, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Window:wxAuiPaneInfo(w:wxWindow)
		Return _create(bmx_wxauipanelinfo_window(wxAuiPaneInfoPtr, w.wxObjectPtr))
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxAuiTabArt
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

	Method Delete()
		If wxAuiDockArtPtr Then
			'bmx_wxauidockart_delete(wxAuiDockArtPtr)
			wxAuiDockArtPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxAuiManagerEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxAuiManagerEvent = New wxAuiManagerEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetManager:wxAuiManager()
		'Return wxAuiManager(bmx_wxauimanagerevent_getmanager(wxEventPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPane:wxAuiPaneInfo()
		Return wxAuiPaneInfo._create(bmx_wxauimanagerevent_getpane(wxEventPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetButton:Int()
		Return bmx_wxauimanagerevent_getbutton(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDC:wxDC()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Veto(_veto:Int = True)
		bmx_wxauimanagerevent_veto(wxEventPtr, _veto)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetVeto:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanVeto:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCanVeto(canVeto:Int)
	End Method
	
End Type


Type TAuiEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_AUINOTEBOOK_BUTTON, ..
					wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_END_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION, ..
					wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND
				Return wxCommandEvent.Create(wxEventPtr, evt)
			Case wxEVT_AUI_PANE_BUTTON, ..
					wxEVT_AUI_PANE_CLOSE, ..
					wxEVT_AUI_PANE_MAXIMIZE, ..
					wxEVT_AUI_PANE_RESTORE, ..
					wxEVT_AUI_RENDER, ..
					wxEVT_AUI_FIND_MANAGER
				Return wxAuiManagerEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_AUINOTEBOOK_BUTTON, ..
					wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_END_DRAG, ..
					wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION, ..
					wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND, ..
					wxEVT_AUI_PANE_BUTTON, ..
					wxEVT_AUI_PANE_CLOSE, ..
					wxEVT_AUI_PANE_MAXIMIZE, ..
					wxEVT_AUI_PANE_RESTORE, ..
					wxEVT_AUI_RENDER, ..
					wxEVT_AUI_FIND_MANAGER
				Return bmx_wxaui_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TAuiEventFactory

