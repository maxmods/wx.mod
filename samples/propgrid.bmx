SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPropGrid
Import wx.wxTextCtrl
Import wx.wxRadioBox
Import wx.wxSystemSettings

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxPropertyGrid sample", -1, -1, 300, 500))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame
	
	Const PGID:Int = 1
	Const TCID:Int = 2
	Const ID_ABOUT:Int = wxID_ABOUT
	Const ID_QUIT:Int = wxID_EXIT
	Const ID_APPENDPROP:Int = 5
	Const ID_APPENDCAT:Int = 6
	Const ID_INSERTPROP:Int = 7
	Const ID_INSERTCAT:Int = 8
	Const ID_ENABLE:Int = 9
	Const ID_HIDE:Int = 10
	Const ID_DELETE:Int = 11
	Const ID_DELETER:Int = 12
	Const ID_DELETEALL:Int = 13
	Const ID_UNSPECIFY:Int = 14
	Const ID_ITERATE1:Int = 15
	Const ID_ITERATE2:Int = 16
	Const ID_ITERATE3:Int = 17
	Const ID_ITERATE4:Int = 18
	Const ID_CLEARMODIF:Int = 19
	Const ID_FREEZE:Int = 20
	Const ID_DUMPLIST:Int = 21
	Const ID_COLOURSCHEME1:Int = 22
	Const ID_COLOURSCHEME2:Int = 23
	Const ID_COLOURSCHEME3:Int = 24
	Const ID_COLOURSCHEME4:Int = 52
	Const ID_CATCOLOURS:Int = 25
	Const ID_SETCOLOUR:Int = 26
	Const ID_STATICLAYOUT:Int = 27
	Const ID_CLEAR:Int = 28
	Const ID_POPULATE1:Int = 29
	Const ID_POPULATE2:Int = 30
	Const ID_COLLAPSE:Int = 31
	Const ID_COLLAPSEALL:Int = 32
	Const ID_GETVALUES:Int = 33
	Const ID_SETVALUES:Int = 34
	Const ID_SETVALUES2:Int = 35
	Const ID_RUNTEST:Int = 36
	Const ID_SAVETOFILE:Int = 37
	Const ID_SAVETOFILE2:Int = 38
	Const ID_LOADFROMFILE:Int = 39
	Const ID_CHANGEFLAGSITEMS:Int = 40
	Const ID_TESTINSERTCHOICE:Int = 41
	Const ID_TESTDELETECHOICE:Int = 42
	Const ID_INSERTPAGE:Int = 43
	Const ID_REMOVEPAGE:Int = 44
	Const ID_SETSPINCTRLEDITOR:Int = 45
	Const ID_SETPROPERTYVALUE:Int = 46
	Const ID_TESTREPLACE:Int = 47
	Const ID_SETCOLUMNS:Int = 48
	Const ID_TESTXRC:Int = 49
	Const ID_ENABLECOMMONVALUES:Int = 50
	Const ID_SELECTSTYLE:Int = 51

	Field m_itemCatColours:wxMenuItem
	Field m_itemFreeze:wxMenuItem
	Field m_itemEnable:wxMenuItem

    Field m_propGrid:wxPropertyGrid

    Field m_tcPropLabel:wxTextCtrl
    Field m_panel:wxWindow

	Field m_radiobox:wxRadioBox

	Method OnInit()
	
		wxInitAllImageHandlers()
	
		CreateGrid( wxPG_BOLD_MODIFIED | wxPG_SPLITTER_AUTO_CENTER | ..
                wxPG_AUTO_SORT ..
                | wxTAB_TRAVERSAL ..
                | wxPG_TOOLBAR ..
                | wxPG_DESCRIPTION, ..
                wxPG_EX_MODE_BUTTONS)
                'wxPG_HIDE_MARGIN|wxPG_STATIC_SPLITTER |
                'wxPG_TOOLTIPS |
                'wxPG_HIDE_CATEGORIES |
                'wxPG_LIMITED_EDITING |
                ' extra style
                '| wxPG_EX_AUTO_UNSPECIFIED_VALUES
                '| wxPG_EX_GREY_LABEL_WHEN_DISABLED
                '| wxPG_EX_NATIVE_DOUBLE_BUFFERING
                '| wxPG_EX_HELP_AS_TOOLTIPS
	
	
		' Create menubar

		Local menuFile:wxMenu = New wxMenu.Create("", wxMENU_TEAROFF)
		Local menuTry:wxMenu = New wxMenu.Create()
		Local menuTools1:wxMenu = New wxMenu.Create()
		Local menuTools2:wxMenu = New wxMenu.Create()
		Local menuHelp:wxMenu = New wxMenu.Create()


    menuHelp.Append(ID_ABOUT, "&About...", "Show about dialog")

    menuTools1.Append(ID_APPENDPROP, "Append New Property")
    menuTools1.Append(ID_APPENDCAT, "Append New Category~tCtrl-S")
    menuTools1.AppendSeparator()
    menuTools1.Append(ID_INSERTPROP, "Insert New Property~tCtrl-Q")
    menuTools1.Append(ID_INSERTCAT, "Insert New Category~tCtrl-W")
    menuTools1.AppendSeparator()
    menuTools1.Append(ID_DELETE, "Delete Selected")
    menuTools1.Append(ID_DELETER, "Delete Random")
    menuTools1.Append(ID_DELETEALL, "Delete All")
    menuTools1.AppendSeparator()
    menuTools1.Append(ID_SETCOLOUR, "Set Bg Colour")
    menuTools1.Append(ID_UNSPECIFY, "Set to Unspecified")
    menuTools1.Append(ID_CLEAR, "Set Value to Default")
    menuTools1.AppendSeparator()
    m_itemEnable = menuTools1.Append(ID_ENABLE, "Enable", "Toggles item's enabled state.")
    m_itemEnable.Enable( False )
    menuTools1.Append(ID_HIDE, "Hide", "Shows or hides a property")

    menuTools2.Append(ID_ITERATE1, "Iterate Over Properties") 
    menuTools2.Append(ID_ITERATE2, "Iterate Over Visible Items")
    menuTools2.Append(ID_ITERATE3, "Reverse Iterate Over Properties")
    menuTools2.Append(ID_ITERATE4, "Iterate Over Categories")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_SETPROPERTYVALUE, "Set Property Value")
    menuTools2.Append(ID_CLEARMODIF, "Clear Modified Status", "Clears wxPG_MODIFIED flag from all properties.")
    menuTools2.AppendSeparator()
    m_itemFreeze = menuTools2.AppendCheckItem(ID_FREEZE, "Freeze", "Disables painting, auto-sorting, etc.")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_DUMPLIST, "Display Values as wxVariant List", "Tests GetAllValues method and wxVariant conversion.")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_GETVALUES, "Get Property Values", "Stores all property values.")
    menuTools2.Append(ID_SETVALUES, "Set Property Values", "Reverts property values to those last stored.")
    menuTools2.Append(ID_SETVALUES2, "Set Property Values 2", "Adds property values that should not initially be as items (so new items are created).")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_COLLAPSE, "Collapse Selected")
    menuTools2.Append(ID_COLLAPSEALL, "Collapse All")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_INSERTPAGE, "Add Page")
    menuTools2.Append(ID_REMOVEPAGE, "Remove Page")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_CHANGEFLAGSITEMS, "Change Children of FlagsProp")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_TESTINSERTCHOICE, "Test InsertPropertyChoice")
    menuTools2.Append(ID_TESTDELETECHOICE, "Test DeletePropertyChoice")
    menuTools2.AppendSeparator()
    menuTools2.Append(ID_SETSPINCTRLEDITOR, "Use SpinCtrl Editor")
    menuTools2.Append(ID_TESTREPLACE, "Test ReplaceProperty")

    menuTry.Append(ID_SELECTSTYLE, "Set Window Style", "Select window style flags used by the grid.")
    menuTry.AppendSeparator()

    menuTry.AppendRadioItem( ID_COLOURSCHEME1, "Standard Colour Scheme")
    menuTry.AppendRadioItem( ID_COLOURSCHEME2, "White Colour Scheme")
    menuTry.AppendRadioItem( ID_COLOURSCHEME3, ".NET Colour Scheme")
    menuTry.AppendRadioItem( ID_COLOURSCHEME4, "Cream Colour Scheme")
    menuTry.AppendSeparator()
    m_itemCatColours = menuTry.AppendCheckItem(ID_CATCOLOURS, "Category Specific Colours", ..
        "Switches between category-specific cell colours and default scheme (actually done using SetPropertyTextColour and SetPropertyBackgroundColour).")
    menuTry.AppendSeparator()
    menuTry.AppendCheckItem(ID_STATICLAYOUT, "Static Layout", "Switches between user-modifiedable and static layouts.")
    menuTry.Append(ID_SETCOLUMNS, "Set Number of Columns")
    menuTry.Append(ID_ENABLECOMMONVALUES, "Use Common Values", "Enable values that are common to all properties.")
    menuTry.AppendSeparator()
    menuTry.Append(ID_TESTXRC, "Display XRC sample")
    menuTry.AppendSeparator()
    menuTry.Append(ID_RUNTEST, "Run Tests")

    menuFile.Append(ID_SAVETOFILE, "&Save Page (use class names)...", ..
        "Saves current property page to a text file, using property class names.")
    menuFile.Append(ID_SAVETOFILE2, "&Save Page (use value names)...", ..
        "Saves current property page to a text file, using property value type names.")
    menuFile.Append(ID_LOADFROMFILE, "&Load Page...", "Loads current property page from a text file")
    menuFile.AppendSeparator()
    menuFile.Append(ID_QUIT, "E&xit~tAlt-X", "Quit this program")

		' Now append the freshly created menu To the menu bar...

		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(menuTry, "&Try These!")
		menuBar.Append(menuTools1, "&Basic")
		menuBar.Append(menuTools2, "&Advanced")
		menuBar.Append(menuHelp, "&Help")

		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)

		' Create a status bar
		CreateStatusBar(1)
		SetStatusText("")
		
		'Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		'Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
	End Method
	
	Method CreateGrid( style:Int, extraStyle:Int )

	    Local wasCreated:Int = False
	
	    If m_panel Then
	        wasCreated = True
	        m_panel.Destroy()
	    End If
	
	    Local panel:wxWindow = New wxPanel.Create(Self, -1, 0, 0, 400, 400)
	    m_panel = panel
	
		' Column
		Local topSizer:wxBoxSizer = New wxBoxSizer.Create( wxVERTICAL )

		Local rb_items:String[] = ["Categorized", "Alphabetic"]
		m_radiobox = New wxRadioBox.Create( panel, TCID, " Mode ", -1, -1, -1, -1, rb_items, 2, wxRA_SPECIFY_COLS )

		Connect(m_radiobox.GetId(), wxEVT_COMMAND_RADIOBOX_SELECTED, OnRadioBoxChange )

		topSizer.Add( m_radiobox, 0, wxEXPAND )


		Local pg:wxPropertyGrid = New wxPropertyGrid.Create(panel, PGID, -1, -1, -1, -1, style )
		m_propGrid = pg
		
		pg.SetExtraStyle(extraStyle)

		PopulateWithStandardItems()
		
		topSizer.Add( m_propGrid, 1, wxEXPAND )

		panel.SetSizer( topSizer )
		topSizer.SetSizeHints( panel )

		Local panelSizer:wxBoxSizer = New wxBoxSizer.Create( wxHORIZONTAL )
		panelSizer.Add( panel, 1, wxEXPAND|wxFIXED_MINSIZE )
		SetSizer( panelSizer )
		panelSizer.SetSizeHints( Self )
		
		If wasCreated Then
			SetSize( ..
				(wxSystemSettings.GetMetric(wxSYS_SCREEN_X)/10)*4, ..
				(wxSystemSettings.GetMetric(wxSYS_SCREEN_Y)/10)*8)
			Centre()
		End If

	End Method
	
	Method PopulateWithStandardItems()
	
		Local pg:wxPropertyGrid = m_propGrid
		
		Local pid:wxPGId
		
		' Append is ideal way To add items To wxPropertyGrid.
		pg.Append( New wxPropertyCategory.Create("Appearance", wxPG_LABEL) )

		pg.Append( New wxStringProperty.Create("Label", wxPG_LABEL, GetTitle()) )
		
		pg.Append( New wxFontProperty.Create("Font", wxPG_LABEL) )
		pg.SetPropertyHelpString("Font", "Editing this will change font used in the property grid.")

		pg.Append( New wxSystemColourProperty.Create("Margin Colour", wxPG_LABEL, pg.GetGrid().GetMarginColour()) )

		

		pg.Append( New wxSystemColourProperty.Create("Cell Colour", wxPG_LABEL, pg.GetGrid().GetCellBackgroundColour()) )

		pg.Append( New wxSystemColourProperty.Create("Cell Text Colour", wxPG_LABEL, pg.GetGrid().GetCellTextColour()) )

		pg.Append( New wxSystemColourProperty.Create("Line Colour", wxPG_LABEL, pg.GetGrid().GetLineColour()) )

'		pg.Append( New wxFlagsProperty.Create("Window Styles", wxPG_LABEL, m_combinedFlags, GetWindowStyle()) )


	End Method
	
	Method PopulateWithExamples()
	End Method
	
	Method PopulateWithLibraryConfig()
	End Method
	
	
	Function OnCloseClick( event:wxEvent )
	End Function
	
	Function OnLabelTextChange( event:wxEvent )
	End Function
	
	
	Function OnColourScheme( event:wxEvent )
	End Function
	
	
	Function OnInsertPropClick( event:wxEvent )
	End Function
	
	Function OnAppendPropClick( event:wxEvent )
	End Function
	
	Function OnClearClick( event:wxEvent )
	End Function
	
	Function OnAppendCatClick( event:wxEvent )
	End Function
	
	Function OnInsertCatClick( event:wxEvent )
	End Function
	
	Function OnDelPropClick( event:wxEvent )
	End Function
	
	Function OnDelPropRClick( event:wxEvent )
	End Function
	
	
	Function OnContextMenu( event:wxEvent )
	End Function
	
	
	Function OnEnableDisable( event:wxEvent )
	End Function
	
	Function OnHideShow( event:wxEvent )
	End Function
	
	Function OnClearModifyStatusClick( event:wxEvent )
	End Function
	
	Function OnFreezeClick( event:wxEvent )
	End Function
	
	Function OnDumpList( event:wxEvent )
	End Function
	
	Function OnCatColours( event:wxEvent )
	End Function
	
	Function OnSetColumns( event:wxEvent )
	End Function
	
	Function OnMisc( event:wxEvent )
	End Function
	
	Function OnPopulateClick( event:wxEvent )
	End Function
	
	Function OnSetSpinCtrlEditorClick( event:wxEvent )
	End Function
	
	Function OnTestReplaceClick( event:wxEvent )
	End Function
	
	Function OnTestXRC( event:wxEvent )
	End Function
	
	Function OnEnableCommonValues( event:wxEvent )
	End Function
	
	Function OnSelectStyle( event:wxEvent )
	End Function
	
	
	Function OnChangeFlagsPropItemsClick( event:wxEvent )
	End Function
	
	
	Function OnSaveToFileClick( event:wxEvent )
	End Function
	
	Function OnLoadFromFileClick( event:wxEvent )
	End Function
	
	
	Function OnSetPropertyValue( event:wxEvent )
	End Function
	
	Function OnInsertChoice( event:wxEvent )
	End Function
	
	Function OnDeleteChoice( event:wxEvent )
	End Function
	
	Function OnInsertPage( event:wxEvent )
	End Function
	
	Function OnRemovePage( event:wxEvent )
	End Function
	
	
	Function OnRadioBoxChange( event:wxEvent )
	End Function
	
	
	Function OnIterate1Click( event:wxEvent )
	End Function
	
	Function OnIterate2Click( event:wxEvent )
	End Function
	
	Function OnIterate3Click( event:wxEvent )
	End Function
	
	Function OnIterate4Click( event:wxEvent )
	End Function
	
	Function OnPropertyGridChange( event:wxEvent )
	End Function
	
	Function OnPropertyGridChanging( event:wxEvent )
	End Function
	
	Function OnPropertyGridSelect( event:wxEvent )
	End Function
	
	Function OnPropertyGridHighlight( event:wxEvent )
	End Function
	
	Function OnPropertyGridItemRightClick( event:wxEvent )
	End Function
	
	Function OnPropertyGridItemDoubleClick( event:wxEvent )
	End Function
	
	Function OnPropertyGridPageChange( event:wxEvent )
	End Function
	
	Function OnPropertyGridButtonClick( event:wxEvent )
	End Function
	
	Function OnPropertyGridTextUpdate( event:wxEvent )
	End Function
	
	Function OnPropertyGridKeyEvent( event:wxEvent )
	End Function
	
	Function OnPropertyGridItemCollapse( event:wxEvent )
	End Function
	
	Function OnPropertyGridItemExpand( event:wxEvent )
	End Function
	
	Function OnAbout( event:wxEvent )
	End Function
	
	Function OnMove( event:wxEvent )
	End Function
	
	Function OnResize( event:wxEvent )
	End Function
	
	Function OnPaint( event:wxEvent )
	End Function
	
	Function OnCloseEvent( event:wxEvent )
	End Function
	
	Function OnIdle( event:wxEvent )
	End Function
	
	Method RunTests()
	End Method
	

	
End Type

