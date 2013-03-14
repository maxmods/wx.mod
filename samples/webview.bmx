SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxWebView
Import wx.wxTextCtrl
'Import wx.wxInfoBar
Import wx.wxStaticText
Import wx.wxPanel

New MyApp.run()

Type MyApp Extends wxApp

	Field frame:wxFrame

	Method OnInit:Int()

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
		
		' Create a log window
		'New wxLogWindow(this, _("Logging"))

	End Method
	
End Type


