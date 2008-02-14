'
' wxFileConfig Sample
'
' by Nigel Brown
'
'
SuperStrict

Framework	wx.wxApp
Import		wx.wxFrame

Import		wx.wxConfig
Import		wx.wxFileConfig

New MyApp.run()


'
'---------------------------------------------------------------------
Type MyApp Extends wxApp
'---------------------------------------------------------------------

	Field frame:MyFrame

	'
	'---------------------------------------------------------------------
	Method OnInit:Int()
	'---------------------------------------------------------------------

		frame = MyFrame(New MyFrame.Create(,,"wxFileConfig wxWidgets App"))

		SetTopWindow(frame)

		frame.Center()
		frame.Show()

		Return True

	End Method

End Type

'
'---------------------------------------------------------------------
Type MyFrame Extends wxFrame
'---------------------------------------------------------------------
	
	'
	'---------------------------------------------------------------------
	Method OnInit()
	'---------------------------------------------------------------------
		'
		wxConfigBase.Set(New wxFileConfig.Create("","","default.ini","",wxCONFIG_USE_RELATIVE_PATH))

 		'
		Local config:wxConfigBase = wxConfigBase.Get()
		config.SetPath("/FC_Confguration")
		DebugLog "FC_HOST = " + config.ReadInt("FC_HOST",-1)

		' create a menu bar
	
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		
		fileMenu.Append(wxID_EXIT, "&Quit~tAlt-Q", "Quit this program")
		
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
		ConnectAny(wxEVT_CLOSE_WINDOW, OnCloseWindow )
		
	End Method

	'
	'---------------------------------------------------------------------
	Method	OnCloseDown()
	'---------------------------------------------------------------------
		'
		DebugLog "::OnCloseDown"

		Local config:wxConfigBase = wxConfigBase.Get()
		If config

			config.SetPath("/FC_Confguration")
			config.WriteInt("FC_HOST",20)
			
			' Flush the data to the file
			config.Flush()
			
			' We need to free the config object by first removing it as the
			' global config instance. We can do this by setting the global
			' instance to Null. Set() returns the "previous" instance, which
			' will be our own wxFileConfig object.
			wxConfigBase.Set(Null).Free()
		EndIf

	End Method

	'
	'---------------------------------------------------------------------
	Function OnCloseWindow(event:wxEvent)
	'---------------------------------------------------------------------
		'
		DebugLog "::OnCloseWindow"

		myFrame(event.parent).OnCloseDown()

		event.Skip()

	End Function

	'
	'---------------------------------------------------------------------
	Function OnQuit(event:wxEvent)
	'---------------------------------------------------------------------
		'
		DebugLog "::OnQuit"

		myFrame(event.parent).Close(True)

	End Function

	'
	'---------------------------------------------------------------------
	Function OnAbout(event:wxEvent)
	'---------------------------------------------------------------------
		
		wxMessageBox("Welcome to " + wxVERSION_STRING + "!~n" + ..
                    "~n" + ..
                    "This is the file config wxWidgets sample~n" + ..
                    "running under " + wxGetOsDescription() + ".", ..
                 "About wxFileConfig", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function
	
End Type

