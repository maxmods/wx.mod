SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPropGrid
Import wx.wxTextCtrl
Import wx.wxRadioBox
Import wx.wxSystemSettings
Import wx.wxArtProvider
Import wx.wxDatePickerCtrl
Import wx.wxButton

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
                | wxPG_SPLITTER_AUTO_CENTER ..
                | wxPG_DEFAULT_STYLE, ..
				wxPG_EX_HELP_AS_TOOLTIPS | wxPG_EX_NATIVE_DOUBLE_BUFFERING)
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
		
	'
    ' Finalize
    '

    SetSize((wxSystemSettings.GetMetric(wxSYS_SCREEN_X)/10)*4, ..
        (wxSystemSettings.GetMetric(wxSYS_SCREEN_Y)/10)*8)
    Centre()
	
		'Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		'Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
		
		' This occurs when a property is selected
		Connect( PGID, wxEVT_PG_SELECTED, OnPropertyGridSelect )
		' This occurs when a property value changes
		Connect( PGID, wxEVT_PG_CHANGED, OnPropertyGridChange )
		' This occurs just prior a property value is changed
		Connect( PGID, wxEVT_PG_CHANGING, OnPropertyGridChanging )
		' This occurs when a mouse moves over another property
		Connect( PGID, wxEVT_PG_HIGHLIGHTED, OnPropertyGridHighlight )
		' This occurs when mouse is right-clicked.
		Connect( PGID, wxEVT_PG_RIGHT_CLICK, OnPropertyGridItemRightClick )
		' This occurs when mouse is double-clicked.
		Connect( PGID, wxEVT_PG_DOUBLE_CLICK, OnPropertyGridItemDoubleClick )
		' This occurs when propgridmanager's page changes.
		Connect( PGID, wxEVT_PG_PAGE_CHANGED, OnPropertyGridPageChange )
		' This occurs when property's editor button (if any) is clicked.
		Connect( PGID, wxEVT_COMMAND_BUTTON_CLICKED, OnPropertyGridButtonClick )


		Connect( ID_APPENDPROP, wxEVT_COMMAND_MENU_SELECTED, OnAppendPropClick )
		Connect( ID_APPENDCAT, wxEVT_COMMAND_MENU_SELECTED, OnAppendCatClick )
		Connect( ID_INSERTPROP, wxEVT_COMMAND_MENU_SELECTED, OnInsertPropClick )
		Connect( ID_INSERTCAT, wxEVT_COMMAND_MENU_SELECTED, OnInsertCatClick )
		Connect( ID_DELETE, wxEVT_COMMAND_MENU_SELECTED, OnDelPropClick )
		Connect( ID_DELETER, wxEVT_COMMAND_MENU_SELECTED, OnDelPropRClick )
		Connect( ID_UNSPECIFY, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_DELETEALL, wxEVT_COMMAND_MENU_SELECTED, OnClearClick )
		Connect( ID_ENABLE, wxEVT_COMMAND_MENU_SELECTED, OnEnableDisable )
		Connect( ID_HIDE, wxEVT_COMMAND_MENU_SELECTED, OnHideShow )
		Connect( ID_ITERATE1, wxEVT_COMMAND_MENU_SELECTED, OnIterate1Click )
		Connect( ID_ITERATE2, wxEVT_COMMAND_MENU_SELECTED, OnIterate2Click )
		Connect( ID_ITERATE3, wxEVT_COMMAND_MENU_SELECTED, OnIterate3Click )
		Connect( ID_ITERATE4, wxEVT_COMMAND_MENU_SELECTED, OnIterate4Click )
		Connect( ID_SETCOLOUR, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_CLEARMODIF, wxEVT_COMMAND_MENU_SELECTED, OnClearModifyStatusClick )
		Connect( ID_FREEZE, wxEVT_COMMAND_MENU_SELECTED, OnFreezeClick )
		Connect( ID_DUMPLIST, wxEVT_COMMAND_MENU_SELECTED, OnDumpList )
	
		Connect( ID_COLOURSCHEME1, wxEVT_COMMAND_MENU_SELECTED, OnColourScheme )
		Connect( ID_COLOURSCHEME2, wxEVT_COMMAND_MENU_SELECTED, OnColourScheme )
		Connect( ID_COLOURSCHEME3, wxEVT_COMMAND_MENU_SELECTED, OnColourScheme )
		Connect( ID_COLOURSCHEME4, wxEVT_COMMAND_MENU_SELECTED, OnColourScheme )
	
		Connect( ID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout )
		Connect( ID_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnCloseClick )
	
		Connect( ID_CATCOLOURS, wxEVT_COMMAND_MENU_SELECTED, OnCatColours )
		Connect( ID_SETCOLUMNS, wxEVT_COMMAND_MENU_SELECTED, OnSetColumns )
		Connect( ID_TESTXRC, wxEVT_COMMAND_MENU_SELECTED, OnTestXRC )
		Connect( ID_ENABLECOMMONVALUES, wxEVT_COMMAND_MENU_SELECTED, OnEnableCommonValues )
		Connect( ID_SELECTSTYLE, wxEVT_COMMAND_MENU_SELECTED, OnSelectStyle )
	
		Connect( ID_STATICLAYOUT, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_CLEAR, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_COLLAPSE, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_COLLAPSEALL, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
	
		Connect( ID_POPULATE1, wxEVT_COMMAND_MENU_SELECTED, OnPopulateClick )
		Connect( ID_POPULATE2, wxEVT_COMMAND_MENU_SELECTED, OnPopulateClick )
	
		Connect( ID_GETVALUES, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_SETVALUES, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
		Connect( ID_SETVALUES2, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
	
		Connect( ID_SAVETOFILE, wxEVT_COMMAND_MENU_SELECTED, OnSaveToFileClick )
		Connect( ID_SAVETOFILE2, wxEVT_COMMAND_MENU_SELECTED, OnSaveToFileClick )
		Connect( ID_LOADFROMFILE, wxEVT_COMMAND_MENU_SELECTED, OnLoadFromFileClick )
	
		Connect( ID_CHANGEFLAGSITEMS, wxEVT_COMMAND_MENU_SELECTED, OnChangeFlagsPropItemsClick )
	
		Connect( ID_RUNTEST, wxEVT_COMMAND_MENU_SELECTED, OnMisc )
	
		Connect( ID_TESTINSERTCHOICE, wxEVT_COMMAND_MENU_SELECTED, OnInsertChoice )
		Connect( ID_TESTDELETECHOICE, wxEVT_COMMAND_MENU_SELECTED, OnDeleteChoice )
	
		Connect( ID_INSERTPAGE, wxEVT_COMMAND_MENU_SELECTED, OnInsertPage )
		Connect( ID_REMOVEPAGE, wxEVT_COMMAND_MENU_SELECTED, OnRemovePage )
	
		Connect( ID_SETSPINCTRLEDITOR, wxEVT_COMMAND_MENU_SELECTED, OnSetSpinCtrlEditorClick )
		Connect( ID_TESTREPLACE, wxEVT_COMMAND_MENU_SELECTED, OnTestReplaceClick )
		Connect( ID_SETPROPERTYVALUE, wxEVT_COMMAND_MENU_SELECTED, OnSetPropertyValue )
	
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

		'PopulateWithStandardItems()
		PopulateWithExamples()
		
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
		
		Local pid:wxPGProperty
'DebugStop
		' Append is ideal way To add items To wxPropertyGrid.
		pg.Append( New wxPropertyCategory.Create("Appearance", wxPG_LABEL) )

		pg.Append( New wxStringProperty.Create("Label", wxPG_LABEL, GetTitle()) )
		
		pg.Append( New wxFontProperty.Create("Font", wxPG_LABEL) )
		pg.SetPropertyHelpStringByName("Font", "Editing this will change font used in the property grid.")

		pg.Append( New wxSystemColourProperty.Create("Margin Colour", wxPG_LABEL, pg.GetGrid().GetMarginColour()) )

		

		pg.Append( New wxSystemColourProperty.Create("Cell Colour", wxPG_LABEL, pg.GetGrid().GetCellBackgroundColour()) )

		pg.Append( New wxSystemColourProperty.Create("Cell Text Colour", wxPG_LABEL, pg.GetGrid().GetCellTextColour()) )

		pg.Append( New wxSystemColourProperty.Create("Line Colour", wxPG_LABEL, pg.GetGrid().GetLineColour()) )

		Local fs_windowstyle_labels:String[] = [ ..
			"wxSIMPLE_BORDER", "wxDOUBLE_BORDER", ..
			"wxSUNKEN_BORDER", "wxRAISED_BORDER", ..
			"wxNO_BORDER", "wxTRANSPARENT_WINDOW", ..
			"wxTAB_TRAVERSAL", "wxWANTS_CHARS", ..
			"wxVSCROLL", ..
			"wxALWAYS_SHOW_SB", "wxCLIP_CHILDREN", ..
			"wxFULL_REPAINT_ON_RESIZE"]

		Local fs_windowstyle_values:Int[] = [ ..
			wxSIMPLE_BORDER, wxDOUBLE_BORDER, ..
			wxSUNKEN_BORDER, wxRAISED_BORDER, ..
			wxNO_BORDER, wxTRANSPARENT_WINDOW, ..
			wxTAB_TRAVERSAL, wxWANTS_CHARS, ..
			wxVSCROLL, ..
			wxALWAYS_SHOW_SB, wxCLIP_CHILDREN, ..
			wxFULL_REPAINT_ON_RESIZE ]

		pg.Append( New wxFlagsProperty.Create("Window Styles", wxPG_LABEL, fs_windowstyle_labels, fs_windowstyle_values , GetWindowStyle()) )

		pg.Append( New wxCursorProperty.Create("Cursor", wxPG_LABEL) )

		pg.Append( New wxPropertyCategory.Create("Position", "PositionCategory") )
		pg.SetPropertyHelpStringByName( "PositionCategory", "Change in items in this category will cause respective changes in frame." )
		pg.Append( New wxIntProperty.Create("Height", wxPG_LABEL, 480) )
		pg.Append( New wxIntProperty.Create("Width", wxPG_LABEL, 640) )
		pg.Append( New wxIntProperty.Create("X", wxPG_LABEL, 10) )
		pg.Append( New wxIntProperty.Create("Y", wxPG_LABEL, 10) )


		Local disabledHelpString:String = "This property is simply disabled. Inorder to have label disabled as well, " + ..
			"you need to set wxPG_EX_GREY_LABEL_WHEN_DISABLED using SetExtraStyle."
		
		pg.Append( New wxPropertyCategory.Create("Environment", wxPG_LABEL) )
		pg.Append( New wxStringProperty.Create("Operating System", wxPG_LABEL, wxGetOsDescription()) )
		
		pg.Append( New wxStringProperty.Create("User Id", wxPG_LABEL, wxGetUserId()) )
		pg.Append( New wxDirProperty.Create("User Home", wxPG_LABEL, wxGetUserHome()) )
		pg.Append( New wxStringProperty.Create("User Name", wxPG_LABEL, wxGetUserName()) )
		
		' Disable some of them
		pg.DisablePropertyByName( "Operating System" )
		pg.DisablePropertyByName( "User Id" )
		pg.DisablePropertyByName( "User Name" )
		
		pg.SetPropertyHelpStringByName( "Operating System", disabledHelpString )
		pg.SetPropertyHelpStringByName( "User Id", disabledHelpString )
		pg.SetPropertyHelpStringByName( "User Name", disabledHelpString )

 '		pg.Append( New wxPropertyCategory.Create("More Examples", wxPG_LABEL) )
'		
'		pg.Append( New wxFontDataProperty.Create( "FontDataProperty", wxPG_LABEL) )
'		pg.SetPropertyHelpStringByName( "FontDataProperty", ..
'			"This demonstrates wxFontDataProperty class defined in this sample app. " + ..
'			"It is exactly like wxFontProperty from the library, but also has colour sub-property." )
'		
'		pg.Append( New wxDirsProperty.Create("DirsProperty", wxPG_LABEL) )
'		pg.SetPropertyHelpStringByName( "DirsProperty", ..
'			"This demonstrates wxDirsProperty class defined in this sample app. " + ..
'			"It is built with WX_PG_IMPLEMENT_ARRAYSTRING_PROPERTY_WITH_VALIDATOR macro, " + ..
'			"with custom action (dir dialog popup) defined." )
'		
'		pg.Append( New wxAdvImageFileProperty.Create("AdvImageFileProperty", wxPG_LABEL) )
'		pg.SetPropertyHelpStringByName( "AdvImageFileProperty", ..
'			"This demonstrates wxAdvImageFileProperty class defined in this sample app. " + ..
'			"Button can be used to add new images to the popup list." )



	End Method
	
	Method PopulateWithExamples()

		Local pg:wxPropertyGrid = m_propGrid

	    ' Add bool property
	    pg.Append( New wxBoolProperty.Create( "BoolProperty", wxPG_LABEL, False ) )
	
	    ' Add bool property with check box
	    pg.Append( New wxBoolProperty.Create( "BoolProperty with CheckBox", wxPG_LABEL, False ) )
	    pg.SetPropertyAttributeByName( "BoolProperty with CheckBox", wxPG_BOOL_USE_CHECKBOX, 1 )
	
	    pg.SetPropertyHelpStringByName( "BoolProperty with CheckBox", ..
	        "Property attribute wxPG_BOOL_USE_CHECKBOX has been set to 1." )

	    pg.Append( New wxDoubleProperty.Create( "DoubleProperty", wxPG_LABEL, 1234500.23 ) )
	
	    ' A string property that can be edited in a separate editor dialog.
	    pg.Append( New wxLongStringProperty.Create( "LongStringProperty", "LongStringProp", ..
	        "This is much longer string than the first one. Edit it by clicking the button." ) )
	
	    ' A property that edits a wxArrayString.
		Local example_array:String[] = [ "String 1", "String 2", "String 3" ]
		pg.Append( New wxArrayStringProperty.Create( "ArrayStringProperty", wxPG_LABEL, example_array) )

		' A file selector property. Note that argument between name
		' and initial value is wildcard (format same as in wxFileDialog).
		Local prop:wxPGProperty = New wxFileProperty.Create( "FileProperty", "TextFile" )
		pg.Append( prop )
		
		prop.SetAttributeString(wxPG_FILE_WILDCARD, "Text Files (*.txt)|*.txt")
		prop.SetAttributeString(wxPG_FILE_DIALOG_TITLE, "Custom File Dialog Title")
		prop.SetAttributeInt(wxPG_FILE_SHOW_FULL_PATH, 0)

?win32
		prop.SetAttributeString(wxPG_FILE_SHOW_RELATIVE_PATH, "C:\Windows")
		pg.SetPropertyValue(prop, "C:\Windows\System32\msvcrt71.dll")
?



    ' An image file property. Arguments are just like for FileProperty, but
    ' wildcard is missing (it is autogenerated from supported image formats).
    ' If you really need to override it, create property separately, and call
    ' its SetWildcard method.
    pg.Append( New wxImageFileProperty.Create( "ImageFile", wxPG_LABEL ) )


    'pid = pg.Append( new wxColourProperty("ColourProperty", wxPG_LABEL, wxRED()) )
    'pg.SetPropertyAttribute(pid, wxPG_COLOUR_ALLOW_CUSTOM, 0)
    'pg.SetPropertyEditor( "ColourProperty"), wxPG_EDITOR(Choice) )
    'pg.SetPropertyHelpString( "ColourProperty",
    '    "wxPropertyGrid::SetPropertyEditor method has been used to change "
    '    "editor of this property to wxPG_EDITOR(Choice)")


    '
    ' wxEnumProperty does not store strings or even list of strings
    ' ( so that's why they are static in function ).
    Local enum_prop_labels:String[] = [ "One Item", ..
        "Another Item", "One More", "This Is Last" ]

    ' this value array would be optional if values matched string indexes
    Local enum_prop_values:Int[] = [ 40, 80, 120, 160 ]

    ' note that the initial value (the last argument) is the actual value,
    ' not index or anything like that. Thus, our value selects "Another Item".
    '
    ' 0 before value is number of items. If it is 0, like in our example,
    ' number of items is calculated, and this requires that the string pointer
    ' array is terminated with NULL.
    pg.Append( New wxEnumProperty.CreateWithArrays("EnumProperty", wxPG_LABEL, ..
        enum_prop_labels, enum_prop_values, 80 ) )


    Local soc:wxPGChoices = New wxPGChoices.Create()
'DebugLog soc.GetCount()

	    ' use basic table from our previous example
	    ' can also set/add wxArrayStrings and wxArrayInts directly.
	    soc.Set( enum_prop_labels, enum_prop_values )

	    ' add extra items
	    soc.Add( "Look, it continues", 200 )
	    soc.Add( "Even More", 240 )
	    soc.Add( "And More", 280 )
	    soc.Add( "True End of the List", 320 )

	    ' Test custom colours ([] operator of wxPGChoices returns
	    ' references to wxPGChoiceEntry).
	    soc.Item(1).SetFgCol(wxRED())
	    soc.Item(1).SetBgCol(wxLIGHT_GREY())
	    soc.Item(2).SetFgCol(wxGREEN())
	    soc.Item(2).SetBgCol(wxLIGHT_GREY())
	    soc.Item(3).SetFgCol(wxBLUE())
	    soc.Item(3).SetBgCol(wxLIGHT_GREY())
	    soc.Item(4).SetBitmap(wxArtProvider.GetBitmap(wxART_FOLDER))

		pg.Append( New wxEnumProperty.CreateWithChoices("EnumProperty 2", wxPG_LABEL, soc, 240) )
 
		pg.AddPropertyChoiceByName("EnumProperty 2", "Testing Extra", 360)

		' Add a second time to test that the caching works
		pg.Append( New wxEnumProperty.CreateWithChoices("EnumProperty 3", wxPG_LABEL, soc , 360 ) )

		pg.SetPropertyHelpStringByName("EnumProperty 3", "Should have same choices as EnumProperty 2")


		pg.Append( New wxEnumProperty.CreateWithChoices("EnumProperty 4",wxPG_LABEL, soc, 240 ) )
		pg.SetPropertyHelpStringByName("EnumProperty 4", "Should have same choices as EnumProperty 2")
		
		pg.Append( New wxEnumProperty.CreateWithChoices("EnumProperty 5",wxPG_LABEL, soc, 240 ) )
		pg.SetPropertyChoicesExclusiveByName("EnumProperty 5")
		pg.AddPropertyChoiceByName("EnumProperty 5", "5th only", 360)
		pg.SetPropertyHelpStringByName("EnumProperty 5", "Should have one extra item when compared to EnumProperty 4")
		
		' Password property example.
		pg.Append( New wxStringProperty.Create("Password", wxPG_LABEL, "password") )
		pg.SetPropertyAttributeByName( "Password", wxPG_STRING_PASSWORD, 1 )
		pg.SetPropertyHelpStringByName( "Password", "Has attribute wxPG_STRING_PASSWORD set to 1" )
		
		' String editor with dir selector button. Uses wxEmptyString as name, which
		' is allowed (naturally, in this case property cannot be accessed by name).
		pg.Append( New wxDirProperty.Create( "DirProperty", wxPG_LABEL, wxGetUserHome()) )
		pg.SetPropertyAttributeStringByName( "DirProperty", wxPG_DIR_DIALOG_MESSAGE, "This is a custom dir dialog message" )
		
		' Add string property - first arg is label, second name, and third initial value
		pg.Append( New wxStringProperty.Create( "StringProperty", wxPG_LABEL ) )
		pg.SetPropertyMaxLengthByName( "StringProperty", 6 )
		pg.SetPropertyHelpStringByName( "StringProperty", ..
			"Max length of this text has been limited to 6, using wxPropertyGrid::SetPropertyMaxLength." )
		
		' Set value after limiting so that it will be applied
		pg.SetPropertyValueStringByName( "StringProperty", "some text" )

			' Multi choice dialog.
		Local tchoices:wxPGChoices = New wxPGChoices.Create()
		tchoices.Add("Cabbage",10)
		tchoices.Add("Carrot",15)
		tchoices.Add("Onion",20)
		tchoices.Add("Potato",25)
		tchoices.Add("Strawberry",30)
		
		Local tchoicesValues:Int[] = [1, 15, 20]
	
		pg.Append( New wxEnumProperty.CreateWithChoices("EnumProperty X", wxPG_LABEL, tchoices ) )
	
		pg.Append( New wxMultiChoiceProperty.CreateWithChoices( "MultiChoiceProperty", wxPG_LABEL, tchoices, tchoicesValues ) )
	
		'pg.Append( new wxTestCustomFlagsProperty("Custom FlagsProperty", wxPG_LABEL ) )
		'pg.SetPropertyEditor( "Custom FlagsProperty", wxPG_EDITOR(TextCtrlAndButton) )
	
		'pg.Append( new wxTestCustomEnumProperty("Custom EnumProperty"), wxPG_LABEL ) )
	
		'pg.Append( New wxSizeProperty.Create( "SizeProperty", "Size", GetSize() ) )
		'pg.Append( New wxPointProperty.Create( "PointProperty", "Position", GetPosition() ) )
	
	
		' UInt samples
		pg.Append( New wxUIntProperty.Create( "UIntProperty", wxPG_LABEL, $FEEEFEEE))
		pg.SetPropertyAttributeByName( "UIntProperty", wxPG_UINT_PREFIX, wxPG_PREFIX_NONE )
		pg.SetPropertyAttributeByName( "UIntProperty", wxPG_UINT_BASE, wxPG_BASE_HEX )
		'pg.SetPropertyAttribute( "UIntProperty", wxPG_UINT_PREFIX, wxPG_PREFIX_NONE )
		'pg.SetPropertyAttribute( "UIntProperty", wxPG_UINT_BASE, wxPG_BASE_OCT )
	
		'
		' wxEditEnumProperty
		Local eech:wxPGChoices = New wxPGChoices.Create()
		eech.Add("Choice 1")
		eech.Add("Choice 2")
		eech.Add("Choice 3")
'		pg.Append( New wxEditEnumProperty.Create("EditEnumProperty", wxPG_LABEL, eech) ) ' , "Choice 2")
	
		'wxString v_
		'wxTextValidator validator1(wxFILTER_NUMERIC,&v_)
		'pg.SetPropertyValidator( "EditEnumProperty", validator1 )
	
		'
		' wxDateTimeProperty
		pg.Append( New wxDateProperty.Create("DateProperty", wxPG_LABEL, wxDateTime.Now() ) )
	
		pg.SetPropertyAttributeByName( "DateProperty", wxPG_DATE_PICKER_STYLE, wxDP_DROPDOWN | wxDP_SHOWCENTURY )
	
		pg.SetPropertyHelpStringByName( "DateProperty", ..
			"Attribute wxPG_DATE_PICKER_STYLE has been set to wxDP_DROPDOWN | wxDP_SHOWCENTURY." + ..
			"Also note that wxPG_ALLOW_WXADV needs to be defined inorder to use wxDatePickerCtrl." )
'End Rem
			
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
		Local frame:MyFrame = MyFrame(event.parent)
		Local prop:wxPGProperty = frame.m_propGrid.GetSelection()
		If Not prop Then
			wxMessageBox("First select a property.")
			Return
		End If

		If frame.m_propGrid.IsPropertyEnabled( prop ) Then
			frame.m_propGrid.DisableProperty ( prop )
			frame.m_itemEnable.SetText( "Enable" )
		Else
			frame. m_propGrid.EnableProperty( prop )
			frame.m_itemEnable.SetText( "Disable" )
		End If
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
		Local frame:MyFrame = MyFrame(event.parent)
		Local evt:wxPropertyGridEvent = wxPropertyGridEvent(event)
		Local property:wxPGProperty = evt.GetProperty()

		
		frame.m_itemEnable.Enable(True)
		If evt.IsPropertyEnabled() Then
			frame.m_itemEnable.SetText( "Disable" )
		Else
			frame.m_itemEnable.SetText( "Enable" )
		End If
    '}
    'Else
    '{
    '    m_itemEnable->Enable( False );
    '}

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

