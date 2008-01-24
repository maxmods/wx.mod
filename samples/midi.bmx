SuperStrict

Framework wx.wxApp
Import wx.wxMidi
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxComboBox
Import wx.wxButton
Import wx.wxNotebook
Import wx.wxStaticText
Import wx.wxLocale

Global wxEVT_POLLING_EVENT:Int = wxNewEventType()

New MyEventFactory

New MyApp.run()

Const ID_MY_PANEL:Int = 100
Const ID_BOOK:Int = 101
Const ID_COMBO_OUTDEV:Int = 102
Const ID_OPEN_DEVICE:Int = 103
Const ID_NOTE_ON:Int = 104
Const ID_NOTE_OFF:Int = 105
Const ID_PLAY_CHORD:Int = 106
Const ID_PLAY_SCALE:Int = 107
Const ID_COMBO_SECTIONS:Int = 108
Const ID_COMBO_INSTRUMENTS:Int = 109
Const ID_SEND_SYSEX:Int = 110
Const ID_COMBO_INDEV:Int = 111
Const ID_START_RECEIVING:Int = 112
Const ID_STOP_RECEIVING:Int = 113
Const ID_CRASH:Int = 114
Const ID_START_LISTENING:Int = 115
Const ID_STOP_LISTENING:Int = 116
Const ID_LOOP_BACK:Int = 117


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
	
	
		New MyPanel.Create(Self, ID_MY_PANEL)

		' Create a status bar just For fun (by Default with 1 pane only)
		CreateStatusBar(2)
		SetStatusText("Welcome to wxMidi sample!")


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

	Field m_pMidi:wxMidiSystem

	'controls on the frame
	Field m_book:wxBookCtrlBase
	Field m_text:wxTextCtrl

	'controls on panel 1
	Field m_pOutCombo:wxComboBox
	Field m_pInCombo:wxComboBox
	Field m_btOpenDevice:wxButton

	'controls on panel 2
	Field m_pSectCombo:wxComboBox		'combo For section names
	Field m_pInstrCombo:wxComboBox		'combo For instrument names
	Field m_btNoteOn:wxButton
	Field m_btNoteOff:wxButton
	Field m_btPlayChord:wxButton
	Field m_btPlayScale:wxButton

	'controls on panel 3
	Field m_btSysEx:wxButton
	Field m_btLoopBack:wxButton

	'controls on panel 4
	Field m_btStartRec:wxButton
	Field m_btStopRec:wxButton

	'controls on panel 5
	Field m_btCrash:wxButton

	'controls on panel 6
	Field m_btStartLis:wxButton
	Field m_btStopLis:wxButton

	Field m_pOutDev:wxMidiOutDevice		' current MIDI output device
	Field m_pInDev:wxMidiInDevice		' current MIDI Input device

	Field m_fReceiveEnabled:Int
	Field m_fDoCrash:Int
	Field m_fCreatePollingEvent:Int
	
	Method OnInit()
	
		m_pMidi = wxMidiSystem.GetInstance()
	
	Local bSizer1:wxBoxSizer = New wxBoxSizer.Create( wxVERTICAL )
		
	' frame layout

	m_book = New wxNotebook.Create(Self, ID_BOOK)
	bSizer1.Add( m_book, 1, wxEXPAND | wxALL, 5 )

	m_text = New wxTextCtrl.Create(Self, wxID_ANY, "", ,,,, wxTE_MULTILINE)

	bSizer1.Add( m_text, 0, wxALL|wxEXPAND, 5 )
	
	'
	' Panel 1: MIDI devices selection panel ------------------------------------------
	'

   Local panel:wxPanel = New wxPanel.Create(m_book)



	Local pMainSizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
	panel.SetSizer(pMainSizer)		' set autolayout based on sizers
	panel.SetAutoLayout(True)


	' Devices combos + Open devices button
	pMainSizer.Add(New wxStaticText.Create(panel, -1, "Output devices available:"), 0, wxALL, 10 )

	m_pOutCombo = New wxComboBox.Create( panel, ID_COMBO_OUTDEV, "This", Null, ..
                              20,25, 270, -1, wxCB_DROPDOWN | wxCB_READONLY | wxTE_PROCESS_ENTER)
	pMainSizer.Add(m_pOutCombo, 0, wxALL, 10 )

	pMainSizer.Add(New wxStaticText.Create(panel, -1, "Input devices available:"), 0, wxALL, 10 )

	m_pInCombo = New wxComboBox.Create( panel, ID_COMBO_INDEV, "This", Null, ..
                              20, 25, 270, -1, wxCB_DROPDOWN | wxCB_READONLY | wxTE_PROCESS_ENTER)
	pMainSizer.Add(m_pInCombo, 0, wxALL, 10 )

    m_btOpenDevice = New wxButton.Create(panel, ID_OPEN_DEVICE, "Open devices", -1, -1, 140, 25 )
    pMainSizer.Add(m_btOpenDevice,0, wxALL, 10 )

    m_book.AddPage(panel, _("Devices"), True)		'True . Select this page


	'
	' Panel 2: MIDI out test panel ----------------------------------------------------
	'

    panel = New wxPanel.Create(m_book)
	Local pPanel2Sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
	panel.SetSizer(pPanel2Sizer)
	panel.SetAutoLayout(True)

	'sections and instruments combos + Program change button
	Local pInstrSizer:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
	pPanel2Sizer.AddSizer(pInstrSizer, 0, wxALL, 10 )

	m_pSectCombo = New wxComboBox.Create( panel, ID_COMBO_SECTIONS, "This", Null, ..
                              20,25, 270, -1, wxCB_DROPDOWN | wxCB_READONLY | wxTE_PROCESS_ENTER)
	pInstrSizer.Add(m_pSectCombo, 0, wxALL, 10 )

	Local pMidiGM:wxMidiDatabaseGM = wxMidiDatabaseGM.GetInstance()
	pMidiGM.PopulateWithSections(m_pSectCombo)
	m_pInstrCombo = New wxComboBox.Create( panel, ID_COMBO_INSTRUMENTS, "This", Null, 20,25, 270, -1, ..
                              wxCB_DROPDOWN | wxCB_READONLY | wxTE_PROCESS_ENTER)
	pInstrSizer.Add(m_pInstrCombo, 0, wxALL, 10 )
	pMidiGM.PopulateWithInstruments(m_pInstrCombo, 0, 0)


	'sizer for the buttons
	Local pButtonsSizer:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
	pPanel2Sizer.AddSizer(pButtonsSizer, 0, wxALL, 10)

	m_btNoteOn = New wxButton.Create(panel, ID_NOTE_ON, "Note On", -1,-1, 100,25 )
    pButtonsSizer.Add(m_btNoteOn,0, wxALL, 10 )

	m_btNoteOff = New wxButton.Create(panel, ID_NOTE_OFF, "Note Off", -1,-1, 100,25 )
    pButtonsSizer.Add(m_btNoteOff,0, wxALL, 10 )

	m_btPlayChord = New wxButton.Create(panel, ID_PLAY_CHORD, "Play chord", -1,-1, 100,25 )
    pButtonsSizer.Add(m_btPlayChord,0, wxALL, 10 )

	m_btPlayScale = New wxButton.Create(panel, ID_PLAY_SCALE, "Play scale", -1,-1, 100,25 )
    pButtonsSizer.Add(m_btPlayScale,0, wxALL, 10 )


    m_book.AddPage(panel, _("MIDI output"), False)


	'
	' Panel 3: Send SysEx test panel ----------------------------------------------------
	'
    panel = New wxPanel.Create(m_book)
	Local pPanel3Sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
	panel.SetSizer(pPanel3Sizer)
	panel.SetAutoLayout(True)


	pPanel3Sizer.Add( New wxStaticText.Create(panel, wxID_ANY, ..
			"Sorry, SysEx messages are equipment-specific commands and data for each~n" + ..
			"MIDI maker. You have to change the pre-programed test message to suit~n" + ..
			"your specific MIDI equipment. In this example, the sysex message is~n" + ..
			"a command for a Casio Privia PX-100 keyboard, to set up reverberation~n" + ..
			"to value 03" ), 1, wxEXPAND , 30 )

	Local pSizer3:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
	pPanel3Sizer.AddSizer(pSizer3, 0, wxALL, 10)

	m_btSysEx = New wxButton.Create(panel, ID_SEND_SYSEX, "Send SysEx", 30,130, 140,25 )
    pSizer3.Add(m_btSysEx, 0, wxALL, 10 )

    pSizer3.Add(New wxButton.Create(panel, ID_STOP_RECEIVING, "Stop receiving", ..
				200,130, 140, 25 ),	0, wxALL, 10 )

	
    m_book.AddPage(panel, _("MIDI SysEx"), False)

		'
		' Panel 4: MIDI input test panel (polling) ----------------------------------------
		'
	
	    panel = New wxPanel.Create(m_book)
		Local pPanel4Sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(pPanel4Sizer)		' set autolayout based on sizers
		panel.SetAutoLayout(True)
	
		m_btStartRec = New wxButton.Create(panel, ID_START_RECEIVING, "Start receiving", 30,30, 140,25 )
	    pPanel4Sizer.Add(m_btStartRec, 0, wxALL, 10 )
	
		m_btStopRec = New wxButton.Create(panel, ID_STOP_RECEIVING, "Stop receiving", 30,30, 140,25 )
	    pPanel4Sizer.Add(m_btStopRec, 0, wxALL, 10 )
	
	    m_book.AddPage(panel, _("input (polling)"), False)


		'
		' Panel 5: Crash test panel ----------------------------------------------------
		'
	
	    panel = New wxPanel.Create(m_book)
		Local pPanel5Sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(pPanel5Sizer)		' set autolayout based on sizers
		panel.SetAutoLayout(True)
	
		m_btCrash = New wxButton.Create(panel, ID_CRASH, "Crash program", 30,30, 140,25 )
	    pPanel4Sizer.Add(m_btCrash, 0, wxALL, 10 )
	
	    m_book.AddPage(panel, _("Crash test"), False)


		'
		' Panel 6: MIDI input test panel (Events) ------------------------------------------
		'
	
	    panel = New wxPanel.Create(m_book)
		Local pPanel6Sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(pPanel6Sizer)		' set autolayout based on sizers
		panel.SetAutoLayout(True)
	
		m_btStartLis = New wxButton.Create(panel, ID_START_LISTENING, "Start receiving", 30,30, 140,25 )
	    pPanel6Sizer.Add(m_btStartLis, 0, wxALL, 10 )
	
		m_btStopLis = New wxButton.Create(panel, ID_STOP_LISTENING, "Stop receiving", 30,30, 140,25 )
	    pPanel6Sizer.Add(m_btStopLis, 0, wxALL, 10 )
	
	    m_book.AddPage(panel, _("input (events)"), False)



		' populate combo box with available Midi devices
		
		Local nNumDevices:Int = m_pMidi.CountDevices()
		m_text.ChangeValue("There are " + nNumDevices + " MIDI devices available~n")
	
		' available input and output devices
		Local nItem:Int, nInput:Int = 0, nOutput:Int = 0
		For Local i:Int = 0 Until nNumDevices
	        Local pMidiDev:wxMidiOutDevice = New wxMidiOutDevice.Create(i)
	        If pMidiDev.IsOutputPort() Then
				nOutput:+ 1
				nItem = m_pOutCombo.Append(pMidiDev.DeviceName() + " [" + pMidiDev.InterfaceUsed() + "]")
				m_pOutCombo.SetItemClientData(nItem, IntVal.Set(i))
	        End If
			If pMidiDev.IsInputPort() Then
				nInput:+ 1
				nItem = m_pInCombo.Append(pMidiDev.DeviceName() + " [" + pMidiDev.InterfaceUsed() + "]")
				m_pInCombo.SetItemClientData(nItem, IntVal.Set(i))
	        End If
			pMidiDev.Free()
	    Next
		If nOutput > 0 Then
			m_pOutCombo.SetSelection(0)
		End If
		If nInput > 0 Then
			m_pInCombo.SetSelection(0)
		End If

		'disable all controls and  buttons but "Open Device"
		'until a Midi device is selected
		m_btOpenDevice.Enable(True)
		m_btNoteOn.Enable(False)
		m_btNoteOff.Enable(False)
		m_btPlayChord.Enable(False)
		m_pSectCombo.Enable(False)
		m_pInstrCombo.Enable(False)
	
	
		SetSizer( bSizer1 )
		Layout()
	
		Connect(ID_BOOK, wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, OnPageChanging)
	
		Connect(ID_OPEN_DEVICE, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonOpenDevice)
		Connect(ID_NOTE_ON, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonNoteOn)
		Connect(ID_NOTE_OFF, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonNoteOff)
		Connect(ID_PLAY_CHORD, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonChord)
		Connect(ID_PLAY_SCALE, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonPlayScale)
	
		Connect(ID_SEND_SYSEX, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonSysEx)
		Connect(ID_LOOP_BACK, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonLoopBack)
	
		Connect(ID_START_RECEIVING, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonStartReceiving)
		Connect(ID_STOP_RECEIVING, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonStopReceiving)
	
		Connect(ID_CRASH, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonCrash)
	
		Connect(ID_START_LISTENING, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonStartListening)
		Connect(ID_STOP_LISTENING, wxEVT_COMMAND_BUTTON_CLICKED, _OnButtonStopListening)
	
		Connect(ID_COMBO_SECTIONS, wxEVT_COMMAND_COMBOBOX_SELECTED, _OnComboSections)
		Connect(ID_COMBO_INSTRUMENTS, wxEVT_COMMAND_COMBOBOX_SELECTED, _OnComboInstruments)
	
		Connect(ID_MY_PANEL, wxEVT_POLLING_EVENT, _OnPollingEvent)
		Connect(wxID_ANY, wxEVT_MIDI_INPUT, _OnMidiReceive)

		ConnectAny(wxEVT_IDLE, _OnIdle)
		
	End Method

	Function OnPageChanging(evt:wxEvent)
		Local event:wxNotebookEvent = wxNotebookEvent(evt)
		
		' Prevent page change If no MIDI device is selected
		Local nNumPage:Int = event.GetOldSelection()
		If nNumPage <> -1 Then
			If Not MyPanel(evt.parent).m_pOutDev Then
				event.Veto()
				wxMessageBox(_("You can not change to another page until a MIDI Device is susscessfully opened"))
				Return
			End If
		End If
		event.Allow()
	End Function

	Method CloseDevices()
		' close devices And Delete midi device objects
		If m_pOutDev Then
			m_pOutDev.Close()
			m_pOutDev.Free()
			m_pOutDev = Null
		End If
		If m_pInDev Then
			m_pInDev.Close()
			m_pInDev.Free()
			m_pInDev = Null
		End If
	End Method
	

	Function _OnButtonOpenDevice(event:wxEvent)
		MyPanel(event.parent).OnButtonOpenDevice(wxCommandEvent(event))
	End Function
	
	Method OnButtonOpenDevice(event:wxCommandEvent)
		CloseDevices()

		' get number of Midi device To use
		Local index:Int = m_pOutCombo.GetSelection()
		Local nMidiDev:Int = IntVal(m_pOutCombo.GetItemClientData(index)).value
		m_pOutDev = New wxMidiOutDevice.Create(nMidiDev)
	
	    ' open output device
		Local sMsg:String
		Local m_lantency:Int = 0
		Local nErr:Int = m_pOutDev.Open(m_lantency)
		If nErr Then
			sMsg = "Error " + nErr + " in Open: " + m_pMidi.GetErrorText(nErr) + "~n"
		Else
		    sMsg = "Output device '" + m_pOutDev.DeviceName() + "' sucessfully opened.~n"
		End If
		m_text.AppendText(sMsg)
	
		'Open Input device
		index = m_pInCombo.GetSelection()
		If index <> -1 Then
			nMidiDev = IntVal(m_pInCombo.GetItemClientData(index)).value
			m_pInDev = New wxMidiInDevice.Create(nMidiDev)
			nErr = m_pInDev.Open()
			If nErr Then
					sMsg = "Error " + nErr + " in Open: " + m_pMidi.GetErrorText(nErr) + "~n"
			Else
				sMsg = "Input device " + m_pInDev.DeviceName() + " sucessfully opened.~n"
			End If
		Else
		    sMsg = "No input device available.~n"
		End If
		m_text.AppendText(sMsg)
	
	
		'enable all buttons
		m_btOpenDevice.Enable(True)
		m_btNoteOn.Enable(True)
		m_btNoteOff.Enable(False)
		m_btPlayChord.Enable(True)
		m_pSectCombo.Enable(True)
		m_pInstrCombo.Enable(True)
	End Method

	Function _OnButtonNoteOn(event:wxEvent)
		MyPanel(event.parent).OnButtonNoteOn(wxCommandEvent(event))
	End Function

	Method OnButtonNoteOn(event:wxCommandEvent)
		Local sMsg:String
		Local msg:wxMidiShortMessage = New wxMidiShortMessage.Create($90, 60, 127)
		Local nErr:Int = m_pOutDev.WriteBytes(msg)
		' alternative:
		' wxMidiError nErr = m_pOutDev.NoteOn(0, 60, 127)
		If nErr Then
			sMsg = "Error " + nErr + " in NoteOn: " + m_pMidi.GetErrorText(nErr) + "~n"
		Else
			sMsg = "NoteOn OK~n"
		End If
		m_text.AppendText(sMsg)
	
		'disable all buttons but Note off
		m_btOpenDevice.Enable(False)
		m_btNoteOn.Enable(False)
		m_btNoteOff.Enable(True)
		m_btPlayChord.Enable(False)
		
		msg.Free()
	End Method

	Function _OnButtonNoteOff(event:wxEvent)
		MyPanel(event.parent).OnButtonNoteOff(wxCommandEvent(event))
	End Function

	Method OnButtonNoteOff(event:wxCommandEvent)
	End Method

	Function _OnButtonChord(event:wxEvent)
		MyPanel(event.parent).OnButtonChord(wxCommandEvent(event))
	End Function

	Method OnButtonChord(event:wxCommandEvent)
	End Method

	Function _OnButtonPlayScale(event:wxEvent)
		MyPanel(event.parent).OnButtonPlayScale(wxCommandEvent(event))
	End Function

	Method OnButtonPlayScale(event:wxCommandEvent)
	End Method

	Function _OnButtonSysEx(event:wxEvent)
		MyPanel(event.parent).OnButtonSysEx(wxCommandEvent(event))
	End Function

	Method OnButtonSysEx(event:wxCommandEvent)
		Local deviceEnquiry:Byte[] = [Byte($F0),Byte($7E),Byte($00),Byte($06),Byte($01),Byte($F7)]
       
		Local msg:wxMidiSysExMessage = New wxMidiSysExMessage.CreateSysExMessage( deviceEnquiry )
       
		m_pOutDev.WriteSysex(msg)
 	End Method

	Function _OnButtonLoopBack(event:wxEvent)
		MyPanel(event.parent).OnButtonLoopBack(wxCommandEvent(event))
	End Function

	Method OnButtonLoopBack(event:wxCommandEvent)
	End Method

	Function _OnButtonStartReceiving(event:wxEvent)
		MyPanel(event.parent).OnButtonStartReceiving(wxCommandEvent(event))
	End Function

	Method OnButtonStartReceiving(event:wxCommandEvent)
		StartReceiving()
	End Method

	Function _OnButtonStopReceiving(event:wxEvent)
		MyPanel(event.parent).OnButtonStopReceiving(wxCommandEvent(event))
	End Function

	Method OnButtonStopReceiving(event:wxCommandEvent)
		m_fReceiveEnabled = False
		m_text.AppendText("Reception stopped.~n")
	End Method

	Function _OnButtonCrash(event:wxEvent)
		MyPanel(event.parent).OnButtonCrash(wxCommandEvent(event))
	End Function

	Method OnButtonCrash(event:wxCommandEvent)
	End Method

	Function _OnButtonStartListening(event:wxEvent)
		MyPanel(event.parent).OnButtonStartListening(wxCommandEvent(event))
	End Function

	Method OnButtonStartListening(event:wxCommandEvent)
		If Not m_pInDev Then
			m_text.AppendText("No input device. Listening not started.~n")
			Return
		End If
	
		'Filter out active sensing messages (0xFE) and clock messages (0xF8 only)
		m_pInDev.SetFilter(wxMIDI_FILT_ACTIVE | wxMIDI_FILT_CLOCK)
	
		' empty the buffer after setting filter, just in case anything got through
		m_pInDev.Flush()
	
		m_text.AppendText("Start listening...~n")
		Local nErr:Int = m_pInDev.StartListening(Self)
		If nErr Then
			m_text.AppendText("Error " + nErr + " in StartListening: " + m_pMidi.GetErrorText(nErr) + "~n")
		End If
	
	End Method

	Function _OnButtonStopListening(event:wxEvent)
		MyPanel(event.parent).OnButtonStopListening(wxCommandEvent(event))
	End Function

	Method OnButtonStopListening(event:wxCommandEvent)
		If Not m_pInDev Then
			m_text.AppendText("No input device. Listening was not started.~n")
			Return
		End If
	
		m_text.AppendText("Stop listening.~n")
		m_pInDev.StopListening()
	End Method

	Function _OnComboSections(event:wxEvent)
		MyPanel(event.parent).OnComboSections(wxCommandEvent(event))
	End Function

	Method OnComboSections(event:wxCommandEvent)
		' A new section selected. Reload Instruments combo with the instruments in the
		'selected section
	
		Local pMidiGM:wxMidiDatabaseGM = wxMidiDatabaseGM.GetInstance()
		Local nSect:Int = m_pSectCombo.GetSelection()
		pMidiGM.PopulateWithInstruments(m_pInstrCombo, nSect)
		DoProgramChange()
	End Method

	Function _OnPollingevent(event:wxEvent)
		MyPanel(event.parent).OnPollingevent(wxCommandEvent(event))
	End Function

	Method OnPollingEvent(event:wxCommandEvent)
		event.Skip(True)			'do not propagate this event

 	   ' simulate crash if m_fDoCrash is true
	    If m_fDoCrash Then
			m_fDoCrash = False
			' crash the program to test whether midi ports get closed
'			Int * tmp = Null
'			*tmp = 5
	    End If

		If Not m_pInDev Then
			Return
		End If

	    If m_pInDev.Poll() Then
			DoReceiveMessage()
		Else
			'no messages available
			' wait 100ms for low event creation rate when no data available
			Delay(100)
		End If

		'continue polling the Midi input
		m_fCreatePollingEvent = True		'when idle, create a polling Midi input event
	End Method

	Function _OnComboInstruments(event:wxEvent)
		MyPanel(event.parent).OnComboInstruments(wxCommandEvent(event))
	End Function

	Method OnComboInstruments(event:wxCommandEvent)
		' A New instrument selected. Change Midi program
		DoProgramChange()
	End Method

	Function _OnMidiReceive(event:wxEvent)
		MyPanel(event.parent).OnMidiReceive(wxCommandEvent(event))
	End Function
	
	Method OnMidiReceive(event:wxCommandEvent)

		event.Skip(True)			 'do Not propagate this event
		m_text.AppendText("Event wxEVT_MIDI_INPUT.  ")
		While m_pInDev.Poll()
			DoReceiveMessage()
		Wend

	End Method

	Function _OnIdle(event:wxEvent)
		MyPanel(event.parent).OnIdle(wxIdleEvent(event))
	End Function

	Method OnIdle(event:wxIdleEvent)
		If m_fCreatePollingEvent Then
			m_fCreatePollingEvent = False
			CreatePollingEvent()
		End If
	End Method

	Method DoReceiveMessage()
		'Read a meessage waiting to be read
	
		Local sMsg:String
		Local nErr:Int
		Local pMidiMsg:wxMidiMessage = m_pInDev.Read(nErr)
		If nErr Then
			sMsg = "Error " + nErr + " in Read: " + m_pMidi.GetErrorText(nErr) + "~n"
		Else
			If pMidiMsg.GetType() = wxMIDI_SHORT_MSG Then
				Local pMsg:wxMidiShortMessage = wxMidiShortMessage(pMidiMsg)
				sMsg = "Received short message: time " + pMsg.GetTimestamp() + ":~t" + ..
							Hex(pMsg.GetStatus(), 2) + " " + Hex(pMsg.GetData1(), 2) + " " + ..
							Hex(pMsg.GetData2(), 2) + "~n"
				pMsg.Free()		' do not forget!!
			Else
				Local pMsg:wxMidiSysExMessage = wxMidiSysExMessage(pMidiMsg)
				sMsg = "Received sysex message: time " + pMsg.GetTimestamp() + ":~t"
				Local pData:Byte[] = pMsg.GetMessage()
				For Local i:Int = 0 Until pData.Length
					If i <> 0 And i Mod 16 = 0 Then
						sMsg :+ "~n~t~t"
					End If
					sMsg :+ Hex(pData[i], 2) + " "
				Next
				sMsg :+ "~n"
				pMsg.Free()		' do not forget!!
			End If
		End If
		m_text.AppendText(sMsg)
	End Method


	Method DoProgramChange()
	
		'Change Midi instrument to the one selected in combo Instruments
		Local nInstr:Int = m_pInstrCombo.GetSelection()
		Local nSect:Int = m_pSectCombo.GetSelection()
		Local pMidiGM:wxMidiDatabaseGM = wxMidiDatabaseGM.GetInstance()
		Local nProgram:Int = pMidiGM.GetInstrFromSection(nSect, nInstr)
		Local nChannel:Int = 0
		Local sMsg:String
		Local nErr:Int = m_pOutDev.ProgramChange(nChannel, nProgram)
		If nErr Then
			sMsg = "Error " + nErr + " in ProgramChange~n"
		Else
			sMsg = "ProgramChange OK: " + pMidiGM.GetInstrumentName(nProgram) + "~n"
		End If
		m_text.AppendText(sMsg)
	
	End Method

	Method CreatePollingEvent()
		' If reception enabled Create New polling Midi Input event 

		If m_fReceiveEnabled Then
			Local event:wxCommandEvent = New wxCommandEvent.NewEvent( wxEVT_POLLING_EVENT, GetId() )
			event.SetEventObject( Self )
			GetEventHandler().AddPendingEvent( event ) ' Add it To the queue
		End If

	End Method

	Method StartReceiving()
		If Not m_pInDev Then
			m_text.AppendText("No input device. Reception not started.~n")
			Return
		End If

		m_text.AppendText("Start receiving:~n")
		m_fReceiveEnabled = True

		'Filter out active sensing messages (0xFE) and clock messages (0xF8 only)
	    m_pInDev.SetFilter(wxMIDI_FILT_ACTIVE | wxMIDI_FILT_CLOCK)

	    ' empty the buffer after setting filter, just in case anything got through
	    m_pInDev.Flush()

		'CreatePollingEvent()
		m_fCreatePollingEvent = True		'when idle, create a Midi event
	End Method
	
End Type

Type IntVal

	Field value:Int

	Function Set:IntVal(value:Int)
		Local this:IntVal = New IntVal
		this.value = value
		Return this
	End Function
End Type

Function Hex$( val:Int, size:Int )
	Local buf:Short[size]
	For Local k:Int = size - 1 To 0 Step -1
		Local n:Int = (val&15)+Asc("0")
		If n>Asc("9") n=n+(Asc("A")-Asc("9")-1)
		buf[k] = n
		val:Shr 4
	Next
	Return String.FromShorts( buf,size )
End Function

Type MyEventFactory Extends TCustomEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Select evt.eventType
			Case wxEVT_POLLING_EVENT
				Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		Return Null
	End Method
	
End Type

