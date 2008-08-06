SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextCtrl
Import wx.wxPanel
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local ab:Absolute = Absolute(New Absolute.Create(Null, wxID_ANY, ..
			"Absolute", -1, -1, 250, 180))
		ab.Show(True)
 
		Return True
	End Method

End Type

Type Absolute Extends wxFrame
 
	Field menubar:wxMenuBar
	Field file:wxMenu
	Field edit:wxMenu
	Field help:wxMenu
	Field textctrl:wxTextCtrl
	
	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
 
		menubar = New wxMenuBar.Create()
		file = New wxMenu.Create()
		edit = New wxMenu.Create()
		help = New wxMenu.Create()
		
		menubar.Append(file, "&File")
		menubar.Append(edit, "&Edit")
		menubar.Append(help, "&Help")
		SetMenuBar(menubar)
		
		textctrl = New wxTextCtrl.Create(panel, -1, "", -1, -1, 250, 150)
		
		Centre()
 
	End Method
	
End Type

