SuperStrict

Framework wx.wx
Import wx.wxFrame
Import wx.wxdc
Import wx.wxVScrolledWindow

Type VScrollApp Extends wxApp

	Field frame:VScrollFrame

	Method OnInit:Int()

		frame = VScrollFrame(New VScrollFrame.Create("VScroll wxWidgets Sample", , ,400, 350))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type


Type VScrollFrame Extends wxFrame

	Const VScroll_Quit:Int = wxID_EXIT
	Const VScroll_About:Int = wxID_ABOUT

	Method OnInit()

		' set the frame icon
		'SetIcon(wxICON(sample));
		
		' create a menu bar
		Local menuFile:wxMenu = New wxMenu.Create()
		
		' the "About" item should be in the help menu
		Local menuHelp:wxMenu = New wxMenu.Create()
		menuHelp.Append(VScroll_About, "&About...~tF1", "Show about dialog")
		
		menuFile.Append(VScroll_Quit, "E&xit~tAlt-X", "Quit this program")
		
		' now append the freshly created menu To the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(menuHelp, "&Help")
		
		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)
		
		' create a status bar just For fun (by Default with 1 pane only)
		CreateStatusBar(2)
		SetStatusText("Welcome to wxWidgets!")

		' create our one and only child -- it will take our entire client area
		New VScrollWindow.Create(Self)

		Connect(VScroll_Quit, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(VScroll_About, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		ConnectNoId(wxEVT_SIZE, OnSize)
	End Method
	
	Function OnSize(event:wxEvent)
		Local w:Int, h:Int
		wxFrame(event.parent).GetClientSize(w, h)
		
		wxFrame(event.parent).SetStatusText(w + "x" + h, 1)

		event.Skip()
	End Function

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function

	Function OnAbout(event:wxEvent)
		wxMessageBox("VScroll shows how to implement scrolling with~n" + ..
			"variable line heights.~n" + ..
			"(c) 2003 Vadim Zeitlin~n" + ..
			"BlitzMax port (c) 2007 Bruce A Henderson", "About VScroll", ..
			wxOK | wxICON_INFORMATION, wxWindow(event.parent))
	End Function
	
End Type


Type VScrollWindow Extends wxVScrolledWindow

	Field frame:wxFrame
	Field changed:Int

	Method OnInit()
		frame = wxFrame(GetParent())

		ConnectNoId(wxEVT_IDLE, OnIdle)
		ConnectNoId(wxEVT_PAINT, OnPaint)
		ConnectNoId(wxEVT_SCROLLWIN, OnScroll)
		
	
		SetLineCount(200)
		changed = True
	End Method
	
	Function OnIdle(event:wxEvent)
		Local scroll:VScrollWindow = VScrollWindow(event.parent)
		
		scroll.frame.SetStatusText("Page size = " + scroll.GetScrollThumb(wxVERTICAL) + ..
				", pos = " + scroll.GetScrollPos(wxVERTICAL) + ..
				", max = " + scroll.GetScrollRange(wxVERTICAL))
				
		scroll.changed = False
	End Function

	Function OnPaint(event:wxEvent)
		Local win:VScrollWindow = VScrollWindow(event.parent)
		
		' we *must* create a wxPaintDC in an OnPaint... or else!
		Local dc:wxPaintDC = New wxPaintDC.Create(win)

		dc.SetPen(wxBLACK_DASHED_PEN())
		
		Local lineFirst:Int = win.GetFirstVisibleLine()
		Local lineLast:Int = win.GetLastVisibleLine()
		
		Local hText:Int = dc.GetCharHeight()
		
		Local y:Int = 0
		For Local line:Int = lineFirst To lineLast
		
			dc.DrawLine(0, y, 1000, y)
			
			Local hLine:Int = win.OnGetLineHeight(line)
			dc.DrawText("Line " + line, 0, y + (hLine - hText) / 2)
			
			y:+ hLine
			dc.DrawLine(0, y, 1000, y)
		Next

		' remember to free the device context!!
		dc.Free()
	End Function

	Function OnScroll(event:wxEvent)
		VScrollWindow(event.parent).changed = True
		
		event.Skip()
	End Function
	
	Method OnGetLineHeight:Int(n:Int)
		If n Mod 2 Then
			Return 15
		Else
			Return 30
		End If
	End Method

End Type



New VScrollApp.run()

