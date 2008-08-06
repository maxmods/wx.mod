SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextCtrl
Import wx.wxStaticText
Import wx.wxPanel
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local gs:FlexGridSizer = FlexGridSizer(New FlexGridSizer.Create(Null, ..
			wxID_ANY, "FlexGridSizer", -1, -1, 270, 220))
		gs.Show(True)
 
		Return True
	End Method

End Type

Type FlexGridSizer Extends wxFrame


	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		Local fgs:wxFlexGridSizer = New wxFlexGridSizer.CreateRC(3, 2, 9, 25)
		
		Local thetitle:wxStaticText = New wxStaticText.Create(panel, -1, "Title")
		Local author:wxStaticText = New wxStaticText.Create(panel, -1, "Author")
		Local review:wxStaticText = New wxStaticText.Create(panel, -1, "Review")
		
		Local tc1:wxTextCtrl = New wxTextCtrl.Create(panel, -1)
		Local tc2:wxTextCtrl = New wxTextCtrl.Create(panel, -1)
		Local tc3:wxTextCtrl = New wxTextCtrl.Create(panel, -1, "", ..
			-1, -1, -1, -1, wxTE_MULTILINE)
		
		fgs.Add(thetitle)
		fgs.Add(tc1, 1, wxEXPAND)
		fgs.Add(author)
		fgs.Add(tc2, 1, wxEXPAND)
		fgs.Add(review, 1, wxEXPAND)
		fgs.Add(tc3, 1, wxEXPAND)
		
		fgs.AddGrowableRow(2, 1)
		fgs.AddGrowableCol(1, 1)
		
		hbox.AddSizer(fgs, 1, wxALL | wxEXPAND, 15)
		panel.SetSizer(hbox)
			
		Centre()
 
	End Method
	
End Type
