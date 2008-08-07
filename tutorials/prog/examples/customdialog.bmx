SuperStrict
 
Framework wx.wxApp
Import wx.wxDialog
Import wx.wxPanel
Import wx.wxStaticBox
Import wx.wxButton
Import wx.wxRadioButton
Import wx.wxTextCtrl
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:CustomDialog = CustomDialog(New CustomDialog.Create_(Null, ..
			wxID_ANY, "CustomDialog", -1, -1, 250, 230))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type CustomDialog Extends wxDialog
 
	Method OnInit()
		
		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		Local st:wxStaticBox = New wxStaticBox.Create(panel, -1, ..
			"Colors", 5, 5, 240, 150)
		Local rb:wxRadioButton = New wxRadioButton.Create(panel, -1, ..
			"256 Colors", 15, 30,,, wxRB_GROUP)
		
		Local rb1:wxRadioButton = New wxRadioButton.Create(panel, -1, ..
			"16 Colors", 15, 55)
		Local rb2:wxRadioButton = New wxRadioButton.Create(panel, -1, ..
			"2 Colors", 15, 80)
		Local rb3:wxRadioButton = New wxRadioButton.Create(panel, -1, ..
			"Custom", 15, 105)
		Local tc:wxTextCtrl = New wxTextCtrl.Create(panel, -1, "", 95, 105)
		
		Local okButton:wxButton = New wxButton.Create(Self, -1, ..
			"Ok", -1 -1, 70, 30)
		Local closeButton:wxButton = New wxButton.Create(Self, -1, ..
			"Close", -1, -1, 70, 30)
		
		hbox.Add(okButton, 1)
		hbox.Add(closeButton, 1, wxLEFT, 5)
		
		vbox.Add(panel, 1)
		vbox.AddSizer(hbox, 0, wxALIGN_CENTER | wxTOP | wxBOTTOM, 10)
		
		SetSizer(vbox)
		
		Centre()
		ShowModal()
		
		Destroy() 
		 
	End Method
	
End Type

