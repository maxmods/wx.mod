SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxArtProvider
Import wx.wxPreferencesEditor
Import wx.wxStockPreferencesPage
Import wx.wxPanel
Import wx.wxStaticText
Import wx.wxCheckBox
Import wx.wxListBox

Global app:MyApp = New MyApp
app.run()

Type MyApp Extends wxApp

	Field frame:MyFrame
	Field settings:TMySettings = New TMySettings
	Field prefEditor:wxPreferencesEditor

	Method OnInit:Int()
	
		SetAppDisplayName("wxWidgets Sample")

		frame = MyFrame(New MyFrame.Create(,,"Preferences sample", 100, 100))
		frame.show()
		
		Return True	
	End Method
	
	Method ShowPreferencesEditor(parent:wxWindow)
		If Not prefEditor
			prefEditor = New wxPreferencesEditor.Create()
			prefEditor.AddPage(New TPrefsPageGeneral.CreateStock(Kind_General))
			prefEditor.AddPage(New TPrefsPageTopics.Create())
		End If
		prefEditor.Show(parent)
	End Method
	
	Method DismissPreferencesEditor()
		If prefEditor Then
			prefEditor.Dismiss()
		End If
	End Method
	
	Method GetSettings:TMySettings()
		Return settings
	End Method

	Method UpdateSettings(settings:TMySettings)
		settings.Copy(Self.settings)
		frame.UpdateSettings()
	End Method

End Type

Type MyFrame Extends wxFrame

	Field textMarkdownSyntax:wxStaticText
    Field textSpellcheck:wxStaticText

	Method OnInit:Int()
	
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		fileMenu.Append(wxID_PREFERENCES)
		fileMenu.Append(wxID_EXIT)
		
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menuBar.Append(fileMenu, "&File")
		SetMenuBar(menuBar)
		
		Local panel:wxPanel = New wxPanel.Create(Self)
		textMarkdownSyntax = New wxStaticText.Create(panel, wxID_ANY, "")
		textSpellcheck = New wxStaticText.Create(panel, wxID_ANY, "")
		
		Local sizer:wxSizer = New wxFlexGridSizer.Create(2, 5, 5)
		sizer.Add(New wxStaticText.Create(panel, wxID_ANY, "Markdown syntax:"), wxALIGN_CENTER | wxALIGN_RIGHT)
		sizer.Add(textMarkdownSyntax, wxALIGN_CENTER)
		sizer.Add(New wxStaticText.Create(panel, wxID_ANY, "Spell checking:"), wxALIGN_CENTER | wxALIGN_RIGHT)
		sizer.Add(textSpellcheck, wxALIGN_CENTER)
		panel.SetSizer(sizer)
		
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnExit)
		Connect(wxID_PREFERENCES, wxEVT_COMMAND_MENU_SELECTED, OnPref)
		ConnectAny(wxEVT_CLOSE_WINDOW, OnClose)

		' Show the initial values
		UpdateSettings()		
	End Method
	
	Method UpdateSettings()
        ' Here we should update the settings we use. As we don't actually do
        ' anything in this sample, just update their values shown on screen.
        Local settings:TMySettings = app.GetSettings()
		If settings.useMarkdown Then
	        textMarkdownSyntax.SetLabel("yes")
		Else
	        textMarkdownSyntax.SetLabel("no")
		End If
		
		If settings.spellcheck Then
	        textSpellcheck.SetLabel("on")
		Else
	        textSpellcheck.SetLabel("off")
		End If
	End Method

	Function OnExit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close()
	End Function
	
	Function OnPref(event:wxEvent)
		app.ShowPreferencesEditor(wxWindow(event.parent))
	End Function
	
	Function OnClose(event:wxEvent)
        app.DismissPreferencesEditor()
        event.Skip()
	End Function
	
End Type

' combines the settings edited in the preferences dialog.
Type TMySettings

	' Normally we would initialize values by loading them from some
	' persistent storage, e.g. using wxConfig.
	' For demonstration purposes, we just set hardcoded values here.
	Field useMarkdown:Int = True
	Field spellcheck:Int = False
	
	Method Copy(settings:TMySettings)
		settings.useMarkdown = useMarkdown
		settings.spellcheck = spellcheck
	End Method

End Type

Type TPrefsPageGeneralPanel Extends wxPanel

    Field useMarkdown:wxCheckBox
    Field spellcheck:wxCheckBox

    '  Settings corresponding to the current values in this dialog.
    Field settingsCurrent:TMySettings = New TMySettings

	Method OnInit:Int()
		useMarkdown = New wxCheckBox.Create(Self, wxID_ANY, "Use Markdown syntax")
		spellcheck = New wxCheckBox.Create(Self, wxID_ANY, "Check spelling")
		
		Local sizer:wxSizer = New wxBoxSizer.Create(wxVERTICAL)
		sizer.Add(useMarkdown, wxAll, 5)
		sizer.Add(spellcheck, wxAll, 5)
		
		SetSizerAndFit(sizer)
		
		useMarkdown.ConnectAny(wxEVT_CHECKBOX, OnChangedUseMarkdown, Null, Self)
		spellcheck.ConnectAny(wxEVT_CHECKBOX, OnChangedSpellcheck, Null, Self)
	End Method

	Method TransferDataToWindow:Int()
		app.GetSettings().Copy(settingsCurrent)
		useMarkdown.SetValue(settingsCurrent.useMarkdown)
		spellcheck.SetValue(settingsCurrent.spellcheck)
		Return True
	End Method

	Method TransferDataFromWindow:Int()
		' Called on platforms with modal preferences dialog to save and apply
		' the changes.
		app.UpdateSettings(settingsCurrent)
        Return True
	End Method

	Method UpdateSettingsIfNecessary()
		' On some platforms (OS X, GNOME), changes to preferences are applied
		' immediately rather than after the OK or Apply button is pressed, so
		' we need to take them into account as soon as they happen. On others
		' (MSW), we need to wait until the changes are accepted by the user by
		' pressing the "OK" button. To reuse the same code for both cases, we
		' always update m_settingsCurrent object under all platforms, but only
		' update the real application settings if necessary here.
		If wxPreferencesEditor.ShouldApplyChangesImmediately() Then
			app.UpdateSettings(settingsCurrent)
		End If
	End Method
	
	Method ChangedUseMarkdown(evt:wxCommandEvent)
		settingsCurrent.useMarkdown = evt.IsChecked()
		UpdateSettingsIfNecessary()
	End Method
	
	Function OnChangedUseMarkdown(evt:wxEvent)
		TPrefsPageGeneralPanel(evt.sink).ChangedUseMarkdown(wxCommandEvent(evt))
	End Function
	
	Method ChangedSpellcheck(evt:wxCommandEvent)
		settingsCurrent.spellcheck = evt.IsChecked()
		UpdateSettingsIfNecessary()
	End Method

	Function OnChangedSpellcheck(evt:wxEvent)
		TPrefsPageGeneralPanel(evt.sink).ChangedSpellcheck(wxCommandEvent(evt))
	End Function
	
End Type

Type TPrefsPageTopicsPanel Extends wxPanel
	
	Field fulltext:wxCheckBox
	
	Method OnInit:Int()
		Local sizer:wxSizer = New wxBoxSizer.Create(wxVERTICAL)
		sizer.Add(New wxStaticText.Create(Self, wxID_ANY, "Search in these topics:"), wxALL, 5)
		
		Local box:wxListBox = New wxListBox.Create(Self, wxID_ANY, Null)
		box.SetMinSize(400, 300)
		sizer.Add(box, wxEXPAND | wxALL, 5)
		
		fulltext = New wxCheckBox.Create(Self, wxID_ANY, "Automatically build fulltext index")
		sizer.Add(fulltext, wxALL, 5)
		
		SetSizerAndFit(sizer)
	End Method
	
	Method TransferDataToWindow:Int()
		' This is the place where you can initialize values, e.g. from wxConfig.
		' For demonstration purposes, we just set hardcoded values.
		fulltext.SetValue(True)
        ' TODO: handle the listbox
        Return True
	End Method
	
	Method TransferDataFromWindow:Int()
		' Called on platforms with modal preferences dialog to save and apply
		' the changes.
		OnChangedFulltext(Null)
		' TODO: handle the listbox
        Return True
	End Method
	
	Function OnChangedFulltext(event:wxEvent)
		' save new fulltext value and apply the change to the app
	End Function
	
End Type

Type TPrefsPageGeneral Extends wxStockPreferencesPage

	Method CreateWindow:wxWindow(parent:wxWindow )
		Return New TPrefsPageGeneralPanel.Create(parent)
	End Method
	
End Type

Type TPrefsPageTopics Extends wxPreferencesPage

	Method GetName:String()
		Return "Topics"
	End Method

	Method GetLargeIcon:wxBitmap()
		Return wxArtProvider.GetBitmap(wxART_HELP, wxART_TOOLBAR)
	End Method
	
	Method CreateWindow:wxWindow(parent:wxWindow)
		Return New TPrefsPageTopicsPanel.Create(parent)
	End Method

End Type
