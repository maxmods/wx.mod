SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHtmlWindow
Import wx.wxTextCtrl
Import wx.wxLog
Import wx.wxFileDialog
Import wx.wxFileSystem
Import wx.wxInternetFSHandler

Import BRL.FileSystem

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		wxInitAllImageHandlers()
		wxFileSystem.AddHandler(New wxInternetFSHandler)

		SetAppName("wxHtmlTest")
		
		frame = MyFrame(New MyFrame.Create(,,"wxHtmlWindow testing application", ,, 640, 480))

		frame.show()
		
		Return True
	
	End Method

End Type

Type MyHtmlWindow Extends wxHtmlWindow
	
	Method OnOpeningURL:String(urlType:Int, url:String, returnStatus:Int Var)
		GetRelatedFrame().SetStatusText(url + " lately opened",1)
		returnStatus = wxHTML_OPEN
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

	Field Html:MyHtmlWindow
	Field processor:wxHtmlProcessor

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

		CreateStatusBar(2)

		processor = New BoldProcessor.Create()
		processor.Enable(False)
		html = MyHtmlWindow(New MyHtmlWindow.Create(Self, -1))
		html.SetRelatedFrame(Self, "HTML : %s")
		
		html.SetRelatedStatusBar(0)
		
		'    html.ReadCustomization(wxConfig::Get());
		html.LoadPage(RealPath("test.htm"))
		html.AddProcessor(processor)

		Local text:wxTextCtrl = New wxTextCtrl.Create(Self, wxID_ANY, "", ,, ,, wxTE_MULTILINE)

		wxLog.SetActiveTarget(New wxLogTextCtrl.Create(text))

		Local sz:wxSizer = New wxBoxSizer.Create(wxVERTICAL)
		sz.Add(html, 3, wxGROW)
		sz.Add(text, 1, wxGROW)
		SetSizer(sz)

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
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnPageOpen(event:wxEvent)
		Local p:String = wxFileSelector("Open HTML document", "", "", "", "HTML files|*.htm;*.html")
		
		If p Then
			MyFrame(event.parent).html.LoadPage(p)
		End If
	End Function
	
	Function OnDefaultLocalBrowser(event:wxEvent)
		Local page:String = MyFrame(event.parent).html.GetOpenedPage()
		If page Then
			wxLaunchDefaultBrowser(page)
		End If
	End Function
	
	Function OnDefaultWebBrowser(event:wxEvent)
		Local page:String = MyFrame(event.parent).html.GetOpenedPage()
		If page Then
			wxLaunchDefaultBrowser("http://www.google.com")
		End If
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
	
	Function OnProcessor(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		
		frame.processor.Enable(Not frame.processor.IsEnabled())
		frame.html.LoadPage(frame.html.GetOpenedPage())
	End Function
	
	Function OnHtmlLinkClicked(event:wxEvent)
		wxLogMessage("The url '" + wxHtmlLinkEvent(event).GetLinkInfo().GetHref() + "' has been clicked!")
		
		' skipping this event the Default behaviour (load the clicked URL) will happen...
		event.Skip()
	End Function
	
	Function OnHtmlCellHover(event:wxEvent)
		Local evt:wxHtmlCellEvent = wxHtmlCellEvent(event)
		Local x:Int, y:Int
		evt.GetPoint(x, y)
		
		wxLogMessage("Mouse moved over cell " + evt.GetCell().ToString() + " at " + x + ";" + y)
	End Function
	
	Function OnHtmlCellClicked(event:wxEvent)
		Local evt:wxHtmlCellEvent = wxHtmlCellEvent(event)
		Local x:Int, y:Int
		evt.GetPoint(x, y)
		
		wxLogMessage("Click over cell " + evt.GetCell().ToString() + " at " + x + ";" + y)
		
		' If we don't skip the event, OnHtmlLinkClicked won't be called!
		event.Skip()
	End Function


End Type

Type BoldProcessor Extends wxHtmlProcessor
	
	Method Process:String(s:String)
		Local r:String = s.Replace("<b>", "")
		r = r.Replace("</b>", "")
		
		Return r
	End Method
End Type

