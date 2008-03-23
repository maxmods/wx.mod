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

Import wx.wxLocale
Import wx.wxConfig
Import wx.wxFileName
Import BRL.LinkedList
Import wx.wxChoiceDialog
Import wx.wxFileDropTarget
Import wx.wxTimer

Import "codegenbase.bmx"
Import "code_gen.bmx"

' projects list
Global projects:TList = New TList

Global locale:wxLocale

Const timerWait:Int = 2500
Global updateTimer:wxTimer

Global config:wxConfigBase

Global checkUpdates:Int
Global localization:Int
Global lastId:Int
Global fileVersion:String
Global languageId:Int

' language data
Global langIds:Int[] = [ ..
	wxLANGUAGE_ENGLISH, ..
	wxLANGUAGE_FRENCH, ..
	wxLANGUAGE_GERMAN, ..
	wxLANGUAGE_RUSSIAN, ..
	wxLANGUAGE_CHINESE_SIMPLIFIED ]

Global langNames:String[] = [ ..
	"English", ..
	"French",..
	"German", ..
	"Russian", ..
	"Simplified Chinese" ]

Type TCGProject

	Field id:Int
	
	Field name:String
	Field projectFile:String
	Field bmxFolder:String
	Field generatedName:String
	
	Field createSuper:Int = True
	Field createImports:Int = True
	
	Field autoGenOnUpdate:Int
	
	Field projectFileRef:wxFileName
	Field lastmod:Int
	
	Function CreateNew:TCGProject()
		Local this:TCGProject = New TCGProject
		
		this.id = GetNewId()
		this.name = _("New Project") + " " + this.id
		
		Return this
	End Function
	
	Method UpdateLastMod()
		If projectFileRef Then
			lastmod = projectFileRef.GetModificationTime()
		End If
	End Method
	
	Method IsValid:Int()

		If projectFile And bmxFolder And generatedName Then
			projectFileRef = wxFileName.FileName(projectFile)
			
			If projectFileRef.FileExists() Then
				Return True
			Else
				projectFileRef = Null
			End If
		End If
	
		Return False
	End Method
	
	Method Generate()
		If IsValid() Then
			
			GenerateProject(Self)
			
		End If
	End Method
	
	Method GenerateAppCode:String()
		If IsValid() Then
			Return GenerateApplicationStubCode(Self)
		End If
		
		Return ""
	End Method
	
	' check if we need
	Method RequiredUpdate:Int()
		If autoGenOnUpdate And IsValid() Then
		
			If lastmod <> projectFileRef.GetModificationTime() Then

				Generate()
				UpdateLastMod()
				
				Return True

			End If
		
		End If
	End Method
	
End Type

Function GetNewId:Int()
	lastId:+1
	Return lastId
End Function

Function LoadProjects()

	locale = New wxLocale.Create()
	
	config.SetPath("/Global")
	
	checkUpdates = config.ReadBool("checkUpdates", False)
	localization = config.ReadInt("localization", 0)
	lastId = config.ReadInt("lastId", 0)
	fileVersion = config.ReadString("fileVersion", "")
	languageId = config.ReadInt("languageId", -1)
	
	If languageId = -1 Then
		GetLanguage()
	End If

    locale.Init(languageId, wxLOCALE_CONV_ENCODING)

	wxLocale.AddCatalogLookupPathPrefix("locale")
	locale.AddCatalog("wxCodeGen")
	locale.AddCatalog("wxstd")
	
	config.SetPath("/Projects")

	
'	If Not fileVersion Then
'		LoadOldStyleProjects()
'	Else
	
		Local dummy:Int, cont:Int
		Local project:String = config.GetFirstGroup(dummy, cont)
	
		While cont
			Local path:String = project + "/"
		
			Local proj:TCGProject = New TCGProject
	
			proj.id = config.ReadInt(path + "id", -1)
			If proj.id = -1 Then
				proj.id = GetNewId()
			End If
			proj.name = config.ReadString(path + "name", "Project " + proj.id)
			proj.projectFile = config. ReadString(path + "projectFile", "")
			
			' get the project file reference
			If proj.projectFile Then
				proj.projectFileRef = wxFileName.FileName(proj.projectFile)
				If Not proj.projectFileRef.FileExists() Then
					proj.projectFile = ""
					proj.projectFileRef = Null
				Else
					proj.lastmod = config.ReadInt(path + "lastmod", 0)
				End If
			End If
			
			proj.bmxFolder = config. ReadString(path + "bmxFolder", "")
			proj.generatedName = config. ReadString(path + "generatedName", "")
			
			proj.createSuper = config.ReadBool(path + "createSuper", True)
			proj.createImports = config. ReadBool(path + "createImports", True)
			proj.autoGenOnUpdate = config. ReadBool(path + "autoGenOnUpdate", False)
	
			projects.AddLast(proj)
	
			project = config.GetNextGroup(dummy, cont)
		Wend
'	End If
	
	config.SetPath("/")

End Function

Function SaveProjects()

	config.SetPath("/Global")
	
	config.WriteBool("checkUpdates", checkUpdates)
	config.WriteInt("localization", localization)
	config.WriteInt("lastId", lastId)
	config.WriteString("fileVersion", AppVersion)
	config.WriteInt("languageId", languageId)
	
	config.DeleteGroup("/Projects")
	
	For Local proj:TCGProject = EachIn projects
		Local path:String = "/Projects/Project_" + proj.id 	
		config.SetPath(path)
		
		config.WriteInt("id", proj.id)
		config.WriteString("name", proj.name)
		config.WriteString("projectFile", proj.projectFile)
		config.WriteString("bmxFolder", proj.bmxFolder)
		config.WriteString("generatedName", proj.generatedName)
		config.WriteInt("lastmod", proj.lastmod)
		
		config.WriteBool("createSuper", proj.createSuper)
		config.WriteBool("createImports", proj.createImports)
		config.WriteBool("autoGenOnUpdate", proj.autoGenOnUpdate)

	Next
	
	config.SetPath("/")

	config.Flush()

End Function

Function GetGenFlags:Int(proj:TCGProject)
	Local flags:Int = 0
	If proj.createSuper Then
		flags :| GEN_SUPER
	End If
	
	If proj.createImports Then
		flags:| GEN_IMPORTS
	End If
	
	Select localization
		Case 1
			flags :| GEN_WXLOCALE
		Case 2
			flags :| GEN_BAHLOCALE
	End Select
	
	Return flags
End Function

Function ImportProject:TFBObject(proj:TCGProject, version:Float Var)

	Return TObjectFactory.ImportObject(proj.projectFile, version)

End Function

Function GenerateProject(proj:TCGProject)

	Local version:Float
	Local project:TFBObject = ImportProject(proj, version)
	
	' process the project
	
	Local projBase:TFBProject = TFBGenFactory.CreateModel(project, GetGenFlags(proj))
	projBase.version = version
	
	Local out:TCodeOutput = New TCodeOutput
	
	' the first call is a bit of a hack. This makes sure, after processing, that all the Imports are set.
	projBase.Generate(out)
	
	out.Reset()
	
	' okay... do it again, and this time store the output somewhere
	projBase.Generate(out)
	
	SaveText(out.code, proj.bmxFolder + "/" + proj.generatedName + ".bmx")
	
	proj.UpdateLastMod()

	projBase.Free()
	project.Free()

End Function

Function GenerateApplicationStubCode:String(proj:TCGProject)

	Local version:Float
	Local project:TFBObject = ImportProject(proj, version)

	' process the project
	
	Local projBase:TFBProject = TFBGenFactory.CreateModel(project, GetGenFlags(proj))
	projBase.version = version
	projBase.generatedName = proj.generatedName
	
	Local out:TCodeOutput = New TCodeOutput
	
	projBase.GenerateAppCode(out)
	
	projBase.Free()
	project.Free()

	Return out.code

End Function

Function GetLanguage()

	Local lng:Int = wxGetSingleChoiceIndex("Select a language:", "Language", langNames)

	If lng <> -1 Then
		' don't use wxLOCALE_LOAD_DEFAULT flag so that Init() doesn't return
		' False just because it failed To Load wxstd catalog
		If Not locale.Init(langIds[lng], wxLOCALE_CONV_ENCODING) Then
			languageId = wxLANGUAGE_ENGLISH
		Else
			languageId = langIds[lng]
		End If
	Else
		If languageId < 0 Then
			languageId = wxLANGUAGE_ENGLISH
		End If
	End If

	locale.AddCatalog("wxCodeGen")
	locale.AddCatalog("wxstd")

End Function
