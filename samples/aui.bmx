'
' wxAui sample
'
' From the C++ sample by Benjamin I. Williams
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxAui
Import wx.wxTextCtrl
Import wx.wxTreeCtrl
Import wx.wxSpinCtrl
Import wx.wxButton
Import wx.wxBitmapButton
Import wx.wxStaticText
Import wx.wxArtProvider
Import wx.wxColourDialog
Import wx.wxHtmlWindow

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxAUI Sample Application", , , 800, 600,wxDEFAULT_FRAME_STYLE | wxSUNKEN_BORDER))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field manager:wxAuiManager
	Field perspectives:String[] = New String[2]
	Field perspectivesMenu:wxMenu
	Field notebookStyle:Int
	Field notebookTheme:Int
	
	Const ID_CreateTree:Int = wxID_HIGHEST + 1
	Const ID_CreateGrid:Int = wxID_HIGHEST + 2
	Const ID_CreateText:Int = wxID_HIGHEST + 3
	Const ID_CreateHTML:Int = wxID_HIGHEST + 4
	Const ID_CreateNotebook:Int = wxID_HIGHEST + 5
	Const ID_CreateSizeReport:Int = wxID_HIGHEST + 6
	Const ID_GridContent:Int = wxID_HIGHEST + 7
	Const ID_TextContent:Int = wxID_HIGHEST + 8
	Const ID_TreeContent:Int = wxID_HIGHEST + 9
	Const ID_HTMLContent:Int = wxID_HIGHEST + 10
	Const ID_NotebookContent:Int = wxID_HIGHEST + 11
	Const ID_SizeReportContent:Int = wxID_HIGHEST + 12
	Const ID_CreatePerspective:Int = wxID_HIGHEST + 13
	Const ID_CopyPerspectiveCode:Int = wxID_HIGHEST + 14
	Const ID_AllowFloating:Int = wxID_HIGHEST + 15
	Const ID_AllowActivePane:Int = wxID_HIGHEST + 16
	Const ID_TransparentHint:Int = wxID_HIGHEST + 17
	Const ID_VenetianBlindsHint:Int = wxID_HIGHEST + 18
	Const ID_RectangleHint:Int = wxID_HIGHEST + 19
	Const ID_NoHint:Int = wxID_HIGHEST + 20
	Const ID_HintFade:Int = wxID_HIGHEST + 21
	Const ID_NoVenetianFade:Int = wxID_HIGHEST + 22
	Const ID_TransparentDrag:Int = wxID_HIGHEST + 23
	Const ID_NoGradient:Int = wxID_HIGHEST + 24
	Const ID_VerticalGradient:Int = wxID_HIGHEST + 25
	Const ID_HorizontalGradient:Int = wxID_HIGHEST + 26
	Const ID_Settings:Int = wxID_HIGHEST + 27
	Const ID_NotebookNoCloseButton:Int = wxID_HIGHEST + 28
	Const ID_NotebookCloseButton:Int = wxID_HIGHEST + 29
	Const ID_NotebookCloseButtonAll:Int = wxID_HIGHEST + 30
	Const ID_NotebookCloseButtonActive:Int = wxID_HIGHEST + 31
	Const ID_NotebookAllowTabMove:Int = wxID_HIGHEST + 32
	Const ID_NotebookAllowTabExternalMove:Int = wxID_HIGHEST + 33
	Const ID_NotebookAllowTabSplit:Int = wxID_HIGHEST + 34
	Const ID_NotebookWindowList:Int = wxID_HIGHEST + 35
	Const ID_NotebookScrollButtons:Int = wxID_HIGHEST + 36
	Const ID_NotebookTabFixedWidth:Int = wxID_HIGHEST + 37
	Const ID_NotebookArtGloss:Int = wxID_HIGHEST + 38
	Const ID_NotebookArtSimple:Int = wxID_HIGHEST + 39
	Const ID_FirstPerspective:Int = ID_CreatePerspective + 1000

	Method OnInit()

		' tell wxAuiManager to manage this frame
		manager = New wxAuiManager.Create(Self)
		
		' set up default notebook style
		notebookStyle = wxAUI_NB_DEFAULT_STYLE | wxAUI_NB_TAB_EXTERNAL_MOVE | wxNO_BORDER
		notebookTheme = 0
		
		' create menu
		Local mb:wxMenuBar = New wxMenuBar.Create()
		
		Local fileMenu:wxMenu = New wxMenu.Create()
		fileMenu.Append(wxID_EXIT, "Exit")
		
		Local viewMenu:wxMenu = New wxMenu.Create()
		viewMenu.Append(ID_CreateText, "Create Text Control")
		viewMenu.Append(ID_CreateHTML, "Create HTML Control")
		viewMenu.Append(ID_CreateTree, "Create Tree")
		viewMenu.Append(ID_CreateGrid, "Create Grid")
		viewMenu.Append(ID_CreateNotebook, "Create Notebook")
		viewMenu.Append(ID_CreateSizeReport, "Create Size Reporter")
		viewMenu.AppendSeparator()
		viewMenu.Append(ID_GridContent, "Use a Grid for the Content Pane")
		viewMenu.Append(ID_TextContent, "Use a Text Control for the Content Pane")
		viewMenu.Append(ID_HTMLContent, "Use an HTML Control for the Content Pane")
		viewMenu.Append(ID_TreeContent, "Use a Tree Control for the Content Pane")
		viewMenu.Append(ID_NotebookContent, "Use a wxAuiNotebook control for the Content Pane")
		viewMenu.Append(ID_SizeReportContent, "Use a Size Reporter for the Content Pane")

		Local optionsMenu:wxMenu = New wxMenu.Create()
		optionsMenu.AppendRadioItem(ID_TransparentHint, "Transparent Hint")
		optionsMenu.AppendRadioItem(ID_VenetianBlindsHint, "Venetian Blinds Hint")
		optionsMenu.AppendRadioItem(ID_RectangleHint, "Rectangle Hint")
		optionsMenu.AppendRadioItem(ID_NoHint, "No Hint")
		optionsMenu.AppendSeparator()
		optionsMenu.AppendCheckItem(ID_HintFade, "Hint Fade-in")
		optionsMenu.AppendCheckItem(ID_AllowFloating, "Allow Floating")
		optionsMenu.AppendCheckItem(ID_NoVenetianFade, "Disable Venetian Blinds Hint Fade-in")
		optionsMenu.AppendCheckItem(ID_TransparentDrag, "Transparent Drag")
		optionsMenu.AppendCheckItem(ID_AllowActivePane, "Allow Active Pane")
		optionsMenu.AppendSeparator()
		optionsMenu.AppendRadioItem(ID_NoGradient, "No Caption Gradient")
		optionsMenu.AppendRadioItem(ID_VerticalGradient, "Vertical Caption Gradient")
		optionsMenu.AppendRadioItem(ID_HorizontalGradient, "Horizontal Caption Gradient")
		optionsMenu.AppendSeparator()
		optionsMenu.Append(ID_Settings, "Settings Pane")
		
		Local notebookMenu:wxMenu = New wxMenu.Create()
		notebookMenu.AppendRadioItem(ID_NotebookArtGloss, "Glossy Theme (Default)")
		notebookMenu.AppendRadioItem(ID_NotebookArtSimple, "Simple Theme")
		notebookMenu.AppendSeparator()
		notebookMenu.AppendRadioItem(ID_NotebookNoCloseButton, "No Close Button")
		notebookMenu.AppendRadioItem(ID_NotebookCloseButton, "Close Button at Right")
		notebookMenu.AppendRadioItem(ID_NotebookCloseButtonAll, "Close Button on All Tabs")
		notebookMenu.AppendRadioItem(ID_NotebookCloseButtonActive, "Close Button on Active Tab")
		notebookMenu.AppendSeparator()
		notebookMenu.AppendCheckItem(ID_NotebookAllowTabMove, "Allow Tab Move")
		notebookMenu.AppendCheckItem(ID_NotebookAllowTabExternalMove, "Allow External Tab Move")
		notebookMenu.AppendCheckItem(ID_NotebookAllowTabSplit, "Allow Notebook Split")
		notebookMenu.AppendCheckItem(ID_NotebookScrollButtons, "Scroll Buttons Visible")
		notebookMenu.AppendCheckItem(ID_NotebookWindowList, "Window List Button Visible")
		notebookMenu.AppendCheckItem(ID_NotebookTabFixedWidth, "Fixed-width Tabs")
		
		perspectivesMenu = New wxMenu.Create()
		perspectivesMenu.Append(ID_CreatePerspective, "Create Perspective")
		perspectivesMenu.Append(ID_CopyPerspectiveCode, "Copy Perspective Data To Clipboard")
		perspectivesMenu.AppendSeparator()
		perspectivesMenu.Append(ID_FirstPerspective + 0, "Default Startup")
		perspectivesMenu.Append(ID_FirstPerspective + 1, "All Panes")


		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append(wxID_ABOUT, "About...")
		
		mb.Append(fileMenu, "File")
		mb.Append(viewMenu, "View")
		mb.Append(perspectivesMenu, "Perspectives")
		mb.Append(optionsMenu, "Options")
		mb.Append(notebookMenu, "Notebook")
		mb.Append(helpMenu, "Help")
		
		SetMenuBar(mb)
		
		CreateStatusBar()
		SetStatusText("Ready")

		' min size for the frame itself isn't completely done.
		' see the end up wxAuiManager::Update() for the test
		' code. For now, just hard code a frame minimum size
		SetMinSize(400, 300)


		' create some toolbars
		Local tb1:wxToolBar = New wxToolBar.Create(Self, wxID_ANY, ,, ,, wxTB_FLAT | wxTB_NODIVIDER)
		tb1.SetToolBitmapSize(48, 48)
		tb1.AddTool(101, "Test", wxArtProvider.GetBitmap(wxART_ERROR))
		tb1.AddSeparator()
		tb1.AddTool(102, "Test", wxArtProvider.GetBitmap(wxART_QUESTION))
		tb1.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_INFORMATION))
		tb1.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_WARNING))
		tb1.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_MISSING_IMAGE))
		tb1.Realize()

		Local tb2:wxToolBar = New wxToolBar.Create(Self, wxID_ANY, ,, ,, wxTB_FLAT | wxTB_NODIVIDER)
		tb2.SetToolBitmapSize(16, 16)
		
		Local tb2bmp1:wxBitmap = wxArtProvider.GetBitmap(wxART_QUESTION, wxART_OTHER, 16, 16)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddSeparator()
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddSeparator()
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.AddTool(101, "Test", tb2bmp1)
		tb2.Realize()
		
		
		Local tb3:wxToolBar = New wxToolBar.Create(Self, wxID_ANY, ,, ,, wxTB_FLAT | wxTB_NODIVIDER)
		tb3.SetToolBitmapSize(16, 16)
		Local tb3bmp1:wxBitmap = wxArtProvider.GetBitmap(wxART_FOLDER, wxART_OTHER, 16, 16)
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.AddSeparator()
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.AddTool(101, "Test", tb3bmp1)
		tb3.Realize()
		
		
		Local tb4:wxToolBar = New wxToolBar.Create(Self, wxID_ANY, ,, ,, wxTB_FLAT | wxTB_NODIVIDER | wxTB_HORZ_TEXT)
		tb4.SetToolBitmapSize(16, 16)
		Local tb4bmp1:wxBitmap = wxArtProvider.GetBitmap(wxART_NORMAL_FILE, wxART_OTHER, 16, 16)
		tb4.AddTool(101, "Item 1", tb4bmp1)
		tb4.AddTool(101, "Item 2", tb4bmp1)
		tb4.AddTool(101, "Item 3", tb4bmp1)
		tb4.AddTool(101, "Item 4", tb4bmp1)
		tb4.AddSeparator()
		tb4.AddTool(101, "Item 5", tb4bmp1)
		tb4.AddTool(101, "Item 6", tb4bmp1)
		tb4.AddTool(101, "Item 7", tb4bmp1)
		tb4.AddTool(101, "Item 8", tb4bmp1)
		tb4.Realize()
		
		' create some more toolbars
		Local tb5:wxToolBar = New wxToolBar.Create(Self, wxID_ANY, ,, ,, wxTB_FLAT | wxTB_NODIVIDER | wxTB_VERTICAL)
		tb5.SetToolBitmapSize(48, 48)
		tb5.AddTool(101, "Test", wxArtProvider.GetBitmap(wxART_ERROR))
		tb5.AddSeparator()
		tb5.AddTool(102, "Test", wxArtProvider.GetBitmap(wxART_QUESTION))
		tb5.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_INFORMATION))
		tb5.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_WARNING))
		tb5.AddTool(103, "Test", wxArtProvider.GetBitmap(wxART_MISSING_IMAGE))
		tb5.Realize()

		' add a bunch of panes
		manager.AddPaneInfo(CreateTreeCtrl(), New wxAuiPaneInfo.Create().Name("test8").Caption("Tree Pane"). ..
                  Left().Layer(1).Position(1).CloseButton(True).MaximizeButton(True))

		Local wnd10:wxWindow = CreateTextCtrl("This pane will prompt the user before hiding.")
		manager.AddPaneInfo(wnd10, New wxAuiPaneInfo.Create().Name("test10").Caption("Text Pane with Hide Prompt").Bottom().Layer(1).Position(1))
		

		manager.AddPaneInfo(New SettingsPanel.CreateSettingsPanel(Self, Self), New wxAuiPaneInfo.Create(). ..
			Name("settings").Caption("Dock Manager Settings").Dockable(False).FloatPane().Hide())

		' create some center panes

		manager.AddPaneInfo(CreateTreeCtrl(), New wxAuiPaneInfo.Create().Name("tree_content").CenterPane().Hide())

    'm_mgr.AddPane(CreateSizeReportCtrl(), wxAuiPaneInfo().Name(wxT("sizereport_content")).
    '              CenterPane().Hide());

		manager.AddPaneInfo(CreateTextCtrl(), New wxAuiPaneInfo.Create().Name("text_content").CenterPane().Hide())

		manager.AddPaneInfo(CreateHTMLCtrl(), New wxAuiPaneInfo.Create().Name("html_content").CenterPane().Hide())

		manager.AddPaneInfo(CreateNotebook(), New wxAuiPaneInfo.Create().Name("notebook_content").CenterPane().PaneBorder(False))


		' add the toolbars To the manager
		manager.AddPaneInfo(tb1, New wxAuiPaneInfo.Create().Name("tb1").Caption("Big Toolbar"). ..
			ToolbarPane().Top().LeftDockable(False).RightDockable(False))

		manager.AddPaneInfo(tb2, New wxAuiPaneInfo.Create().Name("tb2").Caption("Toolbar 2"). ..
			ToolbarPane().Top().Row(1).LeftDockable(False).RightDockable(False))
		
		manager.AddPaneInfo(tb3, New wxAuiPaneInfo.Create().Name("tb3").Caption("Toolbar 3"). ..
			ToolbarPane().Top().Row(1).Position(1).LeftDockable(False).RightDockable(False))
		
		manager.AddPaneInfo(tb4, New wxAuiPaneInfo.Create().Name("tb4").Caption("Sample Bookmark Toolbar"). ..
			ToolbarPane().Top().Row(2).LeftDockable(False).RightDockable(False))
		
		manager.AddPaneInfo(tb5, New wxAuiPaneInfo.Create().Name("tb5").Caption("Sample Vertical Toolbar"). ..
			ToolbarPane().Left().GripperTop().TopDockable(False).BottomDockable(False))

		manager.AddPaneInfo(New wxButton.Create(Self, wxID_ANY, "Test Button"), ..
			New wxAuiPaneInfo.Create().Name("tb6").ToolbarPane().Top().Row(2).Position(1). ..
			LeftDockable(False).RightDockable(False))

		' make some default perspectives
		Local perspectiveAll:String = manager.SavePerspective()
		
		manager.GetPane("tb1").Hide()		
		manager.GetPane("tb6").Hide()
		
		Local perspectiveDefault:String = manager.SavePerspective()
		
		perspectives[0] = perspectiveAll
		perspectives[1] = perspectiveDefault



		' "commit" all changes made to wxAuiManager
		manager.Update()


		' lots and lots of event handling !
		Connect(ID_CreateTree, wxEVT_COMMAND_MENU_SELECTED, OnCreateTree)
		Connect(ID_CreateGrid, wxEVT_COMMAND_MENU_SELECTED, OnCreateGrid)
		Connect(ID_CreateText, wxEVT_COMMAND_MENU_SELECTED, OnCreateText)
		Connect(ID_CreateHTML, wxEVT_COMMAND_MENU_SELECTED, OnCreateHTML)
		'Connect(ID_CreateSizeReport, wxEVT_COMMAND_MENU_SELECTED, OnCreateSizeReport)
		Connect(ID_CreateNotebook, wxEVT_COMMAND_MENU_SELECTED, OnCreateNotebook)
		Connect(ID_CreatePerspective, wxEVT_COMMAND_MENU_SELECTED, OnCreatePerspective)
		Connect(ID_CopyPerspectiveCode, wxEVT_COMMAND_MENU_SELECTED, OnCopyPerspectiveCode)
		Connect(ID_AllowFloating, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_TransparentHint, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_VenetianBlindsHint, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_RectangleHint, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_NoHint, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_HintFade, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_NoVenetianFade, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_TransparentDrag, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_AllowActivePane, wxEVT_COMMAND_MENU_SELECTED, OnManagerFlag)
		Connect(ID_NotebookTabFixedWidth, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookNoCloseButton, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookCloseButton, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookCloseButtonAll, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookCloseButtonActive, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookAllowTabMove, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookAllowTabExternalMove, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookAllowTabSplit, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookScrollButtons, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookWindowList, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookArtGloss, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NotebookArtSimple, wxEVT_COMMAND_MENU_SELECTED, OnNotebookFlag)
		Connect(ID_NoGradient, wxEVT_COMMAND_MENU_SELECTED, OnGradient)
		Connect(ID_VerticalGradient, wxEVT_COMMAND_MENU_SELECTED, OnGradient)
		Connect(ID_HorizontalGradient, wxEVT_COMMAND_MENU_SELECTED, OnGradient)
		Connect(ID_Settings, wxEVT_COMMAND_MENU_SELECTED, OnSettings)
		Connect(ID_GridContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(ID_TreeContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(ID_TextContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(ID_SizeReportContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(ID_HTMLContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(ID_NotebookContent, wxEVT_COMMAND_MENU_SELECTED, OnChangeContentPane)
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnExit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)

		Connect(ID_NotebookTabFixedWidth, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookNoCloseButton, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookCloseButton, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookCloseButtonAll, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookCloseButtonActive, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookAllowTabMove, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookAllowTabExternalMove, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookAllowTabSplit, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookScrollButtons, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NotebookWindowList, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_AllowFloating, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_TransparentHint, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_VenetianBlindsHint, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_RectangleHint, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NoHint, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_HintFade, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NoVenetianFade, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_TransparentDrag, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_NoGradient, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_VerticalGradient, wxEVT_UPDATE_UI, OnUpdateUI)
		Connect(ID_HorizontalGradient, wxEVT_UPDATE_UI, OnUpdateUI)
		
		'EVT_MENU_RANGE(MyFrame::ID_FirstPerspective, MyFrame::ID_FirstPerspective+1000, MyFrame::OnRestorePerspective)
		
		Connect(,wxEVT_AUI_PANE_CLOSE, OnPaneClose)
		ConnectAny(wxEVT_CLOSE, OnClose)
		
		'EVT_AUINOTEBOOK_ALLOW_DND(wxID_ANY, MyFrame::OnAllowNotebookDnD)
		'EVT_AUINOTEBOOK_PAGE_CLOSE(wxID_ANY, MyFrame::OnNotebookPageClose)
	End Method
	
	Function OnClose(event:wxEvent)
		MyFrame(event.parent).manager.UnInit()
		event.Skip()
	End Function

	Method CreateTextCtrl:wxTextCtrl(text:String = "")
		Global count:Int
	
		If text.length = 0 Then
			count:+ 1
			text = "This is text box " + count
		End If
		
		Return New wxTextCtrl.Create(Self, wxID_ANY, text, 0, 0, 150, 90, wxNO_BORDER | wxTE_MULTILINE)
	
	End Method

	Method CreateHTMLCtrl:wxHtmlWindow(parent:wxWindow = Null)
		If parent = Null Then
			parent = Self
		End If
	
		Local ctrl:wxHtmlWindow = New wxHtmlWindow.Create(parent, wxID_ANY, -1, -1, 400, 300)
		ctrl.SetPage(GetIntroText())
		Return ctrl
	
	End Method

	Method CreateNotebook:wxAuiNotebook()
		' create the notebook off-window to avoid flicker
		Local width:Int, height:Int
		GetClientSize(width, height)

		Local ctrl:wxAuiNotebook = New wxAuiNotebook.Create(Self, wxID_ANY, width, height, 430, 200, notebookStyle)
		
		Local pagebmp:wxBitmap = wxArtProvider.GetBitmap(wxART_NORMAL_FILE, wxART_OTHER, 16, 16)
                                    
		ctrl.AddPage(CreateHTMLCtrl(ctrl), "Welcome to wxAUI" , False, pagebmp)
		
		Local panel:wxPanel = New wxPanel.Create(ctrl, wxID_ANY)
		Local flex:wxFlexGridSizer = New wxFlexGridSizer.Create( 2 )
		flex.AddGrowableRow(0)
		flex.AddGrowableRow(3)
		flex.AddGrowableCol(1)
		flex.AddCustomSpacer(5, 5)
		flex.AddCustomSpacer(5, 5)
		flex.Add(New wxStaticText.Create(panel, -1, "wxTextCtrl:"), 0, wxALL | wxALIGN_CENTRE, 5)
		flex.Add(New wxTextCtrl.Create(panel, -1, "", -1, -1, 100, -1), 1, wxALL | wxALIGN_CENTRE, 5)
		flex.Add(New wxStaticText.Create(panel, -1, "wxSpinCtrl:" ), 0, wxALL | wxALIGN_CENTRE, 5)
		flex.Add(New wxSpinCtrl.Create(panel, -1, "5", -1, -1, 100, -1, wxSP_ARROW_KEYS, 5, 50, 5), 0, wxALL | wxALIGN_CENTRE, 5)
		flex.AddCustomSpacer(5, 5)
		flex.AddCustomSpacer(5, 5)
		panel.SetSizer(flex)
		ctrl.AddPage(panel, "wxPanel", False, pagebmp )

		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 1", False, pagebmp )

		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 2")

		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 3")

		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 4")

		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 5")
		
		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 6")
		
		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 7 (longer title)")
		
		ctrl.AddPage( New wxTextCtrl.Create(ctrl, wxID_ANY, "Some more text", ..
			,, ,, wxTE_MULTILINE|wxNO_BORDER) , "wxTextCtrl 8")
	
		Return ctrl
	End Method
	
	Method CreateTreeCtrl:wxTreeCtrl()

		Local tree:wxTreeCtrl = New wxTreeCtrl.Create(Self, wxID_ANY, 0, 0, 160, 250, wxTR_DEFAULT_STYLE | wxNO_BORDER)
		
		Local imageList:wxImageList = New wxImageList.Create(16, 16, True, 2)
		imageList.Add(wxArtProvider.GetBitmap(wxART_FOLDER, wxART_OTHER, 16, 16))
		imageList.Add(wxArtProvider.GetBitmap(wxART_NORMAL_FILE, wxART_OTHER, 16, 16))
		tree.AssignImageList(imageList)	

		Local root:wxTreeItemId = tree.AddRoot("wxAUI Project", 0)
		
		For Local i:Int = 1 To 5
		
			Local item:wxTreeItemId = tree.AppendItem(root, "Item " + i, 0)
			
			For Local n:Int = 1 To 5
				tree.AppendItem(item, "Subitem " + n, 1)
			Next 
		
		Next
		
		tree.Expand(root)
		
		Return tree
	End Method

	
	' event handling
	Function OnEraseBackground(event:wxEvent)
		event.Skip()
	End Function
	
	Function OnSize(event:wxEvent)
		event.Skip()
	End Function

	Function OnCreateTree(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local x:Int, y:Int
		frame.GetStartPosition(x, y)
		
		frame.manager.AddPaneInfo(frame.CreateTreeCtrl(), New wxAuiPaneInfo.Create().Caption("Tree Control").FloatPane(). ..
			FloatingPosition(x, y).FloatingSize(150, 300))
		frame.manager.Update()
	End Function
	
	Function OnCreateGrid(event:wxEvent)
	End Function

	Function OnCreateText(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local x:Int, y:Int
		frame.GetStartPosition(x, y)

		frame.manager.AddPaneInfo(frame.CreateTextCtrl(), New wxAuiPaneInfo.Create().Caption("Text Control"). ..
			FloatPane().FloatingPosition(x, y))
		frame.manager.Update()
	End Function

	Function OnCreateHTML(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local x:Int, y:Int
		frame.GetStartPosition(x, y)

		frame.manager.AddPaneInfo(frame.CreateHTMLCtrl(), New wxAuiPaneInfo.Create().Caption("HTML Control"). ..
			FloatPane().FloatingPosition(x, y).FloatingSize(300, 200))
		frame.manager.Update()
	End Function

	Function OnCreateNotebook(event:wxEvent)
	End Function

	Function OnCreatePerspective(event:wxEvent)
	End Function

	Function OnCopyPerspectiveCode(event:wxEvent)
	End Function

	Function OnManagerFlag(event:wxEvent)
		Local manager:wxAuiManager = MyFrame(event.parent).manager
		Local id:Int = event.GetId()

		If id = ID_TransparentHint Or id = ID_VenetianBlindsHint Or ..
				id = ID_RectangleHint Or id = ID_NoHint Then
			Local flags:Int = manager.GetFlags()
			flags:& ~wxAUI_MGR_TRANSPARENT_HINT
			flags:& ~wxAUI_MGR_VENETIAN_BLINDS_HINT
			flags:& ~wxAUI_MGR_RECTANGLE_HINT
			manager.SetFlags(flags)
    		End If

		Local flag:Int = 0
		Select id
			Case ID_AllowFloating
				flag = wxAUI_MGR_ALLOW_FLOATING 
			Case ID_TransparentDrag
				flag = wxAUI_MGR_TRANSPARENT_DRAG
			Case ID_HintFade
				flag = wxAUI_MGR_HINT_FADE
			Case ID_NoVenetianFade
				flag = wxAUI_MGR_NO_VENETIAN_BLINDS_FADE
			Case ID_AllowActivePane
				flag = wxAUI_MGR_ALLOW_ACTIVE_PANE
			Case ID_TransparentHint
				flag = wxAUI_MGR_TRANSPARENT_HINT
			Case ID_VenetianBlindsHint
				flag = wxAUI_MGR_VENETIAN_BLINDS_HINT
			Case ID_RectangleHint
				flag = wxAUI_MGR_RECTANGLE_HINT
		End Select
    
		If flag Then	
			manager.SetFlags(manager.GetFlags() ~ flag)
		End If
		
		manager.Update()
	
	End Function

	Function OnNotebookFlag(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local id:Int = event.GetId()
		
		If id = ID_NotebookNoCloseButton Or id = ID_NotebookCloseButton Or ..
				id = ID_NotebookCloseButtonAll Or id = ID_NotebookCloseButtonActive Then

			frame.notebookStyle:& ~(wxAUI_NB_CLOSE_BUTTON | wxAUI_NB_CLOSE_ON_ACTIVE_TAB | wxAUI_NB_CLOSE_ON_ALL_TABS)
			        
			Select id
				Case ID_NotebookNoCloseButton
					' nothing doing here...
				Case ID_NotebookCloseButton
					frame.notebookStyle:| wxAUI_NB_CLOSE_BUTTON
				Case ID_NotebookCloseButtonAll
					frame.notebookStyle:| wxAUI_NB_CLOSE_ON_ALL_TABS
				Case ID_NotebookCloseButtonActive
					frame.notebookStyle:| wxAUI_NB_CLOSE_ON_ACTIVE_TAB
			End Select
		End If
    
		Select id
			Case ID_NotebookAllowTabMove
				frame.notebookStyle:~ wxAUI_NB_TAB_MOVE
			Case ID_NotebookAllowTabExternalMove
				frame.notebookStyle:~ wxAUI_NB_TAB_EXTERNAL_MOVE
			Case ID_NotebookAllowTabSplit
				frame.notebookStyle:~ wxAUI_NB_TAB_SPLIT
			Case ID_NotebookWindowList
				frame.notebookStyle:~ wxAUI_NB_WINDOWLIST_BUTTON
			Case ID_NotebookScrollButtons
				frame.notebookStyle:~ wxAUI_NB_SCROLL_BUTTONS
			Case ID_NotebookTabFixedWidth
				frame.notebookStyle:~ wxAUI_NB_TAB_FIXED_WIDTH
		End Select

Rem
    size_t i, count;
    wxAuiPaneInfoArray& all_panes = m_mgr.GetAllPanes();
    For (i = 0, count = all_panes.GetCount(); i < count; ++i)
    {  
        wxAuiPaneInfo& pane = all_panes.Item(i);
        If (pane.window->IsKindOf(CLASSINFO(wxAuiNotebook)))
        {
            wxAuiNotebook* nb = (wxAuiNotebook*)pane.window;
            
            If (id == ID_NotebookArtGloss)
            {
                nb->SetArtProvider(New wxAuiDefaultTabArt);
                m_notebook_theme = 0;
            }
             Else If (id == ID_NotebookArtSimple)
            {
                nb->SetArtProvider(New wxAuiSimpleTabArt);
                m_notebook_theme = 1;
            }
        
        
            nb->SetWindowStyleFlag(m_notebook_style);
            nb->Refresh();
        }
    }
End Rem
	
	End Function

	Function OnGradient(event:wxEvent)
	
		Local gradient:Int = 0	
	
		Select event.GetId()
			Case ID_NoGradient
				gradient = wxAUI_GRADIENT_NONE
			Case ID_VerticalGradient
				gradient = wxAUI_GRADIENT_VERTICAL
			Case ID_HorizontalGradient
				gradient = wxAUI_GRADIENT_HORIZONTAL
		End Select
	
		Local manager:wxAuiManager = MyFrame(event.parent).manager
		manager.GetArtProvider().SetMetric(wxAUI_DOCKART_GRADIENT_TYPE, gradient)
		manager.Update()
	
	End Function

	Function OnChangeContentPane(event:wxEvent)
	End Function

	Function OnSettings(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
	
		' show the settings pane, and float it
		Local floatingPane:wxAuiPaneInfo = frame.manager.GetPane("settings").FloatPane().Show()
		
		Local x:Int, y:Int
		floatingPane.GetFloatingPosition(x, y)
		
		If x = -1 And y = -1 Then
			frame.GetStartPosition(x, y)
			floatingPane.FloatingPosition(x, y)
		End If

		frame.manager.Update()
	
	End Function

	Function OnExit(event:wxEvent)
		wxFrame(event.parent).Close(True)
	End Function

	Function OnAbout(event:wxEvent)
	
		wxMessageBox("wxAUI Demo~nAn advanced window management library for wxWidgets~n" + ..
			"(c) Copyright 2005-2006, Kirix Corporation~n" + ..
			"BlitzMax Port (c) 2007-2013 Bruce A Henderson", ..
			"About wxAUI Demo", wxOK, wxWindow(event.parent))
	
	End Function

	Function OnUpdateUI(evt:wxEvent)

		Local event:wxUpdateUIEvent = wxUpdateUIEvent(evt)
		Local manager:wxAuiManager = MyFrame(event.parent).manager
		Local flags:Int = manager.GetFlags()
		Local notebookStyle:Int = MyFrame(event.parent).notebookStyle

		Select event.GetId()
			Case ID_NoGradient
				event.Check(manager.GetArtProvider().GetMetric(wxAUI_DOCKART_GRADIENT_TYPE) = wxAUI_GRADIENT_NONE)
			
			Case ID_VerticalGradient
				event.Check(manager.GetArtProvider().GetMetric(wxAUI_DOCKART_GRADIENT_TYPE) = wxAUI_GRADIENT_VERTICAL)
			
			Case ID_HorizontalGradient
				event.Check(manager.GetArtProvider().GetMetric(wxAUI_DOCKART_GRADIENT_TYPE) = wxAUI_GRADIENT_HORIZONTAL)
			
			Case ID_AllowFloating
				event.Check((flags & wxAUI_MGR_ALLOW_FLOATING) <> 0)
			
			Case ID_TransparentDrag
				event.Check((flags & wxAUI_MGR_TRANSPARENT_DRAG) <> 0)
			
			Case ID_TransparentHint
				event.Check((flags & wxAUI_MGR_TRANSPARENT_HINT) <> 0)
			
			Case ID_VenetianBlindsHint
				event.Check((flags & wxAUI_MGR_VENETIAN_BLINDS_HINT) <> 0)
			
			Case ID_RectangleHint
				event.Check((flags & wxAUI_MGR_RECTANGLE_HINT) <> 0)
			
			Case ID_NoHint
				event.Check(((wxAUI_MGR_TRANSPARENT_HINT | wxAUI_MGR_VENETIAN_BLINDS_HINT | ..
			             wxAUI_MGR_RECTANGLE_HINT) & flags) = 0)
			
			Case ID_HintFade
				event.Check((flags & wxAUI_MGR_HINT_FADE) <> 0)
			
			Case ID_NoVenetianFade
				event.Check((flags & wxAUI_MGR_NO_VENETIAN_BLINDS_FADE) <> 0)
			
			Case ID_NotebookNoCloseButton
				event.Check((notebookStyle & (wxAUI_NB_CLOSE_BUTTON | wxAUI_NB_CLOSE_ON_ALL_TABS | wxAUI_NB_CLOSE_ON_ACTIVE_TAB)) <> 0)
			
			Case ID_NotebookCloseButton
				event.Check((notebookStyle & wxAUI_NB_CLOSE_BUTTON) <> 0)
			
			Case ID_NotebookCloseButtonAll
				event.Check((notebookStyle & wxAUI_NB_CLOSE_ON_ALL_TABS) <> 0)
			
			Case ID_NotebookCloseButtonActive
				event.Check((notebookStyle & wxAUI_NB_CLOSE_ON_ACTIVE_TAB) <> 0)
			
			Case ID_NotebookAllowTabSplit
				event.Check((notebookStyle & wxAUI_NB_TAB_SPLIT) <> 0)
		
			Case ID_NotebookAllowTabMove
				event.Check((notebookStyle & wxAUI_NB_TAB_MOVE) <> 0)
			
			Case ID_NotebookAllowTabExternalMove
				event.Check((notebookStyle & wxAUI_NB_TAB_EXTERNAL_MOVE) <> 0)
			
			Case ID_NotebookScrollButtons
				event.Check((notebookStyle & wxAUI_NB_SCROLL_BUTTONS) <> 0)
			
			Case ID_NotebookWindowList
				event.Check((notebookStyle & wxAUI_NB_WINDOWLIST_BUTTON) <> 0)
			
			Case ID_NotebookTabFixedWidth
				event.Check((notebookStyle & wxAUI_NB_TAB_FIXED_WIDTH) <> 0)
			
			Case ID_NotebookArtGloss
				event.Check(notebookStyle = 0)
			
			Case ID_NotebookArtSimple
				event.Check(notebookStyle = 1)
		
		End Select

	End Function
	
	Function OnPaneClose(event:wxEvent)
	
		If wxAuiManagerEvent(event).GetPane().GetName() = "test10" Then
		
			Local res:Int = wxMessageBox("Are you sure you want to close/hide this pane?", "wxAUI", wxYES_NO, wxWindow(event.parent))
		
			If res <> wxYES Then
				wxAuiManagerEvent(event).Veto()
			End If
			
		End If
		
	End Function

	Method GetStartPosition(x:Int Var, y:Int Var)
		Global n:Int
		n:+ 20
		
		ClientToScreen(x, y)
		
		x:+ n
		y:+ n
	End Method
	
	Method GetDockArt:wxAuiDockArt()
	    Return manager.GetArtProvider()
	End Method
	
	Method DoUpdate()
		manager.Update()
	End Method

	Method GetIntroText:String()
		Local text:String = ..
			"<html><body>" + ..
			"<h3>Welcome to wxAUI</h3>" + ..
			"<br/><b>Overview</b><br/>" + ..
			"<p>wxAUI is an Advanced User Interface library for the wxWidgets toolkit " + ..
			"that allows developers to create high-quality, cross-platform user " + ..
			"interfaces quickly and easily.</p>" + ..
			"<p><b>Features</b></p>" + ..
			"<p>With wxAUI, developers can create application frameworks with:</p>" + ..
			"<ul>" + ..
			"<li>Native, dockable floating frames</li>" + ..
			"<li>Perspective saving and loading</li>" + ..
			"<li>Native toolbars incorporating real-time, &quot;spring-loaded&quot; dragging</li>" + ..
			"<li>Customizable floating/docking behavior</li>" + ..
			"<li>Completely customizable look-and-feel</li>" + ..
			"<li>Optional transparent window effects (while dragging or docking)</li>" + ..
			"<li>Splittable notebook control</li>" + ..
			"</ul>" + ..
			"<p><b>What's new in 0.9.3?</b></p>" + ..
			"<p>wxAUI 0.9.3, which is now bundled with wxWidgets, adds the following features:" + ..
			"<ul>" + ..
			"<li>New wxAuiNotebook class, a dynamic splittable notebook control</li>" + ..
			"<li>New wxAuiMDI* classes, a tab-based MDI and drop-in replacement for classic MDI</li>" + ..
			"<li>Maximize/Restore buttons implemented</li>" + ..
			"<li>Better hinting with wxGTK</li>" + ..
			"<li>Class rename.  'wxAui' is now the standard class prefix for all wxAUI classes</li>" + ..
			"<li>Lots of bug fixes</li>" + ..
			"</ul>" + ..
			"<p><b>What's new in 0.9.2?</b></p>" + ..
			"<p>The following features/fixes have been added since the last version of wxAUI:</p>" + ..
			"<ul>" + ..
			"<li>Support for wxMac</li>" + ..
			"<li>Updates for wxWidgets 2.6.3</li>" + ..
			"<li>Fix to pass more unused events through</li>" + ..
			"<li>Fix to allow floating windows to receive idle events</li>" + ..
			"<li>Fix for minimizing/maximizing problem with transparent hint pane</li>" + ..
			"<li>Fix to not paint empty hint rectangles</li>" + ..
			"<li>Fix for 64-bit compilation</li>" + ..
			"</ul>" + ..
			"<p><b>What changed in 0.9.1?</b></p>" + ..
			"<p>The following features/fixes were added in wxAUI 0.9.1:</p>" + ..
			"<ul>" + ..
			"<li>Support for MDI frames</li>" + ..
			"<li>Gradient captions option</li>" + ..
			"<li>Active/Inactive panes option</li>" + ..
			"<li>Fix for screen artifacts/paint problems</li>" + ..
			"<li>Fix for hiding/showing floated window problem</li>" + ..
			"<li>Fix for floating pane sizing problem</li>" + ..
			"<li>Fix for drop position problem when dragging around center pane margins</li>" + ..
			"<li>LF-only text file formatting for source code</li>" + ..
			"</ul>" + ..
			"<p>See README.txt for more information.</p>" + ..
			"</body></html>"
		
		Return text
	End Method

End Type

Type SettingsPanel Extends wxPanel

	Const ID_PaneBorderSize:Int = wxID_HIGHEST + 1
	Const ID_SashSize:Int = wxID_HIGHEST + 2
	Const ID_CaptionSize:Int = wxID_HIGHEST + 3
	Const ID_BackgroundColor:Int = wxID_HIGHEST + 4
	Const ID_SashColor:Int = wxID_HIGHEST + 5
	Const ID_InactiveCaptionColor:Int = wxID_HIGHEST + 6
	Const ID_InactiveCaptionGradientColor:Int = wxID_HIGHEST + 7
	Const ID_InactiveCaptionTextColor:Int = wxID_HIGHEST + 8
	Const ID_ActiveCaptionColor:Int = wxID_HIGHEST + 9
	Const ID_ActiveCaptionGradientColor:Int = wxID_HIGHEST + 10
	Const ID_ActiveCaptionTextColor:Int = wxID_HIGHEST + 11
	Const ID_BorderColor:Int = wxID_HIGHEST + 12
	Const ID_GripperColor:Int = wxID_HIGHEST + 13

	Field frame:MyFrame
	Field borderSize:wxSpinCtrl
	Field sashSize:wxSpinCtrl
	Field captionSize:wxSpinCtrl
	Field inactiveCaptionTextColor:wxBitmapButton
	Field inactiveCaptionGradientColor:wxBitmapButton
	Field inactiveCaptionColor:wxBitmapButton
	Field activeCaptionTextColor:wxBitmapButton
	Field activeCaptionGradientColor:wxBitmapButton
	Field activeCaptionColor:wxBitmapButton
	Field sashColor:wxBitmapButton
	Field backgroundColor:wxBitmapButton
	Field borderColor:wxBitmapButton
	Field gripperColor:wxBitmapButton

	Method CreateSettingsPanel:SettingsPanel(parent:wxWindow, _frame:MyFrame)
		frame = _frame
		Create(parent)
		Return Self
	End Method
	
	Method OnInit()

		Connect(ID_PaneBorderSize,  wxEVT_COMMAND_SPINCTRL_UPDATED, OnPaneBorderSize)
		Connect(ID_SashSize,  wxEVT_COMMAND_SPINCTRL_UPDATED, OnSashSize)
		Connect(ID_CaptionSize,  wxEVT_COMMAND_SPINCTRL_UPDATED, OnCaptionSize)
		Connect(ID_BackgroundColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_SashColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_InactiveCaptionColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_InactiveCaptionGradientColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_InactiveCaptionTextColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_ActiveCaptionColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_ActiveCaptionGradientColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_ActiveCaptionTextColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_BorderColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)
		Connect(ID_GripperColor,  wxEVT_COMMAND_BUTTON_CLICKED, OnSetColor)

		Local s1:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		borderSize = New wxSpinCtrl.Create(Self, ID_PaneBorderSize, frame.GetDockArt().GetMetric(wxAUI_DOCKART_PANE_BORDER_SIZE), -1, -1, 50, 20, wxSP_ARROW_KEYS, 0, 100, frame.GetDockArt().GetMetric(wxAUI_DOCKART_PANE_BORDER_SIZE))
		s1.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s1.Add(New wxStaticText.Create(Self, wxID_ANY, "Pane Border Size:"))
		s1.Add(borderSize)
		s1.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s1.SetItemMinSize(1, 180, 20)

		Local s2:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		sashSize = New wxSpinCtrl.Create(Self, ID_SashSize, frame.GetDockArt().GetMetric(wxAUI_DOCKART_SASH_SIZE), -1, -1, 50, 20, wxSP_ARROW_KEYS, 0, 100, frame.GetDockArt().GetMetric(wxAUI_DOCKART_SASH_SIZE))
		s2.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s2.Add(New wxStaticText.Create(Self, wxID_ANY, "Sash Size:"))
		s2.Add(sashSize)
		s2.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s2.SetItemMinSize(1, 180, 20)
		
		Local s3:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		captionSize = New wxSpinCtrl.Create(Self, ID_CaptionSize, frame.GetDockArt().GetMetric(wxAUI_DOCKART_CAPTION_SIZE), -1, -1, 50, 20, wxSP_ARROW_KEYS, 0, 100, frame.GetDockArt().GetMetric(wxAUI_DOCKART_CAPTION_SIZE))
		s3.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s3.Add(New wxStaticText.Create(Self, wxID_ANY, "Caption Size:"))
		s3.Add(captionSize)
		s3.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s3.SetItemMinSize(1, 180, 20)

		Local b:wxBitmap = CreateColorBitmap(wxBLACK())
		
		Local s4:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		backgroundColor = New wxBitmapButton.Create(Self, ID_BackgroundColor, b, -1, -1, 50, 25)
		s4.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s4.Add(New wxStaticText.Create(Self, wxID_ANY, "Background Color:"))
		s4.Add(backgroundColor)
		s4.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s4.SetItemMinSize(1, 180, 20)

		Local s5:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		sashColor = New wxBitmapButton.Create(Self, ID_SashColor, b, -1, -1, 50,25)
		s5.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s5.Add(New wxStaticText.Create(Self, wxID_ANY, "Sash Color:"))
		s5.Add(sashColor)
		s5.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s5.SetItemMinSize(1, 180, 20)
		
		Local s6:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		inactiveCaptionColor = New wxBitmapButton.Create(Self, ID_InactiveCaptionColor, b, -1, -1, 50,25)
		s6.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s6.Add(New wxStaticText.Create(Self, wxID_ANY, "Normal Caption:"))
		s6.Add(inactiveCaptionColor)
		s6.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s6.SetItemMinSize(1, 180, 20)
		
		Local s7:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		inactiveCaptionGradientColor = New wxBitmapButton.Create(Self, ID_InactiveCaptionGradientColor, b, -1, -1, 50,25)
		s7.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s7.Add(New wxStaticText.Create(Self, wxID_ANY, "Normal Caption Gradient:"))
		s7.Add(inactiveCaptionGradientColor)
		s7.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s7.SetItemMinSize(1, 180, 20)
		
		Local s8:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		inactiveCaptionTextColor = New wxBitmapButton.Create(Self, ID_InactiveCaptionTextColor, b, -1, -1, 50,25)
		s8.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s8.Add(New wxStaticText.Create(Self, wxID_ANY, "Normal Caption Text:"))
		s8.Add(inactiveCaptionTextColor)
		s8.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s8.SetItemMinSize(1, 180, 20)
		
		Local s9:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		activeCaptionColor = New wxBitmapButton.Create(Self, ID_ActiveCaptionColor, b, -1, -1, 50,25)
		s9.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s9.Add(New wxStaticText.Create(Self, wxID_ANY, "Active Caption:"))
		s9.Add(activeCaptionColor)
		s9.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s9.SetItemMinSize(1, 180, 20)
		
		Local s10:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		activeCaptionGradientColor = New wxBitmapButton.Create(Self, ID_ActiveCaptionGradientColor, b, -1, -1, 50,25)
		s10.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s10.Add(New wxStaticText.Create(Self, wxID_ANY, "Active Caption Gradient:"))
		s10.Add(activeCaptionGradientColor)
		s10.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s10.SetItemMinSize(1, 180, 20)
		
		Local s11:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		activeCaptionTextColor = New wxBitmapButton.Create(Self, ID_ActiveCaptionTextColor, b, -1, -1, 50,25)
		s11.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s11.Add(New wxStaticText.Create(Self, wxID_ANY, "Active Caption Text:"))
		s11.Add(activeCaptionTextColor)
		s11.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s11.SetItemMinSize(1, 180, 20)
		
		Local s12:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		borderColor = New wxBitmapButton.Create(Self, ID_BorderColor, b, -1, -1, 50,25)
		s12.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s12.Add(New wxStaticText.Create(Self, wxID_ANY, "Border Color:"))
		s12.Add(borderColor)
		s12.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s12.SetItemMinSize(1, 180, 20)
		
		Local s13:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		gripperColor = New wxBitmapButton.Create(Self, ID_GripperColor, b, -1, -1, 50,25)
		s13.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s13.Add(New wxStaticText.Create(Self, wxID_ANY, "Gripper Color:"))
		s13.Add(gripperColor)
		s13.AddCustomSpacer(1, 1, 1, wxEXPAND)
		s13.SetItemMinSize(1, 180, 20)
		
		Local gridSizer:wxGridSizer = New wxGridSizer.Create(2)
		gridSizer.SetHGap(5)
		gridSizer.AddSizer(s1)
		gridSizer.AddSizer(s4)
		gridSizer.AddSizer(s2)
		gridSizer.AddSizer(s5)
		gridSizer.AddSizer(s3)
		gridSizer.AddSizer(s13)
		gridSizer.AddCustomSpacer(1,1)
		gridSizer.AddSizer(s12)
		gridSizer.AddSizer(s6)
		gridSizer.AddSizer(s9)
		gridSizer.AddSizer(s7)
		gridSizer.AddSizer(s10)
		gridSizer.AddSizer(s8)
		gridSizer.AddSizer(s11)

		Local contSizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		contSizer.AddSizer(gridSizer, 1, wxEXPAND | wxALL, 5)
		SetSizer(contSizer)
		GetSizer().SetSizeHints(Self)

		UpdateColors()
	End Method
	
	Method CreateColorBitmap:wxBitmap(c:wxColour)

		Local image:wxImage = wxImage.CreateEmptyImage(25, 14)
		For Local x:Int = 0 Until 25
			For Local y:Int = 0 Until 14
				Local pixcol:wxColour = c
				If x = 0 Or x = 24 Or y = 0 Or y = 13 Then
					pixcol = wxBLACK()
				End If
				image.SetRGB(x, y, pixcol.Red(), pixcol.Green(), pixcol.Blue())
			Next
		Next

		Return New wxBitmap.CreateFromImage(image)
	End Method

	Method UpdateColors()
	
		Local bk:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_BACKGROUND_COLOUR)
		backgroundColor.SetBitmapLabel(CreateColorBitmap(bk))
		
		Local cap:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_INACTIVE_CAPTION_COLOUR)
		inactiveCaptionColor.SetBitmapLabel(CreateColorBitmap(cap))
		
		Local capgrad:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_INACTIVE_CAPTION_GRADIENT_COLOUR)
		inactiveCaptionGradientColor.SetBitmapLabel(CreateColorBitmap(capgrad))
		
		Local captxt:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_INACTIVE_CAPTION_TEXT_COLOUR)
		inactiveCaptionTextColor.SetBitmapLabel(CreateColorBitmap(captxt))
		
		Local acap:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_ACTIVE_CAPTION_COLOUR)
		activeCaptionColor.SetBitmapLabel(CreateColorBitmap(acap))
		
		Local acapgrad:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_ACTIVE_CAPTION_GRADIENT_COLOUR)
		activeCaptionGradientColor.SetBitmapLabel(CreateColorBitmap(acapgrad))
		
		Local acaptxt:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_ACTIVE_CAPTION_TEXT_COLOUR)
		activeCaptionTextColor.SetBitmapLabel(CreateColorBitmap(acaptxt))
		
		Local sash:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_SASH_COLOUR)
		sashColor.SetBitmapLabel(CreateColorBitmap(sash))
		
		Local border:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_BORDER_COLOUR)
		borderColor.SetBitmapLabel(CreateColorBitmap(border))
		
		Local gripper:wxColour = frame.GetDockArt().GetColor(wxAUI_DOCKART_GRIPPER_COLOUR)
		gripperColor.SetBitmapLabel(CreateColorBitmap(gripper))
	End Method

	Function OnPaneBorderSize(event:wxEvent)
		Local frame:MyFrame = SettingsPanel(event.parent).frame
		frame.GetDockArt().SetMetric(wxAUI_DOCKART_PANE_BORDER_SIZE, wxSpinEvent(event).GetPosition())
		frame.DoUpdate()
	End Function

	Function OnSashSize(event:wxEvent)
		Local frame:MyFrame = SettingsPanel(event.parent).frame
		frame.GetDockArt().SetMetric(wxAUI_DOCKART_SASH_SIZE, wxSpinEvent(event).GetPosition())
		frame.DoUpdate()
	End Function

	Function OnCaptionSize(event:wxEvent)
		Local frame:MyFrame = SettingsPanel(event.parent).frame
		frame.GetDockArt().SetMetric(wxAUI_DOCKART_CAPTION_SIZE, wxSpinEvent(event).GetPosition())
		frame.DoUpdate()
	End Function
	
	Function OnSetColor(event:wxEvent)
		Local frame:MyFrame = SettingsPanel(event.parent).frame
	
		Local v:Int
		
		Select event.GetId()
			Case ID_BackgroundColor
				v = wxAUI_DOCKART_BACKGROUND_COLOUR
			Case ID_SashColor
				v = wxAUI_DOCKART_SASH_COLOUR
			Case ID_InactiveCaptionColor
				v = wxAUI_DOCKART_INACTIVE_CAPTION_COLOUR
			Case ID_InactiveCaptionGradientColor
				v = wxAUI_DOCKART_INACTIVE_CAPTION_GRADIENT_COLOUR
			Case ID_InactiveCaptionTextColor
				v = wxAUI_DOCKART_INACTIVE_CAPTION_TEXT_COLOUR
			Case ID_ActiveCaptionColor
				v = wxAUI_DOCKART_ACTIVE_CAPTION_COLOUR
			Case ID_ActiveCaptionGradientColor
				v = wxAUI_DOCKART_ACTIVE_CAPTION_GRADIENT_COLOUR
			Case ID_ActiveCaptionTextColor
				v = wxAUI_DOCKART_ACTIVE_CAPTION_TEXT_COLOUR
			Case ID_BorderColor
				v = wxAUI_DOCKART_BORDER_COLOUR
			Case ID_GripperColor
				v = wxAUI_DOCKART_GRIPPER_COLOUR
			Default
				Return
		End Select

		Local newColour:wxColour = wxGetColourFromUser(frame, frame.GetDockArt().GetColor(v), "Color Picker")

		If newColour.isOk() Then
			frame.GetDockArt().SetColor(v, newColour)
			frame.DoUpdate()
			SettingsPanel(event.parent).UpdateColors()
		End If
	End Function

End Type


New MyApp.run()

