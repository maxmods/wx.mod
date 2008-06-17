SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMDI
Import wx.wxTextCtrl
Import wx.wxScrolledWindow
Import wx.wxTextEntryDialog

New MyApp.run()

Const MDI_QUIT:Int = wxID_EXIT
Const MDI_NEW_WINDOW:Int = 101
Const MDI_REFRESH:Int = 102
Const MDI_CHANGE_TITLE:Int = 103
Const MDI_CHANGE_POSITION:Int = 104
Const MDI_CHANGE_SIZE:Int = 105
Const MDI_CHILD_QUIT:Int = 106
Const MDI_ABOUT:Int = wxID_ABOUT

' For drawing lines in a canvas
Global xpos:Int = -1
Global ypos:Int = -1

Global gs_nFrames:Int = 0

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		wxInitAllImageHandlers()

		frame = MyFrame(New MyFrame.Create(Null,-1,"MDI Demo",,, 500, 400, wxDEFAULT_FRAME_STYLE | wxHSCROLL | wxVSCROLL))


		' Make a menubar
		Local file_menu:wxMenu = New wxMenu.Create()

		file_menu.Append(MDI_NEW_WINDOW, "&New window~tCtrl-N", "Create a new child window")
		file_menu.Append(MDI_QUIT, "&Exit~tAlt-X", "Quit the program")

		Local help_menu:wxMenu = New wxMenu.Create()
		help_menu.Append(MDI_ABOUT, "&About~tF1")

		Local menu_bar:wxMenuBar = New wxMenuBar.Create()

		menu_bar.Append(file_menu, "&File")
		menu_bar.Append(help_menu, "&Help")

		' Associate the menu bar with the frame
		frame.SetMenuBar(menu_bar)


		frame.CreateStatusBar()
		
		frame.show()
		SetTopWindow(frame)
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxMDIParentFrame

   	Field textWindow:wxTextCtrl

	Method OnInit()
'DebugStop
		textWindow = New wxTextCtrl.Create(Self, wxID_ANY, "A help window", ,, ,, wxTE_MULTILINE | wxSUNKEN_BORDER)

		CreateToolBar(wxNO_BORDER | wxTB_FLAT | wxTB_HORIZONTAL)
		InitToolBar(GetToolBar())

    ' Accelerators
		Local entries:wxAcceleratorEntry[] = New wxAcceleratorEntry[3]
		entries[0] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("N"), MDI_NEW_WINDOW)
		entries[1] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("X"), MDI_QUIT)
		entries[2] = New wxAcceleratorEntry.Create(wxACCEL_CTRL, Asc("A"), MDI_ABOUT)
		Local accel:wxAcceleratorTable = New wxAcceleratorTable.Create(entries)
		SetAcceleratorTable(accel)

		Connect(MDI_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(MDI_NEW_WINDOW, wxEVT_COMMAND_MENU_SELECTED, OnNewWindow)
		Connect(MDI_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		
		ConnectAny(wxEVT_CLOSE, OnClose)
		ConnectAny(wxEVT_SIZE, OnSize)
	End Method

	Method InitToolBar(toolBar:wxToolBar)

		Local bitmaps:wxBitmap[] = New wxBitmap[8]

		bitmaps[0] = wxBitmap.CreateFromFile("media/mdi/new.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[1] = wxBitmap.CreateFromFile("media/mdi/open.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[2] = wxBitmap.CreateFromFile("media/mdi/save.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[3] = wxBitmap.CreateFromFile("media/mdi/copy.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[4] = wxBitmap.CreateFromFile("media/mdi/cut.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[5] = wxBitmap.CreateFromFile("media/mdi/paste.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[6] = wxBitmap.CreateFromFile("media/mdi/print.xpm", wxBITMAP_TYPE_XPM)
		bitmaps[7] = wxBitmap.CreateFromFile("media/mdi/help.xpm", wxBITMAP_TYPE_XPM)

	
		toolBar.AddTool(MDI_NEW_WINDOW, "New", bitmaps[0], ,,"New file")
		toolBar.AddTool(1, "Open", bitmaps[1], ,,"Open file")
		toolBar.AddTool(2, "Save", bitmaps[2], ,,"Save file")
		toolBar.AddSeparator()
		toolBar.AddTool(3, "Copy", bitmaps[3], ,,"Copy")
		toolBar.AddTool(4, "Cut", bitmaps[4], ,,"Cut")
		toolBar.AddTool(5, "Paste", bitmaps[5], ,,"Paste")
		toolBar.AddSeparator()
		toolBar.AddTool(6, "Print", bitmaps[6], ,,"Print")
		toolBar.AddSeparator()
		toolBar.AddTool(MDI_ABOUT, "About", bitmaps[7], ,,"Help")

		toolBar.Realize()
	End Method

    Function OnActivate(event:wxEvent)
	End Function

    Function OnRefresh(event:wxEvent)
	End Function
	
	Function OnAbout(event:wxEvent)

	    wxMessageBox("wxWidgets 2.0 MDI Demo~n" + ..
                       "Author: Julian Smart (c) 1997~n" + ..
                       "Usage: mdi.exe", "About MDI Demo")
	End Function


    Function OnUpdateRefresh(event:wxEvent)
	End Function
	

    Function OnChangeTitle(event:wxEvent)
	End Function
	

    Function OnChangePosition(event:wxEvent)
	End Function
	

    Function OnChangeSize(event:wxEvent)
	End Function
	

	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close()
	End Function
	

	Function OnSize(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		
		Local w:Int, h:Int
		frame.GetClientSize(w, h)

		frame.textWindow.SetDimensions(0, 0, 200, h)
		frame.GetClientWindow().SetDimensions(200, 0, w - 200, h)

	End Function
	

    Function OnMove(event:wxEvent)
	End Function
	

    Function OnClose(evt:wxEvent)
		Local event:wxCloseEvent = wxCloseEvent(evt)
	
		If event.CanVeto() And gs_nFrames > 0 Then
			If wxMessageBox(gs_nFrames + " windows still open, close anyhow?", "Please confirm", ..
                          wxICON_QUESTION | wxYES_NO) <> wxYES Then
				event.Veto()
				Return
			End If
		End If

		event.Skip()

	End Function
	
	Function OnNewWindow(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
	
	
		' Make another frame, containing a canvas
		Local subframe:MyChild = MyChild(New MyChild.Create(frame, -1, "Canvas Frame"))
		
		Local title:String = "Canvas Frame " + gs_nFrames
		gs_nFrames:+ 1
		
		subframe.SetTitle(title)
		
		' Give it an icon
'		subframe.SetIcon(wxIcon(chart))
		
		'#If wxUSE_MENUS
		' Make a menubar
		Local file_menu:wxMenu = New wxMenu.Create()
		
		file_menu.Append(MDI_NEW_WINDOW, "&New window")
		file_menu.Append(MDI_CHILD_QUIT, "&Close child", "Close this window")
		file_menu.Append(MDI_QUIT, "&Exit")
		
		Local option_menu:wxMenu = New wxMenu.Create()
		
		option_menu.Append(MDI_REFRESH, "&Refresh picture")
		option_menu.Append(MDI_CHANGE_TITLE, "Change &title...~tCtrl-T")
		option_menu.AppendSeparator()
		option_menu.Append(MDI_CHANGE_POSITION, "Move frame~tCtrl-M")
		option_menu.Append(MDI_CHANGE_SIZE, "Resize frame~tCtrl-S")
		'#If wxUSE_CLIPBOARD
		option_menu.AppendSeparator()
		option_menu.Append(wxID_PASTE, "Copy text from clipboard~tCtrl-V")
		'#EndIf // wxUSE_CLIPBOARD
		
		Local help_menu:wxMenu = New wxMenu.Create()
		help_menu.Append(MDI_ABOUT, "&About")
		
		Local menu_bar:wxMenuBar = New wxMenuBar.Create()
		
		menu_bar.Append(file_menu, "&File")
		menu_bar.Append(option_menu, "&Child")
		menu_bar.Append(help_menu, "&Help")
		
		' Associate the menu bar with the frame
		subframe.SetMenuBar(menu_bar)
		'#EndIf // wxUSE_MENUS
		
		'#If wxUSE_STATUSBAR
		subframe.CreateStatusBar()
		subframe.SetStatusText(title)
		'#EndIf // wxUSE_STATUSBAR
		
		Local width:Int, height:Int
		subframe.GetClientSize(width, height)
		Local canvas:MyCanvas = MyCanvas(New MyCanvas.Create(subframe, -1, 0, 0, width, height))
'		canvas.SetCursor(New wxCursor.Create(wxCURSOR_PENCIL))
		subframe.canvas = canvas
		
		' Give it scrollbars
		canvas.SetScrollbars(20, 20, 50, 50)
		
		subframe.Show(True)
	End Function
	

End Type

Type MyChild Extends wxMDIChildFrame

	Field canvas:MyCanvas

	Method OnInit()


	    Connect(MDI_CHILD_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
	    Connect(MDI_REFRESH, wxEVT_COMMAND_MENU_SELECTED, OnRefresh)
	    Connect(MDI_CHANGE_TITLE, wxEVT_COMMAND_MENU_SELECTED, OnChangeTitle)
	    Connect(MDI_CHANGE_POSITION, wxEVT_COMMAND_MENU_SELECTED, OnChangePosition)
	    Connect(MDI_CHANGE_SIZE, wxEVT_COMMAND_MENU_SELECTED, OnChangeSize)
	
	    ConnectAny(wxID_PASTE, OnPaste)
		' EVT_UPDATE_UI(wxID_PASTE, MyChild::OnUpdatePaste)
	
	    ConnectAny(wxEVT_SIZE, OnSize)
	    ConnectAny(wxEVT_MOVE, OnMove)
	
	    ConnectAny(wxEVT_CLOSE, OnClose)

	End Method

    'Function OnActivate(wxActivateEvent& event)

    Function OnRefresh(event:wxEvent)
		Local frame:MyChild = MyChild(event.parent)
		If frame.canvas Then
			frame.canvas.Refresh()
		End If
	End Function
	
    Function OnUpdateRefresh(event:wxEvent)
	End Function
	
    Function OnChangeTitle(event:wxEvent)
		Global s_title:String = "Canvas Frame"
		
		Local title:String = wxGetTextFromUser("Enter the new title for MDI child", ..
			"MDI sample question", s_title, MyChild(event.parent).GetParent().GetParent())
		If Not title Then
			Return
		End If
		
		s_title = title
		MyChild(event.parent).SetTitle(s_title)
	End Function
	
    Function OnChangePosition(event:wxEvent)
		MyChild(event.parent).Move(10, 10)
	End Function
	
	Function OnChangeSize(event:wxEvent)
		MyChild(event.parent).SetClientSize(100, 100)
	End Function
	
    Function OnQuit(event:wxEvent)
		MyChild(event.parent).Close(True)
	End Function
	
    Function OnSize(event:wxEvent)
	End Function
	
    Function OnMove(event:wxEvent)
	End Function
	
    Function OnClose(evt:wxEvent)
		Local event:wxCloseEvent = wxCloseEvent(evt)
		Local frame:MyChild = MyChild(event.parent)

		If frame.canvas And frame.canvas.IsDirty() Then
			If wxMessageBox("Really close?", "Please confirm", ..
			           wxICON_QUESTION | wxYES_NO) <> wxYES Then
				event.Veto()
				Return
			End If
		End If
		
		gs_nFrames:- 1
		
		event.Skip()
	End Function

    Function OnPaste(event:wxEvent)
	End Function

    Function OnUpdatePaste(event:wxEvent)
	End Function
	
End Type


Type MyCanvas Extends wxScrolledWindow

	Field m_text:String
	Field m_dirty:Int

	Method OnInit()
		ConnectAny(wxEVT_MOUSE_EVENTS, OnEvent)
	End Method

    Method OnDraw(DC:wxDC)
		If Not m_text Then
		    dc.DrawText(m_text, 10, 10)
		End If
		
		dc.SetFont(wxSWISS_FONT())
		dc.SetPen(wxGREEN_PEN())
		dc.DrawLine(0, 0, 200, 200)
		dc.DrawLine(200, 0, 0, 200)
		
		dc.SetBrush(wxCYAN_BRUSH())
		dc.SetPen(wxRED_PEN())
		dc.DrawRectangle(100, 100, 100, 50)
		dc.DrawRoundedRectangle(150, 150, 100, 50, 20)
		
		dc.DrawEllipse(250, 250, 100, 50)
'		#If wxUSE_SPLINES
'		dc.DrawSpline(50, 200, 50, 100, 200, 10)
'		#EndIf // wxUSE_SPLINES
		dc.DrawLine(50, 230, 200, 230)
		dc.DrawText("This is a test string", 50, 230)
		
'		wxPoint points[3]
'		points[0].x = 200 points[0].y = 300
'		points[1].x = 100 points[1].y = 400
'		points[2].x = 300 points[2].y = 400
'		
'		dc.DrawPolygon(3, points)
	End Method

    Method IsDirty:Int()
		Return m_dirty
	End Method
	
    Function OnEvent(evt:wxEvent)
		Local event:wxMouseEvent = wxMouseEvent(evt)
		Local canvas:MyCanvas = MyCanvas(evt.parent)

		Local dc:wxClientDC = New wxClientDC.Create(canvas)
		canvas.PrepareDC(dc)
		
		Local ptX:Int, ptY:Int
		event.GetLogicalPosition(dc, ptX, ptY)
		
		If xpos > -1 And ypos > -1 And event.Dragging() Then
			dc.SetPen(wxBLACK_PEN())
			dc.DrawLine(xpos, ypos, ptX, ptY)
		
			canvas.m_dirty = True
		End If
		
		xpos = ptX
		ypos = ptY
		
		' remember to release the DC!
		dc.Free()
	End Function

    Method SetText(text:String)
		m_text = text
	End Method

End Type


