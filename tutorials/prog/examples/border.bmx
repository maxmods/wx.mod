SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local bd:Border = Border(New Border.Create(Null, wxID_ANY, ..
			"Border", -1, -1, 300, 200))
		bd.Show(True)
 
		Return True
	End Method

End Type

Type Border Extends wxFrame
 
	Method OnInit()
	
		Local col1:wxColour = New wxColour.CreateNamedColour("#4f5049")
		Local col2:wxColour = New wxColour.CreateNamedColour("#ededed")
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
 
		panel.SetBackgroundColour(col1)
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		Local midPan:wxPanel = New wxPanel.Create(panel, wxID_ANY)
		midPan.SetBackgroundColour(col2)
		
		vbox.Add(midPan, 1, wxEXPAND | wxALL, 20)
		panel.SetSizer(vbox)
				
		Centre()
 
	End Method
	
End Type
