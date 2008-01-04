'
' Demonstrates internationalisation (i18n) support
'
' From the C++ sample by Vadim Zeitlin/Julian Smart
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxLocale
Import wx.wxFrame
Import wx.wxChoiceDialog
Import wx.wxTextEntryDialog
Import wx.wxLog
Import wx.wxStaticText
Import wx.wxMessageDialog

' language data
Global langIds:Int[] = [ ..
    wxLANGUAGE_DEFAULT, ..
    wxLANGUAGE_FRENCH, ..
    wxLANGUAGE_GERMAN, ..
    wxLANGUAGE_RUSSIAN, ..
    wxLANGUAGE_BULGARIAN, ..
    wxLANGUAGE_CZECH, ..
    wxLANGUAGE_POLISH, ..
    wxLANGUAGE_SWEDISH, ..
    wxLANGUAGE_JAPANESE, ..
    wxLANGUAGE_GEORGIAN, ..
    wxLANGUAGE_ENGLISH, ..
    wxLANGUAGE_ENGLISH_US, ..
    wxLANGUAGE_ARABIC, ..
    wxLANGUAGE_ARABIC_EGYPT ]

' note that it makes no sense To translate these strings, they are
' shown before we set the locale anyhow
Global langNames:String[] = [ ..
    "System default", ..
    "French", ..
    "German", ..
    "Russian", ..
    "Bulgarian", ..
    "Czech", ..
    "Polish", ..
    "Swedish", ..
    "Japanese", ..
    "Georgian", ..
    "English", ..
    "English (U.S.)", ..
    "Arabic", ..
    "Arabic (Egypt)" ]

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame
	
	Field locale:wxLocale = New wxLocale.Create()

	Method OnInit:Int()
	
		Local lng:Int = wxGetSingleChoiceIndex("Please choose language:", "Language", langNames)

	    If lng <> -1 Then
	        ' don't use wxLOCALE_LOAD_DEFAULT flag so that Init() doesn't return
	        ' false just because it failed to load wxstd catalog
	        If Not locale.Init(langIds[lng], wxLOCALE_CONV_ENCODING) Then
	            wxLogError("This language is not supported by the system.")
	            Return False
	        End If
	    End If

	    ' normally this wouldn't be necessary as the catalog files would be found
	    ' in the default locations, but when the program is not installed the
	    ' catalogs are in the build directory where we wouldn't find them by
	    ' default
	    wxLocale.AddCatalogLookupPathPrefix(".")
	
	    ' Initialize the catalogs we'll be using
	    locale.AddCatalog("internat")
	
		frame = New MyFrame.CreateMyFrame(locale)

		'frame = MyFrame(New MyFrame.Create(,,"Minimal wxWidgets App", 100, 100))

		SetTopWindow(frame)
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

    Const INTERNAT_TEST:Int = wxID_HIGHEST + 1
    Const INTERNAT_PLAY:Int = wxID_HIGHEST + 2
    Const INTERNAT_TEST_1:Int = wxID_HIGHEST + 3
    Const INTERNAT_TEST_2:Int = wxID_HIGHEST + 4
    Const INTERNAT_TEST_3:Int = wxID_HIGHEST + 5

	Field locale:wxLocale

	Method CreateMyFrame:MyFrame(_locale:wxLocale)
		Create(Null, wxID_ANY, _("International wxWidgets App"))
		locale = _locale
		Return Self
	End Method

	Method OnInit()

		' Make a menubar
		Local file_menu:wxMenu = New wxMenu.Create()
		file_menu.Append(INTERNAT_TEST, _("&Test locale availability...~tCtrl-T"))
		file_menu.AppendSeparator()
		file_menu.Append(wxID_ABOUT, _("&About..."))
		file_menu.AppendSeparator()
		file_menu.Append(wxID_EXIT, _("E&xit"))
		
		Local test_menu:wxMenu = New wxMenu.Create()
		test_menu.Append(wxID_OPEN, _("&Open bogus file"))
		test_menu.Append(INTERNAT_PLAY, _("&Play a game"))
		test_menu.AppendSeparator()
		test_menu.Append(INTERNAT_TEST_1, _("&1 _() (gettext)"))
		test_menu.Append(INTERNAT_TEST_2, _("&2 _N() (ngettext)"))
		test_menu.Append(INTERNAT_TEST_3, _("&3 wxTRANSLATE() (gettext_noop)"))
		
		Local menu_bar:wxMenuBar = New wxMenuBar.Create()
		menu_bar.Append(file_menu, _("&File"))
		menu_bar.Append(test_menu, _("&Test"))
		SetMenuBar(menu_bar)

		' this demonstrates RTL layout mirroring For Arabic locales
		Local sizer:wxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		sizer.Add(New wxStaticText.Create(Self, wxID_ANY, _("First")), wxEXPAND | wxBORDER, wxALL)
		sizer.Add(New wxStaticText.Create(Self, wxID_ANY, _("Second")), wxEXPAND | wxBORDER, wxALL)
		SetSizer(sizer)

	    Connect(INTERNAT_TEST, wxEVT_COMMAND_MENU_SELECTED, OnTestLocaleAvail)
	    Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
	    Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
	
	    Connect(INTERNAT_PLAY, wxEVT_COMMAND_MENU_SELECTED, OnPlay)
	    Connect(wxID_OPEN, wxEVT_COMMAND_MENU_SELECTED, OnOpen)
	    Connect(INTERNAT_TEST_1, wxEVT_COMMAND_MENU_SELECTED, OnTest1)
	    Connect(INTERNAT_TEST_2, wxEVT_COMMAND_MENU_SELECTED, OnTest2)
	    Connect(INTERNAT_TEST_3, wxEVT_COMMAND_MENU_SELECTED, OnTest3)

	End Method
	
	Function OnTestLocaleAvail(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)

	    Global s_locale:String
	    Local locale:String = wxGetTextFromUser(_("Enter the locale to test"), wxGetTextFromUserPromptStr, ..
	        s_locale, frame )
	    If Not locale Then
	        Return
	    End If
	
	    s_locale = locale
	    Local info:wxLanguageInfo = wxLocale.FindLanguageInfo(s_locale)
	    If Not info Then
	        Local str:String = _("Locale ~q%s~q is unknown.")
	        wxLogError(str.Replace("%s", s_locale))
	        Return
	    End If
	
	    If wxLocale.IsAvailable(info.GetLanguage() ) Then
	        Local str:String = _("Locale ~q%s~q is available.")
	        wxLogMessage(str.Replace("%s", s_locale))
	    Else
	        Local str:String = _("Locale ~q%s~q is not available.")
	        wxLogWarning(str.Replace("%s", s_locale))
	    End If
	End Function
	
	Function OnAbout(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)

	    Local localeInfo:String
	    Local locale:String = frame.locale.GetLocale()
	    Local sysname:String = frame.locale.GetSysName()
	    Local canname:String = frame.locale.GetCanonicalName()
	
	    localeInfo = _("Language: %s~nSystem locale name:~n%s~nCanonical locale name: %s~n")
		localeInfo = localeInfo.Replace("%s", locale)
		localeInfo = localeInfo.Replace("%s", sysname)
		localeInfo = localeInfo.Replace("%s", canname)
		
	   Local dlg:wxMessageDialog = New wxMessageDialog.Create( ..
			frame, _("I18n sample~n(c) 1998, 1999 Vadim Zeitlin and Julian Smart") + ..
			_("~nBlitzMax Port 2007 Bruce A Henderson") + "~n~n" + localeInfo, ..
			_("About Internat"), wxOK | wxICON_INFORMATION )
			
	    dlg.ShowModal()
		dlg.Free()
	End Function

	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function

	Function OnPlay(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)

		Local str:String = wxGetTextFromUser(_("Enter your number:"), _("Try to guess my number!"), "", frame)

		If Not str Then
			Return
		End If
		
	    Local num:Int = str.ToInt()
	    If num < 0 Then
	        str = _("You've probably entered an invalid number.")
	    Else If num = 9 Then
	        ' this message is not translated (not in catalog) because we used _T()
	        ' and not _() around it
	        str = "You've found a bug in this program!"
	    Else If num = 17 Then
	        ' string must be split in two -- otherwise the translation would't be
	        ' found
	        str = _("Congratulations! you've won. Here is the magic phrase:") + _("cannot create fifo `%s'")
	    Else
	        ' this is a more implicit way to write _() but note that if you use it
	        ' you must ensure that the strings get extracted in the message
	        ' catalog as by default xgettext won't do it (it only knows of _(),
	        ' not wxGetTranslation())
	        str = wxGetTranslation("Bad luck! try again...")
	    End If
	
	    wxMessageBox(str, _("Result"), wxOK | wxICON_INFORMATION)

	End Function

	Function OnOpen(event:wxEvent)
	End Function

	Function OnTest1(event:wxEvent)
	End Function
	
	Function OnTest2(event:wxEvent)
	End Function
	
	Function OnTest3(event:wxEvent)
	End Function
	
End Type
