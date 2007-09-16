'
' wxFont sample
'
' From the C++ sample by Vadim Zeitlin
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxDC
Import wx.wxFrame
Import wx.wxSplitterWindow
Import wx.wxTextCtrl
Import wx.wxTextEntryDialog
Import wx.wxChoiceDialog
Import wx.wxFontDialog
Import wx.wxLog

' used as title For several dialog boxes
Const SAMPLE_TITLE:String = "wxWidgets Font Sample"

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		' Create the main application window
		frame = MyFrame(New MyFrame.Create(,,"Font wxWidgets demo", 50, 50, 600, 400))
		
		' Show it and tell the application that it's our main window
		frame.show(True)
		SetTopWindow(frame)
			
		Return True
	End Method

End Type

Type MyFrame Extends wxFrame

	Field FontSize:Int
	Field textCtrl:wxTextCtrl
	Field canvas:MyCanvas

	Const Font_Quit:Int = wxID_EXIT
	Const Font_About:Int = wxID_ABOUT
	Const Font_ViewMsg:Int = 3
	Const Font_TestTextValue:Int = 4
	
	Const Font_IncSize:Int = 5
	Const Font_DecSize:Int = 6
	Const Font_Bold:Int = 7
	Const Font_Italic:Int = 8
	Const Font_Underlined:Int = 9
	Const Font_wxNORMAL_FONT:Int = 10
	Const Font_wxSMALL_FONT:Int = 11
	Const Font_wxITALIC_FONT:Int = 12
	Const Font_wxSWISS_FONT:Int = 13
	Const Font_Standard:Int = 14
	
	Const Font_Choose:Int = 100
	Const Font_EnumFamiliesForEncoding:Int = 101
	Const Font_EnumFamilies:Int = 102
	Const Font_EnumFixedFamilies:Int = 103
	Const Font_EnumEncodings:Int = 104
	Const Font_SetNativeDesc:Int = 105
	Const Font_SetNativeUserDesc:Int = 106
	Const Font_SetFaceName:Int = 107
	Const Font_SetEncoding:Int = 108
	Const Font_Max:Int = 109

	Method OnInit()
	
		FontSize = wxNORMAL_FONT().GetPointSize()
		
		Local menuFile:wxMenu = New wxMenu.Create()
		
		menuFile.Append(Font_TestTextValue, "&Test text value", ..
		               "Verify that getting and setting text value doesn't change it")
		menuFile.Append(Font_ViewMsg, "&View...~tCtrl-V", "View an email message file")
		menuFile.AppendSeparator()
		menuFile.Append(Font_About, "&About...~tCtrl-A", "Show about dialog")
		menuFile.AppendSeparator()
		menuFile.Append(Font_Quit, "E&xit~tAlt-X", "Quit this program")
		
		Local menuFont:wxMenu = New wxMenu.Create()
		menuFont.Append(Font_IncSize, "&Increase font size by 2 points~tCtrl-I")
		menuFont.Append(Font_DecSize, "&Decrease font size by 2 points~tCtrl-D")
		menuFont.AppendSeparator()
		menuFont.AppendCheckItem(Font_Bold, "&Bold~tCtrl-B", "Toggle bold state")
		menuFont.AppendCheckItem(Font_Italic, "&Oblique~tCtrl-O", "Toggle italic state")
		menuFont.AppendCheckItem(Font_Underlined, "&Underlined~tCtrl-U", "Toggle underlined state")
		
		menuFont.AppendSeparator();
		menuFont.Append(Font_SetNativeDesc, "Set native font &description~tShift-Ctrl-D")
		menuFont.Append(Font_SetNativeUserDesc, "Set &user font description~tShift-Ctrl-U")
		menuFont.Append(Font_SetFaceName, "Check font face name")                   
		menuFont.Append(Font_SetEncoding, "Set font &encoding~tShift-Ctrl-E")
		
		Local menuSelect:wxMenu = New wxMenu.Create()
		menuSelect.Append(Font_Choose, "&Select font...~tCtrl-S", "Select a standard font")
		
		Local menuStdFonts:wxMenu = New wxMenu.Create()
		menuStdFonts.Append(Font_wxNORMAL_FONT, "wxNORMAL_FONT", "Normal font used by wxWidgets")
		menuStdFonts.Append(Font_wxSMALL_FONT,  "wxSMALL_FONT",  "Small font used by wxWidgets")
		menuStdFonts.Append(Font_wxITALIC_FONT, "wxITALIC_FONT", "Italic font used by wxWidgets")
		menuStdFonts.Append(Font_wxSWISS_FONT,  "wxSWISS_FONT",  "Swiss font used by wxWidgets")
		menuSelect.AppendMenu(Font_Standard, "Standar&d fonts", menuStdFonts)
		
		menuSelect.AppendSeparator()
		menuSelect.Append(Font_EnumFamilies, "Enumerate font &families~tCtrl-F")
		menuSelect.Append(Font_EnumFixedFamilies, "Enumerate fi&xed font families~tCtrl-X")
		menuSelect.Append(Font_EnumEncodings, "Enumerate &encodings~tCtrl-E")
		menuSelect.Append(Font_EnumFamiliesForEncoding, "Find font for en&coding...~tCtrl-C", ..
		               "Find font families for given encoding")
		
		' now append the freshly created menu To the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(menuFont, "F&ont")
		menuBar.Append(menuSelect, "&Select")
		
		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)

		Local splitter:wxSplitterWindow = New wxSplitterWindow.Create(Self)

		textctrl = New wxTextCtrl.Create(splitter, wxID_ANY, "Paste text here to see how it looks~nlike in the given font", ,, ,, wxTE_MULTILINE)

		canvas = MyCanvas(New MyCanvas.CreateWin(splitter))

		splitter.SplitHorizontally(textctrl, canvas, 100)

		CreateStatusBar()
		SetStatusText("Welcome to wxWidgets font demo!")


		Connect(Font_Quit, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(Font_TestTextValue, wxEVT_COMMAND_MENU_SELECTED, OnTestTextValue)
		Connect(Font_ViewMsg, wxEVT_COMMAND_MENU_SELECTED, OnViewMsg)
		Connect(Font_About, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
		Connect(Font_IncSize, wxEVT_COMMAND_MENU_SELECTED, OnIncFont)
		Connect(Font_DecSize, wxEVT_COMMAND_MENU_SELECTED, OnDecFont)
		Connect(Font_Bold, wxEVT_COMMAND_MENU_SELECTED, OnBold)
		Connect(Font_Italic, wxEVT_COMMAND_MENU_SELECTED, OnItalic)
		Connect(Font_Underlined, wxEVT_COMMAND_MENU_SELECTED, OnUnderline)
		
		Connect(Font_wxNORMAL_FONT, wxEVT_COMMAND_MENU_SELECTED, OnwxPointerFont)
		Connect(Font_wxSMALL_FONT, wxEVT_COMMAND_MENU_SELECTED, OnwxPointerFont)
		Connect(Font_wxITALIC_FONT, wxEVT_COMMAND_MENU_SELECTED, OnwxPointerFont)
		Connect(Font_wxSWISS_FONT, wxEVT_COMMAND_MENU_SELECTED, OnwxPointerFont)
		
		
		Connect(Font_SetNativeDesc, wxEVT_COMMAND_MENU_SELECTED, OnSetNativeDesc)
		Connect(Font_SetNativeUserDesc, wxEVT_COMMAND_MENU_SELECTED, OnSetNativeUserDesc)
		Connect(Font_SetFaceName, wxEVT_COMMAND_MENU_SELECTED, OnSetFaceName)
		Connect(Font_SetEncoding, wxEVT_COMMAND_MENU_SELECTED, OnSetEncoding)
		
		Connect(Font_Choose, wxEVT_COMMAND_MENU_SELECTED, OnSelectFont)
		Connect(Font_EnumFamiliesForEncoding, wxEVT_COMMAND_MENU_SELECTED, OnEnumerateFamiliesForEncoding)
		Connect(Font_EnumFamilies, wxEVT_COMMAND_MENU_SELECTED, OnEnumerateFamilies)
		Connect(Font_EnumFixedFamilies, wxEVT_COMMAND_MENU_SELECTED, OnEnumerateFixedFamilies)
		Connect(Font_EnumEncodings, wxEVT_COMMAND_MENU_SELECTED, OnEnumerateEncodings)

	End Method
	
	Method GetCanvas:MyCanvas()
		Return canvas
	End Method
	
	Method DoResizeFont(diff:Int)
		Local font:wxFont = canvas.GetTextFont()
		
		font.SetPointSize(font.GetPointSize() + diff)
		DoChangeFont(font)
	End Method

	Method DoChangeFont(font:wxFont, col:wxColour = Null)
	
		canvas.SetTextFont(font)
		If col Then
			canvas.SetColour(col)
		End If
		canvas.Refresh()
		
		textctrl.SetFont(font)
		If col Then
			textctrl.SetForegroundColour(col)
		End If
		
		' update the state of the bold/italic/underlined menu items
		Local mbar:wxMenuBar = GetMenuBar()
		If mbar Then
			mbar.Check(Font_Bold, font.GetWeight() = wxFONTWEIGHT_BOLD)
			mbar.Check(Font_Italic, font.GetStyle() = wxFONTSTYLE_ITALIC)
			mbar.Check(Font_Underlined, font.GetUnderlined())
		End If
	End Method

	Function OnIncFont(event:wxEvent)
		MyFrame(event.parent).DoResizeFont(+2)
	End Function
	
	Function OnDecFont(event:wxEvent)
		MyFrame(event.parent).DoResizeFont(-2)
	End Function

	Function OnEnumerateFamiliesForEncoding(event:wxEvent)
	End Function

	Function OnEnumerateFamilies(event:wxEvent)
		MyFrame(event.parent).DoEnumerateFamilies(False)
	End Function

	Function OnEnumerateFixedFamilies(event:wxEvent)
		MyFrame(event.parent).DoEnumerateFamilies(True)
	End Function

	Function OnEnumerateEncodings(event:wxEvent)
	End Function

	Function OnSetNativeDesc(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local fontInfo:String = wxGetTextFromUser("Enter native font string", "Input font description", ..
			frame.canvas.GetTextFont().GetNativeFontInfoDesc(), frame)
		
		If Not fontInfo Then
			Return     ' user clicked "Cancel" - do nothing
		End If
		
		Local font:wxFont = New wxFont.Create()
		font.SetNativeFontInfo(fontInfo)
		If Not font.IsOk()
			wxLogError("Font info string ~q" + fontInfo + "~q is invalid.")
			Return
		End If
		
		frame.DoChangeFont(font)
	End Function

	Function OnSetFaceName(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		
		Local facename:String = frame.GetCanvas().GetTextFont().GetFaceName()
		Local newFaceName:String = wxGetTextFromUser( "Here you can edit current font face name.", ..
			"Input font facename", facename, frame)
			
		If Not newFaceName Then
			Return     ' user clicked "Cancel" - do nothing
		End If
		
		Local font:wxFont = frame.GetCanvas().GetTextFont()
		If font.SetFaceName(newFaceName) Then      ' change facename only
			frame.DoChangeFont(font)
		Else
			wxMessageBox("There is no font with such face name...", "Invalid face name", wxOK | wxICON_ERROR, frame)
		End If
	End Function

	Function OnSetNativeUserDesc(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local fontdesc:String = frame.GetCanvas().GetTextFont().GetNativeFontInfoUserDesc()
		Local fontUserInfo:String = wxGetTextFromUser("Here you can edit current font description", ..
			"Input font description", fontdesc, frame)
		If Not fontUserInfo Then
			Return     ' user clicked "Cancel" - do nothing
		End If
		
		Local font:wxFont = New wxFont.Create()
		If font.SetNativeFontInfoUserDesc(fontUserInfo)
			frame.DoChangeFont(font)
		Else
			wxMessageBox("Error trying to create a font with such description...")
		End If
	End Function

	Function OnSetEncoding(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local enc:Int = frame.GetEncodingFromUser()
		If enc = wxFONTENCODING_SYSTEM Then
			Return
		End If
		
		Local font:wxFont = frame.canvas.GetTextFont()
		font.SetEncoding(enc)
		frame.DoChangeFont(font)
	End Function
	
	Method GetEncodingFromUser:Int()
		Local count:Int = wxFontMapper.GetSupportedEncodingsCount()
		Local names:String[] = New String[count]
		Local encodings:Int[] = New Int[count]
		
		For Local n:Int = 0 Until count
			Local enc:Int = wxFontMapper.GetEncoding(n)
			encodings[n] = enc
			names[n] = wxFontMapper.GetEncodingName(enc)
		Next
		
		Local i:Int = wxGetSingleChoiceIndex("Choose the encoding", SAMPLE_TITLE, names, Self)
		
		If i = -1 Then
			Return wxFONTENCODING_SYSTEM
		Else
			Return encodings[i]
		End If

	End Method

	Function OnBold(event:wxEvent)
		Local font:wxFont = MyFrame(event.parent).canvas.GetTextFont()
		
		If wxCommandEvent(event).IsChecked() Then
			font.SetWeight(wxFONTWEIGHT_BOLD)
		Else
			font.SetWeight(wxFONTWEIGHT_NORMAL)
		End If
		MyFrame(event.parent).DoChangeFont(font)
	End Function

	Function OnItalic(event:wxEvent)
		Local font:wxFont = MyFrame(event.parent).canvas.GetTextFont()
		
		If wxCommandEvent(event).IsChecked() Then
			font.SetStyle(wxFONTSTYLE_ITALIC)
		Else
			font.SetStyle(wxFONTSTYLE_NORMAL)
		End If
		MyFrame(event.parent).DoChangeFont(font)
	End Function

	Function OnUnderline(event:wxEvent)
		Local font:wxFont = MyFrame(event.parent).canvas.GetTextFont()
		
		font.SetUnderlined(wxCommandEvent(event).IsChecked())
		MyFrame(event.parent).DoChangeFont(font)
	End Function

	Function OnwxPointerFont(event:wxEvent)
		Local font:wxFont
		
		Select event.GetId()
			Case Font_wxNORMAL_FONT
				font = wxNORMAL_FONT()
			
			Case Font_wxSMALL_FONT
				font = wxSMALL_FONT()
			
			Case Font_wxITALIC_FONT
				font = wxITALIC_FONT()
			
			Case Font_wxSWISS_FONT
				font = wxSWISS_FONT()
			
			Default
				'wxFAIL_MSG( wxT("unknown standard font") );
				Return
		End Select
		
		MyFrame(event.parent).DoChangeFont(font)
	End Function

	Function OnSelectFont(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local data:wxFontData = New wxFontData.Create()
		data.SetInitialFont(frame.canvas.GetTextFont())
		data.SetColour(frame.canvas.GetColour())
		
		Local dialog:wxFontDialog = New wxFontDialog.CreateFD(frame, data)
		If dialog.ShowModal() = wxID_OK Then
		
			Local retData:wxFontData = dialog.GetFontData()
			Local font:wxFont = retData.GetChosenFont()
			Local colour:wxColour = retData.GetColour()
			
			frame.DoChangeFont(font, colour)
		End If
		dialog.Free()
	End Function

	Function OnQuit(event:wxEvent)
		' True is To force the frame To close
		wxWindow(event.parent).Close(True)
	End Function

	Function OnTestTextValue(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local value:String = frame.textctrl.GetValue()
		frame.textctrl.ChangeValue(value)

		If frame.textctrl.GetValue() <> value Then		
			wxLogError("Text value changed after getting and setting it")
		End If
	End Function

	Function OnViewMsg(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local value:String = frame.textctrl.GetValue()
		frame.textctrl.ChangeValue(value)
		
		If frame.textctrl.GetValue() <> value Then
			wxLogError("Text value changed after getting and setting it")
		End If
	End Function

	Function OnAbout(event:wxEvent)
		wxMessageBox("wxWidgets font sample~n(c) 1999-2006 Vadim Zeitlin~nBlitzMax port (c) 2007 Bruce A Henderon", ..
			"About " + SAMPLE_TITLE, wxOK | wxICON_INFORMATION, wxWindow(event.parent))
	End Function

	Method DoEnumerateFamilies:Int(fixedWidthOnly:Int, encoding:Int = wxFONTENCODING_SYSTEM, silent:Int = False)
	End Method
	
End Type


' MyCanvas is a canvas on which we show the font sample
Type MyCanvas Extends wxWindow

	Field colour:wxColour = wxRED()
	Field font:wxFont = wxNORMAL_FONT()

	Method OnInit()
		ConnectNoId(wxEVT_PAINT, OnPaint)
	End Method

    ' accessors For the frame
	Method GetTextFont:wxFont()
		Return font
	End Method

	Method GetColour:wxColour()
		Return colour
	End Method
	
	Method SetTextFont(font:wxFont)
		Self.font = font
	End Method
	
	Method SetColour(colour:wxColour)
		self.colour = colour
	End Method
	
	Function OnPaint(event:wxEvent)

		Local canvas:MyCanvas = MyCanvas(event.parent)

		Local dc:wxPaintDC = New wxPaintDC.Create(canvas)
		canvas.PrepareDC(dc)
		
		' set background
		dc.SetBackground(New wxBrush.Create("white", wxSOLID))
		dc.Clear()
	
		' one text line height
		Local hLine:Int = dc.GetCharHeight()
		
		' the current text origin
		Local x:Int = 5, y:Int = 5

		' output the font name/info
		Local fontInfo:String = "Font size is " + canvas.font.GetPointSize() + ..
				" points, family: " + canvas.font.GetFamilyString() + ..
				", encoding: " + wxFontMapper.GetEncodingDescription(canvas.font.GetEncoding())
		
		dc.DrawText(fontInfo, x, y)
		y:+ hLine
		
		Local fixed:String = "no"
		If canvas.font.IsFixedWidth() fixed = "yes"
		
		fontInfo = "Style: " + canvas.font.GetStyleString() + ..
				", weight: " + canvas.font.GetWeightString() + ..
				", fixed width: " + fixed

		dc.DrawText(fontInfo, x, y)
		y:+ hLine

		If canvas.font.IsOk() Then
		
			' TODO !	
		
		End If
		
		y:+ hLine

		' prepare To draw the font
		dc.SetFont(canvas.font)
		dc.SetTextForeground(canvas.colour)

		' the size of one cell (Normally biggest char + small margin)
		Local maxCharWidth:Int, maxCharHeight:Int
		dc.GetTextExtent("W", maxCharWidth, maxCharHeight)
		
		Local w:Int = maxCharWidth + 5
		Local h:Int = maxCharHeight + 4

		' print all font symbols from 32 to 256 in 7 rows of 32 chars each
		For Local i:Int = 0 Until 7
			For Local j:Int = 0 Until 32
			
				Local c:String = Chr(32 * (i + 1) + j)

				Local charWidth:Int, charHeight:Int
				dc.GetTextExtent(c, charWidth, charHeight)

				dc.DrawText(c, x + w*j + (maxCharWidth - charWidth) / 2 + 1, ..
					y + h*i + (maxCharHeight - charHeight) / 2)
			Next
		Next

		' draw the lines between them
		dc.SetPen(New wxPen.CreateFromColour(New wxColour.CreateNamedColour("blue"), 1, wxSOLID))
		Local l:Int
		
		' horizontal
		For l = 0 Until 8
			Local yl:Int = y + h * l - 2
			dc.DrawLine(x - 2, yl, x + 32 * w - 1, yl)
		Next

		' and vertical
		For l = 0 Until 33
			Local xl:Int = x + w * l - 2
			dc.DrawLine(xl, y - 2, xl, y + 7 * h - 1)
		Next

		dc.free()
	End Function

End Type


New MyApp.run()
