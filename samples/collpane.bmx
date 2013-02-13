'
' wxCollapsiblePane sample
'
' From the C++ sample by Francesco Montorsi
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxColourPickerCtrl
Import wx.wxFontPickerCtrl
Import wx.wxFilePickerCtrl
Import wx.wxCollapsiblePane
Import wx.wxStaticText
Import wx.wxTextEntryDialog
Import wx.wxButton
Import wx.wxAboutBox

Const PANE_COLLAPSE:Int = 1
Const PANE_EXPAND:Int = 2
Const PANE_SETLABEL:Int = 3
Const PANE_SHOWDLG:Int = 4
Const PANE_ABOUT:Int = wxID_ABOUT
Const PANE_QUIT:Int = wxID_EXIT


New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		' create and show the main frame
		frame = MyFrame(New MyFrame.Create(Null, -1, "wxCollapsiblePane sample", ,,420, 300, wxDEFAULT_FRAME_STYLE))
		
		frame.show()
	
		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

    Field collPane:wxCollapsiblePane

	Method OnInit()
	
		CreateStatusBar(2)

		' Make a menubar
		Local paneMenu:wxMenu = New wxMenu.Create()
		paneMenu.Append(PANE_COLLAPSE, "Collapse~tCtrl-C")
		paneMenu.Append(PANE_EXPAND, "Expand~tCtrl-E")
		paneMenu.AppendSeparator()
		paneMenu.Append(PANE_SETLABEL, "Set label...~tCtrl-S")
		paneMenu.AppendSeparator()
		paneMenu.Append(PANE_SHOWDLG, "Show dialog...~tCtrl-S")
		paneMenu.AppendSeparator()
		paneMenu.Append(PANE_QUIT)
		
		Local helpMenu:wxMenu = New wxMenu.Create()
		helpMenu.Append(PANE_ABOUT)
		
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(paneMenu, "&Pane")
		menuBar.Append(helpMenu, "&Help")
		SetMenuBar(menuBar)
		
		collPane = New wxCollapsiblePane.Create(Self, -1, "test!")
		Local win:wxWindow = collPane.GetPane()
		
		New wxStaticText.Create(win, -1, "Static control with absolute coords", 10,2)
		New wxStaticText.Create(win, -1, "Yet another one!", 30, 30)
		New wxTextCtrl.Create(win, -1, "You can place anything you like inside a wxCollapsiblePane", 5, 60, 300, -1)

		Connect(PANE_COLLAPSE, wxEVT_COMMAND_MENU_SELECTED, OnCollapse)
		Connect(PANE_EXPAND, wxEVT_COMMAND_MENU_SELECTED, OnExpand)
		Connect(PANE_SETLABEL, wxEVT_COMMAND_MENU_SELECTED, OnSetLabel)
		Connect(PANE_SHOWDLG, wxEVT_COMMAND_MENU_SELECTED, OnShowDialog)
		Connect(PANE_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(PANE_QUIT, wxEVT_COMMAND_MENU_SELECTED, Quit)
		
		Connect(wxID_ANY, wxEVT_UPDATE_UI, UpdateUI)
	End Method


	Function OnCollapse(event:wxEvent)
		MyFrame(event.parent).collPane.Collapse()
	End Function
	
	Function OnExpand(event:wxEvent)
		MyFrame(event.parent).collPane.Expand()
	End Function
	
	Function OnSetLabel(event:wxEvent)
		Local text:String = wxGetTextFromUser("Input the new label")
		MyFrame(event.parent).collPane.SetLabel(text)
	End Function
	
	Function OnShowDialog(event:wxEvent)
		Local dlg:MyDialog = New MyDialog.CreateMyDialog(wxFrame(event.parent))
		dlg.ShowModal()
		dlg.Free()
	End Function
	
	Function Quit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		Local info:wxAboutDialogInfo = New wxAboutDialogInfo.Create()
		info.SetName("wxCollapsiblePane sample")
		info.SetDescription("This sample program demonstrates usage of wxCollapsiblePane")
		info.SetCopyright("(C) 2006 Francesco Montorsi <frm@users.sourceforge.net>~n" + ..
			"BlitzMax port (c) 2007-2013 Bruce A Henderson")
		
		wxAboutBox(info)
	End Function
	
	' Menu command update functions
	Function UpdateUI(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.GetMenuBar().EnableItem(PANE_COLLAPSE, Not frame.collPane.IsCollapsed())
		frame.GetMenuBar().EnableItem(PANE_EXPAND, frame.collPane.IsCollapsed())
	End Function

End Type

Type MyDialog Extends wxDialog

	Const PANEDLG_TOGGLESTATUS_BTN:Int = wxID_HIGHEST
	
	Field collPane:wxCollapsiblePane
	
	Method CreateMyDialog:MyDialog(parent:wxFrame)
		Return MyDialog(Create_(parent, wxID_ANY, "Test dialog", ,,,, wxRESIZE_BORDER|wxDEFAULT_DIALOG_STYLE))
	End Method
	
	Method OnInit()

		Local sz:wxSizer = New wxBoxSizer.Create(wxVERTICAL)
		sz.Add(New wxStaticText.Create(Self, -1, "This dialog allows you to test the wxCollapsiblePane control"), ..
			0, wxALL, 5)
		sz.Add(New wxButton.Create(Self, PANEDLG_TOGGLESTATUS_BTN, "Change status"), 1, wxGROW | wxALL, 5)
		
		collPane = New wxCollapsiblePane.Create(Self, -1, "Click here for a surprise")
		sz.Add(collPane, 0, wxGROW | wxALL, 5)
		sz.Add(New wxTextCtrl.Create(Self, -1, "just a test"), 0, wxGROW | wxALL, 5)
		sz.AddSpacer(10)
		sz.Add(New wxButton.Create(Self, wxID_OK), 0, wxALIGN_RIGHT | wxALL, 5)
		
		' now add test controls in the collapsible pane
		Local win:wxWindow = collPane.GetPane()
		Local paneSz:wxSizer = New wxGridSizer.CreateRC(2, 2, 5, 5)
		paneSz.Add(New wxColourPickerCtrl.Create(win, -1), 1, wxGROW | wxALL, 2)
		paneSz.Add(New wxFontPickerCtrl.Create(win, -1), 1, wxGROW | wxALL, 2)
		paneSz.Add(New wxFilePickerCtrl.Create(win, -1), 1, wxALL | wxALIGN_CENTER, 2)
		paneSz.Add(New wxDirPickerCtrl.Create(win, -1), 1, wxALL | wxALIGN_CENTER, 2)
		win.SetSizer(paneSz)
		paneSz.SetSizeHints(win)
		
		SetSizer(sz)
		sz.SetSizeHints(Self)

		Connect(PANEDLG_TOGGLESTATUS_BTN, wxEVT_COMMAND_BUTTON_CLICKED, OnToggleStatus)
		Connect(wxID_ANY, wxEVT_COMMAND_COLLPANE_CHANGED, OnPaneChanged)
	End Method
	
	Function OnToggleStatus(event:wxEvent)
		Local dlg:MyDialog = MyDialog(event.parent)
		dlg.collPane.Collapse(Not dlg.collPane.IsCollapsed())
	End Function

	Function OnPaneChanged(event:wxEvent)
		Local how:String
		If wxCollapsiblePaneEvent(event).GetCollapsed() Then
			how = "collapsed"
		Else
			how = "expanded"
		End If
		DebugLog("The pane has just been " + how + " by the user")
	End Function

End Type
