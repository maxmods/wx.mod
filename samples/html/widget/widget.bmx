'
' wxHtmlWindow widget sample
'     Demonstrates embedded controls
'
' From the C++ sample
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHtmlWindow
Import wx.wxTextCtrl

New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()
	
		' register the module
		New MyBindModule.Create()

		Local frame:MyFrame = MyFrame(New MyFrame.Create(,,"wxHtmlWindow testing application", ,, 640, 480))

		frame.show()
		SetTopWindow(frame)
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field html:wxHtmlWindow

	Const Minimal_Quit:Int = wxID_EXIT
	Const Minimal_Back:Int = 2
	Const Minimal_Forward:Int = 3

	Method OnInit()
	
		' Create a menu bar
		Local menuFile:wxMenu = New wxMenu.Create()
		Local menuNav:wxMenu = New wxMenu.Create()
		
		menuFile.Append(Minimal_Quit, "E&xit")
		menuNav.Append(Minimal_Back, "Go &BACK")
		menuNav.Append(Minimal_Forward, "Go &FORWARD")
		
		' now append the freshly created menu To the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(menuNav, "&Navigate")
		
		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)

		CreateStatusBar(2)
	
		html = New wxHtmlWindow.Create(Self, -1)
		
		html.SetRelatedFrame(Self, "wxHTML Demo: '%s'")
		html.SetRelatedStatusBar(1)
		
		html.LoadPage("start.htm")


		Connect(Minimal_Quit, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(Minimal_Back, wxEVT_COMMAND_MENU_SELECTED, OnBack)
		Connect(Minimal_Forward, wxEVT_COMMAND_MENU_SELECTED, OnForward)
	End Method

	Function OnQuit(event:wxEvent)
		' True is To force the frame To close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnBack(event:wxEvent)
		If Not MyFrame(event.parent).html.HistoryBack() Then
			wxMessageBox("You reached prehistory era!")
		End If
	End Function
	
	Function OnForward(event:wxEvent)
		If Not MyFrame(event.parent).html.HistoryForward() Then
			wxMessageBox("No more items in history!")
		End If
	End Function


End Type


Type MyBindModule Extends wxHtmlTagsModule

	Method FillHandlersTable(parser:wxHtmlWinParser)
		parser.AddTagHandler(New MyBindTagHandler.Create())
	End Method

End Type

Type MyBindTagHandler Extends wxHtmlTagHandler


	Method GetSupportedTags:String()
		Return "MYBIND"
	End Method


	Method HandleTag:Int(tag:wxHtmlTag)

		Local ax:Int, ay:Int, fl:Int

		tag.GetParamAsInt("X", ax)
		tag.GetParamAsInt("Y", ay)

		If tag.HasParam("FLOAT") Then
			fl = ax
		End If
		
		Local wnd:wxTextCtrl = New wxTextCtrl.Create( GetParser().GetWindowInterface().GetHTMLWindow(), ..
				wxID_ANY, tag.GetParam("NAME"), 0, 0, ax, ay, wxTE_MULTILINE)
		
		wnd.Show(True)
		
		GetParser().GetContainer().InsertCell(New wxHtmlWidgetCell.Create(wnd, fl))

		Return False
	End Method

End Type
