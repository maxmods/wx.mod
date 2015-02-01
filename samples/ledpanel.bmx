SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxLEDPanel


New MyApp.run()


Type MyApp Extends wxApp

	Field frame:LEDFrame

	Method OnInit:Int()

		frame = LEDFrame(New LEDFrame.Create(,,"wxLEDPanel wxWidgets App"))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type LEDFrame Extends wxFrame

	Method OnInit:Int()
	
		Local sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		' The first LEDPanel . Static text
		Local lp1:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4 , 63, 9 ,0)
		lp1.SetText("wxLEDPanel", wxALIGN_CENTER) ' Set the LED-Text
		sizer.Add(lp1, 0, wxALIGN_CENTER | wxALL, 5)

		' The 2nd LEDPanel
		Local lp2:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4, 63, 9,0)
		lp2.SetTextAlign(wxALIGN_CENTER_VERTICAL)    ' Center the text vertical
		lp2.SetLEDColour(wxLED_COLOUR_GREEN)         ' Set the LEDColour (default colour is red)
		lp2.SetScrollDirection(wxLED_SCROLL_LEFT)    ' Set the Scrolldirection
		lp2.SetScrollSpeed(80)                       ' Set the Scrollspeed
		lp2.SetText("wxLEDPanel")
		sizer.Add(lp2, 0, wxALIGN_CENTER|wxALL, 5)
	
		' The 3rd LEDPanel
		Local lp3:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4, 63, 9, 0)
		lp3.SetTextAlign(wxALIGN_CENTER_HORIZONTAL)  ' Center the text horizontal
		lp3.SetLEDColour(wxLED_COLOUR_BLUE)          ' Set the LEDColour (default colour is red)
		lp3.SetScrollDirection(wxLED_SCROLL_UP)      ' Set the Scrolldirection
		lp3.SetScrollSpeed(120)                      ' Set the Scrollspeed
		lp3.SetText("wxLEDPanel~n2nd Line~n3rd Line~n4th Line", wxALIGN_RIGHT) ' multi-line text
		sizer.Add(lp3, 0, wxALIGN_CENTER|wxALL, 5)
	
		' The 4th LEDPanel
		' Bigger LEDs and space (1px) between the leds
		Local lp4:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 5, 5, 63, 9, 1)
		lp4.SetText("wxLEDPanel",wxALIGN_CENTER)
		lp4.SetLEDColour(wxLED_COLOUR_CYAN)          ' Set the LEDColour (default colour is red)
		sizer.Add(lp4, 0, wxALIGN_CENTER|wxALL, 5)
	
		' The 5th LEDPanel . Static text, invertet
		Local lp5:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4, 76, 9, 0)
		lp5.SetLetterSpace(2)                        ' more space between the letters
		lp5.ShowInverted(True)                       ' Draw the LEDs invertet
		lp5.SetText("wxLEDPanel",wxALIGN_CENTER) ' Set the LED-Text
		sizer.Add(lp5, 0, wxALIGN_CENTER|wxALL, 5)
	
		' The 6th LEDPanel
		Local lp6:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4, 76, 9, 0)
		lp6.SetLEDColour(wxLED_COLOUR_GREEN)
		lp6.SetScrollDirection(wxLED_SCROLL_RIGHT)   ' Set the Scrolldirection
		lp6.SetScrollSpeed(80)                       ' Set the Scrollspeed
		lp6.ShowInactiveLEDs(False)                  ' Don't draw inactiv LEDs
		lp6.SetFontTypeWide()                        ' use a bigger font with 7x7 Letters
		lp6.SetText("wxLEDPanel",wxALIGN_CENTER) ' Set the LED-Text
		sizer.Add(lp6, 0, wxALIGN_CENTER|wxALL, 5)
	
		' The 7th LEDPanel
		Local lp7:wxLEDPanel = New wxLEDPanel.Create(Self, wxID_ANY, 4, 4, 76, 9, 0)
		lp7.SetLEDColour(wxLED_COLOUR_BLUE)
		lp7.SetScrollDirection(wxLED_SCROLL_DOWN)    ' Set the Scrolldirection
		lp7.SetScrollSpeed(120)                      ' Set the Scrollspeed
		lp7.ShowInactiveLEDs(False)                  ' Don't draw inactiv LEDs
		lp7.ShowInverted(True)                       ' Draw the LEDs invertet
		lp7.SetFontTypeWide()                        ' use a bigger font with 7x7 Letters
		lp7.SetText("wxLEDPanel~n2nd Line~n3rd Line~n4th Line", wxALIGN_RIGHT) ' Set the LED-Text
		sizer.Add(lp7, 0, wxALIGN_CENTER|wxALL, 5)

	
		' Sizer For the Panel
		SetSizerAndFit(sizer)
		
	End Method
	
End Type


