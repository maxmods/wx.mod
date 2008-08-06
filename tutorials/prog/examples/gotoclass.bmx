SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxPanel
Import wx.wxStaticText
Import wx.wxTextCtrl
Import wx.wxCheckBox
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local gc:GotoClass = GotoClass(New GotoClass.Create(Null, wxID_ANY, ..
			"GotoClass", -1, -1, 450, 400))
		gc.Show(True)
 
		Return True
	End Method

End Type

Type GotoClass Extends wxFrame
 
	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		Local hbox1:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local st1:wxStaticText = New wxStaticText.Create(panel, wxID_ANY, ..
			"Class Name")
		
		hbox1.Add(st1, 0, wxRIGHT, 8)
		Local tc:wxTextCtrl = New wxTextCtrl.Create(panel, wxID_ANY)
		hbox1.Add(tc, 1)
		vbox.AddSizer(hbox1, 0, wxEXPAND | wxLEFT | wxRIGHT | wxTOP, 10)
		
		vbox.AddCustomSpacer(-1, 10)
		
		Local hbox2:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local st2:wxStaticText = New wxStaticText.Create(panel, wxID_ANY, ..
			"Matching Classes")
		
		hbox2.Add(st2, 0)
		vbox.AddSizer(hbox2, 0, wxLEFT | wxTOP, 10)
		
		vbox.AddCustomSpacer(-1, 10)
		
		Local hbox3:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local tc2:wxTextCtrl = New wxTextCtrl.Create(panel, wxID_ANY, "", ..
			-1, -1, -1, -1, wxTE_MULTILINE)
		
		hbox3.Add(tc2, 1, wxEXPAND)
		vbox.AddSizer(hbox3, 1, wxLEFT | wxRIGHT | wxEXPAND, 10)
		
		vbox.AddCustomSpacer(-1, 25)
		
		Local hbox4:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local cb1:wxCheckBox = New wxCheckBox.Create(panel, wxID_ANY, ..
			"Case Sensitive")
		
		hbox4.Add(cb1)
		Local cb2:wxCheckBox = New wxCheckBox.Create(panel, wxID_ANY, ..
			"Nested Classes")
		
		hbox4.Add(cb2, 0, wxLEFT, 10)
		Local cb3:wxCheckBox = New wxCheckBox.Create(panel, wxID_ANY, ..
			"Non-Project Classes")
		
		hbox4.Add(cb3, 0, wxLEFT, 10)
		vbox.AddSizer(hbox4, 0, wxLEFT, 10)
		
		vbox.AddCustomSpacer(-1, 25)
		
		Local hbox5:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local btn1:wxButton = New wxButton.Create(panel, wxID_ANY, "Ok")
		hbox5.Add(btn1, 0)
		Local btn2:wxButton = New wxButton.Create(panel, wxID_ANY, "Close")
		hbox5.Add(btn2, 0, wxLEFT | wxBOTTOM , 5)
		vbox.AddSizer(hbox5, 0, wxALIGN_RIGHT | wxRIGHT, 10)
		
		panel.SetSizer(vbox)
						
		Centre()
 
	End Method
	
End Type



