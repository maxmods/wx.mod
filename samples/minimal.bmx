SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"Minimal wxWidgets App", 100, 100))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Method OnInit()
	
		' create a menu bar
	
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		
		fileMenu.Append(wxID_EXIT, "Exit")'"&Quit~tAlt-Q", "Quit this program")
		
		' now append the freshly created menu to the menu bar...
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menuBar.Append(fileMenu, "&File")
		menuBar.Append(helpMenu, "&Help")

		SetMenuBar(menuBar)
		
		' create a status bar just for fun
		CreateStatusBar(2)
		SetStatusText("Welcome to wxWidgets!")
		
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
	End Method

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
		wxMessageBox("Welcome to " + wxVERSION_STRING + "!~n" + ..
                    "~n" + ..
                    "This is the minimal wxWidgets sample~n" + ..
                    "running under " + wxGetOsDescription() + ".", ..
                 "About wxWidgets minimal sample", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function
	
End Type

New MyApp.run()
