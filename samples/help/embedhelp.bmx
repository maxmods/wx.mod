'
' embedded help sample
'
' by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHtmlHelpController
Import wx.wxFileSystem
Import wx.wxZipFSHandler

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame 

	Method OnInit:Int()
	
		wxInitAllImageHandlers()

		' Required For HTML help (.zip/.hfb)
		wxFileSystem.AddHandler(New wxZipFSHandler)

		' Create the main application window
 		frame = MyFrame(New MyFrame.Create(,,"Embedded Help wxWidgets App",,, 550, 440))

		frame.Center()
		frame.show()
    		SetTopWindow(frame)

		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field m_help:wxHtmlHelpController = New wxHtmlHelpController.Create()
	Field m_helpWindow:wxHtmlHelpWindow

	Method OnInit()
	
		m_help = New wxHtmlHelpController.Create(wxHF_EMBEDDED | wxHF_DEFAULT_STYLE)
	
		
		' create a status bar just for fun (by default with 1 pane only)
		CreateStatusBar()
		SetStatusText("Welcome to wxWidgets!")
		
		Local w:Int, h:Int
		GetClientSize(w, h)
		
		' Create embedded HTML Help window
		m_helpWindow = New wxHtmlHelpWindow.Create(Self, wxID_ANY,,, w, h, wxTAB_TRAVERSAL | wxNO_BORDER, wxHF_DEFAULT_STYLE)
		
		' m_help.UseConfig(config, rootPath) ' Can set your own config object here
		m_help.SetHelpWindow(m_helpWindow)
		
		m_help.AddBook("doc.zip", False)
		
		' go to a page
		m_help.Display("Introduction")

	End Method

End Type

