SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxWebView
Import wx.wxTextCtrl
'Import wx.wxInfoBar
Import wx.wxStaticText
Import wx.wxPanel
Import wx.wxLocale
Import wx.wxLogWindow
Import wx.wxArtProvider
Import BRL.RamStream

?Not linux
Incbin "media/webview/refresh.png"
Incbin "media/webview/stop.png"
?
Incbin "media/webview/wxlogo.png"


New MyApp.run()

Type MyApp Extends wxApp

	Field frame:wxFrame

	Method OnInit:Int()
		wxImage.AddHandler(New wxPNGHandler)

		frame = WebFrame(New WebFrame.CreateWithURL("http://wxwidgets.org"))
		frame.show()
	
		Return True
	
	End Method

End Type

Type WebFrame Extends wxFrame

	Field url:String

	Field m_url:wxTextCtrl
	Field m_browser:wxWebView

	Field m_toolbar:wxToolBar
	Field m_toolbar_back:wxToolBarToolBase
	Field m_toolbar_forward:wxToolBarToolBase
	Field m_toolbar_stop:wxToolBarToolBase
	Field m_toolbar_reload:wxToolBarToolBase
	Field m_toolbar_tools:wxToolBarToolBase

	Field m_find_toolbar_done:wxToolBarToolBase
	Field m_find_toolbar_next:wxToolBarToolBase
	Field m_find_toolbar_previous:wxToolBarToolBase
	Field m_find_toolbar_options:wxToolBarToolBase
	Field m_find_toolbar_wrap:wxMenuItem
	Field m_find_toolbar_highlight:wxMenuItem
	Field m_find_toolbar_matchcase:wxMenuItem
	Field m_find_toolbar_wholeword:wxMenuItem

	Field m_tools_menu:wxMenu
	Field m_tools_history_menu:wxMenu
	Field m_tools_layout:wxMenuItem
	Field m_tools_tiny:wxMenuItem
	Field m_tools_small:wxMenuItem
	Field m_tools_medium:wxMenuItem
	Field m_tools_large:wxMenuItem
	Field m_tools_largest:wxMenuItem
	Field m_tools_handle_navigation:wxMenuItem
	Field m_tools_handle_new_window:wxMenuItem
	Field m_tools_enable_history:wxMenuItem
	Field m_edit_cut:wxMenuItem
	Field m_edit_copy:wxMenuItem
	Field m_edit_paste:wxMenuItem
	Field m_edit_undo:wxMenuItem
	Field m_edit_redo:wxMenuItem
	Field m_edit_mode:wxMenuItem
	Field m_scroll_line_up:wxMenuItem
	Field m_scroll_line_down:wxMenuItem
	Field m_scroll_page_up:wxMenuItem
	Field m_scroll_page_down:wxMenuItem
	Field m_selection_clear:wxMenuItem
	Field m_selection_delete:wxMenuItem
	Field m_find:wxMenuItem
	Field m_context_menu:wxMenuItem

	'Field m_info:wxInfoBar
	Field m_info_text:wxStaticText
	Field m_find_ctrl:wxTextCtrl
	Field m_find_toolbar:wxToolBar

	'wxMenuHistoryMap m_histMenuItems;
	Field m_findText:String
	Field m_findFlags:Int
	Field m_findCount:Int
	
	Field m_histMenuItems:TMap = New TMap
 
	Method CreateWithURL:WebFrame(url:String)
		Self.url = url
		Super.Create(Null, -1, "wxWebView Sample")
		Return Self
	End Method

	Method OnInit()

		' set the frame icon
		'SetIcon(wxIcon(sample));
		SetTitle("wxWebView Sample")
		
		Local topsizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		' Create the toolbar
		m_toolbar = CreateToolBar(wxTB_TEXT)
		m_toolbar.SetToolBitmapSize(32, 32)

		Local back:wxBitmap = wxArtProvider.GetBitmap(wxART_GO_BACK , wxART_TOOLBAR)
 		Local forward:wxBitmap = wxArtProvider.GetBitmap(wxART_GO_FORWARD , wxART_TOOLBAR)
?linux
		Local stop:wxBitmap = wxArtProvider.GetBitmap("gtk-stop", wxART_TOOLBAR)
		Local refresh:wxBitmap = wxArtProvider.GetBitmap("gtk-refresh", wxART_TOOLBAR)
?Not linux
		Local stop:wxBitmap = wxBitmap.CreateFromFile("incbin::media/webview/stop.png", wxBITMAP_TYPE_PNG)
		Local refresh:wxBitmap = wxBitmap.CreateFromFile("incbin::media/webview/refresh.png", wxBITMAP_TYPE_PNG)
?

		m_toolbar_back = m_toolbar.AddTool(wxID_ANY, _("Back"), back)
		m_toolbar_forward = m_toolbar.AddTool(wxID_ANY, _("Forward"), forward)
		m_toolbar_stop = m_toolbar.AddTool(wxID_ANY, _("Stop"), stop)
		m_toolbar_reload = m_toolbar.AddTool(wxID_ANY, _("Reload"),  refresh)
		m_url = New wxTextCtrl.Create(m_toolbar, wxID_ANY, "",  -1, -1, 400, -1, wxTE_PROCESS_ENTER)
		m_toolbar.AddControl(m_url, _("URL"))
		m_toolbar_tools = m_toolbar.AddTool(wxID_ANY, _("Menu"), wxBitmap.CreateFromFile("incbin::media/webview/wxlogo.png", wxBITMAP_TYPE_PNG))
		
		m_toolbar.Realize()


		' Set find values.
		m_findFlags = wxWEB_VIEW_FIND_DEFAULT
		m_findText = ""
		m_findCount = 0

		' Create panel for find toolbar.
		Local panel: wxPanel = New wxPanel.Create(Self)
		topsizer.Add(panel, 0, wxEXPAND)

		' Create sizer for panel.
		Local panel_sizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(panel_sizer)

		' Create the find toolbar.
		m_find_toolbar = New wxToolBar.Create(panel, wxID_ANY, -1, -1, -1, -1, wxTB_HORIZONTAL | wxTB_TEXT | wxTB_HORZ_LAYOUT)
		m_find_toolbar.Hide()
		panel_sizer.Add(m_find_toolbar, 0, wxEXPAND)

		' Create find control.
		m_find_ctrl = New wxTextCtrl.Create(m_find_toolbar, wxID_ANY, "", -1, -1, 140, -1, wxTE_PROCESS_ENTER)


		' Find options menu
		Local findmenu:wxMenu = New wxMenu.Create()
		m_find_toolbar_wrap = findmenu.AppendCheckItem(wxID_ANY,"Wrap")
		m_find_toolbar_matchcase = findmenu.AppendCheckItem(wxID_ANY,"Match Case")
		m_find_toolbar_wholeword = findmenu.AppendCheckItem(wxID_ANY,"Entire Word")
		m_find_toolbar_highlight = findmenu.AppendCheckItem(wxID_ANY,"Highlight")
		' Add find toolbar tools.
		m_find_toolbar.SetToolSeparation(7)
		m_find_toolbar_done = m_find_toolbar.AddTool(wxID_ANY, "Close", wxArtProvider.GetBitmap(wxART_CROSS_MARK))
		m_find_toolbar.AddSeparator()
		m_find_toolbar.AddControl(m_find_ctrl, "Find")
		m_find_toolbar.AddSeparator()
		m_find_toolbar_next = m_find_toolbar.AddTool(wxID_ANY, "Next", wxArtProvider.GetBitmap(wxART_GO_DOWN, wxART_TOOLBAR, 16, 16))
		m_find_toolbar_previous = m_find_toolbar.AddTool(wxID_ANY, "Previous", wxArtProvider.GetBitmap(wxART_GO_UP, wxART_TOOLBAR, 16, 16))
		m_find_toolbar.AddSeparator()
		m_find_toolbar_options = m_find_toolbar.AddTool(wxID_ANY, "Options", wxArtProvider.GetBitmap(wxART_PLUS, wxART_TOOLBAR, 16, 16), Null, wxITEM_DROPDOWN)
		m_find_toolbar_options.SetDropdownMenu(findmenu)
		m_find_toolbar.Realize()


		' Create the info panel
		'm_info = New wxInfoBar(this)
		'topsizer.Add(m_info, wxSizerFlags().Expand())
		
		' Create the webview
		m_browser = New wxWebView.Create(Self, wxID_ANY, url)
		topsizer.Add(m_browser, 1, wxEXPAND, wxAll)
		
		'We register the wxfs:' protocol for testing purposes
		'm_browser.RegisterHandler(wxSharedPtr<wxWebViewHandler>(New wxWebViewArchiveHandler("wxfs")))
		'And the memory: file system
		'm_browser.RegisterHandler(wxSharedPtr<wxWebViewHandler>(New wxWebViewFSHandler("memory")))
		
		SetSizer(topsizer)
		
		'Set a more sensible size for web browsing
		SetSize(800, 600)
'DebugStop
		' Create a log window
		New wxLogWindow.Create(Self, _("Logging"))

		' Create the Tools menu
		m_tools_menu = New wxMenu.Create()
		Local printMenu:wxMenuItem = m_tools_menu.Append(wxID_ANY, _("Print"))
		Local viewSource: wxMenuItem = m_tools_menu.Append(wxID_ANY, _("View Source"))
		m_tools_menu.AppendSeparator()
		m_tools_layout = m_tools_menu.AppendCheckItem(wxID_ANY, _("Use Layout Zoom"))
		m_tools_tiny = m_tools_menu.AppendCheckItem(wxID_ANY, _("Tiny"))
		m_tools_small = m_tools_menu.AppendCheckItem(wxID_ANY, _("Small"))
		m_tools_medium = m_tools_menu.AppendCheckItem(wxID_ANY, _("Medium"))
		m_tools_large = m_tools_menu.AppendCheckItem(wxID_ANY, _("Large"))
		m_tools_largest = m_tools_menu.AppendCheckItem(wxID_ANY, _("Largest"))
		m_tools_menu.AppendSeparator()
		m_tools_handle_navigation = m_tools_menu.AppendCheckItem(wxID_ANY, _("Handle Navigation"))
		m_tools_handle_new_window = m_tools_menu.AppendCheckItem(wxID_ANY, _("Handle New Windows"))
		m_tools_menu.AppendSeparator()

		'Find
		m_find = m_tools_menu.Append(wxID_ANY, _("Find"))
		m_tools_menu.AppendSeparator()

		'History menu
		m_tools_history_menu = New wxMenu.Create()
		Local clearhist:wxMenuItem =  m_tools_history_menu.Append(wxID_ANY, _("Clear History"))
		m_tools_enable_history = m_tools_history_menu.AppendCheckItem(wxID_ANY, _("Enable History"))
		m_tools_history_menu.AppendSeparator()

		m_tools_menu.AppendSubMenu(m_tools_history_menu, "History")

		'Create an editing menu
		Local editmenu:wxMenu = New wxMenu.Create()
		m_edit_cut = editmenu.Append(wxID_ANY, _("Cut"))
		m_edit_copy = editmenu.Append(wxID_ANY, _("Copy"))
		m_edit_paste = editmenu.Append(wxID_ANY, _("Paste"))
		editmenu.AppendSeparator()
		m_edit_undo = editmenu.Append(wxID_ANY, _("Undo"))
		m_edit_redo = editmenu.Append(wxID_ANY, _("Redo"))
		editmenu.AppendSeparator()
		m_edit_mode = editmenu.AppendCheckItem(wxID_ANY, _("Edit Mode"))

		m_tools_menu.AppendSeparator()
		m_tools_menu.AppendSubMenu(editmenu, "Edit")

		Local scroll_menu:wxMenu = New wxMenu.Create()
		m_scroll_line_up = scroll_menu.Append(wxID_ANY, "Line &up")
		m_scroll_line_down = scroll_menu.Append(wxID_ANY, "Line &down")
		m_scroll_page_up = scroll_menu.Append(wxID_ANY, "Page u&p")
		m_scroll_page_down = scroll_menu.Append(wxID_ANY, "Page d&own")
		m_tools_menu.AppendSubMenu(scroll_menu, "Scroll")

		Local script:wxMenuItem =  m_tools_menu.Append(wxID_ANY, _("Run Script"))

		'Selection menu
		Local selection:wxMenu = New wxMenu.Create()
		m_selection_clear = selection.Append(wxID_ANY, _("Clear Selection"))
		m_selection_delete = selection.Append(wxID_ANY, _("Delete Selection"))
		Local selectall:wxMenuItem = selection.Append(wxID_ANY, _("Select All"))

		editmenu.AppendSubMenu(selection, "Selection")

		Local loadscheme:wxMenuItem =  m_tools_menu.Append(wxID_ANY, _("Custom Scheme Example"))
		Local usememoryfs:wxMenuItem =  m_tools_menu.Append(wxID_ANY, _("Memory File System Example"))

		m_context_menu = m_tools_menu.AppendCheckItem(wxID_ANY, _("Enable Context Menu"))

		'By default we want to handle navigation and new windows
		m_tools_handle_navigation.Check()
		m_tools_handle_new_window.Check()
		m_tools_enable_history.Check()
		If Not m_browser.CanSetZoomType(wxWEB_VIEW_ZOOM_TYPE_LAYOUT) Then
			m_tools_layout.Enable(False)
		End If

		' Connect the toolbar events
		Connect(m_toolbar_back.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnBack)
		Connect(m_toolbar_forward.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnForward)
		Connect(m_toolbar_stop.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnStop)
		Connect(m_toolbar_reload.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnReload)
		Connect(m_toolbar_tools.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnToolsClicked)

	
		
		' Connect the webview events
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_NAVIGATING, _OnNavigationRequest)
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_NAVIGATED, _OnNavigationComplete)
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_LOADED, _OnDocumentLoaded)
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_ERROR, _OnError)
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_NEWWINDOW, _OnNewWindow)
		Connect(m_browser.GetId(), wxEVT_COMMAND_WEB_VIEW_TITLE_CHANGED, _OnTitleChanged)


	End Method

	Function _OnBack(evt:wxEvent)
		WebFrame(evt.parent).OnBack(wxCommandEvent(evt))
	End Function

	Function _OnForward(evt:wxEvent)
		WebFrame(evt.parent).OnForward(wxCommandEvent(evt))
	End Function

	Function _OnStop(evt:wxEvent)
		WebFrame(evt.parent).OnStop(wxCommandEvent(evt))
	End Function

	Function _OnReload(evt:wxEvent)
		WebFrame(evt.parent).OnReload(wxCommandEvent(evt))
	End Function

	Function _OnToolsClicked(evt:wxEvent)
		WebFrame(evt.parent).OnToolsClicked(wxCommandEvent(evt))
	End Function

	Function _OnHistory(evt:wxEvent)
		WebFrame(evt.parent).OnHistory(wxCommandEvent(evt))
	End Function

	Function _OnNavigationRequest(evt:wxEvent)
		WebFrame(evt.parent).OnNavigationRequest(wxWebViewEvent(evt))
	End Function

	Function _OnNavigationComplete(evt:wxEvent)
		WebFrame(evt.parent).OnNavigationComplete(wxWebViewEvent(evt))
	End Function

	Function _OnDocumentLoaded(evt:wxEvent)
		WebFrame(evt.parent).OnDocumentLoaded(wxWebViewEvent(evt))
	End Function

	Function _OnError(evt:wxEvent)
		WebFrame(evt.parent).OnError(wxWebViewEvent(evt))
	End Function

	Function _OnNewWindow(evt:wxEvent)
		WebFrame(evt.parent).OnNewWindow(wxWebViewEvent(evt))
	End Function

	Function _OnTitleChanged(evt:wxEvent)
		WebFrame(evt.parent).OnTitleChanged(wxWebViewEvent(evt))
	End Function
	
	Method UpdateState()
		m_toolbar.EnableTool(m_toolbar_back.GetId(), m_browser.CanGoBack())
		m_toolbar.EnableTool(m_toolbar_forward.GetId(), m_browser.CanGoForward())
		
		If m_browser.IsBusy() Then
			m_toolbar.EnableTool(m_toolbar_stop.GetId(), True)
		Else
			m_toolbar.EnableTool(m_toolbar_stop.GetId(), False)
		End If
		
		SetTitle(m_browser.GetCurrentTitle())
		m_url.SetValue(m_browser.GetCurrentURL())
	End Method
	
	Method OnIdle(evt:wxIdleEvent)
		If m_browser.IsBusy() Then
			wxSetCursorId(wxCURSOR_ARROWWAIT)
			m_toolbar.EnableTool(m_toolbar_stop.GetId(), True)
		Else
			wxSetCursor(Null)
			m_toolbar.EnableTool(m_toolbar_stop.GetId(), False)
		End If
	End Method
	
	Method OnURL(evt:wxCommandEvent)
	End Method
	
	Method OnBack(evt:wxCommandEvent)
	End Method
	
	Method OnForward(evt:wxCommandEvent)
	End Method
	
	Method OnStop(evt:wxCommandEvent)
	End Method
	
	Method OnReload(evt:wxCommandEvent)
	End Method
	
	Method OnClearHistory(evt:wxCommandEvent)
	End Method
	
	Method OnEnableHistory(evt:wxCommandEvent)
	End Method
	
	Method OnCut(evt:wxCommandEvent)
	End Method
	
	Method OnCopy(evt:wxCommandEvent)
	End Method
	
	Method OnPaste(evt:wxCommandEvent)
	End Method
	
	Method OnUndo(evt:wxCommandEvent)
	End Method
	
	Method OnRedo(evt:wxCommandEvent)
	End Method
	
	Method OnMode(evt:wxCommandEvent)
	End Method
	
	Method OnHistory(evt:wxCommandEvent)
		m_browser.LoadHistoryItem(wxWebViewHistoryItem(m_histMenuItems.ValueForKey(String(evt.GetId()))))
	End Method
	

	' Callback invoked when there is a request to load a new page (for instance when the user clicks a link)
	Method OnNavigationRequest(evt:wxWebViewEvent)
		'If m_info.IsShown() Then
		'	m_info.Dismiss()
		'End If

		wxLogMessage("Navigation request to '" + evt.GetURL() + "' (target='" + evt.GetTarget() + "')")

		'If we don't want to handle navigation then veto the event and navigation
		'will not take place, we also need to stop the loading animation
		If Not m_tools_handle_navigation.IsChecked() Then
			evt.Veto()
			m_toolbar.EnableTool(m_toolbar_stop.GetId(), False)
		Else
			UpdateState()
		End If
	End Method

	' Callback invoked when a navigation request was accepted
	Method OnNavigationComplete(evt:wxWebViewEvent)
		wxLogMessage("Navigation complete; url='" + evt.GetURL() + "'")
		UpdateState()
	End Method
	
	' Callback invoked when a page is finished loading
	Method OnDocumentLoaded(evt:wxWebViewEvent)
		' Only notify if the document is the main frame, not a subframe
		If evt.GetURL() = m_browser.GetCurrentURL() Then
			wxLogMessage("Document loaded; url='" + evt.GetURL() + "'")
		End If
		UpdateState()
	End Method
	
	Method OnError(evt:wxWebViewEvent)
	End Method
	
	' On new window, we veto to stop extra windows appearing
	Method OnNewWindow(evt:wxWebViewEvent)
	End Method
	
	Method OnTitleChanged(evt:wxWebViewEvent)
		SetTitle(evt.GetString())
		wxLogMessage("Title changed; title='" + evt.GetString() + "'")
	End Method
	
	' Invoked when user selects the "Menu" item
	Method OnToolsClicked(evt:wxCommandEvent)
DebugStop
		If m_browser.GetCurrentURL() = "" Then
			Return
		End If

		m_tools_tiny.Check(False)
		m_tools_small.Check(False)
		m_tools_medium.Check(False)
		m_tools_large.Check(False)
		m_tools_largest.Check(False)

		Local zoom:Int = m_browser.GetZoom()
		Select zoom
			Case wxWEB_VIEW_ZOOM_TINY
				m_tools_tiny.Check()
			Case wxWEB_VIEW_ZOOM_SMALL
				m_tools_small.Check()
			Case wxWEB_VIEW_ZOOM_MEDIUM
				m_tools_medium.Check()
			Case wxWEB_VIEW_ZOOM_LARGE
				m_tools_large.Check()
			Case wxWEB_VIEW_ZOOM_LARGEST
				m_tools_largest.Check()
		End Select

		m_edit_cut.Enable(m_browser.CanCut())
		m_edit_copy.Enable(m_browser.CanCopy())
		m_edit_paste.Enable(m_browser.CanPaste())

		m_edit_undo.Enable(m_browser.CanUndo())
		m_edit_redo.Enable(m_browser.CanRedo())

		m_selection_clear.Enable(m_browser.HasSelection())
		m_selection_delete.Enable(m_browser.HasSelection())

		m_context_menu.Check(m_browser.IsContextMenuEnabled())

		'Firstly we clear the existing menu items, then we add the current ones
		For Local id:String = EachIn m_histMenuItems.Keys()
			m_tools_history_menu.Destroy(id.ToInt())
		Next
		m_histMenuItems.clear()

		Local back:wxWebViewHistoryItem[] = m_browser.GetBackwardHistory()
		Local forward:wxWebViewHistoryItem[] = m_browser.GetForwardHistory()

		Local item:wxMenuItem

		For Local i:Int = 0 Until back.length
			item = m_tools_history_menu.AppendRadioItem(wxID_ANY, back[i].GetTitle())
			m_histMenuItems.Insert(String(item.GetId()), back[i])
			Connect(item.GetId(), wxEVT_COMMAND_MENU_SELECTED, _OnHistory)
		Next

		Local title:String = m_browser.GetCurrentTitle()
		If Not title Then
			title = "(untitled)"
		End If
		item = m_tools_history_menu.AppendRadioItem(wxID_ANY, title)
		item.Check()

		'No need to connect the current item
		m_histMenuItems.Insert(String(item.GetId()), New wxWebViewHistoryItem.Create(m_browser.GetCurrentURL(), m_browser.GetCurrentTitle()))

		For Local i:Int = 0 Until forward.length
			item = m_tools_history_menu.AppendRadioItem(wxID_ANY, forward[i].GetTitle())
			m_histMenuItems.Insert(String(item.GetId()), forward[i])
			Connect(item.GetId(), wxEVT_COMMAND_TOOL_CLICKED, _OnHistory)
		Next

		'wxPoint position = ScreenToClient( wxGetMousePosition() )
		Local x:Int, y:Int
		wxGetMousePosition(x, y)
		ScreenToClient(x, y)
		PopupMenu(m_tools_menu, x, y)

	End Method
	
End Type


