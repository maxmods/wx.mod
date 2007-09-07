SuperStrict

Framework wx.wxApp
Import wx.wxPanel
Import wx.wxFrame
Import wx.wxButton
Import wx.wxTextCtrl
Import wx.wxListBox
Import wx.wxNotebook

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create("Basic Notebook App", 200, 200))
		
		SetTopWindow(frame)
		
		frame.show()
	
		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

	Field notebook:wxNotebook
	Field listbox:wxListBox
	Field textlog:wxTextCtrl
	
	Const BOOKCTRL:Int = 100
	Const BUTTON1:Int = 101
	Const BUTTON2:Int = 102
	Const LISTBOX1:Int = 103
	Const TEXTBOX1:Int = 104
	Const FILE_QUIT:Int = wxID_EXIT
	Const HELP_ABOUT:Int = wxID_ABOUT

	Method OnInit()

		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		
		helpMenu.Append(HELP_ABOUT, "&About...~tF1", "Show about dialog")
		fileMenu.Append(FILE_QUIT, "E&xit~tAlt-X", "Quit this program")
		
		menuBar.Append(fileMenu, "&File")
		menuBar.Append(helpMenu, "&Help")

		SetMenuBar(menuBar)

		CreateStatusBar(2)
		SetStatusText("So far so good.", 0)
		SetStatusText("Welcome!", 1)


		' the notebook
		notebook = wxNotebook.CreateNotebook(Self, BOOKCTRL)
		
		' a panel
		Local panel:wxPanel = wxPanel.CreatePanel(notebook)
		
		' the first page
		notebook.AddPage(panel, "Tab1", True)
		
		' add buttons to the panel
		wxButton.CreateButton(panel, BUTTON1, "Button &1", 50, 30, 100, 30)
		wxButton.CreateButton(panel, BUTTON2, "Button &2", 50, 80, 100, 30)

		' a new panel
		panel = wxPanel.CreatePanel(notebook)
		
		Local choices:String [] = [ "Washington", "Adams", "Jefferson", "Madison", ..
  			"Lincoln", "One", "Two", "Three", "Four"]
		
		listbox = wxListBox.CreateListBox(panel, LISTBOX1, choices, 0, 0, 150, 90, wxLB_SORT | wxLB_EXTENDED)

		' add the second page
		notebook.AddPage(panel, "Tab2", False)
		
		' another new panel
		panel = wxPanel.CreatePanel(notebook)

		Local mysizer:wxBoxSizer = wxBoxSizer.CreateBoxSizer(wxVERTICAL)
		panel.SetSizer(mysizer)
		
		textlog = wxTextCtrl.CreateTextCtrl(panel, TEXTBOX1, "Log~n", 0, 250, 100, 50, wxTE_MULTILINE)
		mysizer.Add(textlog, 1, wxEXPAND | wxALL, 5)
		
		notebook.AddPage(panel, "Tab3", False)


		Connect(FILE_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(HELP_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(BUTTON1, wxEVT_COMMAND_BUTTON_CLICKED, OnButton1)
		Connect(BUTTON2, wxEVT_COMMAND_BUTTON_CLICKED, OnButton2)
		Connect(LISTBOX1, wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, OnListBoxDoubleClick)
	End Method	

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
	End Function
	
	Function OnButton1(event:wxEvent)
		wxMessageBox("Click1", "Click", wxOK | wxICON_INFORMATION, wxWindow(event.parent))
	End Function

	Function OnButton2(event:wxEvent)
		wxMessageBox("Click2 !!", "Click", wxOK | wxICON_INFORMATION, wxWindow(event.parent))
	End Function
	
	Function OnListBoxDoubleClick(event:wxEvent)
		MyFrame(event.parent).textlog.AppendText("ListBox Double click String is: ~n" + ..
			wxCommandEvent(event).GetString() + "~n")
	End Function
	
End Type


New MyApp.run()
