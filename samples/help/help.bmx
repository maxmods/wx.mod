'
' wxHelpController demo
' by Karsten Ballueder
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHelpController
Import wx.wxHtmlHelpController
Import wx.wxHelpControllerHelpProvider
Import wx.wxFileSystem
Import wx.wxZipFSHandler
Import wx.wxLog
Import wx.wxTextEntryDialog
?win32
Import wx.wxBestHelpController
?

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame 

	Method OnInit:Int()
	
	DebugLog wxGetUserName()

		Local provider:wxHelpControllerHelpProvider = New wxHelpControllerHelpProvider.Create()

		wxHelpProvider.Set(provider)

		' Required For images in the online documentation
		wxImage.AddHandler(New wxGIFHandler)

		' Required For advanced HTML help
 
		wxFileSystem.AddHandler(New wxZipFSHandler)

		' Create the main application window
 		frame = MyFrame(New MyFrame.Create(,,"HelpDemo wxWidgets App", 50, 50, 450, 340))

?win32
		provider.SetHelpController(frame.GetMSHtmlHelpController())
?Not Win32
		provider.SetHelpController(frame.GetHelpController())
?

		frame.show()
    		SetTopWindow(frame)

		' initialise the help system: this means that we'll use doc.hlp file under
		' Windows and that the HTML docs are in the subdirectory doc for platforms
		' using HTML help
		If Not frame.GetHelpController().Initialize("doc") Then
			wxLogError("Cannot initialize the help system, aborting.")
		
			Return False
		End If
		
?win32
		If Not frame.GetMSHtmlHelpController().Initialize("doc")
			wxLogError("Cannot initialize the MS HTML Help system.")
		End If
		
		' you need to call Initialize in order to use wxBestHelpController
		If Not frame.GetBestHelpController().Initialize("doc")
			wxLogError("Cannot initialize the best help system, aborting.")
		End If
?
		
		
		' initialise the advanced HTML help system: this means that the HTML docs are in .htb
		' (zipped) form
		If Not frame.GetAdvancedHtmlHelpController().Initialize("doc")
			wxLogError("Cannot initialize the advanced HTML help system, aborting.")
		
			Return False
		End If


		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

	Field m_help:wxHelpController = wxHelpController(New wxHelpController.Create())
	
	Field m_advancedHtmlHelp:wxHtmlHelpController = New wxHtmlHelpController.Create()
	Field m_embeddedHtmlHelp:wxHtmlHelpController = New wxHtmlHelpController.Create()
	Field m_embeddedHelpWindow:wxHtmlHelpWindow


?win32
	Field m_msHtmlHelp:wxCHMHelpController = New wxCHMHelpController.Create()
	Field m_bestHelp:wxBestHelpController = New wxBestHelpController.Create()
?


	Method OnInit()
	
		m_embeddedHtmlHelp = New wxHtmlHelpController.Create(wxHF_EMBEDDED|wxHF_DEFAULT_STYLE)
	
		' set the frame icon
		'SetIcon(wxICON(mondrian))
		
		' create a menu bar
		Local menuFile:wxMenu = New wxMenu.Create()
		
		menuFile.Append(HelpDemo_Help_Index, "&Help Index...")
		menuFile.Append(HelpDemo_Help_Classes, "&Help on Classes...")
		menuFile.Append(HelpDemo_Help_Functions, "&Help on Functions...")
		menuFile.Append(HelpDemo_Help_ContextHelp, "&Context Help...")
		menuFile.Append(HelpDemo_Help_DialogContextHelp, "&Dialog Context Help...~tCtrl-H")
		menuFile.Append(HelpDemo_Help_Help, "&About Help Demo...")
		menuFile.Append(HelpDemo_Help_Search, "&Search help...")
		
		menuFile.AppendSeparator()
		menuFile.Append(HelpDemo_Advanced_Html_Help_Index, "Advanced HTML &Help Index...")
		menuFile.Append(HelpDemo_Advanced_Html_Help_Classes, "Advanced HTML &Help on Classes...")
		menuFile.Append(HelpDemo_Advanced_Html_Help_Functions, "Advanced HTML &Help on Functions...")
		menuFile.Append(HelpDemo_Advanced_Html_Help_Help, "Advanced HTML &About Help Demo...")
		menuFile.Append(HelpDemo_Advanced_Html_Help_Search, "Advanced HTML &Search help...")
		menuFile.Append(HelpDemo_Advanced_Html_Help_Modal, "Advanced HTML Help &Modal Dialog...")
		
		
?win32
		menuFile.AppendSeparator()
		menuFile.Append(HelpDemo_MS_Html_Help_Index, "MS HTML &Help Index...")
		menuFile.Append(HelpDemo_MS_Html_Help_Classes, "MS HTML &Help on Classes...")
		menuFile.Append(HelpDemo_MS_Html_Help_Functions, "MS HTML &Help on Functions...")
		menuFile.Append(HelpDemo_MS_Html_Help_Help, "MS HTML &About Help Demo...")
		menuFile.Append(HelpDemo_MS_Html_Help_Search, "MS HTML &Search help...")
		
		menuFile.AppendSeparator()
		menuFile.Append(HelpDemo_Best_Help_Index, "Best &Help Index...")
?
	
		menuFile.AppendSeparator()
		menuFile.Append(HelpDemo_Quit, "E&xit")
		
		' now append the freshly created menu to the menu bar...
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, "&File")
		
		' ... and attach this menu bar to the frame
		SetMenuBar(menuBar)
		
		' create a status bar just for fun (by default with 1 pane only)
		CreateStatusBar()
		SetStatusText("Welcome to wxWidgets!")
		
		
		Local w:Int, h:Int
		GetClientSize(w, h)
		' Create embedded HTML Help window
		m_embeddedHelpWindow = New wxHtmlHelpWindow.Create(Self, ..
		wxID_ANY, ,, w, h, wxTAB_TRAVERSAL|wxNO_BORDER, wxHF_DEFAULT_STYLE)
		' m_embeddedHtmlHelp.UseConfig(config, rootPath); ' Can set your own config object here
		m_embeddedHtmlHelp.SetHelpWindow(m_embeddedHelpWindow)
		
		m_embeddedHtmlHelp.AddBook("doc.zip", False)
		m_embeddedHtmlHelp.Display("Introduction")

		Connect(HelpDemo_Quit,  wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(HelpDemo_Help_Index, wxEVT_COMMAND_MENU_SELECTED, OnHelp)
		Connect(HelpDemo_Help_Classes, wxEVT_COMMAND_MENU_SELECTED, OnHelp)
		Connect(HelpDemo_Help_Functions, wxEVT_COMMAND_MENU_SELECTED, OnHelp)
		Connect(HelpDemo_Help_Help, wxEVT_COMMAND_MENU_SELECTED, OnHelp)
		Connect(HelpDemo_Help_Search, wxEVT_COMMAND_MENU_SELECTED, OnHelp)
		Connect(HelpDemo_Help_ContextHelp, wxEVT_COMMAND_MENU_SELECTED, OnShowContextHelp)
		Connect(HelpDemo_Help_DialogContextHelp, wxEVT_COMMAND_MENU_SELECTED, OnShowDialogContextHelp)
		
		Connect(HelpDemo_Advanced_Html_Help_Index, wxEVT_COMMAND_MENU_SELECTED, OnAdvancedHtmlHelp)
		Connect(HelpDemo_Advanced_Html_Help_Classes, wxEVT_COMMAND_MENU_SELECTED, OnAdvancedHtmlHelp)
		Connect(HelpDemo_Advanced_Html_Help_Functions, wxEVT_COMMAND_MENU_SELECTED, OnAdvancedHtmlHelp)
		Connect(HelpDemo_Advanced_Html_Help_Help, wxEVT_COMMAND_MENU_SELECTED, OnAdvancedHtmlHelp)
		Connect(HelpDemo_Advanced_Html_Help_Search, wxEVT_COMMAND_MENU_SELECTED, OnAdvancedHtmlHelp)
		
		Connect(HelpDemo_Advanced_Html_Help_Modal, wxEVT_COMMAND_MENU_SELECTED, OnModalHtmlHelp)


?win32
		Connect(HelpDemo_MS_Html_Help_Index, wxEVT_COMMAND_MENU_SELECTED, OnMSHtmlHelp)
		Connect(HelpDemo_MS_Html_Help_Classes, wxEVT_COMMAND_MENU_SELECTED, OnMSHtmlHelp)
		Connect(HelpDemo_MS_Html_Help_Functions, wxEVT_COMMAND_MENU_SELECTED, OnMSHtmlHelp)
		Connect(HelpDemo_MS_Html_Help_Help, wxEVT_COMMAND_MENU_SELECTED, OnMSHtmlHelp)
		Connect(HelpDemo_MS_Html_Help_Search, wxEVT_COMMAND_MENU_SELECTED, OnMSHtmlHelp)
		
		Connect(HelpDemo_Best_Help_Index, wxEVT_COMMAND_MENU_SELECTED, OnBestHelp)
?
	End Method


	Method GetHelpController:wxHelpControllerBase()
		Return m_help
	End Method
	
	Method GetAdvancedHtmlHelpController:wxHtmlHelpController()
		Return m_advancedHtmlHelp
	End Method
	
?win32
	Method GetMSHtmlHelpController:wxCHMHelpController()
		Return m_msHtmlHelp
	End Method

	Method GetBestHelpController:wxBestHelpController()
		Return m_bestHelp
	End Method
?


    ' event handlers
	Function OnQuit(event:wxEvent)
	End Function

	Function OnHelp(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.ShowHelp(event.GetId(), frame.m_help)
	End Function

	Function OnAdvancedHtmlHelp(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.ShowHelp(event.GetId(), frame.m_advancedHtmlHelp)
	End Function

?win32
	Function OnMSHtmlHelp(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.ShowHelp(event.GetId(), frame.m_msHtmlHelp)
	End Function

	Function OnBestHelp(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.ShowHelp(event.GetId(), frame.m_bestHelp)
	End Function
?


	Function OnModalHtmlHelp(event:wxEvent)
	End Function

	Function OnShowContextHelp(event:wxEvent)
	End Function
	
	Function OnShowDialogContextHelp(event:wxEvent)
	End Function


	Rem
	 Notes: ShowHelp uses section ids for displaying particular topics,
	 but you might want to use a unique keyword to display a topic, instead.
	
	 Section ids are specified as follows for the different formats.
	
	 WinHelp
	
	   The [MAP] section specifies the topic to integer id mapping, e.g.
	
	   [MAP]
	   #define intro       100
	   #define functions   1
	   #define classes     2
	   #define about       3
	
	   The identifier name corresponds to the label used for that topic.
	   You could also put these in a .h file and #include it in both the MAP
	   section and your C++ source.
	
	   Note that Tex2RTF doesn't currently generate the MAP section automatically.
	
	 MS HTML Help
	
	   The [MAP] section specifies the HTML filename root to integer id mapping, e.g.
	
	   [MAP]
	   #define doc1       100
	   #define doc3       1
	   #define doc2       2
	   #define doc4       3
	
	   The identifier name corresponds to the HTML filename used for that topic.
	   You could also put these in a .h file and #include it in both the MAP
	   section and your C++ source.
	
	   Note that Tex2RTF doesn't currently generate the MAP section automatically.
	
	 Simple wxHTML Help and External HTML Help
	
	   A wxhelp.map file is used, for example:
	
	   0 wx.htm             ; wxWidgets: Help index; additional keywords like overview
	   1 wx204.htm          ; wxWidgets Function Reference
	   2 wx34.htm           ; wxWidgets Class Reference
	
	   Note that Tex2RTF doesn't currently generate the MAP section automatically.
	
	 Advanced HTML Help
	
	   An extension to the .hhc file format is used, specifying a new parameter
	   with name="ID":
	
	   <OBJECT type="text/sitemap">
	   <param name="Local" value="doc2.htm#classes">
	   <param name="Name" value="Classes">
	   <param name="ID" value=2>
	   </OBJECT>
	
	   Again, this is not generated automatically by Tex2RTF, though it could
	   be added quite easily.
	
	   Unfortunately adding the ID parameters appears to interfere with MS HTML Help,
	   so you should not try to compile a .chm file from a .hhc file with
	   this extension, or the contents will be messed up.
	end Rem
	Method ShowHelp(commandId:Int, helpController:wxHelpControllerBase)

		Select commandId
			Case HelpDemo_Help_Classes, HelpDemo_Html_Help_Classes, HelpDemo_Advanced_Html_Help_Classes, ..
				HelpDemo_MS_Html_Help_Classes, HelpDemo_Best_Help_Classes
			  helpController.DisplaySection(2)
			  'helpController.DisplaySection("Classes") ' An alternative form for most controllers
			
			Case HelpDemo_Help_Functions, HelpDemo_Html_Help_Functions, ..
				HelpDemo_Advanced_Html_Help_Functions, HelpDemo_MS_Html_Help_Functions
			  helpController.DisplaySection(1)
			  'helpController.DisplaySection("Functions") ' An alternative form for most controllers
			
			Case HelpDemo_Help_Help, HelpDemo_Html_Help_Help, HelpDemo_Advanced_Html_Help_Help, ..
				HelpDemo_MS_Html_Help_Help, HelpDemo_Best_Help_Help
			  helpController.DisplaySection(3)
			  'helpController.DisplaySection("About") ' An alternative form for most controllers
			
			Case HelpDemo_Help_Search, HelpDemo_Html_Help_Search, HelpDemo_Advanced_Html_Help_Search, ..
				HelpDemo_MS_Html_Help_Search, HelpDemo_Best_Help_Search
			
			  Local key:String = wxGetTextFromUser("Search for?", "Search help for keyword", "", Self)
			  
				If key Then
					helpController.KeywordSearch(key)
				End If
			
			Case HelpDemo_Help_Index, HelpDemo_Html_Help_Index, HelpDemo_Advanced_Html_Help_Index, ..
				HelpDemo_MS_Html_Help_Index, HelpDemo_Best_Help_Index
			  helpController.DisplayContents()
		
		End Select
		


	End Method


End Type



' menu items
Const HelpDemo_Quit:Int = 100
Const HelpDemo_Help_Index:Int = 101
Const HelpDemo_Help_Classes:Int = 102
Const HelpDemo_Help_Functions:Int = 103
Const HelpDemo_Help_Help:Int = 104
Const HelpDemo_Help_Search:Int = 105
Const HelpDemo_Help_ContextHelp:Int = 106
Const HelpDemo_Help_DialogContextHelp:Int = 107

Const HelpDemo_Html_Help_Index:Int = 108
Const HelpDemo_Html_Help_Classes:Int = 109
Const HelpDemo_Html_Help_Functions:Int = 110
Const HelpDemo_Html_Help_Help:Int = 111
Const HelpDemo_Html_Help_Search:Int = 112

Const HelpDemo_Advanced_Html_Help_Index:Int = 113
Const HelpDemo_Advanced_Html_Help_Classes:Int = 114
Const HelpDemo_Advanced_Html_Help_Functions:Int = 115
Const HelpDemo_Advanced_Html_Help_Help:Int = 116
Const HelpDemo_Advanced_Html_Help_Search:Int = 117
Const HelpDemo_Advanced_Html_Help_Modal:Int = 118

Const HelpDemo_MS_Html_Help_Index:Int = 119
Const HelpDemo_MS_Html_Help_Classes:Int = 120
Const HelpDemo_MS_Html_Help_Functions:Int = 121
Const HelpDemo_MS_Html_Help_Help:Int = 122
Const HelpDemo_MS_Html_Help_Search:Int = 123

Const HelpDemo_Best_Help_Index:Int = 124
Const HelpDemo_Best_Help_Classes:Int = 125
Const HelpDemo_Best_Help_Functions:Int = 126
Const HelpDemo_Best_Help_Help:Int = 127
Const HelpDemo_Best_Help_Search:Int = 128

Const HelpDemo_Help_KDE:Int = 129
Const HelpDemo_Help_GNOME:Int = 130
Const HelpDemo_Help_Netscape:Int = 131
' controls start here (the numbers are, of course, arbitrary)
Const HelpDemo_Text:Int = 1000

