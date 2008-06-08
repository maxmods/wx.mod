SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMDI
Import wx.wxTextCtrl
Import wx.wxScrolledWindow

New MyApp.run()

Const MDI_QUIT:Int = wxID_EXIT
Const MDI_NEW_WINDOW:Int = 101
Const MDI_REFRESH:Int = 102
Const MDI_CHANGE_TITLE:Int = 103
Const MDI_CHANGE_POSITION:Int = 104
Const MDI_CHANGE_SIZE:Int = 105
Const MDI_CHILD_QUIT:Int = 106
Const MDI_ABOUT:Int = wxID_ABOUT


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		wxInitAllImageHandlers()

		frame = MyFrame(New MyFrame.Create(Null,-1,"MDI Demo",,, 500, 400, wxDEFAULT_FRAME_STYLE | wxHSCROLL | wxVSCROLL))


		' Make a menubar
		local file_menu:wxMenu = new wxMenu.Create()

		file_menu.Append(MDI_NEW_WINDOW, "&New window~tCtrl-N", "Create a new child window")
		file_menu.Append(MDI_QUIT, "&Exit~tAlt-X", "Quit the program")

		Local help_menu:wxMenu = new wxMenu.Create()
		help_menu.Append(MDI_ABOUT, "&About~tF1")

		local menu_bar:wxMenuBar = new wxMenuBar.Create()

		menu_bar.Append(file_menu, "&File")
		menu_bar.Append(help_menu, "&Help")

		' Associate the menu bar with the frame
		frame.SetMenuBar(menu_bar)


		frame.CreateStatusBar()
		
		frame.show()
		SetTopWindow(frame)
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxMDIParentFrame

   	Field textWindow:wxTextCtrl

	Global gs_nFrames:Int = 0

	Method OnInit()
'DebugStop
		textWindow = New wxTextCtrl.Create(Self, wxID_ANY, "A help window", ,, ,, wxTE_MULTILINE | wxSUNKEN_BORDER)

		CreateToolBar(wxNO_BORDER | wxTB_FLAT | wxTB_HORIZONTAL)
		InitToolBar(GetToolBar())

    ' Accelerators
		Local entries:wxAcceleratorEntry[] = New wxAcceleratorEntry[3]
		entries[0] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("N"), MDI_NEW_WINDOW)
		entries[1] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("X"), MDI_QUIT)
		entries[2] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("A"), MDI_ABOUT)
		Local accel:wxAcceleratorTable = New wxAcceleratorTable.Create(entries)
		SetAcceleratorTable(accel)

		Connect(MDI_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(MDI_NEW_WINDOW, wxEVT_COMMAND_MENU_SELECTED, OnNewWindow)
		Connect(MDI_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		
		ConnectAny(wxEVT_CLOSE, OnClose)
		ConnectAny(wxEVT_SIZE, OnSize)
	End Method

	Method InitToolBar(toolBar:wxToolBar)

		Local bitmaps:wxBitmap[] = New wxBitmap[8]

		bitmaps[0] = wxBitmap.CreateFromFile("media/mdi/new.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[1] = wxBitmap.CreateFromFile("media/mdi/open.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[2] = wxBitmap.CreateFromFile("media/mdi/save.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[3] = wxBitmap.CreateFromFile("media/mdi/copy.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[4] = wxBitmap.CreateFromFile("media/mdi/cut.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[5] = wxBitmap.CreateFromFile("media/mdi/paste.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[6] = wxBitmap.CreateFromFile("media/mdi/print.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[7] = wxBitmap.CreateFromFile("media/mdi/help.xpm", wxBITMAP_TYPE_XPM)

	
		toolBar.AddTool(MDI_NEW_WINDOW, "New", bitmaps[0], ,,"New file")
		toolBar.AddTool(1, "Open", bitmaps[1], ,,"Open file")
		toolBar.AddTool(2, "Save", bitmaps[2], ,,"Save file")
		toolBar.AddSeparator()
		toolBar.AddTool(3, "Copy", bitmaps[3], ,,"Copy")
		toolBar.AddTool(4, "Cut", bitmaps[4], ,,"Cut")
		toolBar.AddTool(5, "Paste", bitmaps[5], ,,"Paste")
		toolBar.AddSeparator()
		toolBar.AddTool(6, "Print", bitmaps[6], ,,"Print")
		toolBar.AddSeparator()
		toolBar.AddTool(MDI_ABOUT, "About", bitmaps[7], ,,"Help")

		toolBar.Realize()
	End Method

    Function OnActivate(event:wxEvent)
	End Function

    Function OnRefresh(event:wxEvent)
	End Function
	
	Function OnAbout(event:wxEvent)

	    wxMessageBox("wxWidgets 2.0 MDI Demo~n" + ..
                       "Author: Julian Smart (c) 1997~n" + ..
                       "Usage: mdi.exe", "About MDI Demo")
	End Function


    Function OnUpdateRefresh(event:wxEvent)
	End Function
	

    Function OnChangeTitle(event:wxEvent)
	End Function
	

    Function OnChangePosition(event:wxEvent)
	End Function
	

    Function OnChangeSize(event:wxEvent)
	End Function
	

	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close()
	End Function
	

	Function OnSize(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		
		Local w:Int, h:Int
		frame.GetClientSize(w, h)

		frame.textWindow.SetDimensions(0, 0, 200, h)
		frame.GetClientWindow().SetDimensions(200, 0, w - 200, h)

	End Function
	

    Function OnMove(event:wxEvent)
	End Function
	

    Function OnClose(evt:wxEvent)
		Local event:wxCloseEvent = wxCloseEvent(evt)
	
		If event.CanVeto() And gs_nFrames > 0 Then
			If wxMessageBox(gs_nFrames + " windows still open, close anyhow?", "Please confirm", ..
                          wxICON_QUESTION | wxYES_NO) <> wxYES Then
				event.Veto()
				Return
			End If
		End If

		event.Skip()

	End Function
	
	Function OnNewWindow(event:wxEvent)
	End Function
	

End Type


Type MyCanvas Extends wxScrolledWindow

End Type


