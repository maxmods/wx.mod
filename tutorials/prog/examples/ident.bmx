SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxButton
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local id:Ident = Ident(New Ident.Create(Null, wxID_ANY, ..
			"Identifiers", -1, -1, 200, 150))
		id.Show(True)
 
		Return True
	End Method

End Type

Type Ident Extends wxFrame
 
	Method OnInit()
		
		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		Local grid:wxGridSizer = New wxGridSizer.Create(2, 3)
		
		grid.Add(New wxButton.Create(panel, wxID_CANCEL), 0, wxTOP | wxLEFT, 9)
		grid.Add(New wxButton.Create(panel, wxID_DELETE), 0, wxTOP, 9)
		grid.Add(New wxButton.Create(panel, wxID_SAVE), 0, wxLEFT, 9)
		grid.Add(New wxButton.Create(panel, wxID_EXIT))
		grid.Add(New wxButton.Create(panel, wxID_STOP), 0, wxLEFT, 9)
		grid.Add(New wxButton.Create(panel, wxID_NEW))
		
		panel.SetSizer(grid)
		Centre()
 
	End Method
	
End Type

