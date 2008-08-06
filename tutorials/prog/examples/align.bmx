SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxPanel
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local ab:Align = Align(New Align.Create(Null, wxID_ANY, "Align", -1, -1, 300, 200))
		ab.Show(True)
 
		Return True
	End Method

End Type

Type Align Extends wxFrame
 
	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
 
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		Local hbox1:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local hbox2:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		Local ok:wxButton = New wxButton.Create(panel, -1, "Ok")
		Local cancel:wxButton = New wxButton.Create(panel, -1, "Cancel")
		
		hbox1.Add(New wxPanel.Create(panel, -1))
		vbox.AddSizer(hbox1, 1, wxEXPAND)
		
		
		hbox2.Add(ok)
		hbox2.Add(cancel)
		
		vbox.AddSizer(hbox2, 0, wxALIGN_RIGHT | wxRIGHT | wxBOTTOM, 10)
		panel.SetSizer(vbox)
				
		Centre()
 
	End Method
	
End Type


