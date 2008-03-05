SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxButton
Import wx.wxPanel
Import wx.wxCheckBox
Import BRL.PolledInput

Import BRL.GLMax2D

?macos
Import "cocoa_glue.bmx"
?

New MyApp.run()


Type MyApp Extends wxAppMain
	Global frame:wxFrame
	Global shouldExit:Int = False
	
	Global showingGraphics:Int = False
	Global fullScreenGraphics:Int = False
	
	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"Groovy Graphics test", 100, 100))
		SetTopWindow(frame)
		frame.show()
	
		'# Connect exit event
		frame.Connect(, wxEVT_CLOSE, OnClose)

		ConnectAny(wxEVT_KEY_DOWN, OnMouse)
		ConnectAny(wxEVT_MOUSE_EVENTS, OnMouse)
		Return True
	End Method

	Method MainLoop:Int() 

		While True
			While Not Pending() And ProcessIdle() ; Wend
			While Pending()
				If Not Dispatch() Then
					shouldExit = True
					Exit
				End If
			Wend
			If shouldExit Then
				While pending() 
					dispatch() 
				Wend
				Return 0
			End If

			If showingGraphics Then
				If fullScreenGraphics Then
					wxPollEvents
					PollSystem
				End If
'DebugLog "graphics.... " + MouseX() + " : " + MouseY()
				If KeyDown(KEY_ESCAPE) Then
					DisableGraphics()
					Continue
				End If

				SetClsColor(255, 255, 255)

				Cls
				
				SetColor(0, 0, 0)
				
				DrawText "Left  = " + MouseDown(1), 100, 10
				DrawText "Right = " + MouseDown(2), 100, 30
				DrawText "Mid   = " + MouseDown(3), 100, 50
				
				DrawText "X,Y   = " + MouseX() + ", " + MouseY(), 100, 80
	
				Flip
			
			End If

		Wend
	End Method
	
	Function OnClose(event:wxEvent)
		MyApp.DisableGraphics()
		MyApp.shouldExit = True
	End Function
	
	Function EnableGraphics()
	
		If Not showingGraphics Then
			
			?macos
			initCocoa()
			?
			

			frame.Hide()
			If fullScreenGraphics Then
				EnablePolledInput()
				'wxGetApp().ConnectAny(wxEVT_MOUSE_EVENTS, OnMouse)
				'wxGetApp().ConnectAny(wxEVT_KEY_DOWN, OnMouse)
				Graphics 800, 600, 32
			Else
'				frame.Hide()
				Graphics 1024, 786, 0
			End If
			
			SetBlend alphablend
			
			showingGraphics = True
		End If
	
	End Function
	
	Function DisableGraphics()
	
		If showingGraphics Then
		
			EndGraphics()
			
			frame.Show()
		
			showingGraphics = False
		End If
	
	End Function
	
	Function OnMouse(evt:wxEvent)
		DebugLog "OnMouse"
	End Function

End Type


Type MyFrame Extends wxFrame

	Const ID_BUTTON:Int = 1000
	Const ID_CBOX:Int = 1001

	Field btn:wxButton
	Field chk:wxCheckBox

	Method OnInit()
	
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
		
		Local panel:wxPanel = New wxPanel.Create(Self)
		
		btn = New wxButton.Create(panel, ID_BUTTON, "Go!", 50, 50)
		chk = New wxCheckBox.Create(panel, ID_CBOX, "FullScreen", 50, 80)
		
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(ID_BUTTON, wxEVT_COMMAND_BUTTON_CLICKED, OnButton)
		Connect(ID_CBOX, wxEVT_COMMAND_CHECKBOX_CLICKED, OnCheckBox)
		
	End Method

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
		wxMessageBox("Groovy Graphics test.", ..
                 "About Groovy Graphics test", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function
	
	Function OnButton(evt:wxEvent)
	
		MyApp.EnableGraphics()
	
	End Function
	
	Function OnCheckBox(evt:wxEvent)
		MyApp.fullScreenGraphics = wxCommandEvent(evt).IsChecked()
	End Function

	
End Type
