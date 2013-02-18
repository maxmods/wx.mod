SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxXmlResource
Import wx.wxHelpProvider
Import wx.wxTextCtrl
Import wx.wxSystemOptions
Import wx.wxStaticText
Import wx.wxCheckBox
Import wx.wxFlatNotebook
Import wx.wxNotebook
Import wx.wxStaticBitmap
Import wx.wxLog
Import wx.wxStdDialogButtonSizer
Import wx.wxMessageDialog
Import wx.wxStaticLine
Import wx.wxSlider
Import wx.wxChoice
Import wx.wxGauge
Import wx.wxComboBox
Import wx.wxColourPickerCtrl
Import wx.wxCalendarCtrl
Import wx.wxChoicebook
Import wx.wxAnimationCtrl
Import wx.wxBannerWindow
Import wx.wxCommandLinkButton
Import wx.wxCheckListBox
Import wx.wxBitmapComboBox
Import wx.wxGenericDirCtrl
Import wx.wxFileCtrl
Import wx.wxHtmlWindow
Import wx.wxListBox
Import wx.wxSimpleHtmlListBox
Import wx.wxListCtrl
Import wx.wxSplitterWindow
Import wx.wxRadioButton
Import wx.wxRadioBox
'Import wx.wxRibbonBar
Import wx.wxScrollBar
Import wx.wxSpinButton
Import wx.wxSpinCtrl
Import wx.wxSearchCtrl
Import wx.wxOwnerDrawnComboBox
Import wx.wxToolbook
Import wx.wxTreebook
Import wx.wxTreeCtrl
Import wx.wxFilePickerCtrl
'Import wx.wxDirPickerCtrl
Import wx.wxFontPickerCtrl
Import wx.wxBitmapButton
Import wx.wxCollapsiblePane

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		' If there is any of a certain format of image in the xrcs, then first
		' load a handler for that image type. This example uses XPMs, but if
		' you want PNGs, then add a PNG handler, etc. See wxImage.AddHandler()
		' documentation for the types of image handlers available.
		wxImage.AddHandler(New wxXPMHandler)
		wxImage.AddHandler(New wxGIFHandler)
		
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
		SetMenuBar(wxXmlResource.Get().LoadMenuBar(,"main_menu"))
		' Load the toolbar from XRC and set this frame's toolbar to it.
		' NOTE: For toolbars you currently should do it exactly like this.
		' With toolbars, you currently can't create one, and set it later. It
		' needs to be all in one step.
		wxSystemOptions.SetOption("msw.remap", 0)
		SetToolBar(wxXmlResource.Get().LoadToolBar(Self, "main_toolbar"))
		
		' Give the frame an optional statusbar. The '1' just means one field.
		' A gripsizer will automatically get put on into the corner, if that
		' is the normal OS behaviour for frames on that platform. Helptext
		' for menu items and toolbar tools will automatically get displayed
		' here.
		CreateStatusBar( 1 )

		Connect(XRCID("unload_resource_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnUnloadResourceMenuCommand)
		Connect(XRCID("reload_resource_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnReloadResourceMenuCommand)
		Connect(wxID_EXIT,  wxEVT_COMMAND_MENU_SELECTED, OnExitToolOrMenuCommand)
		Connect(XRCID("non_derived_dialog_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnNonDerivedDialogToolOrMenuCommand)
		Connect(XRCID("derived_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnDerivedDialogToolOrMenuCommand)
		Connect(XRCID("controls_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnControlsToolOrMenuCommand)
		Connect(XRCID("uncentered_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnUncenteredToolOrMenuCommand)
'		Connect(XRCID("custom_class_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnCustomClassToolOrMenuCommand)
		Connect(XRCID("platform_property_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnPlatformPropertyToolOrMenuCommand)
		Connect(XRCID("art_provider_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnArtProviderToolOrMenuCommand)
		Connect(XRCID("variable_expansion_tool_or_menuitem"), wxEVT_COMMAND_MENU_SELECTED, OnVariableExpansionToolOrMenuCommand)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAboutToolOrMenuCommand) 
	End Method

	Function OnUnloadResourceMenuCommand(event:wxEvent)
		If wxXmlResource.Get().Unload("rc/basicdlg.xrc") Then
			wxLogMessage("Basic dialog resource has now been unloaded, you " + ..
				"won't be able to use it before loading it again")
		Else
			wxLogWarning("Failed to unload basic dialog resource")
		End If
	End Function

	Function OnReloadResourceMenuCommand(event:wxEvent)
		If wxXmlResource.Get().Load("rc/basicdlg.xrc") Then
			wxLogStatus("Basic dialog resource has been loaded.")
		Else
			wxLogError("Failed to load basic dialog resource")
		End If
	End Function
	
	Function OnExitToolOrMenuCommand(event:wxEvent)
		' True is To force the frame To close.
		wxWindow(event.parent).Close(True)
	End Function

	Function OnNonDerivedDialogToolOrMenuCommand(event:wxEvent)
		' "non_derived_dialog" is the name of the wxDialog XRC node that should be loaded.
		Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "non_derived_dialog")
		If dlg Then
			dlg.ShowModal()
		End If
	End Function
	
	Function OnUncenteredToolOrMenuCommand(event:wxEvent)
		Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "uncentered_dialog")
		dlg.ShowModal()
	End Function

	Function OnDerivedDialogToolOrMenuCommand(event:wxEvent)
		' Make an instance of our derived dialog, passing it "this" window
		' (the main frame) as the parent of the dialog. This allows the dialog
		' to be destructed automatically when the parent is destroyed.
		Local prefs:PreferencesDialog = New PreferencesDialog.Create(wxWindow(event.parent))
		' Show the instance of the dialog, modally.
		prefs.ShowModal()
	End Function

	Function OnControlsToolOrMenuCommand(event:wxEvent)
		Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "controls_dialog")
	
	
	
		' All done. Show the dialog.
		dlg.ShowModal()
	End Function
		
	Function OnPlatformPropertyToolOrMenuCommand(event:wxEvent)
	    Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "platform_property_dialog")
	    dlg.ShowModal()
	End Function

	Function OnArtProviderToolOrMenuCommand(event:wxEvent)
		Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "art_provider_dialog")
		dlg.ShowModal()
	End Function

	Function OnVariableExpansionToolOrMenuCommand(event:wxEvent)
		Local dlg:wxDialog = wxXmlResource.Get().LoadDialog(wxWindow(event.parent), "variable_expansion_dialog")
		dlg.ShowModal()
	End Function

	Function OnAboutToolOrMenuCommand(event:wxEvent)
		Local msg:String =  "This is the about dialog of XML resources demo.~n" + ..
			"Welcome to " + wxVERSION_STRING

		wxMessageBox(msg, "About XML resources demo", wxOK | wxICON_INFORMATION, wxWindow(event.parent))
	End Function


End Type

Type PreferencesDialog Extends wxDialog

	Method Create:PreferencesDialog(parent:wxWindow)
		wxXmlResource.Get().LoadObject(Self, parent, "derived_dialog", "wxDialog")
		OnInit()
		Return Self
	End Method
	
	Method OnInit()
		Connect( XRCID("my_button"), wxEVT_COMMAND_BUTTON_CLICKED, OnMyButtonClicked)
		Connect(XRCID("my_checkbox"), wxEVT_UPDATE_UI, OnUpdateUIMyCheckbox)
		' Note that the ID here isn't a XRCID, it is one of the standard wx ID's.
		Connect( wxID_OK, wxEVT_COMMAND_BUTTON_CLICKED , OnOK)
	End Method

	' Stuff To do when "My Button" gets clicked
	Function OnMyButtonClicked(event:wxEvent)
		' Construct a message dialog.
		Local msgDlg:wxMessageDialog = New wxMessageDialog.Create(wxWindow(event.parent), "You clicked on My Button")
		
		' Show it modally.
		msgDlg.ShowModal()
	End Function

	' Stuff To do when a "My Checkbox" gets updated
	' (drawn, Or it changes its value)
	Function OnUpdateUIMyCheckbox(event:wxEvent)
		' Get a boolean value of whether the checkbox is checked
		' You could just write:
		' myCheckBoxIsChecked = event.IsChecked()
		' since the event that was passed into this function already has the
		' is a pointer to the right control. However,
		' this is the XRCCTRL way (which is more obvious as to what is going on).
		Local myCheckBoxIsChecked:Int = wxCheckBox(XRCCTRL(wxWindow(event.parent), "my_checkbox")).IsChecked()
		
		' Now call either Enable(true) or Enable(false) on the textctrl, depending
		' on the value of that boolean.
		wxTextCtrl(XRCCTRL(wxWindow(event.parent), "my_textctrl")).Enable(myCheckBoxIsChecked)
	End Function

	' Override base class functions of a wxDialog.
	Function OnOK(event:wxEvent)
		' Construct a message dialog (An extra parameters to put a cancel button on).
		Local msgDlg2:wxMessageDialog = New wxMessageDialog.Create(wxWindow(event.parent), ..
			"Press OK to close Derived dialog, or Cancel to abort", ..
			"Overriding base class OK button handler", ..
			wxOK | wxCANCEL | wxCENTER )
		
		' Show the message dialog, and if it returns wxID_OK (ie they clicked on OK button)...
		If msgDlg2.ShowModal() = wxID_OK Then
			' ...then end this Preferences dialog.
			wxDialog(event.parent).EndModal(wxID_OK)
			' You could also have used event.Skip() which would then skip up
			' to the wxDialog's event table and see if there was a wxEVT_COMMAND_BUTTON_CLICKED
			' handler for wxID_OK and if there was, then execute that code.
		End If
		
		' Otherwise do nothing.
	End Function


End Type


