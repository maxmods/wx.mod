SuperStrict

Framework wx.wxApp
Import wx.wxMidi
Import wx.wxFrame
Import wx.wxPanel

New MyApp.run()

Type MyApp Extends wxApp

	Method OnInit:Int()

		Local frame:MyFrame = MyFrame(New MyFrame.Create(,,"wxMidi Sample", -1, -1, 600, 400))

		frame.Center()
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Method OnInit()

	    ' Create a menu bar
	    Local menuFile:wxMenu = New wxMenu.Create()
	    menuFile.Append(wxID_EXIT, "E&xit~tAlt-X", "Quit this program")
	
	    ' the "About" item should be in the help menu
	    Local helpMenu:wxMenu = New wxMenu.Create()
	    helpMenu.Append(wxID_ABOUT, "&About...", "Show about dialog")
	
	    ' now append the freshly created menu To the menu bar...
	    Local menuBar:wxMenuBar = New wxMenuBar.Create()
	    menuBar.Append(menuFile, "&File")
	    menuBar.Append(helpMenu, "&Help")
	
	    ' ... And attach this menu bar To the frame
	    SetMenuBar(menuBar)

		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
	End Method

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
		wxMessageBox("This is the About dialog of the wxMidi sample.~n" + ..
                "Welcome to wxMidi " + wxMIDI_VERSION(), ..
                 "About wxMidi sample", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function

End Type

Type MyPanel Extends wxPanel


End Type