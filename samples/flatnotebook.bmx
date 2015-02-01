'
' wxFlatNotebook sample
'
' From the C++ sample by Eran Ifrah and Priyank Bolia
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFlatNotebook
Import wx.wxFrame
Import wx.wxSystemSettings
Import wx.wxTextCtrl
Import wx.wxTextEntryDialog
Import wx.wxColourDialog
Import BRL.Random

Global mainFrame:Frame


New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()
	
		wxInitAllImageHandlers()

		mainFrame = Frame(New Frame.Create(Null, -1, "Frame"))

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

	Field m_ImageList:wxBitmap[]

	Method OnInit:Int()
		m_ImageList = New wxBitmap[3]
		m_ImageList[0] = wxBitmap.CreateFromFile("media/flatnotebook/book_red.png", wxBITMAP_TYPE_PNG)
		m_ImageList[1] = wxBitmap.CreateFromFile("media/flatnotebook/book_green.png", wxBITMAP_TYPE_PNG)

		m_ImageList[2] = wxBitmap.CreateFromFile("media/flatnotebook/book_blue.png", wxBITMAP_TYPE_PNG)


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
	
		m_visualMenu.AppendSubMenu(styleMenu, "Tabs Style")
		
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

		item = New wxMenuItem.Create(m_visualMenu, MENU_PREVIEW_SELECT_TAB, "Active Preview Select Tab", "Active Preview Select Tab", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(m_visualMenu, MENU_INVERT_COLOR_LINE_VC8, "Invert Color Line Around Tab VC8", "Invert Color Line Around Tab VC8", wxITEM_CHECK)
		m_visualMenu.AppendItem(item)
		
		item = New wxMenuItem.Create(m_visualMenu, MENU_BOTTOM_LINE_BORDER, "Set Panel Line Bottom Border as same Color as Tab", "Set Panel Line Bottom Border as same Color as Tab", wxITEM_CHECK)
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
		book.SetImageList(m_ImageList)
	
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
		Connect(MENU_PREVIEW_SELECT_TAB, wxEVT_COMMAND_MENU_SELECTED, OnPreviewSelectTab)
		Connect(MENU_INVERT_COLOR_LINE_VC8, wxEVT_COMMAND_MENU_SELECTED, OnInvertColorLineVC8)
		Connect(MENU_BOTTOM_LINE_BORDER, wxEVT_COMMAND_MENU_SELECTED, OnBottomLineBorder)
		Connect(MENU_DCLICK_CLOSES_TAB, wxEVT_COMMAND_MENU_SELECTED, OnDClickCloseTab)
		Connect(MENU_GRADIENT_BACKGROUND, wxEVT_COMMAND_MENU_SELECTED, OnGradientBack)
		Connect(MENU_COLORFULL_TABS, wxEVT_COMMAND_MENU_SELECTED, OnColorfullTabs)
		Connect(MENU_SMART_TABS, wxEVT_COMMAND_MENU_SELECTED, OnSmartTabs)
		Connect(MENU_USE_DROP_ARROW_BUTTON, wxEVT_COMMAND_MENU_SELECTED, OnDropDownArrow)
		Connect(MENU_ALLOW_FOREIGN_DND, wxEVT_COMMAND_MENU_SELECTED, OnAllowForeignDnd)

		Connect(MENU_USE_DROP_ARROW_BUTTON, wxEVT_UPDATE_UI, OnDropDownArrowUI)
		Connect(MENU_HIDE_NAV_BUTTONS, wxEVT_UPDATE_UI, OnHideNavigationButtonsUI)
		Connect(MENU_ALLOW_FOREIGN_DND, wxEVT_UPDATE_UI, OnAllowForeignDndUI)

		Connect(-1, wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGING, OnPageChanging)

		Connect(-1, wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CHANGED, OnPageChanged)

		Connect(-1, wxEVT_COMMAND_FLATNOTEBOOK_PAGE_CLOSING, OnPageClosing)

		

		Connect(MENU_EDIT_INSERT_PAGE, wxEVT_COMMAND_MENU_SELECTED, OnInsertPage)

		Connect(MENU_EDIT_INSERT_BEFORE_PAGE, wxEVT_COMMAND_MENU_SELECTED, OnInsertBeforeGivenPage)

		Connect(MENU_EDIT_SELECT_PAGE_TO_DELETE, wxEVT_COMMAND_MENU_SELECTED, OnDeleteGivenPage)


		Maximize(True)
	End Method

	Method DeleteNotebookPage(tabIdx:Int)
		book.DeletePage(tabIdx)
	End Method

	Method InsertNotebookPage:Int(tabIdx:Int)
		Local caption:String = "New Page Inserted #" + newPageCounter

		Local img:Int = -1
		If m_bShowImages Then
			img = Rand(0, book.GetImageList().length - 1)
		End If
		Return book.InsertPage(tabIdx, CreatePage(),  caption, True, img)

	End Method


	Function OnInsertPage(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local index:Int = frm.book.GetSelection()
		frm.Freeze()
		frm.InsertNotebookPage(index)
		frm.Thaw()
	End Function
	
	Function OnInsertBeforeGivenPage(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local tabIdx:Int = frm.GetTabIndexFromUser("Insert Page", "Enter Tab Number to insert the page before:")
		If tabIdx <> -1 Then
			frm.Freeze()
			frm.InsertNotebookPage(tabIdx)
			frm.Thaw()
		End If
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
			img = Rand(0, frm.book.GetImageList().length - 1)
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
		Local frm:Frame = Frame(event.parent)

		frm.DeleteNotebookPage(frm.book.GetSelection())

	End Function

	Function OnDeleteGivenPage(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local tabIdx:Int = frm.GetTabIndexFromUser("Delete Page", "Enter Tab Number to delete:")
		If tabIdx <> -1 Then
			frm.DeleteNotebookPage(tabIdx)
		End If
	End Function

	Function OnSetSelection(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local tabIdx:Int = frm.GetTabIndexFromUser("Enable Tab", "Enter Tab Number to enable:")
		If tabIdx <> -1 Then
			frm.book.SetSelection(tabIdx)
		End If
	End Function

	Function OnAdvanceSelectionFwd(event:wxEvent)
		Frame(event.parent).book.AdvanceSelection(True)
	End Function

	Function OnAdvanceSelectionBack(event:wxEvent)
		Frame(event.parent).book.AdvanceSelection(False)
	End Function

	Function OnShowImages(event:wxEvent)
		Frame(event.parent).m_bShowImages = wxCommandEvent(event).IsChecked()

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
		Local frm:Frame = Frame(event.parent)

		' Open a color dialog
		Local dlg:wxColourDialog = New wxColourDialog.Create(frm)
		If dlg.ShowModal() = wxID_OK Then
			Select event.GetId()
	            Case MENU_SELECT_GRADIENT_COLOR_BORDER
	                frm.book.SetGradientColorBorder(dlg.GetColourData().GetColour())
	
	            Case MENU_SELECT_GRADIENT_COLOR_FROM
	                frm.book.SetGradientColorFrom(dlg.GetColourData().GetColour())
	
	            Case MENU_SELECT_GRADIENT_COLOR_TO
	                frm.book.SetGradientColorTo(dlg.GetColourData().GetColour())
	
	            Case MENU_SET_ACTIVE_TEXT_COLOR
	                frm.book.SetActiveTabTextColour(dlg.GetColourData().GetColour())
	
	            Case MENU_SELECT_NONACTIVE_TEXT_COLOR
	                frm.book.SetNonActiveTabTextColour(dlg.GetColourData().GetColour())
	
	            Case MENU_SET_ACTIVE_TAB_COLOR
	                frm.book.SetActiveTabColour(dlg.GetColourData().GetColour())
	
	            Case MENU_SET_TAB_AREA_COLOR
	                frm.book.SetTabAreaColour(dlg.GetColourData().GetColour())
	
	        End Select
			frm.book.Refresh()
		End If
		dlg.Free()
	End Function

	Function OnSetPageImageIndex(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local size:Int = frm.book.GetImageList().length - 1
		Local dlg: wxTextEntryDialog = New wxTextEntryDialog.Create(frm, "Enter an image index (0-" + size + "):", "Set Angle")

		If dlg.ShowModal() = wxID_OK Then

			Local val:String = dlg.GetValue()

			frm.book.SetPageImageIndex(frm.book.GetSelection(), Max(0, Min(size, val.ToInt())))

		End If
		dlg.Free()

	End Function

	Function OnStyle(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

        Local style:Int = frm.book.GetWindowStyleFlag()
        Select event.GetId()
            Case MENU_HIDE_NAV_BUTTONS
                If event.IsChecked() Then
                    ' Hide the navigation buttons
                    style :| wxFNB_NO_NAV_BUTTONS
                Else
                    style :& ~(wxFNB_NO_NAV_BUTTONS)
                    style :& ~(wxFNB_DROPDOWN_TABS_LIST)
                End If
                frm.book.SetWindowStyleFlag(style)
    
            Case MENU_HIDE_X
                If event.IsChecked() Then
                    ' Hide the X button
                    style :| wxFNB_NO_X_BUTTON
                Else
                    If style & wxFNB_NO_X_BUTTON Then
                        style :~ wxFNB_NO_X_BUTTON
                    End If
                End If
                frm.book.SetWindowStyleFlag(style)
    
            Case MENU_DRAW_BORDER
                If event.IsChecked() Then
                    style :| wxFNB_TABS_BORDER_SIMPLE
                Else
                    If style & wxFNB_TABS_BORDER_SIMPLE Then
                        style :~ wxFNB_TABS_BORDER_SIMPLE
                    End If
                End If
                frm.book.SetWindowStyleFlag(style)
    
            Case MENU_USE_MOUSE_MIDDLE_BTN
                If event.IsChecked() Then
                    style :| wxFNB_MOUSE_MIDDLE_CLOSES_TABS
                Else
                    If style & wxFNB_MOUSE_MIDDLE_CLOSES_TABS Then
                        style :~ wxFNB_MOUSE_MIDDLE_CLOSES_TABS
                    End If
                End If
                frm.book.SetWindowStyleFlag(style)
    
            Case MENU_USE_BOTTOM_TABS
                If event.IsChecked() Then
                    style :| wxFNB_BOTTOM
                Else
                    If style & wxFNB_BOTTOM Then
                        style :~ wxFNB_BOTTOM
                    End If
                End If
                frm.book.SetWindowStyleFlag(style)
                frm.book.Refresh()
        End Select
	End Function

	Function OnDrawTabX(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_X_ON_TAB
		Else
			If style & wxFNB_X_ON_TAB Then
				style :~ wxFNB_X_ON_TAB
			End If		
		End If
	
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnGradientBack(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_BACKGROUND_GRADIENT
		Else
			style :& ~(wxFNB_BACKGROUND_GRADIENT)
		End If
		frm.book.SetWindowStyleFlag( style )
		frm.book.Refresh()
	End Function

	Function OnColorfullTabs(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_COLORFUL_TABS
		Else
			style :& ~(wxFNB_COLORFUL_TABS)
		End If
		frm.book.SetWindowStyleFlag( style )
		frm.book.Refresh()
	End Function

	Function OnSmartTabs(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_SMART_TABS
		Else
			style :& ~(wxFNB_SMART_TABS)
		End If
		frm.book.SetWindowStyleFlag( style )
		frm.book.Refresh()
	End Function

	Function OnDropDownArrow(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_DROPDOWN_TABS_LIST
			style :| wxFNB_NO_NAV_BUTTONS
		Else
			style :& ~(wxFNB_DROPDOWN_TABS_LIST)
			style :& ~(wxFNB_NO_NAV_BUTTONS)
		End If
	
		frm.book.SetWindowStyleFlag( style )
		frm.book.Refresh()
	End Function

	Function OnDropDownArrowUI(event:wxEvent)
		Local style:Int = Frame(event.parent).book.GetWindowStyleFlag()
		If style & wxFNB_DROPDOWN_TABS_LIST Then
			wxUpdateUIEvent(event).Check( True )
		Else
			wxUpdateUIEvent(event).Check( True )
		End If

	End Function

	Function OnHideNavigationButtonsUI(event:wxEvent)
		Local style:Int = Frame(event.parent).book.GetWindowStyleFlag()
		If style & wxFNB_NO_NAV_BUTTONS Then
			wxUpdateUIEvent(event).Check(True)
		Else
			wxUpdateUIEvent(event).Check(False)
		End If

	End Function


	Function OnEnableTab(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local tabIdx:Int = frm.GetTabIndexFromUser("Set Selection", "Enter Tab Number to select:")
		If tabIdx <> -1 Then
			frm.book.EnablePage(tabIdx, True)
		End If
	End Function

	Function OnDisableTab(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local tabIdx:Int = frm.GetTabIndexFromUser("Disable Tab", "Enter Tab Number To disable:")
		If tabIdx <> -1 Then
			frm.book.EnablePage(tabIdx, False)
		End If
	End Function

	Function OnEnableDrag(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			If style & wxFNB_NODRAG Then
				style :~ wxFNB_NODRAG
			End If
		Else
			style :| wxFNB_NODRAG
		End If
	
		frm.book.SetWindowStyleFlag(style)
	End Function

	
	Function OnPreviewSelectTab(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_PREVIEW_SELECT_TAB
		Else
			If style & wxFNB_PREVIEW_SELECT_TAB Then
				style :~ wxFNB_PREVIEW_SELECT_TAB
			End If
		End If
		
			frm.book.SetWindowStyleFlag(style)
	End Function
		
	Function OnInvertColorLineVC8(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_INVERSE_COLOR_LINE_VC8
		Else
			If style & wxFNB_INVERSE_COLOR_LINE_VC8 Then
				style :~ wxFNB_INVERSE_COLOR_LINE_VC8
			End If
		End If
		
		frm.book.SetWindowStyleFlag(style)
	End Function
 	 
	Function OnBottomLineBorder(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()
		If event.IsChecked() Then
			style :| wxFNB_BOTTOM_LINE_COLOR_CHANGE
		Else
			If style & wxFNB_BOTTOM_LINE_COLOR_CHANGE Then
				style :~ wxFNB_BOTTOM_LINE_COLOR_CHANGE
			End If
		End If
		
		frm.book.SetWindowStyleFlag(style)
	End Function

	Function OnDClickCloseTab(evt:wxEvent)
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()

		If event.IsChecked() Then

			style :| wxFNB_DCLICK_CLOSES_TABS

		Else

			style :& ~(wxFNB_DCLICK_CLOSES_TABS)

		End If

	

		frm.book.SetWindowStyleFlag(style)

	End Function

	Function OnAllowForeignDnd( evt:wxEvent )
		Local event:wxCommandEvent = wxCommandEvent(evt)
		Local frm:Frame = Frame(event.parent)

		Local style:Int = frm.book.GetWindowStyleFlag()

		If event.IsChecked() Then

			style :| wxFNB_ALLOW_FOREIGN_DND

		Else

			style :& ~(wxFNB_ALLOW_FOREIGN_DND)
		End If

		frm.book.SetWindowStyleFlag( style )

		frm.book.Refresh()

	End Function

	Function OnAllowForeignDndUI( event:wxEvent )
		Local style:Int = Frame(event.parent).book.GetWindowStyleFlag()
		If style & wxFNB_NODRAG Then

			wxUpdateUIEvent(event).Enable(False)
		Else
			wxUpdateUIEvent(event).Enable(True)
		End If

	End Function


	' Notebook
	Function OnPageChanging(event:wxEvent)
	End Function

	Function OnPageChanged(event:wxEvent)
		DebugLog("Page has changed, new selection is now = " + wxFlatNotebookEvent(event).GetSelection())
	End Function

	Function OnPageClosing(event:wxEvent)
		DebugLog("Page is closing: selection = " + wxFlatNotebookEvent(event).GetSelection())
	End Function

	Function OnSetAllPagesShapeAngle(event:wxEvent)
		Local frm:Frame = Frame(event.parent)

		Local dlg:wxTextEntryDialog = New wxTextEntryDialog.Create(frm, "Enter an inclination of header borders (0-15):", "Set Angle")

		If dlg.ShowModal() = wxID_OK Then

			Local val:String = dlg.GetValue()

			frm.book.SetAllPagesShapeAngle(Max(0, Min(15, val.ToInt())))

		End If
		dlg.Free()

	End Function

	Method GetTabIndexFromUser:Int(title:String, prompt:String)

		Local dlg:wxTextEntryDialog = New wxTextEntryDialog.Create(Self, prompt, title)

		If dlg.ShowModal() = wxID_OK Then

			Local val:String = dlg.GetValue()
			dlg.Free()

			Return val.ToInt()

		End If
		dlg.Free()

		Return -1

	End Method


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
Const MENU_PREVIEW_SELECT_TAB:Int = 10040
Const MENU_INVERT_COLOR_LINE_VC8:Int = 10041
Const MENU_BOTTOM_LINE_BORDER:Int = 10042
