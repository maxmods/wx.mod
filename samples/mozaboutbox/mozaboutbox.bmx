'
' wxMozillaLikeAboutDialog sample
'
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxImage
Import wx.wxAboutBox
Import wx.wxDateTime
Import wx.wxMozillaLikeAboutBoxDialog

Import BRL.RamStream


Incbin "../media/mozaboutbox/header.png"

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		SetAppName("AboutBox Sample")
		

		wxImage.AddHandler(New wxPNGHandler)

		frame = MyFrame(New MyFrame.Create(, -1, "AboutBox example"))
		
		frame.Center()
		frame.Show()
		
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Const wxID_MOZABOUT:Int = 10001

	Method OnInit()
	
		' create a menu bar
		
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		helpMenu.Append(wxID_MOZABOUT, "Mozilla-like about box", "Show mozilla-like about dialog")
		
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
		Connect(wxID_MOZABOUT, wxEVT_COMMAND_MENU_SELECTED, OnMozAbout)
		
	End Method

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
		Local info:wxAboutDialogInfo = New wxAboutDialogInfo.Create()
		
		' Call of AddDeveloper() Method adds a record To list of developers
		info.AddDeveloper("John Doe")
		' Call of AddDocWriter() Method adds a record To list of documentation writers
		info.AddDocWriter("Donald Duck")
		' Call of AddArtist() Method adds a record To list of artists
		info.AddArtist("Scrooge Mc.Duck")
		' Call of AddTranslator() Method adds a record To list of translators
		info.AddTranslator("Mickey Mouse")
		' This Method adds application description.
		info.SetDescription("Sample wxWidgets application for testing wxAboutBox() function.")
		' This Method sets application version String
		info.SetVersion("1.0.0 beta 1")
		' SetName() Method sets application name displayed in About box. 
		' It is better To pass wxApp::GetAppName() To this Method
		info.SetName(wxGetApp().GetAppName())
		' Sets application Web-site URL
		info.SetWebSite("http://www.blitzmax.com", "Visit BlitzMax for cool stuff!")
		' Sets the icon which will be displayed in About box.
		'info.SetIcon(wxIcon(wxICON_AAA)
		' Sets application license String. Only wxGTK port has native way of 
		' displaying application license. All other ports will use generic way For this purpose.
		info.SetLicence("Public Domain")
		
		wxAboutBox(info)
		
	End Function
	
	Function OnMozAbout(event:wxEvent)
	
		' Create About box 
		Local dlg:wxMozillaLikeAboutBoxDialog = New wxMozillaLikeAboutBoxDialog.Create(wxWindow(event.parent))
		' Set application name
		dlg.SetAppName(wxGetApp().GetAppName())
		' Set application version
		dlg.SetVersion("1.0.0 b1")
		' Set copyright message
		dlg.SetCopyright(Chr($A9) + " " + wxDateTime.Now().GetYear() + " Volodymir (T-Rex) Tryapichko. Ported to BlitzMax by Bruce A Henderson.")
		' Set build info message. This is optional Step. If you don't specify build info message then
		' default one will be used
		dlg.SetCustomBuildInfo(wxMozillaLikeAboutBoxDialog.GetBuildInfo(wxBUILDINFO_LONG) + ". " + "Compiled by BaH")
		' Set header bitmap
		dlg.SetHeaderBitmap(wxBitmap.CreateFromFile("incbin::../media/mozaboutbox/header.png", wxBITMAP_TYPE_PNG))
		' Apply changes
		dlg.ApplyInfo()
		' Show dialog
		dlg.ShowModal()
		' Destroy dialog
		dlg.Free()
		
	End Function
	
End Type
