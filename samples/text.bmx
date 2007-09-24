SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxTextCtrl
Import wx.wxLog
Import wx.wxTextEntryDialog
Import wx.wxNumberEntryDialog
Import wx.wxMessageDialog
Import wx.wxMouseEvent

New MyApp.run()



Type MyApp Extends wxApp

	Method OnInit:Int()

		Local frame:MyFrame = MyFrame(New MyFrame.Create(Null, -1, "Text wxWidgets sample", 50, 50, 700, 550))
		
		frame.SetSizeHints( 500, 400 )

		Local file_menu:wxMenu = New wxMenu.Create()
		file_menu.Append(TEXT_SAVE, "&Save file~tCtrl-S", "Save the text control contents to file")
		file_menu.Append(TEXT_LOAD, "&Load file~tCtrl-O", "Load the sample file into text control")
		file_menu.AppendSeparator()
		file_menu.Append(TEXT_RICH_TEXT_TEST, "Show Rich Text Editor")
		file_menu.AppendSeparator()
		file_menu.Append(TEXT_ABOUT, "&About~tAlt-A")
		file_menu.AppendSeparator()
		file_menu.Append(TEXT_QUIT, "E&xit~tAlt-X", "Quit this sample")
		
		Local menu_bar:wxMenuBar = New wxMenuBar.Create( wxMB_DOCKABLE )
		menu_bar.Append(file_menu, "&File")
		
		
		Local tooltip_menu:wxMenu = New wxMenu.Create()
		tooltip_menu.Append(TEXT_TOOLTIPS_SETDELAY, "Set &delay~tCtrl-D")
		tooltip_menu.AppendSeparator()
		tooltip_menu.Append(TEXT_TOOLTIPS_ENABLE, "&Toggle tooltips~tCtrl-T", "enable/disable tooltips", True)
		tooltip_menu.Check(TEXT_TOOLTIPS_ENABLE, True)
		menu_bar.Append(tooltip_menu, "&Tooltips")
		
		
		
		' notice that we use non Default accelerators on purpose here To compare
		' their behaviour with the built in handling of standard Ctrl/Cmd-C/V
		Local menuClipboard:wxMenu = New wxMenu.Create()
		menuClipboard.Append(TEXT_CLIPBOARD_COPY, "&Copy~tCtrl-Shift-C", "Copy the selection to the clipboard")
		menuClipboard.Append(TEXT_CLIPBOARD_PASTE, "&Paste~tCtrl-Shift-V", "Paste from clipboard to the text control")
		menuClipboard.AppendSeparator()
		menuClipboard.AppendCheckItem(TEXT_CLIPBOARD_VETO, "Vet&o~tCtrl-Shift-O", "Veto all clipboard operations")
		menu_bar.Append(menuClipboard, "&Clipboard")
		
		
		Local MenuText:wxMenu = New wxMenu.Create()
		MenuText.Append(TEXT_ADD_SOME, "&Append some text~tCtrl-A")
		MenuText.Append(TEXT_ADD_FREEZE, "&Append text with freeze/thaw~tShift-Ctrl-A")
		MenuText.Append(TEXT_REMOVE, "&Remove first 10 characters~tCtrl-Y")
		MenuText.Append(TEXT_REPLACE, "&Replace characters 4 to 8 with ABC~tCtrl-R")
		MenuText.Append(TEXT_SELECT, "&Select characters 4 to 8~tCtrl-I")
		MenuText.Append(TEXT_SET, "&Set the first text zone value~tCtrl-E")
		MenuText.Append(TEXT_CHANGE, "&Change the first text zone value~tShift-Ctrl-E")
		MenuText.AppendSeparator()
		MenuText.Append(TEXT_MOVE_ENDTEXT, "Move cursor to the end of &text")
		MenuText.Append(TEXT_MOVE_ENDENTRY, "Move cursor to the end of &entry")
		MenuText.AppendCheckItem(TEXT_SET_EDITABLE, "Toggle &editable state")
		MenuText.AppendCheckItem(TEXT_SET_ENABLED, "Toggle e&nabled state")
		MenuText.Check(TEXT_SET_EDITABLE, True)
		MenuText.Check(TEXT_SET_ENABLED, True)
		MenuText.AppendSeparator()
		MenuText.Append(TEXT_LINE_DOWN, "Scroll text one line down")
		MenuText.Append(TEXT_LINE_UP, "Scroll text one line up")
		MenuText.Append(TEXT_PAGE_DOWN, "Scroll text one page down")
		MenuText.Append(TEXT_PAGE_UP, "Scroll text one page up")
		MenuText.AppendSeparator()
		MenuText.Append(TEXT_GET_LINE, "Get the text of a line of the tabbed multiline")
		MenuText.Append(TEXT_GET_LINELENGTH, "Get the length of a line of the tabbed multiline")
		menu_bar.Append(MenuText, "Te&xt")
		
		
		Local menuLog:wxMenu = New wxMenu.Create()
		menuLog.AppendCheckItem(TEXT_LOG_KEY, "Log &key events")
		menuLog.AppendCheckItem(TEXT_LOG_CHAR, "Log &char events")
		menuLog.AppendCheckItem(TEXT_LOG_MOUSE, "Log &mouse events")
		menuLog.AppendCheckItem(TEXT_LOG_TEXT, "Log &text events")
		menuLog.AppendCheckItem(TEXT_LOG_FOCUS, "Log &focus events")
		menuLog.AppendCheckItem(TEXT_LOG_CLIP, "Log clip&board events")
		menuLog.AppendSeparator()
		menuLog.Append(TEXT_CLEAR, "&Clear the log~tCtrl-L", "Clear the log window contents")
		
		' Select only the interesting events by Default
		MyTextCtrl.logClip = True
		MyTextCtrl.logText = True
		
		menuLog.Check(TEXT_LOG_KEY, MyTextCtrl.logKey)
		menuLog.Check(TEXT_LOG_CHAR, MyTextCtrl.logChar)
		menuLog.Check(TEXT_LOG_TEXT, MyTextCtrl.logText)
		
		menu_bar.Append(menuLog, "&Log")
		
		
		frame.SetMenuBar(menu_bar)
		
		frame.Show(True)
		
		SetTopWindow(frame)
	
		Return True
	
	End Method

End Type




Type MyTextCtrl Extends wxTextCtrl

	Global logKey:Int
	Global logChar:Int
	Global logMouse:Int
	Global logText:Int
	Global logFocus:Int
	Global logClip:Int
	
	Field hasCapture:Int
	
	Method OnInit()
		ConnectAny(wxEVT_KEY_DOWN, OnKeyDown)
		ConnectAny(wxEVT_KEY_UP, OnKeyUp)
		ConnectAny(wxEVT_CHAR, OnChar)
		
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_UPDATED, OnText)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_ENTER, OnTextEnter)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_URL, OnTextURL)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_MAXLEN, OnTextMaxLen)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_CUT, OnTextCut)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_COPY, OnTextCopy)
		Connect(wxID_ANY, wxEVT_COMMAND_TEXT_PASTE, OnTextPaste)
		
		ConnectAny(wxEVT_MOUSE_EVENTS, OnMouseEvent)
		
		ConnectAny(wxEVT_SET_FOCUS, OnSetFocus)
		ConnectAny(wxEVT_KILL_FOCUS, OnKillFocus)
	End Method

	Function OnKeyDown(event:wxEvent)
		MyTextCtrl(event.parent).DoKeyDown(wxKeyEvent(event))
	End Function

	Method DoKeyDown(event:wxKeyEvent)
		Select event.GetKeyCode()
		
			Case WXK_F1
				' show current position And text length
				
				Local line:Int, column:Int, pos:Int
				pos = GetInsertionPoint()
				PositionToXY(pos, column, line)
				
				wxLogMessage("Current position: " + pos + ..
					"~nCurrent line, column: (" + line + ", " + column + ..
					")~nNumber of lines: " + GetNumberOfLines() + "~nCurrent line length: " + ..
					GetLineLength(line) + "~nTotal text length: " + GetValue().length + " (" + GetLastPosition() + ")")
				
				Local _from:Int, _to:Int
				GetSelection(_from, _to)
				
				Local sel:String = GetStringSelection()
				
				wxLogMessage("Selection: from " + _from + " to " + _to + ".")
				wxLogMessage("Selection = '" + sel + "' (len = " + sel.length + ")")
			
			Case WXK_F2
				' go To the End
				SetInsertionPointEnd()
			
			Case WXK_F3
				' go To position 10
				SetInsertionPoint(10)
			
			Case WXK_F4
				If Not hasCapture Then
					'wxLogDebug("Now capturing mouse and events.")
					hasCapture = True
					CaptureMouse()
				Else
					'wxLogDebug("Stopped capturing mouse and events.")
					hasCapture = False
					ReleaseMouse()
				End If
			
			Case WXK_F5
				' insert a blank line
				WriteText("~n")			
			
			Case WXK_F6
				wxLogMessage("IsModified() before SetValue(): " + IsModified())
				ChangeValue("ChangeValue() has been called")
				wxLogMessage("IsModified() after SetValue(): " +  IsModified())
			
			Case WXK_F7
				wxLogMessage("Position 10 should be now visible.")
				ShowPosition(10)
			
			Case WXK_F8
				wxLogMessage("Control has been cleared")
				Clear()
			
			Case WXK_F9
				WriteText("WriteText() has been called")
			
			Case WXK_F10
				AppendText("AppendText() has been called")
			
			Case WXK_F11
				DiscardEdits()
				wxLogMessage("Control marked as non modified")
		
		End Select
		
		If logKey Then
		LogKeyEvent("Key down", event)
		End If
		
		event.Skip()
	End Method
	
	Function OnKeyUp(event:wxEvent)
		If logChar Then
			MyTextCtrl(event.parent).LogKeyEvent("Key up", wxKeyEvent(event))
		End If
		
		event.Skip()
	End Function
	
	Function OnChar(event:wxEvent)
		If logChar Then
			MyTextCtrl(event.parent).LogKeyEvent("Char", wxKeyEvent(event))
		End If
		
		event.Skip()
	End Function
	
	Function OnText(event:wxEvent)
		If Not logText Then
			Return
		End If
		
		Local win:MyTextCtrl = MyTextCtrl(event.parent)
		Local changeVerb:String
		If  win.IsModified() Then
			changeVerb = "changed"
		Else
			changeVerb = "set by program"
		End If
		
		Local data:String = String(win.GetClientData())
		If data Then
			wxLogMessage("Text " + changeVerb + " in control '" + data + "'")
		Else
			wxLogMessage("Text " + changeVerb + " in some control")
		End If
	End Function
	
	Function OnTextEnter(event:wxEvent)
		If Not logText Then
			Return
		End If
		
		Local win:MyTextCtrl = MyTextCtrl(event.parent)
		Local data:String = String(win.GetClientData())
		If data Then
			wxLogMessage("Enter pressed in control '" + data + "'")
		Else
			wxLogMessage("Enter pressed in some control")
		End If
	End Function
	
	Function OnTextURL(event:wxEvent)
		Local ev:wxMouseEvent = wxTextUrlEvent(event).GetMouseEvent()
		
		' filter out mouse moves, too many of them
		If ev.Moving() Then
			Return
		End If
		
		Local _start:Int = wxTextUrlEvent(event).GetURLStart()
		Local _end:Int = wxTextUrlEvent(event).GetURLEnd()

		wxLogMessage("Mouse event over URL '" + ..
			wxTextCtrl(event.parent).GetValue()[_start .. _end] + "': " + GetMouseEventDesc(ev))
	End Function
	
	Function OnTextMaxLen(event:wxEvent)
		wxLogMessage("You can't enter more characters into this control.")
	End Function
	
	Function OnTextCut(event:wxEvent)
	End Function
	
	Function OnTextCopy(event:wxEvent)
	End Function
	
	Function OnTextPaste(event:wxEvent)
	End Function
	
	Function OnMouseEvent(event:wxEvent)
		Local ev:wxMouseEvent = wxMouseEvent(event)
		
		ev.Skip()
		
		If Not logMouse Then
			Return
		End If
		
		If Not ev.Moving() Then
			Local msg:String 
			If ev.Entering() Then
				msg = "Mouse entered the window"
			Else If ev.Leaving() Then
				msg = "Mouse left the window"
			Else
			msg = GetMouseEventDesc(ev)
				End If
			
			msg:+ " at (" + ev.GetX()  + ", " + ev.GetY() + ") "
			
			Local x:Int, y:Int, posX:Int, posY:Int
			ev.GetPosition(x, y)
			Local rc:Int = wxTextCtrl(event.parent).HitTest(x, y, posX, posY)
			If rc <> wxTE_HT_UNKNOWN Then
				msg:+ "at position " + posX + ", " + posY + " "
			End If
			
			msg:+ "[Flags: " + ..
				GetChar( ev.LeftIsDown(), "1" ) + ..
				GetChar( ev.MiddleIsDown(), "2" ) + ..
				GetChar( ev.RightIsDown(), "3" ) + ..
				GetChar( ev.ControlDown(), "C" ) + ..
				GetChar( ev.AltDown(), "A" ) + ..
				GetChar( ev.ShiftDown(), "S" ) + ..
				GetChar( ev.MetaDown(), "M" ) + ..
				"]"
			
			wxLogMessage(msg)
		End If
	End Function
	
	Function OnSetFocus(event:wxEvent)
		If logFocus Then
			wxLogMessage( event.parent.toString() + " got focus.")
		End If
		
		event.Skip()
	End Function
	
	Function OnKillFocus(event:wxEvent)
		If logFocus Then
			wxLogMessage( event.parent.toString() + " lost focus")
		End If
		
		event.Skip()
	End Function

	Function GetChar:String(on:Int, c:String)
		If on Then
			Return c
		Else
			Return "-"
		End If
	End Function
 
	Method LogKeyEvent(name:String, event:wxKeyEvent)
		Local key:String
		Local keycode:Int = event.GetKeyCode()
		
		Select keycode
			Case WXK_BACK
				key = "BACK"
			Case WXK_TAB
				key = "TAB"
			Case WXK_RETURN
				key = "RETURN"
			Case WXK_ESCAPE
				key = "ESCAPE"
			Case WXK_SPACE
				key = "SPACE"
			Case WXK_DELETE
				key = "DELETE"
			Case WXK_START
				key = "START"
			Case WXK_LBUTTON
				key = "LBUTTON"
			Case WXK_RBUTTON
				key = "RBUTTON"
			Case WXK_CANCEL
				key = "CANCEL"
			Case WXK_MBUTTON
				key = "MBUTTON"
			Case WXK_CLEAR
				key = "CLEAR"
			Case WXK_SHIFT
				key = "SHIFT"
			Case WXK_ALT
				key = "ALT"
			Case WXK_CONTROL
				key = "CONTROL"
			Case WXK_MENU
				key = "MENU"
			Case WXK_PAUSE
				key = "PAUSE"
			Case WXK_CAPITAL
				key = "CAPITAL"
			Case WXK_END
				key = "END"
			Case WXK_HOME
				key = "HOME"
			Case WXK_LEFT
				key = "LEFT"
			Case WXK_UP
				key = "UP"
			Case WXK_RIGHT
				key = "RIGHT"
			Case WXK_DOWN
				key = "DOWN"
			Case WXK_SELECT
				key = "SELECT"
			Case WXK_PRINT
				key = "PRINT"
			Case WXK_EXECUTE
				key = "EXECUTE"
			Case WXK_SNAPSHOT
				key = "SNAPSHOT"
			Case WXK_INSERT
				key = "INSERT"
			Case WXK_HELP
				key = "HELP"
			Case WXK_NUMPAD0
				key = "NUMPAD0"
			Case WXK_NUMPAD1
				key = "NUMPAD1"
			Case WXK_NUMPAD2
				key = "NUMPAD2"
			Case WXK_NUMPAD3
				key = "NUMPAD3"
			Case WXK_NUMPAD4
				key = "NUMPAD4"
			Case WXK_NUMPAD5
				key = "NUMPAD5"
			Case WXK_NUMPAD6
				key = "NUMPAD6"
			Case WXK_NUMPAD7
				key = "NUMPAD7"
			Case WXK_NUMPAD8
				key = "NUMPAD8"
			Case WXK_NUMPAD9
				key = "NUMPAD9"
			Case WXK_MULTIPLY
				key = "MULTIPLY"
			Case WXK_ADD
				key = "ADD"
			Case WXK_SEPARATOR
				key = "SEPARATOR"
			Case WXK_SUBTRACT
				key = "SUBTRACT"
			Case WXK_DECIMAL
				key = "DECIMAL"
			Case WXK_DIVIDE
				key = "DIVIDE"
			Case WXK_F1
				key = "F1"
			Case WXK_F2
				key = "F2"
			Case WXK_F3
				key = "F3"
			Case WXK_F4
				key = "F4"
			Case WXK_F5
				key = "F5"
			Case WXK_F6
				key = "F6"
			Case WXK_F7
				key = "F7"
			Case WXK_F8
				key = "F8"
			Case WXK_F9
				key = "F9"
			Case WXK_F10
				key = "F10"
			Case WXK_F11
				key = "F11"
			Case WXK_F12
				key = "F12"
			Case WXK_F13
				key = "F13"
			Case WXK_F14
				key = "F14"
			Case WXK_F15
				key = "F15"
			Case WXK_F16
				key = "F16"
			Case WXK_F17
				key = "F17"
			Case WXK_F18
				key = "F18"
			Case WXK_F19
				key = "F19"
			Case WXK_F20
				key = "F20"
			Case WXK_F21
				key = "F21"
			Case WXK_F22
				key = "F22"
			Case WXK_F23
				key = "F23"
			Case WXK_F24
				key = "F24"
			Case WXK_NUMLOCK
				key = "NUMLOCK"
			Case WXK_SCROLL
				key = "SCROLL"
			Case WXK_PAGEUP
				key = "PAGEUP"
			Case WXK_PAGEDOWN
				key = "PAGEDOWN"
			Case WXK_NUMPAD_SPACE
				key = "NUMPAD_SPACE"
			Case WXK_NUMPAD_TAB
				key = "NUMPAD_TAB"
			Case WXK_NUMPAD_ENTER
				key = "NUMPAD_ENTER"
			Case WXK_NUMPAD_F1
				key = "NUMPAD_F1"
			Case WXK_NUMPAD_F2
				key = "NUMPAD_F2"
			Case WXK_NUMPAD_F3
				key = "NUMPAD_F3"
			Case WXK_NUMPAD_F4
				key = "NUMPAD_F4"
			Case WXK_NUMPAD_HOME
				key = "NUMPAD_HOME"
			Case WXK_NUMPAD_LEFT
				key = "NUMPAD_LEFT"
			Case WXK_NUMPAD_UP
				key = "NUMPAD_UP"
			Case WXK_NUMPAD_RIGHT
				key = "NUMPAD_RIGHT"
			Case WXK_NUMPAD_DOWN
				key = "NUMPAD_DOWN"
			Case WXK_NUMPAD_PAGEUP
				key = "NUMPAD_PAGEUP"
			Case WXK_NUMPAD_PAGEDOWN
				key = "NUMPAD_PAGEDOWN"
			Case WXK_NUMPAD_END
				key = "NUMPAD_END"
			Case WXK_NUMPAD_BEGIN
				key = "NUMPAD_BEGIN"
			Case WXK_NUMPAD_INSERT
				key = "NUMPAD_INSERT"
			Case WXK_NUMPAD_DELETE
				key = "NUMPAD_DELETE"
			Case WXK_NUMPAD_EQUAL
				key = "NUMPAD_EQUAL"
			Case WXK_NUMPAD_MULTIPLY
				key = "NUMPAD_MULTIPLY"
			Case WXK_NUMPAD_ADD
				key = "NUMPAD_ADD"
			Case WXK_NUMPAD_SEPARATOR
				key = "NUMPAD_SEPARATOR"
			Case WXK_NUMPAD_SUBTRACT
				key = "NUMPAD_SUBTRACT"
			Case WXK_NUMPAD_DECIMAL
				key = "NUMPAD_DECIMAL"
		
			Default
				If wxIsprint(keycode) Then
					key = "' " + Chr(keycode) + " '"
				Else If keycode > 0 And keycode < 27 Then
					key = "Ctrl-" + Chr(Asc("A") + keycode - 1)
				Else
					key = "unknown (" + keycode + ")"
				End If
		End Select

		' hacky code to get hex value of unicode char
		Local val:Int = event.GetUnicodeKey()[0]
		Local count:Int = 0
		Local buf:Short[8]
		For Local k:Int = 7 To 0 Step -1
			Local n:Int =(val&15)+Asc("0")
			If n>Asc("9") n=n+(Asc("A")-Asc("9")-1)
			buf[k]=n
			val:Shr 4
			count:+ 1
			If val = 0 Then
				Exit
			End If
		Next
		Local uni:String = String.FromShorts( buf,8 )[8 - count..8]

		key:+ " (Unicode: 0x" +  uni + ")"
		
		wxLogMessage( name + " event: " + key + " (flags = " + ..
			GetChar( event.ControlDown(), "C" ) + ..
			GetChar( event.AltDown(), "A" ) + ..
			GetChar( event.ShiftDown(), "S" ) + ..
			GetChar( event.MetaDown(), "M" ) + ")")
	End Method
	
	Method LogClipEvent(what:String, event:wxClipboardTextEvent)
	End Method

End Type

Type MyPanel Extends wxPanel

	Field text:MyTextCtrl
	Field password:MyTextCtrl
	Field enter:MyTextCtrl
	Field tab:MyTextCtrl
	Field readonly:MyTextCtrl
	Field limited:MyTextCtrl
	
	Field multitext:MyTextCtrl
	Field horizontal:MyTextCtrl
	
	Field textrich:MyTextCtrl
	
	
	Field Log:wxTextCtrl
	Field logOld:wxLog
	

	Method OnInit()
	
		Log = New wxTextCtrl.Create( Self, wxID_ANY, "This is the log window.~n", 5, 260, 630, 100, wxTE_MULTILINE | wxTE_READONLY )
		
		logOld = wxLog.SetActiveTarget( New wxLogTextCtrl.Create( Log ) )

		' single line text controls
		
		text = MyTextCtrl(New MyTextCtrl.Create( Self, wxID_ANY, "Single line.", ,, ,, wxTE_PROCESS_ENTER))
		text.SetForegroundColour(wxBLUE())
		text.SetBackgroundColour(wxLIGHT_GREY())
		text.AppendText(" Appended.")
		text.SetInsertionPoint(0)
		text.WriteText("Prepended. ")
		
		password = MyTextCtrl(New MyTextCtrl.Create( Self, wxID_ANY, "", 10, 50, 140,, wxTE_PASSWORD ))
		
		readonly = MyTextCtrl(New MyTextCtrl.Create( Self, wxID_ANY, "Read only", 10,90, 140, , wxTE_READONLY ))
		
		limited = MyTextCtrl(New MyTextCtrl.Create(Self, wxID_ANY, "Max 8 ch", 10, 130, 140))
		limited.SetMaxLength(8)
		
		' multi line text controls

		horizontal = MyTextCtrl(New MyTextCtrl.Create( Self, wxID_ANY, "Multiline text control with a horizontal scrollbar.~n", ..
			10, 170, 140,70, wxTE_MULTILINE | wxHSCROLL))
		
		horizontal.AppendText("Text in default encoding")
		
		multitext = MyTextCtrl(New MyTextCtrl.Create( Self, wxID_ANY, "Multi line.", 180, 10, 200, 70, wxTE_MULTILINE ))
		multitext.SetFont(wxITALIC_FONT())
		multitext.AppendText(" Appended.")
		multitext.SetInsertionPoint(0)
		multitext.WriteText( "Prepended. " )
		multitext.SetForegroundColour(wxRED())
		multitext.SetBackgroundColour(wxLIGHT_GREY())
		
		
		multitext.SetToolTip("Press Fn function keys here")


		tab = MyTextCtrl(New MyTextCtrl.Create( Self, 100, "Multiline, allow <TAB> processing.", ..
			180, 90, 200, 70, wxTE_MULTILINE |  wxTE_PROCESS_TAB ))
		tab.SetClientData("tab")
		
		enter = MyTextCtrl(New MyTextCtrl.Create( Self, 100, "Multiline, allow <ENTER> processing.", ..
			180, 170, 200, 70, wxTE_MULTILINE | wxTE_PROCESS_ENTER))
		enter.SetClientData("enter")

		textrich = MyTextCtrl(New MyTextCtrl.Create(Self, wxID_ANY, "Allows more than 30Kb of text~n" + ..
				"(even under broken Win9x)~n" + ..
				"and a very very very very very " + ..
				"very very very long line to test " + ..
				"wxHSCROLL style~n" + ..
				"~nAnd here is a link in quotation marks to " + ..
				"test wxTE_AUTO_URL: ~qhttp://www.wxwidgets.org~q", ..
				450, 10, 200, 230, wxTE_RICH | wxTE_MULTILINE | wxTE_AUTO_URL))
		textrich.SetStyle(0, 10, New wxTextAttr.Create(wxRED()))
		textrich.SetStyle(10, 20, New wxTextAttr.Create(wxBLUE()))
		textrich.SetStyle(30, 40, New wxTextAttr.Create(wxGREEN(), wxNullColour, wxITALIC_FONT()))
		textrich.SetDefaultStyle(New wxTextAttr.Create())
		textrich.AppendText("~n~nFirst 10 characters should be in red~n")
		textrich.AppendText("Next 10 characters should be in blue~n")
		textrich.AppendText("Next 10 characters should be normal~n")
		textrich.AppendText("And the next 10 characters should be green and italic~n")
		textrich.SetDefaultStyle(New wxTextAttr.Create(wxCYAN(), wxBLUE()))
		textrich.AppendText("This text should be cyan on blue~n")
		textrich.SetDefaultStyle(New wxTextAttr.Create(wxBLUE(), wxWHITE()))
		textrich.AppendText("And this should be in blue and the text you " + ..
		"type should be in blue as well")


		' lay out the controls
		Local column1:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		column1.Add( text, 0, wxALL | wxEXPAND, 10 )
		column1.Add( password, 0, wxALL | wxEXPAND, 10 )
		column1.Add( readonly, 0, wxALL | wxEXPAND, 10 )
		column1.Add( limited, 0, wxALL | wxEXPAND, 10 )
		column1.Add( horizontal, 1, wxALL | wxEXPAND, 10 )
		
		Local column2:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		column2.Add( multitext, 1, wxALL | wxEXPAND, 10 )
		column2.Add( tab, 1, wxALL | wxEXPAND, 10 )
		column2.Add( enter, 1, wxALL | wxEXPAND, 10 )
		
		Local row1:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		row1.AddSizer( column1, 0, wxALL | wxEXPAND, 10 )
		row1.AddSizer( column2, 1, wxALL | wxEXPAND, 10 )
		row1.Add( textrich, 1, wxALL | wxEXPAND, 10 )
		
		Local topSizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		topSizer.AddSizer( row1, 2, wxALL | wxEXPAND, 10 )
		
		topSizer.Add( Log, 1, wxALL | wxEXPAND, 10 )
		
		SetAutoLayout( True )
		SetSizer(topSizer)
	
	End Method

	Method GetFocusedText:wxTextCtrl()
		Local win:wxWindow = FindFocus()
	
		If win Then
			Return wxTextCtrl(win)
		Else
			Return multitext
		End If
	End Method

	Method DoPasteFromClipboard()
	End Method

	Method DoCopyToClipboard()
	End Method
	
	Method DoRemoveText()
		GetFocusedText().Remove(0, 10)
	End Method
	
	Method DoReplaceText()
		GetFocusedText().Replace(3, 8, "ABC")
	End Method
	
	Method DoSelectText()
		GetFocusedText().SetSelection(3, 8)
	End Method
	
	Method DoMoveToEndOfText()
		multitext.SetInsertionPointEnd()
		multitext.SetFocus()
	End Method
	
	Method DoMoveToEndOfEntry()
		text.SetInsertionPointEnd()
		text.SetFocus()
	End Method


    ' Return True If currently text control has any selection
	Method HasSelection:Int()
		Local _from:Int, _to:Int
		GetFocusedText().GetSelection(_from, _to)
		Return _from <> _to
	End Method

End Type

Type MyFrame Extends wxFrame

	Field panel:MyPanel

	Method Oninit()
		CreateStatusBar(2)
		
		panel = MyPanel(New MyPanel.Create( Self, 10, 10, 300, 100 ))



		Connect(TEXT_QUIT,   wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(TEXT_ABOUT,  wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(TEXT_SAVE,   wxEVT_COMMAND_MENU_SELECTED, OnFileSave)
		Connect(TEXT_LOAD,   wxEVT_COMMAND_MENU_SELECTED, OnFileLoad)
		Connect(TEXT_RICH_TEXT_TEST, wxEVT_COMMAND_MENU_SELECTED, OnRichTextTest)
		
		Connect(TEXT_LOG_KEY,  wxEVT_COMMAND_MENU_SELECTED, OnLogKey)
		Connect(TEXT_LOG_CHAR, wxEVT_COMMAND_MENU_SELECTED, OnLogChar)
		Connect(TEXT_LOG_MOUSE,wxEVT_COMMAND_MENU_SELECTED, OnLogMouse)
		Connect(TEXT_LOG_TEXT, wxEVT_COMMAND_MENU_SELECTED, OnLogText)
		Connect(TEXT_LOG_FOCUS,wxEVT_COMMAND_MENU_SELECTED, OnLogFocus)
		Connect(TEXT_LOG_CLIP, wxEVT_COMMAND_MENU_SELECTED, OnLogClip)
		Connect(TEXT_CLEAR,    wxEVT_COMMAND_MENU_SELECTED, OnLogClear)
		
		Connect(TEXT_TOOLTIPS_SETDELAY,  wxEVT_COMMAND_MENU_SELECTED, OnSetTooltipDelay)
		Connect(TEXT_TOOLTIPS_ENABLE,    wxEVT_COMMAND_MENU_SELECTED, OnToggleTooltips)
		
		Connect(TEXT_CLIPBOARD_PASTE,    wxEVT_COMMAND_MENU_SELECTED, OnPasteFromClipboard)
		Connect(TEXT_CLIPBOARD_COPY,     wxEVT_COMMAND_MENU_SELECTED, OnCopyToClipboard)
		
		Connect(TEXT_CLIPBOARD_PASTE, wxEVT_UPDATE_UI, OnUpdatePasteFromClipboard)
		Connect(TEXT_CLIPBOARD_COPY,  wxEVT_UPDATE_UI, OnUpdateCopyToClipboard)
		
		Connect(TEXT_REMOVE,             wxEVT_COMMAND_MENU_SELECTED, OnRemoveText)
		Connect(TEXT_REPLACE,            wxEVT_COMMAND_MENU_SELECTED, OnReplaceText)
		Connect(TEXT_SELECT,             wxEVT_COMMAND_MENU_SELECTED, OnSelectText)
		Connect(TEXT_ADD_SOME,           wxEVT_COMMAND_MENU_SELECTED, OnAddText)
		Connect(TEXT_ADD_FREEZE,         wxEVT_COMMAND_MENU_SELECTED, OnAddTextFreeze)
		Connect(TEXT_MOVE_ENDTEXT,       wxEVT_COMMAND_MENU_SELECTED, OnMoveToEndOfText)
		Connect(TEXT_MOVE_ENDENTRY,      wxEVT_COMMAND_MENU_SELECTED, OnMoveToEndOfEntry)
		
		Connect(TEXT_SET_EDITABLE,       wxEVT_COMMAND_MENU_SELECTED, OnSetEditable)
		Connect(TEXT_SET_ENABLED,        wxEVT_COMMAND_MENU_SELECTED, OnSetEnabled)
		
		Connect(TEXT_LINE_DOWN,          wxEVT_COMMAND_MENU_SELECTED, OnScrollLineDown)
		Connect(TEXT_LINE_UP,            wxEVT_COMMAND_MENU_SELECTED, OnScrollLineUp)
		Connect(TEXT_PAGE_DOWN,          wxEVT_COMMAND_MENU_SELECTED, OnScrollPageDown)
		Connect(TEXT_PAGE_UP,            wxEVT_COMMAND_MENU_SELECTED, OnScrollPageUp)
		
		Connect(TEXT_GET_LINE,           wxEVT_COMMAND_MENU_SELECTED, OnGetLine)
		Connect(TEXT_GET_LINELENGTH,     wxEVT_COMMAND_MENU_SELECTED, OnGetLineLength)
		
		Connect(TEXT_SET,                wxEVT_COMMAND_MENU_SELECTED, OnSetText)
		Connect(TEXT_CHANGE,             wxEVT_COMMAND_MENU_SELECTED, OnChangeText)
		
		ConnectAny(wxEVT_IDLE, OnIdle)
	End Method


	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function

	Function OnAbout(event:wxEvent)
		'    wxBeginBusyCursor();
		
		Local dialog:wxMessageDialog = New wxMessageDialog.Create(wxWindow(event.parent), ..
			"This is a text control sample. It demonstrates the many different~n" + ..
			"text control styles, the use of the clipboard, setting and handling~n" + ..
			"tooltips and intercepting key and char events.~n" + ..
			"~n" + ..
			"Copyright (c) 1999, Robert Roebling, Julian Smart, Vadim Zeitlin~n" + ..
			"BlitzMax port (c) 2007 Bruce A Henderson", ..
			"About wxTextCtrl Sample", ..
			wxOK | wxICON_INFORMATION)
		
		dialog.ShowModal()
		
		'    wxEndBusyCursor();
	End Function

	Function OnSetTooltipDelay(event:wxEvent)
		Global tDelay:Int = 5000
		
		Local sDelay:String = wxGetTextFromUser("Enter delay (in milliseconds)", ..
		                    "Set tooltip delay", tDelay, wxWindow(event.parent))
		If Not sDelay Then
			Return ' cancelled
		End If
		
		tDelay = sDelay.ToInt()
		
		wxToolTip.SetDelay(tdelay)
		
		wxLogStatus("Tooltip delay set to " + tDelay + " milliseconds", wxFrame(event.parent))
	End Function

	Function OnToggleTooltips(event:wxEvent)
		Global enabled:Int
		
		wxToolTip.Enable(enabled)
		
		If enabled Then
			wxLogStatus("Tooltips enabled", wxFrame(event.parent))
		Else
			wxLogStatus("Tooltips disabled", wxFrame(event.parent))
		End If
		
		enabled = Not enabled
	End Function

	Function OnPasteFromClipboard(event:wxEvent)
		wxLogMessage("Pasting text from clipboard.")
		MyFrame(event.parent).panel.DoPasteFromClipboard()
	End Function
	
	Function OnCopyToClipboard(event:wxEvent)
		wxLogMessage("Copying text to clipboard.")
		MyFrame(event.parent).panel.DoCopyToClipboard()
	End Function
	
	
	Function OnUpdatePasteFromClipboard(event:wxEvent)
'		wxClipboardLocker lockClip;
		
'		event.Enable( wxTheClipboard.IsSupported(wxDF_TEXT) );
	End Function


	Function OnUpdateCopyToClipboard(event:wxEvent)
		wxUpdateUIEvent(event).Enable( MyFrame(event.parent).panel.HasSelection() )
	End Function
	
	
	Function OnAddTextFreeze(event:wxEvent)
		MyFrame(event.parent).DoAddText(True)
	End Function
	
	Function OnAddText(event:wxEvent)
		MyFrame(event.parent).DoAddText(False)
	End Function
	
	Function OnRemoveText(event:wxEvent)
		MyFrame(event.parent).panel.DoRemoveText()
	End Function
	
	Function OnReplaceText(event:wxEvent)
		MyFrame(event.parent).panel.DoReplaceText()
	End Function
	
	Function OnSelectText(event:wxEvent)
		MyFrame(event.parent).panel.DoSelectText()
	End Function
	
	
	Function OnMoveToEndOfText(event:wxEvent)
		MyFrame(event.parent).panel.DoMoveToEndOfText()
	End Function
	
	Function OnMoveToEndOfEntry(event:wxEvent)
		MyFrame(event.parent).panel.DoMoveToEndOfEntry()
	End Function
	
	
	Function OnScrollLineDown(event:wxEvent)
		If Not MyFrame(event.parent).panel.textrich.LineDown() Then
			wxLogMessage("Already at the bottom")
		End If
	End Function
	
	
	Function OnScrollLineUp(event:wxEvent)
		If Not MyFrame(event.parent).panel.textrich.LineUp() Then
			wxLogMessage("Already at the top")
		End If
	End Function
	
	
	Function OnScrollPageDown(event:wxEvent)
		If Not MyFrame(event.parent).panel.textrich.PageDown() Then
			wxLogMessage("Already at the bottom")
		End If
	End Function
	
	
	Function OnScrollPageUp(event:wxEvent)
		If Not MyFrame(event.parent).panel.textrich.PageUp() Then
			wxLogMessage("Already at the top")
		End If
	End Function


	Function OnGetLine(event:wxEvent)
		Local nLine:Int = wxGetNumberFromUser("Which line would you like to get?", ..
			"Enter which line you would like to get", ..
			"Get a line from the tabbed multiline text control")
		
		wxMessageBox(MyFrame(event.parent).panel.tab.GetLineText(nLine))
	End Function


	Function OnGetLineLength(event:wxEvent)
		Local nLine:Int = wxGetNumberFromUser("Which line would you like to get?", ..
			"Enter which line you would like to get", ..
			"Get length of a line from the tabbed multiline text control")
		
		wxMessageBox("Length of line " + nLine + " is:" + MyFrame(event.parent).panel.tab.GetLineLength(nLine))
	End Function
	
	
	Function OnLogClear(event:wxEvent)
		MyFrame(event.parent).panel.log.Clear()
	End Function
	
	Function OnFileSave(event:wxEvent)
	End Function

	Function OnFileLoad(event:wxEvent)
	End Function
	
	Function OnRichTextTest(event:wxEvent)
	End Function
	
	
	Function OnSetEditable(event:wxEvent)
		Local panel:MyPanel = MyFrame(event.parent).panel
	
		Global editable:Int

		panel.text.SetEditable(editable)
		panel.password.SetEditable(editable)
		panel.multitext.SetEditable(editable)
		panel.textrich.SetEditable(editable)

		editable = Not editable
	End Function
	
	Function OnSetEnabled(event:wxEvent)
		Local panel:MyPanel = MyFrame(event.parent).panel
		
		Local enabled:Int = panel.text.IsEnabled()
		enabled = Not enabled
		
		panel.text.Enable(enabled)
		panel.password.Enable(enabled)
		panel.multitext.Enable(enabled)
		panel.readonly.Enable(enabled)
		panel.limited.Enable(enabled)
		panel.textrich.Enable(enabled)
	End Function
	
	
	Function OnLogKey(event:wxEvent)
		MyTextCtrl.logKey = wxCommandEvent(event).IsChecked()
	End Function
	
	
	Function OnLogChar(event:wxEvent)
		MyTextCtrl.logChar = wxCommandEvent(event).IsChecked()
	End Function
	
	
	Function OnLogMouse(event:wxEvent)
		MyTextCtrl.logMouse = wxCommandEvent(event).IsChecked()
	End Function


	Function OnLogText(event:wxEvent)
		MyTextCtrl.logText = wxCommandEvent(event).IsChecked()
	End Function
	
	
	Function OnLogFocus(event:wxEvent)
		MyTextCtrl.logFocus = wxCommandEvent(event).IsChecked()
	End Function
	
	
	Function OnLogClip(event:wxEvent)
		MyTextCtrl.logClip = wxCommandEvent(event).IsChecked()
	End Function


	Function OnSetText(event:wxEvent)
'		MyFrame(event.parent).panel.text.SetValue("Hello, world! (what else did you expect?)")
	End Function


	Function OnChangeText(event:wxEvent)
		MyFrame(event.parent).panel.text.ChangeValue("Changed, not set: no event")
	End Function


	Function OnIdle(event:wxEvent)
		' track the window which has the focus in the status bar
		Global windowFocus:wxWindow
		Local focus:wxWindow = wxWindow.FindFocus()
		If focus And (focus <> windowFocus) Then
			windowFocus = focus
		
			Local msg:String = "Focus: wxWindow = " + windowFocus.toString()
		
			MyFrame(event.parent).SetStatusText(msg)
		End If
		
		event.Skip()
	End Function

	Method DoAddText(freeze:Int)
		Local text:wxTextCtrl = panel.textrich
		text.Clear()
		
		If freeze Then
			text.Freeze()
		End If
		
		For Local i:Int = 0 Until 100
			text.AppendText("Line " + i + "~n")
		Next
		
		If freeze Then
			text.Thaw()
		End If
		
		text.SetInsertionPoint(0)
	End Method

End Type


Function GetMouseEventDesc:String(ev:wxMouseEvent)
	' click event
	Local button:String
	Local dbl:Int, up:Int
	
	If ev.LeftDown() Or ev.LeftUp() Or ev.LeftDClick() Then
		button = "Left"
		dbl = ev.LeftDClick()
		up = ev.LeftUp()
	
	Else If ev.MiddleDown() Or ev.MiddleUp() Or ev.MiddleDClick() Then
		button = "Middle"
		dbl = ev.MiddleDClick()
		up = ev.MiddleUp()
	Else If ev.RightDown() Or ev.RightUp() Or ev.RightDClick() Then
		button = "Right"
		dbl = ev.RightDClick()
		up = ev.RightUp()
	Else
		Return "Unknown mouse event"
	End If
	
	If dbl Then
		Return button + " mouse button double clicked"
	Else
		If up Then
			Return button + " mouse button released"
		Else
			Return button + " mouse button clicked"
		End If
	End If
	
End Function

Type RichTextFrame Extends wxFrame
End Type



Const TEXT_QUIT:Int = wxID_EXIT
Const TEXT_ABOUT:Int = wxID_ABOUT
Const TEXT_LOAD:Int = 101
Const TEXT_SAVE:Int = 102
Const TEXT_CLEAR:Int = 103
Const TEXT_RICH_TEXT_TEST:Int = 104

' clipboard menu
Const TEXT_CLIPBOARD_COPY:Int = 200
Const TEXT_CLIPBOARD_PASTE:Int = 201
Const TEXT_CLIPBOARD_VETO:Int = 202

' tooltip menu
Const TEXT_TOOLTIPS_SETDELAY:Int = 300
Const TEXT_TOOLTIPS_ENABLE:Int = 301

' text menu
Const TEXT_ADD_SOME:Int = 400
Const TEXT_ADD_FREEZE:Int = 401
Const TEXT_MOVE_ENDTEXT:Int = 402
Const TEXT_MOVE_ENDENTRY:Int = 403
Const TEXT_SET_EDITABLE:Int = 404
Const TEXT_SET_ENABLED:Int = 405
Const TEXT_LINE_DOWN:Int = 406
Const TEXT_LINE_UP:Int = 407
Const TEXT_PAGE_DOWN:Int = 408
Const TEXT_PAGE_UP:Int = 409

Const TEXT_GET_LINE:Int = 410
Const TEXT_GET_LINELENGTH:Int = 411

Const TEXT_REMOVE:Int = 412
Const TEXT_REPLACE:Int = 413
Const TEXT_SELECT:Int = 414
Const TEXT_SET:Int = 415
Const TEXT_CHANGE:Int = 416

' Log menu
Const TEXT_LOG_KEY:Int = 417
Const TEXT_LOG_CHAR:Int = 418
Const TEXT_LOG_MOUSE:Int = 419
Const TEXT_LOG_TEXT:Int = 420
Const TEXT_LOG_FOCUS:Int = 421
Const TEXT_LOG_CLIP:Int = 422
