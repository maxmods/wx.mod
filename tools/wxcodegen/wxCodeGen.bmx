' Copyright (c) 2008 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Framework wx.wxApp
Import wx.wxSystemOptions

Import "cgmain.bmx"


New MyApp.run()


Type MyApp Extends wxApp

	Field frame:CodeGenFrame

	Method OnInit:Int()

?macos
		' make the default Mac font for controls not so big
		wxSystemOptions.SetOption(wxWINDOW_DEFAULT_VARIANT, wxWINDOW_VARIANT_SMALL)
?

		SetAppName("wxCodeGen")
		SetVendorName("wxMax")
		
		config = wxConfigBase.Get()
	
		LoadProjects()
		
		frame = CodeGenFrame(New CodeGenFrame.Create())
		
		SetTopWindow(frame)
		
		frame.show()
	
		Return True
	
	End Method

End Type

Type CodeGenFrame Extends CodeGenFrameBase

	Field currentProject:TCGProject

	Method OnInit()
		Super.OnInit()

?macos
		' default font size is a bit big
		txtAppCode.SetFont(New wxFont.CreateWithAttribs(wxNORMAL_FONT().GetPointSize() * .9, 76, 90, 90, False))
?
		
		lstProjects.SetDropTarget(New MyDropTarget.Create())
		
		updateTimer = New wxTimer.Create(Self)
		ConnectAny(wxEVT_TIMER, OnTimer)
		
		InitializeUI()
	End Method
	
	' initialize the UI
	Method InitializeUI()
	
		cbProjectUpdates.SetValue(checkUpdates)
		rbLocale.SetSelection(localization)
		
		For Local proj:TCGProject = EachIn projects
		
			lstProjects.Append(proj.name, proj)
		
		Next

		If checkUpdates Then
			updateTimer.Start(timerWait, True)
		End If
		
	End Method

	Method OnClose(event:wxCloseEvent)
		updateTimer.Stop()

		SaveProjects()
	
		Destroy()
	End Method
	
	Method OnAddProject(event:wxCommandEvent)
		CreateNewProject()
	End Method

	
	Method CreateNewProject:TCGProject()
		
		Local proj:TCGProject = TCGProject.CreateNew()

		projects.AddLast(proj)
		
		lstProjects.Append(proj.name, proj)
		
		Return proj
	End Method

	Method OnSelectItem(event:wxCommandEvent)
		Local row:Int = event.GetInt()

		If row >= 0 Then
			ShowProject(TCGProject(event.GetClientData()))
		Else
			HideProject()
		End If
	End Method


	Method OnLocaleSelected(event:wxCommandEvent)
		localization = event.GetInt()
	End Method


	Method OnCheckForUpdatesChecked(event:wxCommandEvent)
		checkUpdates = event.IsChecked()

		If checkUpdates Then
			If Not updateTimer.IsRunning() Then
				updateTimer.Start(timerWait, True)
			End If
		Else
			upDateTimer.Stop()
		End If
		
	End Method
	
	Method ShowProject(proj:TCGProject)
		If proj Then
			currentProject = proj
			
			pnlProject.Enable()
			txtProjectName.Enable()
			fpkProjectFile.Enable()
			dpkProjectFolder.Enable()
			txtGenFilename.Enable()
			
			pnlCode.Enable()
			txtAppCode.Enable()
			btnRefresh.Enable()

			If CheckGenerate() Then
				txtAppCode.ChangeValue(ShowAppCode())
			End If
			
			btnDeleteProject.Enable()
			
			If checkUpdates Then
				cbAutoGenerate.Enable()
			Else
				cbAutoGenerate.Disable()
			End If
			
			txtProjectName.ChangeValue(proj.name)
			fpkProjectFile.SetPath(proj.projectFile)
			dpkProjectFolder.SetPath(proj.bmxFolder)
			txtGenFilename.ChangeValue(proj.generatedName)
			
			cbSuperStrict.SetValue(proj.createSuper)
			cbImports.SetValue(proj.createImports)
			cbAutoGenerate.SetValue(proj.autoGenOnUpdate)
		End If
	End Method
	
	Method CheckGenerate:Int()
		If currentProject Then
			If currentProject.IsValid() Then

				btnGenerate.Enable()
	
				Return True
			End If
		End If
		
		btnGenerate.Disable()
		
	End Method
	
	
	Method HideProject()
		currentProject = Null
		
		pnlProject.Disable()
		txtProjectName.Disable()
		fpkProjectFile.Disable()
		dpkProjectFolder.Disable()
		txtGenFilename.Disable()

		pnlCode.Disable()
		txtAppCode.Disable()
		btnRefresh.Disable()
		
		CheckGenerate()
		
		btnDeleteProject.Disable()
		
		txtProjectName.ChangeValue("")
		fpkProjectFile.SetPath("")
		dpkProjectFolder.SetPath("")
		txtGenFilename.ChangeValue("")
		txtAppCode.ChangeValue("")

	End Method

	Method OnProjectNameLostFocus(event:wxFocusEvent)
		If currentProject Then
			currentProject.name = txtProjectName.GetValue()

			Local row:Int = FindRow()
			
			If row >= 0 Then
				lstProjects.SetString(row, currentProject.name)
			End If
			
		End If

	End Method
	
	Method FindRow:Int()
		For Local i:Int = 0 Until lstProjects.GetCount()
			If currentProject = lstProjects.GetItemClientData(i)
				Return i
			End If
		Next
		Return -1
	End Method
	
	Method OnProjectFileChange(event:wxFileDirPickerEvent)
		If currentProject Then
			currentProject.projectFile = event.GetPath()
			CheckGenerate()
		End If
	End Method

	
	Method OnBMXFolderChange(event:wxFileDirPickerEvent)
		If currentProject Then
			currentProject.bmxFolder = event.GetPath()
			CheckGenerate()
		End If
	End Method

	Method OnGenNameLostFocus(event:wxFocusEvent)
		If currentProject Then
			currentProject.generatedName = txtGenFilename.GetValue()
			CheckGenerate()
		End If
	End Method

	Method OnSuperStrictChecked(event:wxCommandEvent)
		If currentProject Then
			currentProject.createSuper = event.IsChecked()
		End If
	End Method

	Method OnImportsChecked(event:wxCommandEvent)
		If currentProject Then
			currentProject.createImports = event.IsChecked()
		End If
	End Method

	Method OnAutoGenChecked(event:wxCommandEvent)
		If currentProject Then
			currentProject.autoGenOnUpdate = event.IsChecked()
		End If
	End Method

	Method OnGenerate(event:wxCommandEvent)
		If currentProject Then
			currentProject.Generate()
			
			' also update the code section.
			txtAppCode.ChangeValue(currentProject.GenerateAppCode())
		End If
	End Method


	Method OnDeleteProject(event:wxCommandEvent)
		If currentProject Then
			Local result:Int = wxMessageBox(_("Are you sure you want to delete? : ") + ..
				"~n'" + currentProject.name + "'", ..
				_("Delete Project?"), ..
				wxYES | wxNO | wxCANCEL, Self)
			If result = wxYES Then
				
				Local row:Int = FindRow()
			
				If row >= 0 Then
					lstProjects.DeleteItem(row)
					projects.remove(currentProject)
					HideProject()
					
				End If

			End If
		End If
	End Method

	Method OnQuit(event:wxCommandEvent)
		Close(True)
	End Method

	Method OnAbout(event:wxCommandEvent)

		wxMessageBox("A wxMax BlitzMax Code Generator~n" + ..
			"(c) 2008 Bruce A Henderson", ..
			"About wxCodeGen v"+ AppVersion, wxOK, Self)
	End Method

	Method OnNewProject(event:wxCommandEvent)
		CreateNewProject()
	End Method

	Method OnChangeLanguage(event:wxCommandEvent)
		Local oldLang:Int = languageId

		GetLanguage()
		
		If languageId <> oldLang Then
			wxMessageBox(_("You will need to restart wxCodeGen to see the new language."), ..
				_("Language Changed"), wxOK, Self)
		End If
	End Method
	
	Function OnTimer(event:wxEvent)
	
		For Local proj:TCGProject = EachIn projects
		
			If proj.RequiredUpdate() Then
				' also recreate the Application Code section
				If CodeGenFrame(event.parent).currentProject = proj Then
					CodeGenFrame(event.parent).txtAppCode.ChangeValue(proj.GenerateAppCode())
				End If
				
				wxFrame(event.parent).SetStatusText(_("Updated at ") + CurrentTime() + " : " + proj.name)
			End If
		
		Next
		
		' restart the timer...
		updateTimer.Start(timerWait, True)
	End Function
	
	Method OnCodeRefresh(event:wxCommandEvent)
		If currentProject Then
			txtAppCode.ChangeValue(ShowAppCode())
		End If
	End Method
	
	Method ShowAppCode:String()
		If currentProject Then
			Return currentProject.GenerateAppCode()
		Else
			Return ""
		End If
	End Method

	Method OnAppCodeKeyDown(evt:wxKeyEvent)
' enable Select ALL (ctrl-A) for Win32
?win32
		Local event:wxKeyEvent = wxKeyEvent(evt)

		If event.ControlDown() Then
			If event.GetKeyCode() = 65 Then ' 65 on Win32... 1 on Linux...
				txtAppCode.SetSelection(-1, -1)
			End If
		End If
?
		evt.skip()
	End Method

End Type

Type MyDropTarget Extends wxFileDropTarget

	Method OnDropFiles:Int(x:Int, y:Int, filenames:String[])
	
		Local dropped:Int = False
	
		' process the dropped files
		For Local i:Int = 0 Until filenames.length
			
			Local file:String = filenames[i]
			
			' is this a formbuilder project?
			If file.EndsWith(".fbp") Or file.EndsWith(".pjd") Then
			
				Local found:Int
				
				' check our projects to see if we have it already!
				For Local proj:TCGProject = EachIn projects
					If file = proj.projectFile Then
						' we should switch to this project
						MyApp(wxGetApp()).frame.ShowProject(proj)
						found = True
						dropped = True
						Exit
					End If
				Next
				
				If Not found Then
					' otherwise... is it a valid file? (exists etc)
					If wxFileName.FFileExists(file) Then
						' add as a new project
						Local proj:TCGProject = MyApp(wxGetApp()).frame.CreateNewProject()
						proj.projectFile = file

						dropped = True
					End If
				End If
			
			End If
			
		Next
		
		Return dropped
	End Method

End Type

