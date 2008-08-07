SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxMessageDialog
 
Const ID_INFO:Int = 1
Const ID_ERROR:Int = 2
Const ID_QUESTION:Int = 3
Const ID_ALERT:Int = 4
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local msgs:Messages = Messages(New Messages.Create(Null, ..
			wxID_ANY, "Messages", -1, -1, 210, 110))
		msgs.Show(True)
 
		Return True
	End Method

End Type

Type Messages Extends wxFrame
 
	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		
		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local gs:wxGridSizer = New wxGridSizer.CreateRC(2, 2, 2, 2)
		
		Local btn1:wxButton = New wxButton.Create(panel, ID_INFO, "Info")
		Local btn2:wxButton = New wxButton.Create(panel, ID_ERROR, "Error")
		Local btn3:wxButton = New wxButton.Create(panel, ID_QUESTION, "Question")
		Local btn4:wxButton = New wxButton.Create(panel, ID_ALERT, "Alert")
		
		Connect(ID_INFO, wxEVT_COMMAND_BUTTON_CLICKED, ShowMessage1)
		Connect(ID_ERROR, wxEVT_COMMAND_BUTTON_CLICKED, ShowMessage2)
		Connect(ID_QUESTION, wxEVT_COMMAND_BUTTON_CLICKED, ShowMessage3)
		Connect(ID_ALERT, wxEVT_COMMAND_BUTTON_CLICKED, ShowMessage4)
		
		gs.Add(btn1, 1, wxEXPAND)
		gs.Add(btn2, 1)
		gs.Add(btn3, 1)
		gs.Add(btn4, 1)
	
		hbox.AddSizer(gs, 0, wxALL, 15)
		panel.SetSizer(hbox)
 
		Center()
 
	End Method
	
	Function ShowMessage1(event:wxEvent)
		Local dial:wxMessageDialog = New wxMessageDialog.Create(Null, ..
			"Download completed", "Info", wxOK)
		dial.ShowModal()
 
		dial.Free()
	End Function
 
	Function ShowMessage2(event:wxEvent)
		Local dial:wxMessageDialog = New wxMessageDialog.Create(Null, ..
			"Error loading file", "Error", wxOK | wxICON_ERROR)
		dial.ShowModal()
 
		dial.Free()
	End Function
 
	Function ShowMessage3(event:wxEvent)
		Local dial:wxMessageDialog = New wxMessageDialog.Create(Null, ..
			"Are you sure to quit?", "Question", wxYES_NO | wxNO_DEFAULT | ..
			wxICON_QUESTION)
		dial.ShowModal()
 
		dial.Free()
	End Function
 
	Function ShowMessage4(event:wxEvent)
		Local dial:wxMessageDialog = New wxMessageDialog.Create(Null, ..
			"Unallowed operation", "Exclamation", wxOK | wxICON_EXCLAMATION)
		dial.ShowModal()
 
		dial.Free()
	End Function

End Type


