'
' wxUIActionSimulator sample
'
' From the C++ sample by Kevin Ollivier
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxTextCtrl
Import wx.wxPanel
Import wx.wxUIActionSimulator
Import wx.wxTextEntryDialog

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:wxFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(Null, -1, "UI Action Simulator"))
		
		frame.show()
	
		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

	Field m_button:wxButton
	Field m_text:wxTextCtrl
	
	Const RunSimulation:Int = 1
	Const SimulateText:Int = 2

	Method OnInit()

		' Create a menu bar
		Local fileMenu:wxMenu = New wxMenu.Create()
		
		fileMenu.Append(wxID_NEW, "&New File...", "Open a new file")
		fileMenu.Append(RunSimulation, "&Run Simulation", "Run predefined UI action simulation")
		fileMenu.Append(SimulateText, "Simulate &text input...", "Enter text to simulate")
		fileMenu.AppendSeparator()
		
		fileMenu.Append(wxID_EXIT, "E&xit~tAlt-X", "Quit this program")
		
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(fileMenu, "&File")
		
		SetMenuBar(menuBar)

		Local panel:wxPanel = New wxPanel.Create(Self)
		
		Local sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(sizer)
		
		m_button = New wxButton.Create(panel, wxID_ANY, "&Button")
		sizer.Add(m_button, 0, wxALIGN_CENTER | wxALL, 5)
		
		m_text = New wxTextCtrl.Create(panel, wxID_ANY, "", -1, -1, -1, -1, wxTE_MULTILINE)
		sizer.Add(m_text, 1, wxEXPAND | wxALL)


		ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, OnButtonPressed)
		Connect(RunSimulation, wxEVT_COMMAND_MENU_SELECTED, OnRunSimulation)
		Connect(SimulateText, wxEVT_COMMAND_MENU_SELECTED, OnSimulateText)
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnExit)
	End Method

	Function OnButtonPressed(event:wxEvent)
		 MyFrame(event.parent).m_text.AppendText("Button pressed.~n")
	End Function
	
	Function OnRunSimulation(event:wxEvent)
		Local sim:wxUIActionSimulator = New wxUIActionSimulator.Create()
		
		' Add some extra distance To take account of window decorations
		Local x:Int, y:Int
		MyFrame(event.parent).m_button.GetScreenPosition(x, y)
		sim.MouseMove(x + 10, y + 10)
		sim.MouseClick(wxMOUSE_BTN_LEFT)
		
		' Process the resulting button event
		wxYield()
		
		MyFrame(event.parent).m_text.SetFocus()
		sim.Char(Asc("A"))
		sim.Char(Asc("A"), wxMOD_SHIFT)
		sim.Char(WXK_RETURN)
		sim.Char(Asc("Z"))
		sim.Char(Asc("Z"), wxMOD_SHIFT)
		sim.Char(WXK_RETURN)
		sim.Text("aAbBcC")
		sim.Char(WXK_RETURN)
		sim.Text("1 234.57e-8")
		sim.Char(WXK_RETURN)

	End Function
	
	Function OnSimulateText(event:wxEvent)
		Global s_text:String
		
		Local text:String = wxGetTextFromUser("Enter text to simulate: ", "wxUIActionSimulator wxWidgets Sample", s_text, wxWindow(event.parent))
		If Not text Then
			Return
		End If
		
		s_text = text
		
		Local sim:wxUIActionSimulator = New wxUIActionSimulator.Create()
		MyFrame(event.parent).m_text.SetFocus()
		sim.Text(s_text)
		
	End Function
	
	Function OnExit(event:wxEvent)
		wxWindow(event.parent).Close()
	End Function

End Type

