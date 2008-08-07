SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextCtrl
Import wx.wxButton
Import wx.wxStaticText
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local gs:GridSizer = GridSizer(New GridSizer.Create(Null, wxID_ANY, ..
			"GridSizer", -1, -1, 270, 220))
		gs.Show(True)
 
		Return True
	End Method

End Type

Type GridSizer Extends wxFrame

	Field menubar:wxMenuBar
	Field file:wxMenu
	
	Field sizer:wxBoxSizer
	Field gs:wxGridSizer
	Field display:wxTextCtrl

 
	Method OnInit()
 
		menubar = New wxMenuBar.Create()
		file = New wxMenu.Create()
		
		SetMenuBar(menubar)
		
		sizer = New wxBoxSizer.Create(wxVERTICAL)
		
		display = New wxTextCtrl.Create(Self, -1, "", -1, -1, -1, -1, wxTE_RIGHT)
		
		sizer.Add(display, 0, wxEXPAND | wxTOP | wxBOTTOM, 4)
		gs = New wxGridSizer.CreateRC(4, 4, 3, 3)
		
		gs.Add(New wxButton.Create(Self, -1, "Cls"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "Bck"), 0, wxEXPAND)
		gs.Add(New wxStaticText.Create(Self, -1, ""), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "Close"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "7"), 0, wxEXPAND) 
		gs.Add(New wxButton.Create(Self, -1, "8"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "9"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "/"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "4"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "5"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "6"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "*"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "1"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "2"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "3"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "-"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "0"), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "."), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "="), 0, wxEXPAND)
		gs.Add(New wxButton.Create(Self, -1, "+"), 0, wxEXPAND)
		
		sizer.AddSizer(gs, 1, wxEXPAND)
		SetSizer(sizer)
		SetMinSize(270, 220)
			
		Centre()
 
	End Method
	
End Type



