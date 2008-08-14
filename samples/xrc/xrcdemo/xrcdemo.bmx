SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxXmlResource
Import wx.wxHelpProvider
Import wx.wxTextCtrl
Import wx.wxSystemOptions
Import wx.wxStaticText

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		' If there is any of a certain format of image in the xrcs, then first
		' load a handler for that image type. This example uses XPMs, but if
		' you want PNGs, then add a PNG handler, etc. See wxImage.AddHandler()
		' documentation for the types of image handlers available.
		wxImage.AddHandler(New wxXPMHandler)
		
		' Initialize all the XRC handlers. Always required (unless you feel like
		' going through and initializing a handler of each control type you will
		' be using (ie initialize the spinctrl handler, initialize the textctrl
		' handler). However, if you are only using a few control types, it will
		' save some space to only initialize the ones you will be using. See
		' wxXRC docs for details.
		wxXmlResource.Get().InitAllHandlers()
		
		' Load all of the XRC files that will be used. You can put everything
		' into one giant XRC file if you wanted, but then they become more
		' diffcult to manage, and harder to reuse in later projects.
		' The menubar
		If Not wxXmlResource.Get().Load("rc/menu.xrc") Then
			Return False
		End If
		
		' The toolbar
		If Not wxXmlResource.Get().Load("rc/toolbar.xrc") Then
			Return False
		End If
		
		' Non-derived dialog example
		If Not wxXmlResource.Get().Load("rc/basicdlg.xrc") Then
			Return False
		End If
		
		' Derived dialog example
		If Not wxXmlResource.Get().Load("rc/derivdlg.xrc") Then
			Return False
		End If
		
		' Controls property example
		If Not wxXmlResource.Get().Load("rc/controls.xrc") Then
			Return False
		End If
		
		' Frame example
		If Not wxXmlResource.Get().Load("rc/frame.xrc") Then
			Return False
		End If
		
		' Uncentered example
		If Not wxXmlResource.Get().Load("rc/uncenter.xrc") Then
			Return False
		End If
		
		' Custom class example
		If Not wxXmlResource.Get().Load("rc/custclas.xrc") Then
			Return False
		End If
		
		' wxArtProvider example
		If Not wxXmlResource.Get().Load("rc/artprov.xrc") Then
			Return False
		End If
		
		' Platform property example
		If Not wxXmlResource.Get().Load("rc/platform.xrc") Then
			Return False
		End If
		
		' Variable expansion example
		If Not wxXmlResource.Get().Load("rc/variable.xrc") Then
			Return False
		End If

		' Use the simple help provider to show the context-sensitive help
		wxHelpProvider.Set( New wxSimpleHelpProvider )
		
		' Make an instance of your derived frame. Passing NULL (the default value
		' of MyFrame's constructor is NULL) as the frame doesn't have a parent
		' since it is the main application window.
		Local frame:MyFrame = New MyFrame
		
		' Show the frame as it's created initially hidden.
		frame.Show(True)
 
		Return True
	End Method

End Type

Type MyFrame Extends wxFrame
 
	Method New()
		wxXmlResource.Get().LoadObject(Self, Null, "main_frame", "wxFrame")
		
		OnInit()
	End Method

	Method OnInit()

		' Load the menubar from XRC and set this frame's menubar to it.
		'SetMenuBar(wxXmlResource.Get().LoadMenuBar(,"main_menu"))
		' Load the toolbar from XRC and set this frame's toolbar to it.
		' NOTE: For toolbars you currently should do it exactly like this.
		' With toolbars, you currently can't create one, and set it later. It
		' needs to be all in one step.
		wxSystemOptions.SetOption("msw.remap", 0)
		SetToolBar(wxXmlResource.Get().LoadToolBar(self, "main_toolbar"))
		
		' Give the frame an optional statusbar. The '1' just means one field.
		' A gripsizer will automatically get put on into the corner, if that
		' is the normal OS behaviour for frames on that platform. Helptext
		' for menu items and toolbar tools will automatically get displayed
		' here.
		CreateStatusBar( 1 )

'		Connect(XRCID("unload_resource_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnUnloadResourceMenuCommand)
'		Connect(XRCID("reload_resource_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnReloadResourceMenuCommand)
'		Connect(wxID_EXIT,  wxEVT_COMMAND_MENU_SELECTED, OnExitToolOrMenuCommand)
'		Connect(XRCID("non_derived_dialog_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnNonDerivedDialogToolOrMenuCommand)
'		Connect(XRCID("derived_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnDerivedDialogToolOrMenuCommand)
'		Connect(XRCID("controls_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnControlsToolOrMenuCommand)
'		Connect(XRCID("uncentered_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnUncenteredToolOrMenuCommand)
'		Connect(XRCID("custom_class_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnCustomClassToolOrMenuCommand)
		Connect(XRCID("platform_property_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnPlatformPropertyToolOrMenuCommand)
'		Connect(XRCID("art_provider_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnArtProviderToolOrMenuCommand)
'		Connect(XRCID("variable_expansion_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnVariableExpansionToolOrMenuCommand)
'		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAboutToolOrMenuCommand) 
	End Method

	Function OnPlatformPropertyToolOrMenuCommand(event:wxEvent)
	    Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "platform_property_dialog")
	    dlg.ShowModal()
	End Function


End Type
