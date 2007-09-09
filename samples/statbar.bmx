'
' wxStatusBar sample
'
' From the C++ sample by Vadim Zeitlin
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTimer
Import wx.wxCheckBox
Import wx.wxBitmapButton
Import wx.wxLog
Import wx.wxNumberEntryDialog
Import wx.wxMemoryDC
Import wx.wxStaticText

Import BRL.System

Const BITMAP_SIZE_X:Int = 32
Const BITMAP_SIZE_Y:Int = 15

' menu items
Const StatusBar_Quit:Int = wxID_EXIT
Const StatusBar_SetFields:Int = 2
Const StatusBar_Recreate:Int = 3
Const StatusBar_About:Int = wxID_ABOUT
Const StatusBar_Toggle:Int = 5
Const StatusBar_Checkbox:Int = 1000
Const StatusBar_SetStyle:Int = 1001
Const StatusBar_SetStyleNormal:Int = 1002
Const StatusBar_SetStyleFlat:Int = 1003
Const StatusBar_SetStyleRaised:Int = 1004

' Start the app !!!!!
New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create("wxStatusBar sample", 50, 50, 450, 340))

		frame.show()
		
		Return True
	
	End Method

End Type

Type MyStatusBar Extends wxStatusBar

	Const Field_Text:Int = 0
	Const Field_Checkbox:Int = 1
	Const Field_Bitmap:Int = 2
	Const Field_Clock:Int = 3
	Const Field_Max:Int = 4
	
	Field timer:wxTimer
	Field checkbox:wxCheckBox
	Field statbmp:wxBitmapButton
	
	Method OnInit()
		timer = New wxTimer.Create(Self)

		Local widths:Int[] = [ -1, 150, BITMAP_SIZE_X, 100 ]
		
		SetFieldsCount(Field_Max)
		SetStatusWidths(widths)
		
		checkbox = New wxCheckBox.Create(Self, StatusBar_Checkbox, "&Toggle clock")
		checkbox.SetValue(True)
		
		statbmp = New wxBitmapButton.Create(Self, wxID_ANY, CreateBitmapForButton(), ,, ,, wxBU_EXACTFIT)
		
		timer.Start(1000)
		
		SetMinHeight(BITMAP_SIZE_Y)
		
		UpdateClock()
	
		ConnectNoId(wxEVT_SIZE, OnSize)
		Connect(StatusBar_Checkbox, wxEVT_COMMAND_CHECKBOX_CLICKED, OnToggleClock)
		Connect(wxID_ANY, wxEVT_COMMAND_BUTTON_CLICKED, OnButton)
		Connect(wxID_ANY, wxEVT_TIMER, OnTimer)
	End Method
	
	' toggle the state of the status bar controls
	Method DoToggle()

		If checkbox.GetValue() Then
		
			timer.Start(1000)
			
			statbmp.SetBitmapLabel(CreateBitmapForButton(False))
			statbmp.Refresh()
			
			UpdateClock()
		
		Else ' don't show clock
		
			timer.Stop()
			
			statbmp.SetBitmapLabel(CreateBitmapForButton(True))
			statbmp.Refresh()
			
			
			SetStatusText("", Field_Clock)
		End If
	End Method

	Method CreateBitmapForButton:wxBitmap(on:Int = False)
		Const BMP_BUTTON_SIZE_X:Int = 10
		Const BMP_BUTTON_SIZE_Y:Int = 9
		
		Local bitmap:wxBitmap = New wxBitmap.CreateEmpty(BMP_BUTTON_SIZE_X, BMP_BUTTON_SIZE_Y)
		
		Local dc:wxMemoryDC = New wxMemoryDC.Create()
		dc.SelectObject(bitmap)
		
		If on Then
			dc.SetBrush(wxGREEN_BRUSH())
		Else
			dc.SetBrush(wxRED_BRUSH())
		End If
		
		dc.SetBackground(wxLIGHT_GREY_BRUSH())
		dc.Clear()
		dc.DrawEllipse(0, 0, BMP_BUTTON_SIZE_X, BMP_BUTTON_SIZE_Y)
		dc.SelectObject(wxNullBitmap())
		
		Return bitmap
	End Method

	Method UpdateClock()
		SetStatusText(CurrentTime(), Field_Clock)
	End Method

	' event handlers

	Function OnTimer(event:wxEvent)
		MyStatusBar(event.parent).UpdateClock()
	End Function
	
	Function OnSize(event:wxEvent)

		Local sb:MyStatusBar = MyStatusBar(event.parent)
		If  Not sb.checkbox Then
			Return
		End If
		
		Local x:Int, y:Int, width:Int, height:Int
		sb.GetFieldRect(Field_Checkbox, x, y, width, height)

		sb.checkbox.SetDimensions(x + 2, y + 2, width - 4, height - 4)
		
		sb.GetFieldRect(Field_Bitmap, x, y, width, height)
		
		Local sw:Int, sh:Int
		sb.statbmp.GetSize(sw, sh)
		
		sb.statbmp.Move(x + (width - sw) / 2, y + (height - sh) / 2)
		
		event.Skip()
	End Function
	
	Function OnToggleClock(event:wxEvent)
		MyStatusBar(event.parent).DoToggle()
	End Function
	
	Function OnButton(event:wxEvent)
		Local sb:MyStatusBar = MyStatusBar(event.parent)
		sb.checkbox.SetValue(Not sb.checkbox.GetValue())
		sb.DoToggle()
	End Function

End Type

Type MyFrame Extends wxFrame

	Field statbarDefault:wxStatusBar
	Field statbarCustom:MyStatusBar
	
	Field statbarStyle:Int
	Field statbarKind:Int

	Const StatBar_Default:Int = 0
	Const StatBar_Custom:Int = 1
	Const StatBar_Max:Int = 2

	Method OnInit()
		statbarDefault = Null
		statbarCustom = Null
		
		statbarStyle = wxSB_NORMAL
	
		' create a menu bar
		Local menuFile:wxMenu = New wxMenu.Create()
		menuFile.Append(StatusBar_Quit, "E&xit~tAlt-X", "Quit this program")
		
		Local statbarMenu:wxMenu = New wxMenu.Create()
		statbarMenu.Append(StatusBar_SetFields, "&Set field count~tCtrl-C", "Set the number of status bar fields")
		statbarMenu.Append(StatusBar_Toggle, "&Toggle Status Bar", "Toggle the status bar display", True)
		statbarMenu.Append(StatusBar_Recreate, "&Recreate~tCtrl-R", "Toggle status bar format")
		
		Local statbarStyleMenu:wxMenu = New wxMenu.Create()
		statbarStyleMenu.Append(StatusBar_SetStyleNormal, "&Normal", "Sets the style of the first field to normal (sunken) look", True)
		statbarStyleMenu.Append(StatusBar_SetStyleFlat, "&Flat", "Sets the style of the first field to flat look", True)
		statbarStyleMenu.Append(StatusBar_SetStyleRaised, "&Raised", "Sets the style of the first field to raised look", True)
		statbarMenu.AppendMenu(StatusBar_SetStyle, "Field style", statbarStyleMenu)
		
		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append(StatusBar_About, "&About...~tCtrl-A", "Show about dialog")
		
		' now append the freshly created menu To the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(statbarMenu, "&Status bar")
		menuBar.Append(helpMenu, "&Help")
		
		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)
		
		' create Default status bar To start with
		CreateStatusBar(2)
		statbarKind = StatBar_Default
		SetStatusText("Welcome to wxWidgets!")
		
		statbarDefault = GetStatusBar()

		Connect(StatusBar_Quit, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(StatusBar_SetFields, wxEVT_COMMAND_MENU_SELECTED, OnSetStatusFields)
		Connect(StatusBar_Recreate, wxEVT_COMMAND_MENU_SELECTED, OnRecreateStatusBar)
		Connect(StatusBar_About, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(StatusBar_Toggle, wxEVT_COMMAND_MENU_SELECTED, OnStatusBarToggle)
		Connect(StatusBar_SetStyleNormal, wxEVT_COMMAND_MENU_SELECTED, OnSetStyleNormal)
		Connect(StatusBar_SetStyleFlat, wxEVT_COMMAND_MENU_SELECTED, OnSetStyleFlat)
		Connect(StatusBar_SetStyleRaised, wxEVT_COMMAND_MENU_SELECTED, OnSetStyleRaised)
		Connect(StatusBar_Toggle, wxEVT_UPDATE_UI, OnUpdateStatusBarToggle)
		Connect(StatusBar_SetFields, wxEVT_UPDATE_UI, OnUpdateSetStatusFields)
		Connect(StatusBar_SetStyleNormal, wxEVT_UPDATE_UI, OnUpdateSetStyleNormal)
		Connect(StatusBar_SetStyleFlat, wxEVT_UPDATE_UI, OnUpdateSetStyleFlat)
		Connect(StatusBar_SetStyleRaised, wxEVT_UPDATE_UI, OnUpdateSetStyleRaised)
	End Method
	
	Function OnUpdateSetStatusFields(event:wxEvent)
		' only allow the settings of the number of status fields For the Default
		' status bar
		Local sb:wxStatusBar = MyFrame(event.parent).GetStatusBar()
		wxUpdateUIEvent(event).Enable(sb = MyFrame(event.parent).statbarDefault)
	End Function
	
	Function OnUpdateStatusBarToggle(event:wxEvent)
		wxUpdateUIEvent(event).Check(wxFrame(event.parent).GetStatusBar() <> Null)
	End Function
	
	Function OnUpdateSetStyleNormal(event:wxEvent)
		wxUpdateUIEvent(event).Check(MyFrame(event.parent).statbarStyle = wxSB_NORMAL)
	End Function
	
	Function OnUpdateSetStyleFlat(event:wxEvent)
		wxUpdateUIEvent(event).Check(MyFrame(event.parent).statbarStyle = wxSB_FLAT)
	End Function
	
	Function OnUpdateSetStyleRaised(event:wxEvent)
		wxUpdateUIEvent(event).Check(MyFrame(event.parent).statbarStyle = wxSB_RAISED)
	End Function
	
	Function OnStatusBarToggle(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local statbarOld:wxStatusBar = frame.GetStatusBar()
		If statbarOld Then
			statbarOld.Hide()
			frame.SetStatusBar(Null)
		Else
			frame.DoCreateStatusBar(frame.statbarKind)
		End If
	End Function
	
	Method DoCreateStatusBar(kind:Int)
		Local statbarOld:wxStatusBar = GetStatusBar()
		If statbarOld Then
			statbarOld.Hide()
		End If
		
		Select kind
			Case StatBar_Default
				SetStatusBar(statbarDefault)
			
			Case StatBar_Custom
				If Not statbarCustom Then
					statbarCustom = MyStatusBar(New MyStatusBar.Create(Self))
				End If
				SetStatusBar(statbarCustom)
			
			Default
				'wxFAIL_MSG("unknown stat bar kind")
		End Select
		
		ApplyStyle()
		GetStatusBar().Show()
		PositionStatusBar()
		
		statbarKind = kind
	End Method
	
	Method ApplyStyle()
		Local sb:wxStatusBar = GetStatusBar()
		Local fields:Int = sb.GetFieldsCount()
		Local styles:Int[] = New Int[fields]
		
		For Local i:Int = 1 Until fields
			styles[i] = wxSB_NORMAL
		Next
		
		styles[0] = statbarStyle
		
		sb.SetStatusStyles(styles)	
	End Method

	Function OnQuit(event:wxEvent)
		' True is To force the frame To close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		Local dlg:MyAboutDialog = New MyAboutDialog.Create(wxWindow(event.parent))
		dlg.ShowModal()
	End Function
	
	Function OnSetStatusFields(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local sb:wxStatusBar = frame.GetStatusBar()
		
		Local nFields:Int = wxGetNumberFromUser("Select the number of fields in the status bar", ..
			"Fields:", "wxWidgets statusbar sample", sb.GetFieldsCount(), 1, 5, frame)
		
		' we don't check if the number changed at all on purpose: calling
		' SetFieldsCount() with the same number of fields should be ok
		If nFields <> -1 Then

			Local def:Int[] = Null
			Local widthsFor2Fields:Int[] = [ 200, -1 ]
			Local widthsFor3Fields:Int[] = [ -1, -2, -1 ]
			Local widthsFor4Fields:Int[] = [ 100, -1, 100, -2 ]

			Local widthsAll:Int[][] = [ ..
				def,           ..     ' 1 Field: Default
				widthsFor2Fields, ..  ' 2 fields: 1 fixed, 1 Var
				widthsFor3Fields, ..  ' 3 fields: 3 Var
				widthsFor4Fields, ..  ' 4 fields: 3 fixed, 2 vars
				def             ..    ' 5 fields: Default (all have same width)
			]
			
			Local widths:Int[] = widthsAll[nFields - 1]
			sb.SetFieldsCount(nFields)
			sb.SetStatusWidths(widths)
			
			Local s:String
			For Local n:Int = 0 Until nFields
				If widths Then
					If widths[n] > 0 Then
						s = "fixed (" + widths[n] + ")"
					Else
						s = "variable (*" + (-widths[n]) + ")"
					End If
				
				Else
					s = "default"
				End If
				
				frame.SetStatusText(s, n)
			Next
			
		Else
			wxLogStatus("Cancelled", frame)
		End If
	End Function
	
	Function OnRecreateStatusBar(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		If frame.statbarKind = StatBar_Custom Then
			frame.DoCreateStatusBar(StatBar_Default)
		Else
			frame.DoCreateStatusBar(StatBar_Custom)
		End If
	End Function
	
	Function OnSetStyleNormal(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.statbarStyle = wxSB_NORMAL
		frame.ApplyStyle()
	End Function
	
	Function OnSetStyleFlat(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.statbarStyle = wxSB_FLAT
		frame.ApplyStyle()
	End Function
	
	Function OnSetStyleRaised(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.statbarStyle = wxSB_RAISED
		frame.ApplyStyle()
	End Function 

End Type

' ----------------------------------------------------------------------------
' MyAboutDialog
' ----------------------------------------------------------------------------
Type MyAboutDialog Extends wxDialog

	Method Create:MyAboutDialog(parent:wxWindow, id:Int = -1, title:String = "About statbar", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
	
		super.Create(parent, id, title, x, y, w, h, style)
		Return Self
	End Method
	
	Method OnInit()
		Local text:wxStaticText = New wxStaticText.Create(Self, wxID_ANY, "wxStatusBar sample~n" + ..
			"(c) 2000 Vadim Zeitlin~nBlitzmax port (c) 2007 Bruce A Henderson")

		Local btn:wxButton = New wxButton.Create(Self, wxID_OK, "&Close")
		
		' create the top status bar without the size grip (Default style),
		' otherwise it looks weird
		Local statbarTop:wxStatusBar = New wxStatusBar.Create(Self, wxID_ANY, 0)
		statbarTop.SetFieldsCount(3)
		statbarTop.SetStatusText("This is a top status bar", 0)
		statbarTop.SetStatusText("in a dialog", 1)
		statbarTop.SetStatusText("Great, isn't it?", 2)
		
		Local statbarBottom:wxStatusBar = New wxStatusBar.Create(Self, wxID_ANY)
		statbarBottom.SetFieldsCount(2)
		statbarBottom.SetStatusText("This is a bottom status bar", 0)
		statbarBottom.SetStatusText("in a dialog", 1)
		
		Local sizerTop:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		sizerTop.Add(statbarTop, 0, wxGROW)
		sizerTop.AddCustomSpacer(-1, 10, 1, wxGROW)
		sizerTop.Add(text, 0, wxCENTRE | wxRIGHT | wxLEFT, 20)
		sizerTop.AddCustomSpacer(-1, 10, 1, wxGROW)
		sizerTop.Add(btn, 0, wxCENTRE | wxRIGHT | wxLEFT, 20)
		sizerTop.AddCustomSpacer(-1, 10, 1, wxGROW)
		sizerTop.Add(statbarBottom, 0, wxGROW)
		
		SetSizer(sizerTop)
		
		sizerTop.Fit(Self)
		sizerTop.SetSizeHints(Self)

	End Method
End Type

