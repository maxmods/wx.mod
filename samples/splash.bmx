SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxSplashScreen
Import wx.wxStaticText

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()
		wxImage.AddHandler(New wxPNGHandler)

		frame = MyFrame(New MyFrame.Create(,,"wxSplashScreen sample application"))

		Local bitmap:wxBitmap = New wxBitmap.Create()
		
		Local ok:Int = bitmap.LoadFile("splash.png", wxBITMAP_TYPE_PNG)
		
		If ok Then
		
			New wxSplashScreen.Splash(bitmap, wxSPLASH_CENTRE_ON_SCREEN | wxSPLASH_TIMEOUT, ..
				6000, frame, wxID_ANY, ,, ,, wxSIMPLE_BORDER | wxSTAY_ON_TOP)
		
		End If
		
		Yield()
		
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
		
		fileMenu.Append(wxID_EXIT, "Exit~tAlt-X", "Quit this program")
		
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

		Local bitmap:wxBitmap = New wxBitmap.Create()
		
		Local ok:Int = bitmap.LoadFile("splash.png", wxBITMAP_TYPE_PNG)

		If ok Then

			Local image:wxImage = bitmap.ConvertToImage()
			image.Rescale( bitmap.GetWidth()/2, bitmap.GetHeight()/2 )
			
			bitmap = wxBitmap.CreateFromImage(image)

			Local splash:wxSplashScreen = New wxSplashScreen.Splash(bitmap, ..
				wxSPLASH_CENTRE_ON_PARENT | wxSPLASH_NO_TIMEOUT, ..
				0, wxWindow(event.parent), wxID_ANY, ,, ,, wxSIMPLE_BORDER | wxSTAY_ON_TOP)

			Local win:wxWindow = splash.GetSplashWindow()
			
			Local text:wxStaticText = New wxStaticText.Create(win, wxID_EXIT, ..
				"click somewhere~non image", 13, 11)
				
			text.SetBackgroundColour(wxWHITE())
			text.SetForegroundColour(wxBLACK())

			Local font:wxFont = text.GetFont()
			font.SetPointSize(2 * font.GetPointSize()/3)
			text.SetFont(font)

		End If
		
	End Function

End Type

New MyApp.run()

