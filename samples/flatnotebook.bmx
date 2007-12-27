SuperStrict

Framework wx.wxApp
Import wx.wxFlatNotebook
Import wx.wxFrame
Import wx.wxSystemSettings
Import wx.wxTextCtrl

Global mainFrame:Frame


New MyApp.run()


Type MyApp Extends wxApp

	'Field frame:wxFrame

	Method OnInit:Int()

		mainFrame = Frame(New Frame.Create(Null, -1, "Frame"))
	'	frame = wxFrame.CreateFrame(,,"Hello World", 100, 100)
		mainFrame.show()
	
		Return True
	
	End Method

End Type


Type Frame Extends wxFrame

	' Menus

	Field m_fileMenu:wxMenu
	Field m_editMenu:wxMenu
	Field m_visualMenu:wxMenu


	Field m_menuBar:wxMenuBar

	Field book:wxFlatNotebook
	Field secondBook:wxFlatNotebook
	Field m_bShowImages:Int
	Field m_bVCStyle:Int
	Field newPageCounter:Int


	Method OnInit()
	
		' Init the menu bar
		m_menuBar  = New wxMenuBar.Create( wxMB_DOCKABLE )
		m_fileMenu = New wxMenu.Create()
		m_visualMenu = New wxMenu.Create()
	
		Local item:wxMenuItem = New wxMenuItem.Create(m_fileMenu, wxID_EXIT, "E&xit", "Exit demo", wxITEM_NORMAL)
		m_fileMenu.AppendItem(item)
		
		m_editMenu = New wxMenu.Create()
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_ADD_PAGE, "New Page~tCtrl+N", "Add New Page", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_INSERT_PAGE, "Insert Page~tCtrl+I", "Insert New Page", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_DELETE_PAGE, "Delete Page~tCtrl+F4", "Delete Page", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_SELECT_PAGE_TO_DELETE, "Select Page to Delete", "Delete Given Page", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_DELETE_ALL, "Delete All Pages", "Delete All Pages", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_SET_SELECTION, "Set Selection", "Set Selection", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_ADVANCE_SELECTION_FWD, "Advance Selection Forward", "Advance Selection Forward", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_EDIT_ADVANCE_SELECTION_BACK, "Advance Selection Backward", "Advance Selection Backward", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SET_ALL_TABS_SHAPE_ANGLE, "Set an inclination of tab header borders", "Set the shape of tab header", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_SET_PAGE_IMAGE_INDEX, "Set image index of selected page", "Set image index", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_SHOW_IMAGES, "Show Images", "Show Images", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
	
		Local styleMenu:wxMenu = New wxMenu.Create()
		item = New wxMenuItem.Create(styleMenu, MENU_USE_DEFULT_STYLE, "Use Default Style", "Use VC71 Style", wxITEM_RADIO)
		styleMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(styleMenu, MENU_USE_VC71_STYLE, "Use VC71 Style", "Use VC71 Style", wxITEM_RADIO)
		styleMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(styleMenu, MENU_USE_VC8_STYLE, "Use VC8 Style", "Use VC8 Style", wxITEM_RADIO)
		styleMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(styleMenu, MENU_USE_FANCY_STYLE, "Use Fancy Style", "Use Fancy Style", wxITEM_RADIO)
		styleMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(styleMenu, MENU_USE_FF2_STYLE, "Use Firefox 2 Style", "Use Firefox 2 Style", wxITEM_RADIO)
		styleMenu.AppendItem(item)
	
		m_visualMenu.AppendMenu(-1, "Tabs Style", styleMenu)
		
		item = New wxMenuItem.Create(m_visualMenu, MENU_SELECT_GRADIENT_COLOR_FROM, "Select fancy tab style 'from' color", "Select fancy tab style 'from' color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SELECT_GRADIENT_COLOR_TO, "Select fancy tab style 'to' color", "Select fancy tab style 'to' color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SELECT_GRADIENT_COLOR_BORDER, "Select fancy tab style 'border' color", "Select fancy tab style 'border' color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		m_editMenu.AppendSeparator()
		item = New wxMenuItem.Create(m_editMenu, MENU_HIDE_NAV_BUTTONS, "Hide Navigation Buttons", "Hide Navigation Buttons", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check(True)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_HIDE_X, "Hide X Button", "Hide X Button", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_SMART_TABS, "Smart tabbing", "Smart tabbing", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check( False )
	
		item = New wxMenuItem.Create(m_editMenu, MENU_USE_DROP_ARROW_BUTTON, "Use drop down button for tab navigation", "Use drop down arrow for quick tab navigation", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check( True )
		m_editMenu.AppendSeparator()
	
		item = New wxMenuItem.Create(m_editMenu, MENU_USE_MOUSE_MIDDLE_BTN, "Use Mouse Middle Button as 'X' button", "Use Mouse Middle Button as 'X' button", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(m_editMenu, MENU_DCLICK_CLOSES_TAB, "Mouse double click closes tab", "Mouse double click closes tab", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check(False)
	
		m_editMenu.AppendSeparator()
	
		item = New wxMenuItem.Create(m_editMenu, MENU_USE_BOTTOM_TABS, "Use Bottoms Tabs", "Use Bottoms Tabs", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_ENABLE_TAB, "Enable Tab", "Enable Tab", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_DISABLE_TAB, "Disable Tab", "Disable Tab", wxITEM_NORMAL)
		m_editMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_ENABLE_DRAG_N_DROP, "Enable Drag And Drop of Tabs", "Enable Drag And Drop of Tabs", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check(False)
	
		item = New wxMenuItem.Create(m_editMenu, MENU_ALLOW_FOREIGN_DND, "Enable Drag And Drop of Tabs to foreign notebooks", "Enable Drag And Drop of Tabs to foreign notebooks", wxITEM_CHECK)
		m_editMenu.AppendItem(item)
		item.Check(False)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_DRAW_BORDER, "Draw Border around tab area", "Draw Border around tab area", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		item.Check(True)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_DRAW_TAB_X, "Draw X button On Active Tab", "Draw X button On Active Tab", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(m_visualMenu, MENU_SET_ACTIVE_TAB_COLOR, "Select Active Tab Color", "Select Active Tab Color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SET_TAB_AREA_COLOR, "Select Tab Area Color", "Select Tab Area Color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SET_ACTIVE_TEXT_COLOR, "Select active tab text color", "Select active tab text color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_SELECT_NONACTIVE_TEXT_COLOR, "Select NON-active tab text color", "Select NON-active tab text color", wxITEM_NORMAL)
		m_visualMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(m_visualMenu, MENU_GRADIENT_BACKGROUND, "Use Gradient Coloring for tab area", "Use Gradient Coloring for tab area", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		item.Check( False )
	
		item = New wxMenuItem.Create(m_visualMenu, MENU_COLORFULL_TABS, "Colorful tabs", "Colorful tabs", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		item.Check( False )
	
		m_menuBar.Append(m_fileMenu, "&File")
		m_menuBar.Append(m_editMenu, "&Edit")
		m_menuBar.Append(m_visualMenu, "&Tab Appearance")
	
		SetMenuBar(m_menuBar)

		' Create a Right click menu
		Local rmenu:wxMenu = New wxMenu.Create()
		item = New wxMenuItem.Create(rmenu, MENU_EDIT_DELETE_PAGE, "Close Tab~tCtrl+F4", "Close Tab", wxITEM_NORMAL)
		rmenu.AppendItem(item)
		
		Local mainSizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		SetSizer(mainSizer)

		Local bookStyle:Int = 0 
		If m_bVCStyle Then
		   bookStyle:| wxFNB_VC71
	    End If
		bookStyle :| wxFNB_TABS_BORDER_SIMPLE
		bookStyle :| wxFNB_NODRAG
		bookStyle :| wxFNB_CUSTOM_DLG
	
		book = New wxFlatNotebook.CreateFNB(Self, wxID_ANY, -1, -1, 300, 400, bookStyle)
		book.SetCustomizeOptions(wxFNB_CUSTOM_TAB_LOOK | wxFNB_CUSTOM_LOCAL_DRAG | wxFNB_CUSTOM_FOREIGN_DRAG )
	
		' Allow the second notebook to accept foreign pages
		' from other notebooks around
		bookStyle :& ~(wxFNB_NODRAG)
		bookStyle :| wxFNB_ALLOW_FOREIGN_DND
		secondBook = New wxFlatNotebook.CreateFNB(Self, wxID_ANY, -1, -1, 300, 400, bookStyle)
	
		' Set right click menu to the notebook
		book.SetRightClickMenu(rmenu)
	
		' Set the image list 
		'book.SetImageList(&m_ImageList)
	
		' Add spacer between the books
		Local spacer:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		spacer.SetBackgroundColour(wxSystemSettings.GetColour(wxSYS_COLOUR_3DFACE))
		mainSizer.Add(book, 6, wxEXPAND)
		mainSizer.Add(spacer, 0, wxALL | wxEXPAND)
		mainSizer.Add(secondBook, 2, wxEXPAND)

		' Add some pages to the second notebook
		Freeze()
		Local text:wxTextCtrl = New wxTextCtrl.Create(secondBook, wxID_ANY, "Second Book Page 1", -1, -1, -1, -1, wxTE_MULTILINE)
		Local ret:Int = secondBook.AddPage(text,  "Second Book Page 1")
	
		text = New wxTextCtrl.Create(secondBook, wxID_ANY, "Second Book Page 2", -1, -1, -1, -1, wxTE_MULTILINE)
		ret = secondBook.AddPage(text,  "Second Book Page 2")
	
		Thaw()	

		Centre() 
		mainSizer.Layout()
		SendSizeEvent()

		ConnectRange(MENU_HIDE_X, MENU_USE_BOTTOM_TABS, wxEVT_COMMAND_MENU_SELECTED, OnStyle)
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(MENU_EDIT_DELETE_ALL, wxEVT_COMMAND_MENU_SELECTED, OnDeleteAll)
		Connect(MENU_EDIT_ADD_PAGE, wxEVT_COMMAND_MENU_SELECTED, OnAddPage)
		Connect(MENU_EDIT_DELETE_PAGE, wxEVT_COMMAND_MENU_SELECTED, OnDeletePage)
		Connect(MENU_EDIT_SET_SELECTION, wxEVT_COMMAND_MENU_SELECTED, OnSetSelection)
		Connect(MENU_EDIT_ADVANCE_SELECTION_FWD, wxEVT_COMMAND_MENU_SELECTED, OnAdvanceSelectionFwd)
		Connect(MENU_EDIT_ADVANCE_SELECTION_BACK, wxEVT_COMMAND_MENU_SELECTED, OnAdvanceSelectionBack)
		Connect(MENU_SET_ALL_TABS_SHAPE_ANGLE, wxEVT_COMMAND_MENU_SELECTED, OnSetAllPagesShapeAngle)
		Connect(MENU_SHOW_IMAGES, wxEVT_COMMAND_MENU_SELECTED, OnShowImages)
		ConnectRange(MENU_SELECT_GRADIENT_COLOR_FROM, MENU_SELECT_GRADIENT_COLOR_BORDER, wxEVT_COMMAND_MENU_SELECTED, OnSelectColor)
		Connect(MENU_USE_VC71_STYLE, wxEVT_COMMAND_MENU_SELECTED, OnVC71Style)
		Connect(MENU_USE_VC8_STYLE, wxEVT_COMMAND_MENU_SELECTED, OnVC8Style)
		Connect(MENU_USE_DEFULT_STYLE, wxEVT_COMMAND_MENU_SELECTED, OnDefaultStyle)
		Connect(MENU_USE_FANCY_STYLE, wxEVT_COMMAND_MENU_SELECTED, OnFancyStyle)
		Connect(MENU_USE_FF2_STYLE, wxEVT_COMMAND_MENU_SELECTED, OnFF2Style)
		Connect(MENU_SET_PAGE_IMAGE_INDEX, wxEVT_COMMAND_MENU_SELECTED, OnSetPageImageIndex)
		Connect(MENU_ENABLE_TAB, wxEVT_COMMAND_MENU_SELECTED, OnEnableTab)
		Connect(MENU_DISABLE_TAB, wxEVT_COMMAND_MENU_SELECTED, OnDisableTab)
		Connect(MENU_ENABLE_DRAG_N_DROP, wxEVT_COMMAND_MENU_SELECTED, OnEnableDrag)
		Connect(MENU_SELECT_NONACTIVE_TEXT_COLOR, wxEVT_COMMAND_MENU_SELECTED, OnSelectColor)
		Connect(MENU_SET_ACTIVE_TAB_COLOR, wxEVT_COMMAND_MENU_SELECTED, OnSelectColor)
		Connect(MENU_SET_TAB_AREA_COLOR, wxEVT_COMMAND_MENU_SELECTED, OnSelectColor)
		Connect(MENU_SET_ACTIVE_TEXT_COLOR, wxEVT_COMMAND_MENU_SELECTED, OnSelectColor)
		Connect(MENU_DRAW_TAB_X, wxEVT_COMMAND_MENU_SELECTED, OnDrawTabX)
		Connect(MENU_DCLICK_CLOSES_TAB, wxEVT_COMMAND_MENU_SELECTED, OnDClickCloseTab)
		Connect(MENU_GRADIENT_BACKGROUND, wxEVT_COMMAND_MENU_SELECTED, OnGradientBack)
		Connect(MENU_COLORFULL_TABS, wxEVT_COMMAND_MENU_SELECTED, OnColorfullTabs)
		Connect(MENU_SMART_TABS, wxEVT_COMMAND_MENU_SELECTED, OnSmartTabs)
		Connect(MENU_USE_DROP_ARROW_BUTTON, wxEVT_COMMAND_MENU_SELECTED, OnDropDownArrow)
		Connect(MENU_ALLOW_FOREIGN_DND, wxEVT_COMMAND_MENU_SELECTED, OnAllowForeignDnd)

		Maximize(True)
	End Method

	Method DeleteNotebookPage(tabIdx:Int)
	End Method
	

	Method InsertNotebookPage:Int(tabIdx:Int)
	End Method


	Function OnInsertPage(event:wxEvent)
	End Function
	
	Function OnInsertBeforeGivenPage(event:wxEvent)
	End Function

	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function

	Function OnDeleteAll(event:wxEvent)
		Frame(event.parent).book.DeleteAllPages()
	End Function

	Function OnAddPage(event:wxEvent)
		Local frm:Frame = Frame(event.parent)
	
		Local caption:String = "New Page Added #" + frm.newPageCounter
		frm.Freeze()
		Local img:Int = -1
		If frm.m_bShowImages Then
			'img = Rand(0, frm.book.GetImageList().size()
			img = 0
		End If
		frm.book.AddPage(frm.CreatePage(), caption, True, img)
		frm.Thaw()	

	End Function

	Method CreatePage:wxWindow()
	
		Local caption:String = "New Page Added #" + newPageCounter
		newPageCounter:+ 1
	
		Local w:Int, h:Int
		book.GetPageBestSize(w, h)
		Return New wxTextCtrl.Create(book, wxID_ANY, caption, -1, -1, w, h, wxTE_MULTILINE)
	End Method

	Function OnDeletePage(event:wxEvent)
	End Function

	Function OnDeleteGivenPage(event:wxEvent)
	End Function

	Function OnSetSelection(event:wxEvent)
	End Function

	Function OnAdvanceSelectionFwd(event:wxEvent)
	End Function

	Function OnAdvanceSelectionBack(event:wxEvent)
	End Function

	Function OnShowImages(event:wxEvent)
	End Function

	Function OnVC71Style(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		
		' remove old tabs style
		Local mirror:Int = ~(wxFNB_VC71 | wxFNB_VC8 | wxFNB_FANCY_TABS | wxFNB_FF2)
		style :& mirror
		
		style :| wxFNB_VC71
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnFF2Style(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		
		' remove old tabs style
		Local mirror:Int = ~(wxFNB_VC71 | wxFNB_VC8 | wxFNB_FANCY_TABS)
		style :& mirror
		
		style :| wxFNB_FF2
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnVC8Style(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		
		' remove old tabs style
		Local mirror:Int = ~(wxFNB_VC71 | wxFNB_VC8 | wxFNB_FANCY_TABS | wxFNB_FF2)
		style :& mirror
		
		style :| wxFNB_VC8
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnDefaultStyle(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		
		' remove old tabs style
		Local mirror:Int = ~(wxFNB_VC71 | wxFNB_VC8 | wxFNB_FANCY_TABS | wxFNB_FF2)
		style :& mirror
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnFancyStyle(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		
		' remove old tabs style
		Local mirror:Int = ~(wxFNB_VC71 | wxFNB_VC8 | wxFNB_FANCY_TABS | wxFNB_FF2)
		style :& mirror
		
		style :| wxFNB_FANCY_TABS
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnSelectColor(event:wxEvent)
	End Function

	Function OnSetPageImageIndex(event:wxEvent)
	End Function

	Function OnStyle(event:wxEvent)
	End Function

	Function OnDrawTabX(event:wxEvent)
	End Function

	Function OnGradientBack(event:wxEvent)
	End Function

	Function OnColorfullTabs(event:wxEvent)
	End Function

	Function OnSmartTabs(event:wxEvent)
	End Function

	Function OnDropDownArrow(event:wxEvent)
	End Function

	Function OnDropDownArrowUI(event:wxEvent)
	End Function

	Function OnHideNavigationButtonsUI(event:wxEvent)
	End Function


	Function OnEnableTab(event:wxEvent)
	End Function

	Function OnDisableTab(event:wxEvent)
	End Function

	Function OnEnableDrag(event:wxEvent)
	End Function

	Function OnDClickCloseTab(event:wxEvent)
	End Function

	Function OnAllowForeignDnd( event:wxEvent )
	End Function

	Function OnAllowForeignDndUI( event:wxEvent )
	End Function


	' Notebook
	Function OnPageChanging(event:wxEvent)
	End Function

	Function OnPageChanged(event:wxEvent)
	End Function

	Function OnPageClosing(event:wxEvent)
	End Function

	Function OnSetAllPagesShapeAngle(event:wxEvent)
	End Function


End Type


Const MENU_EDIT_DELETE_ALL:Int = 10000
Const MENU_EDIT_ADD_PAGE:Int = 10001
Const MENU_EDIT_DELETE_PAGE:Int = 10002
Const MENU_EDIT_SET_SELECTION:Int = 10003
Const MENU_EDIT_ADVANCE_SELECTION_FWD:Int = 10004
Const MENU_EDIT_ADVANCE_SELECTION_BACK:Int = 10005
Const MENU_SET_ALL_TABS_SHAPE_ANGLE:Int = 10006
Const MENU_SHOW_IMAGES:Int = 10007
Const MENU_USE_VC71_STYLE:Int = 10008
Const MENU_USE_DEFULT_STYLE:Int = 10009
Const MENU_USE_FANCY_STYLE:Int = 10010
Const MENU_SELECT_GRADIENT_COLOR_FROM:Int = 10011
Const MENU_SELECT_GRADIENT_COLOR_TO:Int = 10012
Const MENU_SELECT_GRADIENT_COLOR_BORDER:Int = 10013
Const MENU_SET_PAGE_IMAGE_INDEX:Int = 10014
Const MENU_HIDE_X:Int = 10015
Const MENU_HIDE_NAV_BUTTONS:Int = 10016
Const MENU_USE_MOUSE_MIDDLE_BTN:Int = 10017
Const MENU_DRAW_BORDER:Int = 10018
Const MENU_USE_BOTTOM_TABS:Int = 10019
Const MENU_ENABLE_TAB:Int = 10020
Const MENU_DISABLE_TAB:Int = 10021
Const MENU_ENABLE_DRAG_N_DROP:Int = 10022
Const MENU_DCLICK_CLOSES_TAB:Int = 10023
Const MENU_USE_VC8_STYLE:Int = 10024
Const MENU_USE_FF2_STYLE:Int = 10025

Const MENU_SET_ACTIVE_TEXT_COLOR:Int = 10027
Const MENU_DRAW_TAB_X:Int = 10028
Const MENU_SET_ACTIVE_TAB_COLOR:Int = 10029
Const MENU_SET_TAB_AREA_COLOR:Int = 10030
Const MENU_SELECT_NONACTIVE_TEXT_COLOR:Int = 10031
Const MENU_GRADIENT_BACKGROUND:Int = 10032
Const MENU_COLORFULL_TABS:Int = 10033
Const MENU_SMART_TABS:Int = 10034
Const MENU_USE_DROP_ARROW_BUTTON:Int = 10035
Const MENU_ALLOW_FOREIGN_DND:Int = 10036
Const MENU_EDIT_INSERT_PAGE:Int = 10037
Const MENU_EDIT_INSERT_BEFORE_PAGE:Int = 10038
Const MENU_EDIT_SELECT_PAGE_TO_DELETE:Int = 10039

