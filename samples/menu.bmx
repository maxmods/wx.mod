SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMouseEvent
Import wx.wxTextCtrl
Import wx.wxLog

New MyApp.run()

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxWidgets menu sample"))

		frame.show()
		
		frame.SetStatusText("Welcome to wxWidgets menu sample")
		
		SetTopWindow(frame)
		
		Return True
	
	End Method

End Type

' Constants
Const Menu_File_Quit:Int = wxID_EXIT
Const Menu_File_ClearLog:Int = 100

Const Menu_MenuBar_Toggle:Int = 200
Const Menu_MenuBar_Append:Int = 201
Const Menu_MenuBar_Insert:Int = 202
Const Menu_MenuBar_Delete:Int = 203
Const Menu_MenuBar_Enable:Int = 204
Const Menu_MenuBar_GetLabel:Int = 205
Const Menu_MenuBar_SetLabel:Int = 206
Const Menu_MenuBar_FindMenu:Int = 207

Const Menu_Menu_Append:Int = 300
Const Menu_Menu_AppendSub:Int = 301
Const Menu_Menu_Insert:Int = 302
Const Menu_Menu_Delete:Int = 303
Const Menu_Menu_Enable:Int = 304
Const Menu_Menu_Check:Int = 305
Const Menu_Menu_GetLabel:Int = 306
Const Menu_Menu_SetLabel:Int = 307
Const Menu_Menu_GetInfo:Int = 308
Const Menu_Menu_FindItem:Int = 309

Const Menu_Test_Normal:Int = 400
Const Menu_Test_Check:Int = 401
Const Menu_Test_Radio1:Int = 402
Const Menu_Test_Radio2:Int = 403
Const Menu_Test_Radio3:Int = 404

Const Menu_SubMenu:Int = 450
Const Menu_SubMenu_Normal:Int = 451
Const Menu_SubMenu_Check:Int = 452
Const Menu_SubMenu_Radio1:Int = 453
Const Menu_SubMenu_Radio2:Int = 454
Const Menu_SubMenu_Radio3:Int = 455

Const Menu_Dummy_First:Int = 500
Const Menu_Dummy_Second:Int = 501
Const Menu_Dummy_Third:Int = 502
Const Menu_Dummy_Fourth:Int = 503
Const Menu_Dummy_Last:Int = 504

Const Menu_Help_About:Int = wxID_ABOUT

Const Menu_Popup_ToBeDeleted:Int = 2000
Const Menu_Popup_ToBeGreyed:Int = 2001
Const Menu_Popup_ToBeChecked:Int = 2002
Const Menu_Popup_Submenu:Int = 2003

Const Menu_Max:Int = 2004

Type MyFrame Extends wxFrame

	' the menu previously detached from the menubar (May be Null)
	Field menu:wxMenu
	
	' the count of dummy menus already created
	Field countDummy:Int
	
	
	' the control used For logging
	Field textctrl:wxTextCtrl
	
	
	' the previous Log target
'	Field logOld:wxLog

	Method OnInit()
	
		CreateStatusBar()
		
		' create the menubar
		Local fileMenu:wxMenu = New wxMenu.Create()
		
		Local stockSubMenu:wxMenu = New wxMenu.Create()
		stockSubMenu.Append(wxID_ADD)
		stockSubMenu.Append(wxID_APPLY)
		stockSubMenu.Append(wxID_BOLD)
		stockSubMenu.Append(wxID_CANCEL)
		stockSubMenu.Append(wxID_CLEAR)
		stockSubMenu.Append(wxID_CLOSE)
		stockSubMenu.Append(wxID_COPY)
		stockSubMenu.Append(wxID_CUT)
		stockSubMenu.Append(wxID_DELETE)
		stockSubMenu.Append(wxID_FIND)
		stockSubMenu.Append(wxID_REPLACE)
		stockSubMenu.Append(wxID_BACKWARD)
		stockSubMenu.Append(wxID_DOWN)
		stockSubMenu.Append(wxID_FORWARD)
		stockSubMenu.Append(wxID_UP)
		stockSubMenu.Append(wxID_HELP)
		stockSubMenu.Append(wxID_HOME)
		stockSubMenu.Append(wxID_INDENT)
		stockSubMenu.Append(wxID_INDEX)
		stockSubMenu.Append(wxID_ITALIC)
		stockSubMenu.Append(wxID_JUSTIFY_CENTER)
		stockSubMenu.Append(wxID_JUSTIFY_FILL)
		stockSubMenu.Append(wxID_JUSTIFY_LEFT)
		stockSubMenu.Append(wxID_JUSTIFY_RIGHT)
		stockSubMenu.Append(wxID_NEW)
		stockSubMenu.Append(wxID_NO)
		stockSubMenu.Append(wxID_OK)
		stockSubMenu.Append(wxID_OPEN)
		stockSubMenu.Append(wxID_PASTE)
		stockSubMenu.Append(wxID_PREFERENCES)
		stockSubMenu.Append(wxID_PRINT)
		stockSubMenu.Append(wxID_PREVIEW)
		stockSubMenu.Append(wxID_PROPERTIES)
		stockSubMenu.Append(wxID_EXIT)
		stockSubMenu.Append(wxID_REDO)
		stockSubMenu.Append(wxID_REFRESH)
		stockSubMenu.Append(wxID_REMOVE)
		stockSubMenu.Append(wxID_REVERT_TO_SAVED)
		stockSubMenu.Append(wxID_SAVE)
		stockSubMenu.Append(wxID_SAVEAS)
		stockSubMenu.Append(wxID_STOP)
		stockSubMenu.Append(wxID_UNDELETE)
		stockSubMenu.Append(wxID_UNDERLINE)
		stockSubMenu.Append(wxID_UNDO)
		stockSubMenu.Append(wxID_UNINDENT)
		stockSubMenu.Append(wxID_YES)
		stockSubMenu.Append(wxID_ZOOM_100)
		stockSubMenu.Append(wxID_ZOOM_FIT)
		stockSubMenu.Append(wxID_ZOOM_IN)
		stockSubMenu.Append(wxID_ZOOM_OUT)
		fileMenu.AppendSubMenu(stockSubMenu, "&Standard items demo")

'    wxMenuItem *item = New wxMenuItem(fileMenu, Menu_File_ClearLog,
'                                      "Clear &log~tCtrl-L"));
'#If wxUSE_OWNER_DRAWN || defined(__WXGTK__)
'    item.SetBitmap(copy_xpm);
'#EndIf
'    fileMenu.Append(item);
'    fileMenu.AppendSeparator();
'#EndIf // USE_LOG_WINDOW

		fileMenu.Append(Menu_File_Quit, "E&xit~tAlt-X", "Quit menu sample")
	
		Local menubarMenu:wxMenu = New wxMenu.Create()
		menubarMenu.Append(Menu_MenuBar_Append, "&Append menu~tCtrl-A", "Append a menu to the menubar")
		menubarMenu.Append(Menu_MenuBar_Insert, "&Insert menu~tCtrl-I", "Insert a menu into the menubar")
		menubarMenu.Append(Menu_MenuBar_Delete, "&Delete menu~tCtrl-D", "Delete the last menu from the menubar")
		menubarMenu.Append(Menu_MenuBar_Toggle, "&Toggle menu~tCtrl-T", "Toggle the first menu in the menubar", True)
		menubarMenu.AppendSeparator()
		menubarMenu.Append(Menu_MenuBar_Enable, "&Enable menu~tCtrl-E", "Enable or disable the last menu", True)
		menubarMenu.AppendSeparator()
		menubarMenu.Append(Menu_MenuBar_GetLabel, "&Get menu label~tCtrl-G", "Get the label of the last menu")
		menubarMenu.Append(Menu_MenuBar_SetLabel, "&Set menu label~tCtrl-S", "Change the label of the last menu")
		menubarMenu.AppendSeparator()
		menubarMenu.Append(Menu_MenuBar_FindMenu, "&Find menu from label~tCtrl-F", "Find a menu by searching for its label")

		Local subMenu:wxMenu = New wxMenu.Create()
		subMenu.Append(Menu_SubMenu_Normal, "&Normal submenu item", "Disabled submenu item")
		subMenu.AppendCheckItem(Menu_SubMenu_Check, "&Check submenu item", "Check submenu item")
		subMenu.AppendRadioItem(Menu_SubMenu_Radio1, "Radio item &1", "Radio item")
		subMenu.AppendRadioItem(Menu_SubMenu_Radio2, "Radio item &2", "Radio item")
		subMenu.AppendRadioItem(Menu_SubMenu_Radio3, "Radio item &3", "Radio item")
		
		menubarMenu.AppendMenu(Menu_SubMenu, "Submenu", subMenu)
		
		Local menuMenu:wxMenu = New wxMenu.Create()
		menuMenu.Append(Menu_Menu_Append, "&Append menu item~tAlt-A", "Append a menu item to the last menu")
		menuMenu.Append(Menu_Menu_AppendSub, "&Append sub menu~tAlt-S", "Append a sub menu to the last menu")
		menuMenu.Append(Menu_Menu_Insert, "&Insert menu item~tAlt-I", "Insert a menu item in head of the last menu")
		menuMenu.Append(Menu_Menu_Delete, "&Delete menu item~tAlt-D", "Delete the last menu item from the last menu")
		menuMenu.AppendSeparator()
		menuMenu.Append(Menu_Menu_Enable, "&Enable menu item~tAlt-E", "Enable or disable the last menu item", True)
		menuMenu.Append(Menu_Menu_Check, "&Check menu item~tAlt-C", "Check or uncheck the last menu item", True)
		menuMenu.AppendSeparator()
		menuMenu.Append(Menu_Menu_GetInfo, "Get menu item in&fo~tAlt-F", "Show the state of the last menu item")
		menuMenu.Append(Menu_Menu_SetLabel, "Set menu item label~tAlt-L", "Set the label of a menu item")
		menuMenu.AppendSeparator()
		menuMenu.Append(Menu_Menu_FindItem, "Find menu item from label", "Find a menu item by searching for its label")
		
		Local testMenu:wxMenu = New wxMenu.Create()
		testMenu.Append(Menu_Test_Normal, "&Normal item")
		testMenu.AppendSeparator()
		testMenu.AppendCheckItem(Menu_Test_Check, "&Check item")
		testMenu.AppendSeparator()
		testMenu.AppendRadioItem(Menu_Test_Radio1, "Radio item &1")
		testMenu.AppendRadioItem(Menu_Test_Radio2, "Radio item &2")
		testMenu.AppendRadioItem(Menu_Test_Radio3, "Radio item &3")
		
		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append(Menu_Help_About, "&About~tF1", "About menu sample")

		Local menuBar:wxMenuBar = New wxMenuBar.Create( wxMB_DOCKABLE )
		
		menuBar.Append(fileMenu, "&File")
		menuBar.Append(menubarMenu, "Menu&bar")
		menuBar.Append(menuMenu, "&Menu")
		menuBar.Append(testMenu, "&Test")
		menuBar.Append(helpMenu, "&Help")
		
		' these items should be initially checked
		menuBar.Check(Menu_MenuBar_Toggle, True)
		menuBar.Check(Menu_MenuBar_Enable, True)
		menuBar.Check(Menu_Menu_Enable, True)
		menuBar.Check(Menu_Menu_Check, False)
		
		' associate the menu bar with the frame
		SetMenuBar(menuBar)

		' intercept all menu events And Log them in this custom event handler
		PushEventHandler(New MyEvtHandler.Create(Self))

		' create the Log text window
		textctrl = New wxTextCtrl.Create(Self, wxID_ANY, "", ,, ,, wxTE_MULTILINE)
		textctrl.SetEditable(False)
		
		'wxLog::SetTimestamp(Null);
		'm_logOld = wxLog::SetActiveTarget(New wxLogTextCtrl(m_textctrl));
		
		wxLogMessage("Brief explanations: the commands or the ~qMenu~q menu " + ..
			"append/insert/delete items to/from the last menu.~n" + ..
			"The commands from ~qMenubar~q menu work with the " + ..
			"menubar itself.~n~n" + ..
			"Right click the band below to test popup menus.~n")
		
	End Method

	Method LogMenuEvent(event:wxEvent)
		Local id:Int = event.GetId()
		
		Local msg:String = "Menu command " + id
		
		' Catch all checkable menubar items And also the check item from the popup menu
		Local item:wxMenuItem = GetMenuBar().FindItem(id)
		If (item And item.IsCheckable()) Or (id = Menu_Popup_ToBeChecked) Then
			msg:+ " (the item is currently "
			If Not event.IsChecked Then
				msg:+ "not "
			End If
		
			msg:+"checked)"      
		End If

		wxLogMessage(msg)
	End Method	
	
	Function OnQuit(event:wxEvent)
		wxFrame(event.parent).Close(True)
	End Function
	
	Function OnClearLog(event:wxEvent)
		MyFrame(event.parent).textctrl.Clear()
	End Function
	
	Function OnClearLogUpdateUI(event:wxEvent)
		' if we only enable this item when the log window is empty, we never see
		' it in the disable state as a message is logged whenever the menu is
		' opened, so we disable it if there is not "much" text in the window
		event.Enable( MyFrame(event.parent).textctrl.GetNumberOfLines() > 5 )
	End Function
	
	Function OnAbout(event:wxEvent)
		wxMessageBox("wxWidgets menu sample~n(c) 1999-2001 Vadim Zeitlin" + ..
			"~nBlitzmax port (c) 2007 Bruce A Henderson", ..
			"About wxWidgets menu sample", wxICON_INFORMATION)
	End Function
	
	Function OnDummy(event:wxEvent)
	End Function
	
	Function OnAppendMenuItem(event:wxEvent)
	End Function
	
	Function OnAppendSubMenu(event:wxEvent)
	End Function
	
	Function OnDeleteMenuItem(event:wxEvent)
	End Function
	
	Function OnInsertMenuItem(event:wxEvent)
	End Function
	
	Function OnCheckMenuItem(event:wxEvent)
	End Function
	
	Function OnEnableMenuItem(event:wxEvent)
	End Function
	
	Function OnGetLabelMenuItem(event:wxEvent)
	End Function
	
	Function OnSetLabelMenuItem(event:wxEvent)
	End Function
	
	Function OnGetMenuItemInfo(event:wxEvent)
	End Function
	
	Function OnFindMenuItem(event:wxEvent)
	End Function
	
	Function OnAppendMenu(event:wxEvent)
	End Function
	
	Function OnInsertMenu(event:wxEvent)
	End Function
	
	Function OnDeleteMenu(event:wxEvent)
	End Function
	
	Function OnToggleMenu(event:wxEvent)
	End Function
	
	Function OnEnableMenu(event:wxEvent)
	End Function
	
	Function OnGetLabelMenu(event:wxEvent)
	End Function
	
	Function OnSetLabelMenu(event:wxEvent)
	End Function
	
	Function OnFindMenu(event:wxEvent)
	End Function
	
	Function OnTestNormal(event:wxEvent)
	End Function
	
	Function OnTestCheck(event:wxEvent)
	End Function
	
	Function OnTestRadio(event:wxEvent)
	End Function
	
	Function OnUpdateSubMenuNormal(event:wxEvent)
	End Function
	
	Function OnUpdateSubMenuCheck(event:wxEvent)
	End Function
	
	Function OnUpdateSubMenuRadio(event:wxEvent)
	End Function
	
	Function OnContextMenu(event:wxEvent)
	End Function
	
	Function OnRightUp(event:wxEvent)
		Local x:Int, y:Int
		wxMouseEvent(event).GetPosition(x, y)
		MyFrame(event.parent).ShowContextMenu(x, y)
	End Function
 
	Function OnMenuOpen(event:wxEvent)
		MyFrame(event.parent).LogMenuOpenOrClose(wxMenuEvent(event), "opened")
		event.Skip()
	End Function
	
	Function OnMenuClose(event:wxEvent)
		MyFrame(event.parent).LogMenuOpenOrClose(wxMenuEvent(event), "closed")	
		event.Skip()
	End Function
		
	Function OnUpdateCheckMenuItemUI(event:wxEvent)
	End Function
	
	Function OnSize(event:wxEvent)
	End Function
	
	Method LogMenuOpenOrClose(event:wxMenuEvent, what:String)
	End Method
	
	Method ShowContextMenu(x:Int, y:Int)
	End Method

	Method CreateDummyMenu:wxMenu(title:String)
	End Method
	
	Method GetLastMenuItem:wxMenuItem()
	End Method
	
End Type


' A small helper class which intercepts all menu events And logs them
Type MyEvtHandler Extends wxEvtHandler

	Field frame:MyFrame
	
	Method Create:MyEvtHandler(_frame:MyFrame)
		frame = _frame
		Return MyEvtHandler(CreateHandler())
	End Method
	
	Method OnInit()
	    Connect(wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, OnMenuEvent)
	End Method
		
	Function OnMenuEvent(event:wxEvent)
		MyEvtHandler(event.parent).frame.LogMenuEvent(event)
	
		event.Skip()
	End Function

End Type

