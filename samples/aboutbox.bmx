'
' wxAboutBox sample
'
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxAboutBox


New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(, -1, "AboutBox example"))
		
		frame.Center()
		frame.Show()
		
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Method OnInit:Int()
	
		' create a menu bar
		
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		
		fileMenu.Append(wxID_EXIT, "E&xit~tAlt-X", "Quit this program")
		
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
		
		Local info:wxAboutDialogInfo = New wxAboutDialogInfo.Create()
		
		info.SetName("My Program")
		info.SetVersion("1.2.3 Beta")
		info.SetDescription("This program does something great.")
		info.SetCopyright("(C) 2007 Me <my@email.addre.ss>")
		
		' uncomment to see "generic" about box
		'info.SetWebSite("http://www.blitzmax.com", "Visit BlitzMax for cool stuff!")
		
		wxAboutBox(info)
		
	End Function
	
End Type

