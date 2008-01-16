'
' BlitzMax code generated with wxCodeGen v0.85 : 16 Jan 2008 13:18:24
' 
' 
' PLEASE DO "NOT" EDIT THIS FILE!
' 
SuperStrict

Import wx.wxButton
Import wx.wxCheckBox
Import wx.wxFilePickerCtrl
Import wx.wxFrame
Import wx.wxListBox
Import wx.wxLocale
Import wx.wxMenu
Import wx.wxMenuBar
Import wx.wxNotebook
Import wx.wxPanel
Import wx.wxRadioBox
Import wx.wxStaticBoxSizer
Import wx.wxStaticText
Import wx.wxStatusBar
Import wx.wxTextCtrl
Import wx.wxWindow


Type CodeGenFrameBase Extends wxFrame

	Field m_panel1:wxPanel
	Field m_staticText1:wxStaticText
	Field lstProjects:wxListBox
	Field btnAddProject:wxButton
	Field btnDeleteProject:wxButton
	Field ntbMain:wxNotebook
	Field pnlProject:wxPanel
	Field m_staticText6:wxStaticText
	Field txtProjectName:wxTextCtrl
	Field m_staticText2:wxStaticText
	Field fpkProjectFile:wxFilePickerCtrl
	Field m_staticText3:wxStaticText
	Field dpkProjectFolder:wxDirPickerCtrl
	Field m_staticText4:wxStaticText
	Field txtGenFilename:wxTextCtrl
	Field m_staticText5:wxStaticText
	Field cbSuperStrict:wxCheckBox
	Field cbImports:wxCheckBox
	Field cbAutoGenerate:wxCheckBox
	Field pnlCode:wxPanel
	Field txtAppCode:wxTextCtrl
	Field pnlPrefs:wxPanel
	Field cbProjectUpdates:wxCheckBox
	Field rbLocale:wxRadioBox
	Field btnLanguage:wxButton
	Field btnGenerate:wxButton
	Field sbStatus:wxStatusBar
	Field m_menubar1:wxMenuBar
	Field m_menu1:wxMenu
	Field m_menu2:wxMenu

	Const ID_NEW_PROJECT:Int = 1000

	Method Create:CodeGenFrameBase(parent:wxWindow = Null,id:Int = wxID_ANY, title:String = "wxCodeGen", x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxCAPTION|wxCLOSE_BOX|wxMINIMIZE_BOX|wxSYSTEM_MENU|wxTAB_TRAVERSAL)
		return CodeGenFrameBase(Super.Create(parent, id, title, x, y, w, h, style))
	End Method

	Method OnInit()

		Local bSizer1:wxBoxSizer
		bSizer1 = new wxBoxSizer.Create(wxVERTICAL)
		bSizer1.SetMinSize(700,400)
		m_panel1 = new wxPanel.Create(Self, wxID_ANY,,,,, wxTAB_TRAVERSAL)

		Local bSizer2:wxBoxSizer
		bSizer2 = new wxBoxSizer.Create(wxHORIZONTAL)

		Local bSizer7:wxBoxSizer
		bSizer7 = new wxBoxSizer.Create(wxVERTICAL)
		m_staticText1 = new wxStaticText.Create(m_panel1, wxID_ANY, _("Projects"))
		m_staticText1.Wrap(-1)
		m_staticText1.SetFont(new wxFont.CreateWithAttribs(wxNORMAL_FONT().GetPointSize(), 70, 90, 92, False))
		bSizer7.Add(m_staticText1, 0, wxEXPAND|wxLEFT|wxTOP, 5)

		lstProjects = new wxListBox.Create(m_panel1, wxID_ANY, Null,,,,, wxLB_NEEDED_SB|wxLB_SINGLE)

		bSizer7.Add(lstProjects, 1, wxALL|wxEXPAND, 5)


		Local bSizer13:wxBoxSizer
		bSizer13 = new wxBoxSizer.Create(wxHORIZONTAL)
		btnAddProject = new wxButton.Create(m_panel1, wxID_ANY, _("Add"))
		bSizer13.Add(btnAddProject, 0, wxALL, 5)

		btnDeleteProject = new wxButton.Create(m_panel1, wxID_ANY, _("Delete"))
		btnDeleteProject.Enable(False)
		bSizer13.Add(btnDeleteProject, 0, wxALL, 5)

		bSizer7.AddSizer(bSizer13, 0, wxEXPAND, 5)

		bSizer2.AddSizer(bSizer7, 0, wxEXPAND, 5)


		Local bSizer3:wxBoxSizer
		bSizer3 = new wxBoxSizer.Create(wxVERTICAL)
		ntbMain = new wxNotebook.Create(m_panel1, wxID_ANY)
		pnlProject = new wxPanel.Create(ntbMain, wxID_ANY,,,,, wxTAB_TRAVERSAL)
		pnlProject.Enable(False)

		Local bSizer5:wxBoxSizer
		bSizer5 = new wxBoxSizer.Create(wxVERTICAL)

		Local fgSizer1:wxFlexGridSizer
		fgSizer1 = new wxFlexGridSizer.CreateRC(4, 2, 0, 0)
		fgSizer1.AddGrowableCol( 1 )
		fgSizer1.SetFlexibleDirection( wxBOTH )
		fgSizer1.SetNonFlexibleGrowMode( wxFLEX_GROWMODE_SPECIFIED )
		m_staticText6 = new wxStaticText.Create(pnlProject, wxID_ANY, _("Project Name"))
		m_staticText6.Wrap(-1)
		fgSizer1.Add(m_staticText6, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5)

		txtProjectName = new wxTextCtrl.Create(pnlProject, wxID_ANY, "")
		txtProjectName.SetMaxLength(0)
		txtProjectName.Enable(False)
		fgSizer1.Add(txtProjectName, 1, wxALL|wxEXPAND, 5)

		m_staticText2 = new wxStaticText.Create(pnlProject, wxID_ANY, _("wxFormBuilder Project File"))
		m_staticText2.Wrap(-1)
		fgSizer1.Add(m_staticText2, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5)

		fpkProjectFile = new wxFilePickerCtrl.Create(pnlProject, wxID_ANY, "", _("Select a wxFormbuilder Project File"), _("*.*"),,,,, wxFLP_DEFAULT_STYLE)
		fpkProjectFile.Enable(False)

		fgSizer1.Add(fpkProjectFile, 1, wxALL|wxEXPAND, 5)

		m_staticText3 = new wxStaticText.Create(pnlProject, wxID_ANY, _("BMX Project Folder"))
		m_staticText3.Wrap(-1)
		fgSizer1.Add(m_staticText3, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5)

		dpkProjectFolder = new wxDirPickerCtrl.Create(pnlProject, wxID_ANY, "", _("Select the BlitzMax Project folder"),,,,, wxDIRP_DEFAULT_STYLE)
		dpkProjectFolder.Enable(False)

		fgSizer1.Add(dpkProjectFolder, 1, wxALL|wxEXPAND, 5)

		m_staticText4 = new wxStaticText.Create(pnlProject, wxID_ANY, _("Generated Filename"))
		m_staticText4.Wrap(-1)
		fgSizer1.Add(m_staticText4, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5)


		Local bSizer12:wxBoxSizer
		bSizer12 = new wxBoxSizer.Create(wxHORIZONTAL)
		txtGenFilename = new wxTextCtrl.Create(pnlProject, wxID_ANY, "")
		txtGenFilename.SetMaxLength(0)
		txtGenFilename.Enable(False)
		bSizer12.Add(txtGenFilename, 1, wxALL, 5)

		m_staticText5 = new wxStaticText.Create(pnlProject, wxID_ANY, _(".bmx"))
		m_staticText5.Wrap(-1)
		bSizer12.Add(m_staticText5, 0, wxALIGN_CENTER|wxALL, 5)

		fgSizer1.AddSizer(bSizer12, 0, wxEXPAND, 5)

		bSizer5.AddSizer(fgSizer1, 0, wxEXPAND, 5)


		Local sbSizer1:wxStaticBoxSizer
		sbSizer1 = new wxStaticBoxSizer.CreateSizerWithBox( new wxStaticBox.Create(pnlProject, wxID_ANY, _("App Structure")), wxVERTICAL)
		cbSuperStrict = new wxCheckBox.Create(pnlProject, wxID_ANY, _("Create SuperStrict"))
		sbSizer1.Add(cbSuperStrict, 0, wxALL, 5)

		cbImports = new wxCheckBox.Create(pnlProject, wxID_ANY, _("Create Import statements"))
		sbSizer1.Add(cbImports, 0, wxALL, 5)

		bSizer5.AddSizer(sbSizer1, 0, wxALL|wxEXPAND, 5)

		cbAutoGenerate = new wxCheckBox.Create(pnlProject, wxID_ANY, _("Auto-Generate Code on Update"))
		bSizer5.Add(cbAutoGenerate, 0, wxALL, 5)

		pnlProject.SetSizer(bSizer5)
		pnlProject.Layout()
		ntbMain.AddPage(pnlProject, _("Project Config"), True)

		pnlCode = new wxPanel.Create(ntbMain, wxID_ANY,,,,, wxTAB_TRAVERSAL)
		pnlCode.Enable(False)

		Local bSizer6:wxBoxSizer
		bSizer6 = new wxBoxSizer.Create(wxVERTICAL)
		txtAppCode = new wxTextCtrl.Create(pnlCode, wxID_ANY, "",,,,, wxTE_DONTWRAP|wxTE_MULTILINE|wxTE_READONLY)
		txtAppCode.SetMaxLength(0)
		txtAppCode.SetFont(new wxFont.CreateWithAttribs(wxNORMAL_FONT().GetPointSize(), 76, 90, 90, False))
		bSizer6.Add(txtAppCode, 1, wxALL|wxEXPAND, 5)

		pnlCode.SetSizer(bSizer6)
		pnlCode.Layout()
		ntbMain.AddPage(pnlCode, _("Application Code"), False)

		pnlPrefs = new wxPanel.Create(ntbMain, wxID_ANY,,,,, wxTAB_TRAVERSAL)

		Local bSizer10:wxBoxSizer
		bSizer10 = new wxBoxSizer.Create(wxVERTICAL)
		cbProjectUpdates = new wxCheckBox.Create(pnlPrefs, wxID_ANY, _("Check for Project File Updates"))
		cbProjectUpdates.SetToolTip(_("Monitors the project files for changes."))
		bSizer10.Add(cbProjectUpdates, 0, wxALL, 5)

		Local rbLocaleChoices:String[] = [ "None", "wxLocale", "BaH.Locale" ]
		rbLocale = new wxRadioBox.Create(pnlPrefs, wxID_ANY, _("String Localization"),,,,, rbLocaleChoices, 1, wxRA_SPECIFY_COLS)
		bSizer10.Add(rbLocale, 0, wxALL, 5)

		btnLanguage = new wxButton.Create(pnlPrefs, wxID_ANY, _("wxCodeGen Language"))
		bSizer10.Add(btnLanguage, 0, wxALL, 5)

		pnlPrefs.SetSizer(bSizer10)
		pnlPrefs.Layout()
		ntbMain.AddPage(pnlPrefs, _("Global Preferences"), False)


		bSizer3.Add(ntbMain, 1, wxEXPAND | wxALL, 5)


		Local bSizer4:wxBoxSizer
		bSizer4 = new wxBoxSizer.Create(wxHORIZONTAL)
		btnGenerate = new wxButton.Create(m_panel1, wxID_ANY, _("Generate"))
		btnGenerate.Enable(False)
		bSizer4.Add(btnGenerate, 0, wxALL, 5)

		bSizer3.AddSizer(bSizer4, 0, wxALIGN_RIGHT, 5)

		bSizer2.AddSizer(bSizer3, 1, wxEXPAND, 5)

		m_panel1.SetSizer(bSizer2)
		m_panel1.Layout()
		bSizer1.Add(m_panel1, 1, wxEXPAND | wxALL, 0)

		sbStatus = Self.CreateStatusBar(2, 0, wxID_ANY)

		m_menubar1 = new wxMenuBar.Create()

		m_menu1 = new wxMenu.Create()

		Local m_menuItem2:wxMenuItem
		m_menuItem2 = new wxMenuItem.Create(m_menu1, ID_NEW_PROJECT, _("&New Project") + "	CTRL-N", "", wxITEM_NORMAL)
		m_menu1.AppendItem(m_menuItem2)

		m_menu1.AppendSeparator()

		Local m_menuItem3:wxMenuItem
		m_menuItem3 = new wxMenuItem.Create(m_menu1, wxID_EXIT, _("&Quit") + "	CTRL-Q", "", wxITEM_NORMAL)
		m_menu1.AppendItem(m_menuItem3)
		m_menubar1.Append(m_menu1, _("File"))

		m_menu2 = new wxMenu.Create()

		Local m_menuItem1:wxMenuItem
		m_menuItem1 = new wxMenuItem.Create(m_menu2, wxID_ABOUT, _("&About"), "", wxITEM_NORMAL)
		m_menu2.AppendItem(m_menuItem1)
		m_menubar1.Append(m_menu2, _("&Help"))
		SetMenuBar(m_menubar1)

		SetSizer(bSizer1)
		Layout()
		bSizer1.Fit(Self)
		Center(wxBOTH)

		ConnectAny(wxEVT_CLOSE_WINDOW, _OnClose)
		lstProjects.ConnectAny(wxEVT_COMMAND_LISTBOX_SELECTED, _OnSelectItem, Null, Self)
		btnAddProject.ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, _OnAddProject, Null, Self)
		btnDeleteProject.ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, _OnDeleteProject, Null, Self)
		txtProjectName.ConnectAny(wxEVT_KILL_FOCUS, _OnProjectNameLostFocus, Null, Self)
		fpkProjectFile.ConnectAny(wxEVT_COMMAND_FILEPICKER_CHANGED, _OnProjectFileChange, Null, Self)
		dpkProjectFolder.ConnectAny(wxEVT_COMMAND_DIRPICKER_CHANGED, _OnBMXFolderChange, Null, Self)
		txtGenFilename.ConnectAny(wxEVT_KILL_FOCUS, _OnGenNameLostFocus, Null, Self)
		cbSuperStrict.ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, _OnSuperStrictChecked, Null, Self)
		cbImports.ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, _OnImportsChecked, Null, Self)
		cbAutoGenerate.ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, _OnAutoGenChecked, Null, Self)
		cbProjectUpdates.ConnectAny(wxEVT_COMMAND_CHECKBOX_CLICKED, _OnCheckForUpdatesChecked, Null, Self)
		rbLocale.ConnectAny(wxEVT_COMMAND_RADIOBOX_SELECTED, _OnLocaleSelected, Null, Self)
		btnLanguage.ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, _OnChangeLanguage, Null, Self)
		btnGenerate.ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, _OnGenerate, Null, Self)
		Connect(m_menuItem2.GetId(), wxEVT_COMMAND_MENU_SELECTED, _OnNewProject)
		Connect(m_menuItem3.GetId(), wxEVT_COMMAND_MENU_SELECTED, _OnQuit)
		Connect(m_menuItem1.GetId(), wxEVT_COMMAND_MENU_SELECTED, _OnAbout)
	End Method

	Function _OnClose(event:wxEvent)
		CodeGenFrameBase(event.parent).OnClose(wxCloseEvent(event))
	End Function

	Method OnClose(event:wxCloseEvent)
		DebugLog "Please override CodeGenFrame.OnClose()"
		event.Skip()
	End Method

	Function _OnSelectItem(event:wxEvent)
		CodeGenFrameBase(event.sink).OnSelectItem(wxCommandEvent(event))
	End Function

	Method OnSelectItem(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnSelectItem()"
		event.Skip()
	End Method

	Function _OnAddProject(event:wxEvent)
		CodeGenFrameBase(event.sink).OnAddProject(wxCommandEvent(event))
	End Function

	Method OnAddProject(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnAddProject()"
		event.Skip()
	End Method

	Function _OnDeleteProject(event:wxEvent)
		CodeGenFrameBase(event.sink).OnDeleteProject(wxCommandEvent(event))
	End Function

	Method OnDeleteProject(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnDeleteProject()"
		event.Skip()
	End Method

	Function _OnProjectNameLostFocus(event:wxEvent)
		CodeGenFrameBase(event.sink).OnProjectNameLostFocus(wxFocusEvent(event))
	End Function

	Method OnProjectNameLostFocus(event:wxFocusEvent)
		DebugLog "Please override CodeGenFrame.OnProjectNameLostFocus()"
		event.Skip()
	End Method

	Function _OnProjectFileChange(event:wxEvent)
		CodeGenFrameBase(event.sink).OnProjectFileChange(wxFileDirPickerEvent(event))
	End Function

	Method OnProjectFileChange(event:wxFileDirPickerEvent)
		DebugLog "Please override CodeGenFrame.OnProjectFileChange()"
		event.Skip()
	End Method

	Function _OnBMXFolderChange(event:wxEvent)
		CodeGenFrameBase(event.sink).OnBMXFolderChange(wxFileDirPickerEvent(event))
	End Function

	Method OnBMXFolderChange(event:wxFileDirPickerEvent)
		DebugLog "Please override CodeGenFrame.OnBMXFolderChange()"
		event.Skip()
	End Method

	Function _OnGenNameLostFocus(event:wxEvent)
		CodeGenFrameBase(event.sink).OnGenNameLostFocus(wxFocusEvent(event))
	End Function

	Method OnGenNameLostFocus(event:wxFocusEvent)
		DebugLog "Please override CodeGenFrame.OnGenNameLostFocus()"
		event.Skip()
	End Method

	Function _OnSuperStrictChecked(event:wxEvent)
		CodeGenFrameBase(event.sink).OnSuperStrictChecked(wxCommandEvent(event))
	End Function

	Method OnSuperStrictChecked(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnSuperStrictChecked()"
		event.Skip()
	End Method

	Function _OnImportsChecked(event:wxEvent)
		CodeGenFrameBase(event.sink).OnImportsChecked(wxCommandEvent(event))
	End Function

	Method OnImportsChecked(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnImportsChecked()"
		event.Skip()
	End Method

	Function _OnAutoGenChecked(event:wxEvent)
		CodeGenFrameBase(event.sink).OnAutoGenChecked(wxCommandEvent(event))
	End Function

	Method OnAutoGenChecked(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnAutoGenChecked()"
		event.Skip()
	End Method

	Function _OnCheckForUpdatesChecked(event:wxEvent)
		CodeGenFrameBase(event.sink).OnCheckForUpdatesChecked(wxCommandEvent(event))
	End Function

	Method OnCheckForUpdatesChecked(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnCheckForUpdatesChecked()"
		event.Skip()
	End Method

	Function _OnLocaleSelected(event:wxEvent)
		CodeGenFrameBase(event.sink).OnLocaleSelected(wxCommandEvent(event))
	End Function

	Method OnLocaleSelected(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnLocaleSelected()"
		event.Skip()
	End Method

	Function _OnChangeLanguage(event:wxEvent)
		CodeGenFrameBase(event.sink).OnChangeLanguage(wxCommandEvent(event))
	End Function

	Method OnChangeLanguage(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnChangeLanguage()"
		event.Skip()
	End Method

	Function _OnGenerate(event:wxEvent)
		CodeGenFrameBase(event.sink).OnGenerate(wxCommandEvent(event))
	End Function

	Method OnGenerate(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnGenerate()"
		event.Skip()
	End Method

	Function _OnNewProject(event:wxEvent)
		CodeGenFrameBase(event.parent).OnNewProject(wxCommandEvent(event))
	End Function

	Method OnNewProject(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnNewProject()"
		event.Skip()
	End Method

	Function _OnQuit(event:wxEvent)
		CodeGenFrameBase(event.sink).OnQuit(wxCommandEvent(event))
	End Function

	Method OnQuit(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnQuit()"
		event.Skip()
	End Method

	Function _OnAbout(event:wxEvent)
		CodeGenFrameBase(event.sink).OnAbout(wxCommandEvent(event))
	End Function

	Method OnAbout(event:wxCommandEvent)
		DebugLog "Please override CodeGenFrame.OnAbout()"
		event.Skip()
	End Method

End Type

