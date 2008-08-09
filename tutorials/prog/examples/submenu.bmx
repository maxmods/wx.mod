SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sub:SubMenu = SubMenu(New SubMenu.Create(Null, ..
			wxID_ANY, "Submenu", -1, -1, 280, 180))
		sub.Show(True)
 
		Return True
	End Method

End Type

Type SubMenu Extends wxFrame
 
	Field menubar:wxMenuBar
	Field file:wxMenu
	Field imp:wxMenu
	Field quit:wxMenuItem
	
	Method OnInit()
		
		menubar = New wxMenuBar.Create()
		file = New wxMenu.Create()
		file.Append(wxID_CLOSE, "&Quit")
		file.Append(wxID_ANY, "&New")
		file.Append(wxID_ANY, "&Open")
		file.Append(wxID_ANY, "&Save")
		file.AppendSeparator();
		
		imp = New wxMenu.Create()
		imp.Append(wxID_ANY, "Import newsfeed list...")
		imp.Append(wxID_ANY, "Import bookmarks...")
		imp.Append(wxID_ANY, "Import mail...")
		
		file.AppendSubMenu(imp, "I&mport")
		
		quit = New wxMenuItem.Create(file, wxID_CLOSE, "&Quit~tCtrl+W")
		file.AppendItem(quit)
		
		menubar.Append(file, "&File")
		SetMenuBar(menubar)
		
		Connect(wxID_CLOSE, wxEVT_COMMAND_MENU_SELECTED, OnQuit)

		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type

