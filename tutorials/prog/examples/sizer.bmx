SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextCtrl
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sz:Sizer = Sizer(New Sizer.Create(Null, wxID_ANY, ..
			"Sizer", -1, -1, 250, 180))
		sz.Show(True)
 
		Return True
	End Method

End Type

Type Sizer Extends wxFrame
 
	Field menubar:wxMenuBar
	Field file:wxMenu
	Field edit:wxMenu
	Field help:wxMenu
	Field textctrl:wxTextCtrl
	
	Method OnInit()
 
		menubar = New wxMenuBar.Create()
		file = New wxMenu.Create()
		edit = New wxMenu.Create()
		help = New wxMenu.Create()
		
		menubar.Append(file, "&File")
		menubar.Append(edit, "&Edit")
		menubar.Append(help, "&Help")
		SetMenuBar(menubar)
		
		textctrl = New wxTextCtrl.Create(Self, -1, "", -1, -1, 250, 150)
		
		Centre()
 
	End Method
	
End Type


