'
' wxShutDown Sample
'
' Uses a timer to countdown.
'
' by Nigel Brown
'
'
SuperStrict

Framework	wx.wxApp

Import	wx.wxFrame

Import	wx.wxTimer
Import	wx.wxProgressDialog

Import	wx.wxlocale

New MyApp.run()

'
'---------------------------------------------------------------------
Type MyApp Extends wxApp
'---------------------------------------------------------------------

	Field	frame:MyFrame

	'
	'---------------------------------------------------------------------
	Method OnInit:Int()
	'---------------------------------------------------------------------

		frame = MyFrame(New MyFrame.Create(,,"wxProgressDialog wxWidgets App"))

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

	Field	count:Int

	Field	timer:wxTimer
	Field	timeout:wxProgressDialog

	Const	MAXIMUM:Int = 10
	Const	wxID_SHUTDOWN:Int = 666

	'
	'---------------------------------------------------------------------
	Method OnInit()
	'---------------------------------------------------------------------
		' create a menu bar
	
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		
		fileMenu.Append(wxID_SHUTDOWN, "&ShutDown", "Shut the machine down")
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
		Connect(wxID_SHUTDOWN, wxEVT_COMMAND_MENU_SELECTED, OnShutdown)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		ConnectAny(wxEVT_CLOSE_WINDOW, OnCloseWindow )

	End Method

	'
	'---------------------------------------------------------------------
	Function OnTimer(event:wxEvent)
	'---------------------------------------------------------------------
		myFrame(event.parent)._OnTimer(wxCommandEvent(event))
	End Function
	'---------------------------------------------------------------------
	Method _OnTimer(event:wxCommandEvent)
	'---------------------------------------------------------------------
		Local cont:Int
		Local skip:Int

		count:+1
		
		cont = timeout.UpdateProgress(count,"",skip)
		If cont = False
			timer.Stop()
			timer.free()
			timeout.free()
			DebugLog "Shut Down canceled !!!!"
			
			Return
		EndIf
		
		If count > MAXIMUM
			DebugLog "SHUTTING DOWN !!!!"

			' You probably dont need this, but hey!
			timer.Stop()
			timer.free()
			timeout.free()
			
			' dont uncomment this unless you really really want to shutdown.
''			wxShutdown(wxSHUTDOWN_POWEROFF)
		EndIf

	EndMethod

	'
	'---------------------------------------------------------------------
	Method	OnCloseDown()
	'---------------------------------------------------------------------
		'
		DebugLog "::OnCloseDown"

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
	Function OnShutdown(event:wxEvent)
	'---------------------------------------------------------------------
		myFrame(event.parent)._OnShutdown(wxCommandEvent(event))
	End Function
	'---------------------------------------------------------------------
	Method _OnShutdown(event:wxCommandEvent)
	'---------------------------------------------------------------------
		'
		timeout:wxProgressDialog = New wxProgressDialog.Create( AppTitle,..
																_("Shutting down"),..
																MAXIMUM,..
																Self,..
																wxPD_APP_MODAL|..
																wxPD_AUTO_HIDE|..
																wxPD_CAN_ABORT|..
																wxPD_REMAINING_TIME..
																)

		timer = wxTimer(New wxTimer.Create(Self))
		connectAny(wxEVT_TIMER, OnTimer)
		count=0
		timer.Start(1000)

	End Method

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
                    "This is the file wxShutdown sample~n" + ..
                    "running under " + wxGetOsDescription() + ".", ..
                 "About wxShutdown Sample", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function
	
End Type

