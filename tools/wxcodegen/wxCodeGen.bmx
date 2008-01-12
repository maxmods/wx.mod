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
Import "cgmain.bmx"


Const AppVersion:String = "0.80"

New MyApp.run()


Type MyApp Extends wxApp

	Field frame: CodeGenFrame

	Method OnInit:Int()
	
		SetAppName("wxCodeGen")
		SetVendorName("BaH")
		
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
		
		InitializeUI()
	End Method
	
	' initialize the UI
	Method InitializeUI()
	
		cbProjectUpdates.SetValue(checkUpdates)
		rbLocale.SetSelection(localization)
		
		For Local proj:TCGProject = EachIn projects
		
			lstProjects.Append(proj.name, proj)
		
		Next
		
	End Method

	Method OnClose(event:wxCloseEvent)
		SaveProjects()
	
		Destroy()
	End Method
	
	Method OnAddProject(event:wxCommandEvent)
		CreateNewProject()
	End Method

	
	Method CreateNewProject()
		
		Local proj:TCGProject = TCGProject.CreateNew()

		projects.AddLast(proj)
		
		lstProjects.Append(proj.name, proj)
		
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
	End Method
	
	Method ShowProject(proj:TCGProject)
		If proj Then
			currentProject = proj
			
			pnlProject.Enable()
			txtProjectName.Enable()
			fpkProjectFile.Enable()
			dpkProjectFolder.Enable()
			txtGenFilename.Enable()

			CheckGenerate()
			
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
	
	Method CheckGenerate()
		If currentProject Then
			If currentProject.IsValid() Then

				btnGenerate.Enable()
	
				Return			
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
		
		CheckGenerate()
		
		btnDeleteProject.Disable()
		
		txtProjectName.ChangeValue("")
		fpkProjectFile.SetPath("")
		dpkProjectFolder.SetPath("")
		txtGenFilename.ChangeValue("")

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
		End If	
	End Method


	Method OnDeleteProject(event:wxCommandEvent)
		If currentProject Then
			Local result:Int = wxMessageBox("Are you sure you want to delete '" + ..
				currentProject.name + "' ?", ..
				"Delete Project?", ..
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

		wxMessageBox("A wxFormBuilder BlitzMax Code Generator~n" + ..
			"(c) 2008 Bruce A Henderson", ..
			"About wxCodeGen v"+ AppVersion, wxOK, Self)
	End Method


End Type


