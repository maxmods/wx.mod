SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxHtmlHelpController


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
 		frame = New MyFrame.Create(,,"HelpDemo wxWidgets App", 50, 50, 450, 340)

		provider.SetHelpController(frame.GetMSHtmlHelpController())

		frame.show()
    		SetTopWindow(frame)

		Return True
	
	End Method

End Type


Type MyFrame Extends wxFrame

	Method OnInit()
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

