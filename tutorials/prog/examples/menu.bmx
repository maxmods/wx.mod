SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:SimpleMenu = SimpleMenu(New SimpleMenu.Create(Null, ..
			wxID_ANY, "Simple Menu", -1, -1, 280, 180))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type SimpleMenu Extends wxFrame
 
    Field menubar:wxMenuBar
    Field file:wxMenu

	Method OnInit()
		
		menubar = New wxMenuBar.Create()
		file = New wxMenu.Create()
		file.Append(wxID_CLOSE, "&Quit")
		menubar.Append(file, "&File")
		SetMenuBar(menubar)
		
		Connect(wxID_CLOSE, wxEVT_COMMAND_MENU_SELECTED, OnQuit)

		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type

