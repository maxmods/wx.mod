SuperStrict

Framework wx.wx
Import wx.wxApp
Import wx.wxFrame
Import wx.wxTaskBarIcon

Global Application : TApplication

Try
	Application = New TApplication
	Application.Run()
Catch Exception : Object
	wxMessageBox(Exception.ToString(), "Fatal error", wxICON_ERROR)
End Try

Type TApplication Extends wxApp
	Field Frame : TFrame

	Method OnInit:Int()
	
		wxInitAllImageHandlers()
	
		Frame = New TFrame
		Frame.Create(,, "TrayIcon Test",,,,, wxCAPTION|wxCLOSE_BOX|wxMINIMIZE_BOX|wxSYSTEM_MENU)
		Frame.Show()
		SetTopWindow(Frame)
		
		Return True
	End Method
End Type

Type TFrame Extends wxFrame
	Const ID_MENU_OPEN : Int = 100, ..
	      ID_MENU_EXIT : Int = 101
	
	Field Icon     : wxIcon
	Field TrayIcon : wxTaskBarIcon
	'Field Popup    : wxMenu
	
	Method OnInit()
		' Load Icon
		Icon = New wxIcon.Create()
		Icon.LoadFile("media/taskbaricon/Icon.ico", wxBITMAP_TYPE_ICO)
		If Not Icon.IsOk() Then Throw("Can't load 'Icon.ico'")
		
		' Create tray icon with popup menu
		TrayIcon = New MyTaskBarIcon.Create(wxTBI_DOCK)

		' Set icon for caption and taskbar
		Self.SetIcon(Icon)
		TrayIcon.SetIcon(Icon, "")
		
		TrayIcon.ConnectAny(wxEVT_TASKBAR_LEFT_DCLICK, OnTrayDClick)
'		TrayIcon.ConnectAny(wxEVT_TASKBAR_RIGHT_UP, OnTrayRightUp)
		TrayIcon.Connect(ID_MENU_OPEN, wxEVT_COMMAND_MENU_SELECTED, OnPopupOpen)
		TrayIcon.Connect(ID_MENU_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnPopupExit)
		
		'Popup = New wxMenu.Create()
		'Popup.Append(ID_MENU_OPEN, "Open")
		'Popup.Append(ID_MENU_EXIT, "Exit")
		
		' Connect some events
		ConnectAny(wxEVT_ICONIZE, OnIconize)
		ConnectAny(wxEVT_CLOSE, OnClose)
	End Method
	
	Function OnIconize(E:wxEvent)
		Local Event : wxIconizeEvent, ..
		      _Self : TFrame
		
		Event = wxIconizeEvent(E)
		_Self = TFrame(Event.Parent)
		
		' If minimize, than hide frame and show tray icon
		If Event.Iconized() Then
			_Self.Hide()
			_Self.TrayIcon.SetIcon(_Self.Icon, "Some tooltip text")
		EndIf
	End Function
	
	Function OnTrayDClick(E:wxEvent)
		Local Event : wxTaskBarIconEvent, ..
		      _Self : wxTaskBarIcon
		
		Event = wxTaskBarIconEvent(E)
		_Self = wxTaskBarIcon(Event.Parent)
		Application.Frame.Show()
		' Maximize(False) results a restore
		Application.Frame.Maximize(False)
		Application.Frame.SetFocus()
		_Self.RemoveIcon()
	End Function

'	Function OnTrayRightUp(E:wxEvent)
'		Local Event : wxTaskBarIconEvent, ..
'		      _Self : wxTaskBarIcon

'		Event = wxTaskBarIconEvent(E)
'		_Self = wxTaskBarIcon(Event.Parent)

		' Show popup menu		
'		_Self.PopupMenu(Application.Frame.Popup)
'	End Function
	
	Function OnPopupOpen(E:wxEvent)
		Application.Frame.Show()
		Application.Frame.SetFocus()
		Application.Frame.TrayIcon.RemoveIcon()
	End Function
	
	Function OnPopupExit(E:wxEvent)
		Application.Frame.Close()
	End Function
	
	Function OnClose(E:wxEvent)
		Local Event : wxCloseEvent, ..
		      _Self : TFrame
		
		Event = wxCloseEvent(E)
		_Self = TFrame(Event.Parent)
		
		' Remove icon before you close the application!
		_Self.TrayIcon.RemoveIcon()
		End
	End Function
End Type

Type MyTaskBarIcon Extends wxTaskBarIcon

	Method CreatePopupMenu:wxMenu()
		Local Popup:wxMenu = New wxMenu.Create()
		Popup.Append(TFrame.ID_MENU_OPEN, "Open")
		Popup.Append(TFrame.ID_MENU_EXIT, "Exit")
		
		Return Popup
	End Method

End Type

