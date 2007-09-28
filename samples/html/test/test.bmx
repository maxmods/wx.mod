SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHtmlWindow

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		wxInitAllImageHandlers()
		
		SetAppName("wxHtmlTest")
		
		frame = MyFrame(New MyFrame.Create(,,"wxHtmlWindow testing application", ,, 640, 480))

		frame.show()
		
		Return True
	
	End Method

End Type

Type MyHtmlWindow Extends wxHtmlWindow

	Method OnInit()
	End Method
	
	Method OnOpeningURL:String(urlType:Int, url:String, returnStatus:Int Ptr)
		GetRelatedFrame().SetStatusText(url + " lately opened",1)
		returnStatus[0] = wxHTML_OPEN
	End Method

End Type

    ' menu items
Const ID_PageOpen:Int = wxID_HIGHEST
Const ID_DefaultLocalBrowser:Int = wxID_HIGHEST + 1
Const ID_DefaultWebBrowser:Int = wxID_HIGHEST + 2
Const ID_Back:Int = wxID_HIGHEST + 3
Const ID_Forward:Int = wxID_HIGHEST + 4
Const ID_Processor:Int = wxID_HIGHEST + 5

Type MyFrame Extends wxFrame

	Method OnInit()

		' create a menu bar
		Local menuFile:wxMenu = New wxMenu.Create()
		Local menuNav:wxMenu = New wxMenu.Create()
		
		menuFile.Append(ID_PageOpen, "&Open HTML page...")
		menuFile.Append(ID_DefaultLocalBrowser, "&Open current page with default browser")
		menuFile.Append(ID_DefaultWebBrowser, "Open a &web page with default browser")
		menuFile.AppendSeparator()
		menuFile.Append(ID_Processor, "&Remove bold attribute", "", wxITEM_CHECK)
		
		menuFile.AppendSeparator()
		menuFile.Append(wxID_EXIT, "&Close frame")
		menuNav.Append(ID_Back, "Go &BACK")
		menuNav.Append(ID_Forward, "Go &FORWARD")
		
		' now append the freshly created menu To the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		menuBar.Append(menuNav, "&Navigate")
		
		' ... And attach this menu bar To the frame
		SetMenuBar(menuBar)
		
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(ID_PageOpen, wxEVT_COMMAND_MENU_SELECTED, OnPageOpen)
		Connect(ID_DefaultLocalBrowser, wxEVT_COMMAND_MENU_SELECTED, OnDefaultLocalBrowser)
		Connect(ID_DefaultWebBrowser, wxEVT_COMMAND_MENU_SELECTED, OnDefaultWebBrowser)
		Connect(ID_Back, wxEVT_COMMAND_MENU_SELECTED, OnBack)
		Connect(ID_Forward, wxEVT_COMMAND_MENU_SELECTED, OnForward)
		Connect(ID_Processor, wxEVT_COMMAND_MENU_SELECTED, OnProcessor)
		
		Connect(wxID_ANY, wxEVT_COMMAND_HTML_LINK_CLICKED, OnHtmlLinkClicked)
		Connect(wxID_ANY, wxEVT_COMMAND_HTML_CELL_HOVER, OnHtmlCellHover)
		Connect(wxID_ANY, wxEVT_COMMAND_HTML_CELL_CLICKED, OnHtmlCellClicked)
	End Method

	' event handlers
	Function OnQuit(event:wxEvent)
	End Function
	
	Function OnPageOpen(event:wxEvent)
	End Function
	
	Function OnDefaultLocalBrowser(event:wxEvent)
	End Function
	
	Function OnDefaultWebBrowser(event:wxEvent)
	End Function
	
	Function OnBack(event:wxEvent)
	End Function
	
	Function OnForward(event:wxEvent)
	End Function
	
	Function OnProcessor(event:wxEvent)
	End Function
	
	Function OnHtmlLinkClicked(event:wxEvent)
	End Function
	
	Function OnHtmlCellHover(event:wxEvent)
	End Function
	
	Function OnHtmlCellClicked(event:wxEvent)
	End Function


End Type
