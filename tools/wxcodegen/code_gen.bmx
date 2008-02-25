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

Import BaH.libxml
Import BRL.StandardIO
Import BRL.System


Const AppVersion:String = "1.00"


Global eventMap:TMap = New TMap
InitEvents()


Const GEN_SUPER:Int = $001
Const GEN_IMPORTS:Int = $002
Const GEN_WXLOCALE:Int = $004
Const GEN_BAHLOCALE:Int = $008



Type TFBObject

	Field class:String
	Field subclass:String
	Field expanded:Int

	Field properties:TMap = New TMap
	Field events:TMap = New TMap
	
	Field objects:TList = New TList


	Method extractDetails(node:TxmlNode)
	
		class = node.GetAttribute("class")
		subclass = node.GetAttribute("subclass")
		expanded = Int(node.GetAttribute("expanded"))
		
		Local children:TList = node.getChildren()
		
		If children Then
			For Local det:TxmlNode = EachIn children
			
				Select det.GetName()
				
					Case "property"
						Local text:String = det.GetText().Trim()
						If text Then
							Local name:String = det.getAttribute("name")
							properties.Insert(name, text)
						End If
					Case "event"
						Local text:String = det.GetText().Trim()
						If text Then
							Local name:String = det.getAttribute("name")
							events.Insert(name, text)
						End If
					Case "object"
						Local widget:TFBObject = New TFBObject
						objects.AddLast(widget)
						widget.extractDetails(det)
				End Select
			
			Next
		End If
		
	End Method
	
	Method Free()
		properties.Clear()
		events.Clear()
		
		For Local obj:TFBObject = EachIn objects
			obj.Free()
		Next
		
		objects.Clear()
	End Method

End Type


Type TFBGenFactory

	Global firstId:Int
	Global lastId:Int


	Function CreateModel:TFBProject(obj:TFBObject, flags:Int)
	
		If obj.class = "Project" Then
		
			Local project:TFBProject = TFBProject(Make(Null, obj, flags))
			
			Return project
		
		End If
	
	End Function


	Function Make:TFBWidget(parent:TFBWidget, obj:TFBObject, flags:Int = 0)
	
		Local widget:TFBWidget
	
		Select obj.class
		
			Case "Project"
				widget = New TFBProject
			
			Case "Frame"
				widget = New TFBFrame

			Case "Dialog"
				widget = New TFBDialog

			Case "wxBoxSizer"
				widget = New TFBBoxSizer

			Case "wxGridSizer"
				widget = New TFBGridSizer

			Case "wxFlexGridSizer"
				widget = New TFBFlexGridSizer

			Case "sizeritem"
				widget = New TFBsizeritem

			Case "wxStaticBoxSizer"
				widget = New TFBStaticBoxSizer

			Case "wxListCtrl"
				widget = New TFBListCtrl

			Case "wxTextCtrl"
				widget = New TFBTextCtrl

			Case "wxButton"
				widget = New TFBButton

			Case "wxPanel", "Panel"
				widget = New TFBPanel

			Case "wxStaticText"
				widget = New TFBStaticText

			Case "wxComboBox"
				widget = New TFBComboBox
				
			Case "wxTreeCtrl"
				widget = New TFBTreeCtrl
		
			Case "wxStaticBitmap"
				widget = New TFBStaticBitmap
		
			Case "wxGauge"
				widget = New TFBGauge
		
			Case "wxSlider"
				widget = New TFBSlider
		
			Case "wxStaticLine"
				widget = New TFBStaticLine
		
			Case "wxRadioButton"
				widget = New TFBRadioButton
		
			Case "wxRadioBox"
				widget = New TFBRadioBox
		
			Case "wxCheckBox"
				widget = New TFBCheckBox
		
			Case "wxMenuBar"
				widget = New TFBMenuBar

			Case "wxMenu"
				widget = New TFBMenu

			Case "wxMenuItem"
				widget = New TFBMenuItem

			Case "submenu"
				widget = New TFBMenu

			Case "separator"
				widget = New TFBMenuSeparator

			Case "wxHtmlWindow"
				widget = New TFBHTMLWindow

			Case "wxCheckListBox"
				widget = New TFBCheckListBox

			Case "wxToggleButton"
				widget = New TFBToggleButton

			Case "wxListBox"
				widget = New TFBListBox

			Case "wxScrollBar"
				widget = New TFBScrollBar

			Case "wxSpinCtrl"
				widget = New TFBSpinCtrl
			
			Case "wxListbook"
				widget = New TFBListBook
			
			Case "listbookpage"
				widget = New TFBListBookPage
			
			Case "wxChoicebook"
				widget = New TFBChoicebook
			
			Case "choicebookpage"
				widget = New TFBChoiceBookPage
			
			Case "wxRichTextCtrl"
				widget = New TFBRichTextCtrl

			Case "wxNotebook"
				widget = New TFBNotebook
			
			Case "notebookpage"
				widget = New TFBNoteBookPage
			
			Case "wxFilePickerCtrl"
				widget = New TFBFilePickerCtrl
			
			Case "wxDirPickerCtrl"
				widget = New TFBDirPickerCtrl

			Case "wxStatusBar"
				widget = New TFBStatusBar

			Case "wxGenericDirCtrl"
				widget = New TFBGenericDirCtrl

			Case "wxScintilla"
				widget = New TFBScintilla

			Case "wxHyperlinkCtrl"
				widget = New TFBHyperlinkCtrl
				
			Case "wxBitmapButton"
				widget = New TFBBitmapButton

			Case "wxChoice"
				widget = New TFBChoice
				
			Case "wxDatePickerCtrl"
				widget = New TFBDatePickerCtrl
			
			Case "wxToolBar"
				widget = New TFBToolBar

			Case "tool"
				widget = New TFBToolItem

			Case "toolSeparator"
				widget = New TFBToolSeparator
				
			Case "wxStdDialogButtonSizer"
				widget = New TFBStdDialogButtonSizer

			Case "wxSplitterWindow"
				widget = New TFBSplitterWindow

			Case "splitteritem"
				widget = New TFBSplitterItem

		End Select
		
		If widget Then
			widget.obj = obj
			
			If TFBProject(widget) Then
				firstId = widget.prop("first_id").ToInt() - 1
				lastId = firstId
				TFBProject(widget).SetOpts(flags)
			End If
			
			' add the new widget to the parent
			If parent Then
				parent.kids.AddLast(widget)
				widget.parent = parent
				
				lastId = widget.Configure(lastId)
			End If
			
			' process any kids of this widget
			If obj.objects.count() > 0 Then
				For Local o:TFBObject = EachIn obj.objects
					Make(widget, o)
				Next
			End If
		
		End If
	
		Return widget
	End Function


End Type

Type TEventType

	Field name:String
	Field event:String
	Field constant:String
	Field extraImport:String
	
	Function Set:TEventType(name:String, event:String, constant:String, extraImport:String = "")
		Local this:TEventType = New TEventType
		this.name = name
		this.event = event
		this.constant = constant
		this.extraImport = extraImport
		Return this
	End Function
	
End Type

Function MapEvent:String(event:String)

	Local evt:TEventType = TEventType(eventMap.ValueForKey(event))
	
	If evt Then
		Return evt.event
	End If

	Return "EVENT_" + event + "_NOT_AVAILABLE"

End Function

Function MapEventConst:String(event:String)

	Local evt:TEventType = TEventType(eventMap.ValueForKey(event))
	
	If evt Then
		Return evt.constant
	End If
	
	Return "EVENT_" + event + "_NOT_AVAILABLE"

End Function

Function MapEventImport:String(event:String)

	Local evt:TEventType = TEventType(eventMap.ValueForKey(event))
	
	If evt Then
		Return evt.extraImport
	End If

	Return Null
End Function


' generates the position, size and style part, leaving out the particular section if it doesn't have a value.
Function DoPosSizeStyle:String(widget:TFBWidget, showIfEmpty:Int = False)

	Local text:String

	If widget.prop("pos") Then
		text:+ ", "
		text:+ widget.prop("pos")
	Else
		If widget.prop("size") Or widget.prop("style") Or widget.prop("window_style") Or showIfEmpty Then
			text:+ ",,"
		End If
	End If

	If widget.prop("size") Then
		text:+ ", "
		text:+ widget.prop("size")
	Else
		If widget.prop("style") Or widget.prop("window_style") Or showIfEmpty Then
			text:+ ",,"
		End If
	End If
	
	If widget.prop("style") Or widget.prop("window_style") Or showIfEmpty Then
		text:+ ", " + widget.WindowStyle()
	End If

	Return text
End Function

Function DoPosSize:String(widget:TFBWidget, showIfEmpty:Int = True)

	Local text:String

	If widget.prop("pos") Then
		text:+ ", "
		text:+ widget.prop("pos")
	Else
		If widget.prop("size") Or showIfEmpty Then
			text:+ ",,"
		End If
	End If

	If widget.prop("size") Then
		text:+ ", "
		text:+ widget.prop("size")
	Else
		If showIfEmpty Then
			text:+ ",,"
		End If
	End If
	
	Return text
End Function

Type TCodeOutput

	Field code:String

	Method Add(text:String, indent:Int = 0, newline:Int = 1)
	
		If indent Then
			For Local i:Int = 0 Until indent
				code:+ "~t"
			Next
		End If
		
		code:+ text
		
		If newline Then
			For Local i:Int = 0 Until newline
				code:+ "~n"
			Next
		End If
		
	End Method
	
	Method Reset()
		code = ""
	End Method

End Type

Type TFBWidget

	Global genFlags:Int

	Field parent:TFBWidget
	
	Field obj:TFBObject
	Field kids:TList = New TList
	
	Field id:Int = 0
	Global version:Float
	
	Method Free()
		parent = Null
		For Local kid:TFBWidget = EachIn kids
			kid.Free()
		Next
		kids.Clear()
		obj.Free()
		obj = Null
	End Method

	Method Generate(out:TCodeOutput) Abstract

	Method GenerateAppCode(out:TCodeOutput)
	End Method

	Method Configure:Int(lastId:Int)
		Local perm:String = String(prop("permission"))
		If perm And perm <> "none" Then
			Local form:TFBContainer = GetMainContainer()
			If form Then
				form.fields.AddLast(Self)
			End If
		End If
		
		If prop("id") Then
		
			If Not IsSpecialId(prop("id")) Then
				lastId :+ 1
				id = lastId
				
				Local form:TFBContainer = GetMainContainer()
				If form Then
					form.consts.AddLast(Self)
				End If
			End If
		
		End If
		
		AddImport()
		
		Return lastId
	End Method
	
	' returns True if my permissions are set. This determines whether I am Local or a Field of my parent
	Method HasPermissions:Int()
		Local perm:String = String(prop("permission"))
		Return perm = Null Or perm <> "none"
	End Method
	
	Method prop:String(name:String)
		Return String(obj.properties.ValueForKey(name))
	End Method

	Method event:String(name:String)
		Return String(obj.events.ValueForKey(name))
	End Method

	Method GetForm:TFBForm()
		If TFBForm(Self) Then
			Return TFBForm(Self)
		End If
		If parent Then
			Return parent.GetForm()
		End If
		Return Null
	End Method

	' retrieves the main container - this is my somewhere-parent who is a child of project
	Method GetMainContainer:TFBContainer()
		If parent And parent.IsMainContainer() Then
			Return TFBContainer(parent)
		End If
		Return parent.GetMainContainer()
	End Method

	Method GetParentContainer:TFBContainer()
		If TFBContainer(parent) Then
			Return TFBContainer(parent)
		End If
		Return parent.GetParentContainer()
	End Method
	
	' depending on the context of who owns me, return Self or my parent-container name.
	Method ContainerReference:String()
		Local container:TFBContainer = GetParentContainer()
		If container.IsMainContainer() Then
			Return "Self"
		Else
			Return container.prop("name")
		End If
	End Method

	' retrieves the project object - which should be one of my parents
	Method GetProject:TFBProject()
		If TFBProject(Self) Then
			Return TFBProject(Self)
		End If
		Return parent.GetProject()
	End Method

	Method AddImport()
		Local proj:TFBProject = GetProject()
		If proj Then

			Local imp:String = GetImport()
			If imp Then
				proj.imports.Insert(imp, "")
			End If
			
			If genflags & GEN_WXLOCALE Then
				proj.imports.Insert("wx.wxLocale", "")
			End If

			If genflags & GEN_BAHLOCALE Then
				proj.imports.Insert("BaH.Locale", "")
			End If
			
		End If
	End Method
	
	' is my parent the Project? - this means that I am like a wxFrame or custom panel or dialog
	Method IsMainContainer:Int()
		If parent And TFBProject(parent) Then
			Return True
		End If
	End Method
	
	Method IsDefault:Int(text:String)
		Return text = "-1,-1"
	End Method
	
	Method NameReference:String(name:String, noref:Int = False)
		If Not noref Then
			Return name + "."
		Else
			Return ""
		End If
	End Method
	
	Method DoColour:String(col:String)

		Local text:String = ""

		If col.Find("wx") >= 0 Then
			text:+ "wxSystemSettings.GetColour(" + col + ")"

			Local proj:TFBProject = GetProject()
			If proj Then
				proj.imports.Insert("wx.wxSystemSettings", "")
			End If
		Else
			text:+ "new wxColour.Create(" + col + ")"
		End If
		
		Return text
	
	End Method
	
	Method DoBitmap:String(bm:String)

		Local text:String = ""
		
		Local bitmap:String[] = bm.Split(";")
		text:+ "wxBitmap.CreateFromFile(~q" + bitmap[0] + "~q, "
		
		Local kind:String = bitmap[0].Split(".")[1].ToUpper()
		Select kind
			Case "PNG"
				text:+ "wxBITMAP_TYPE_PNG"
			Default
				text:+ "wxBITMAP_TYPE_ANY"
		End Select
		
		text:+ ")"
		
		Return text
	
	End Method
	
	' standard widget settings, like Enabled,  MinSize, MaxSize etc.
	Method StandardSettings(out:TCodeOutput, noref:Int = False)

		' Enable()
		If prop("enabled") And prop("enabled") <> "1" Then
			out.Add(NameReference(prop("name"), noref) + "Enable(False)", 2)
		End If
		
		' SetFont()
		Local font:String = prop("font")
		If font Then
			Local text:String = NameReference(prop("name"), noref) + "SetFont("
			text:+ "new wxFont.CreateWithAttribs("
			
			Local attribs:String[] = font.Split(",")
			
			If attribs[3] = "-1" Then
				text:+ "wxNORMAL_FONT().GetPointSize(), "
			Else
				text:+ attribs[3] + ", "
			End If
			
			text:+ attribs[4] + ", "
			text:+ attribs[1] + ", "
			text:+ attribs[2] + ", "
			
			If attribs[5] = "0" Then
				text:+ "False"
			Else
				text:+ "True"
			End If
			
			If attribs[0] Then
				text:+ ", ~q" + attribs[0] + "~q"
			End If
			
			text:+ "))"
			
			out.Add(text, 2)
		End If
		
		' SetForegroundColour()
		Local col:String = prop("fg")
		If col Then
			Local text:String = NameReference(prop("name"), noref) + "SetForegroundColour("
			
			text:+ DoColour(col)
			
			text:+ ")"
			
			out.Add( text, 2)
		End If

		' SetBackgroundColour()
		col = prop("bg")
		If col Then
			Local text:String = NameReference(prop("name"), noref) + "SetBackgroundColour("

			text:+ DoColour(col)
			
			text:+ ")"
			
			out.Add( text, 2)
		End If
		
		' extra_style?
		If prop("extra_style") Then
			out.Add(NameReference(prop("name"), noref) + "SetExtraStyle(" + prop("extra_style") + ")", 2)
		End If

		' SetExtraStyle()
		If prop("window_extra_style") Then
			out.Add(NameReference(prop("name"), noref) + "SetExtraStyle(" + prop("window_extra_style") + ")", 2)
		End If

		' Hide()
		If prop("hide") = "1" Then
			out.Add(NameReference(prop("name"), noref) + "Hide()", 2)
		End If
		
		' SetToolTip()
		If prop("tooltip") Then
			out.Add(NameReference(prop("name"), noref) + "SetToolTip(" + GetString("~q" + prop("tooltip") + "~q") + ")", 2)
		End If
		
		' SetHelpText()
		If prop("context_help") Then
			out.Add(NameReference(prop("name"), noref) + "SetHelpText(" + GetString("~q" + prop("context_help") + "~q") + ")", 2)
		End If

		' SetMinSize()
		If prop("minimum_size") And Not IsDefault(prop("minimum_size")) Then
			out.Add(NameReference(prop("name"), noref) + "SetMinSize(" + prop("minimum_size") + ")", 2)
		End If
	
		' SetMaxSize()
		If prop("maximum_size") And Not IsDefault(prop("maximum_size")) Then
			out.Add(NameReference(prop("name"), noref) + "SetMaxSize(" + prop("maximum_size") + ")", 2)
		End If

	End Method
	
	Method WindowStyle:String(def:String = "")
	
		Local text:String = def
		
		If prop("style") Then
			If def Then
				text:+ "|"
			End If
			text:+ prop("style")
		End If
		
		If prop("window_style") Then
			If def Or prop("style") Then
				text:+ "|"
			End If
			text:+ prop("window_style")
		End If
	
		Return text
	End Method

	Method StandardCreate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(True), 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)

	End Method
	
	Method StandardCreateWithLabel(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(True), 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "

		text:+ GetString("~q" + prop("label") + "~q")
		
		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)

	End Method
	
	Method MakeChoices:String(text:String)
	
		Local s:String = text.Replace("\'", "'")
		s = s.Replace("\\", "\")
		s = s.Replace("\~q", "~~q")
		s = s.Replace("\t", "~~t")
		s = s.Replace("\r", "~~r")
		
		Local tok:TStringTokenizer

		' 1.9 uses ", <1.9 uses '
		If version < 1.9 Then
			tok = New TStringTokenizer.Create(s, "'")
		Else
			tok = New TStringTokenizer.Create(s, "~q")
		End If
	
		Local str:String
		
		While tok.HasMoreTokens()
			If str Then
				str:+ ", "
			End If
		
			str:+ "~q" + tok.GetNextToken() + "~q"
		Wend
		
		Return str
	End Method
	
	Method IsSpecialId:Int(text:String)
		If text.StartsWith("wxID_") Then
			Return True
		End If
		
		Return False
	End Method
	
	Method IsEmptyQuotes:Int(text:String)
		Return text = "~q~q"
	End Method
	
	Method GetString:String(text:String, noLocale:Int = False)
		text = text.Replace("~r", "")
		text = text.Replace("~n", "~~n")
		text = text.Replace("~t", "~~t")
		If Not noLocale Then
			If genflags & GEN_WXLOCALE And Not IsEmptyQuotes(text) Then
				text = "_(" + text + ")"
			End If
			If genflags & GEN_BAHLOCALE And Not IsEmptyQuotes(text) Then
				text = "GetLocaleText(" + text + ")"
			End If
		End If
		Return text
	End Method
	
	Method GetType:String(def:Int = False) Abstract
	Method GetImport:String() Abstract

	Method GetFullType:String(name:String, def:Int = False)
		If prop("subclass") Then
			Local s:String = prop("subclass").split(";")[0]
			If s Then
				If def And s.StartsWith("T") Then
					Return s + "Base"
				Else
					Return s
				End If
			End If
		End If
		Return name
	End Method
	
	Method GetFullImport:String(name:String)
		If prop("subclass") Then
			Local s:String = prop("subclass").split(";")[1].Trim()
			If s Then
				If s.find(".bmx") >= 0 Then
					Return "~q" + s + "~q"
				Else
					Return s
				End If
			End If
		End If
		Return name
	End Method
	
End Type

Type TFBProject Extends TFBWidget

	Field generatedName:String

	Field imports:TMap = New TMap
	
	Method Free()
		Super.Free()
		
		imports.Clear()
	End Method
	
	Method SetOpts(flags:Int)
		genflags = flags
	End Method

	Method Generate(out:TCodeOutput)
	
		out.Add(GeneratedNotice())
	
		If genflags & GEN_SUPER Then
			out.Add("SuperStrict",,2)
		End If
		
		If genflags & GEN_IMPORTS Then
			' imports !
			For Local imp:String = EachIn imports.keys()
				out.Add("Import " + imp)
			Next
		End If
		
		' some space...
		out.Add("",,2)
		
		' our forms and things
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method
	
	Method GenerateAppCode(out:TCodeOutput)
	
		out.Add("'")
		out.Add("' Example application stub generated by wxCodeGen v" + AppVersion + " : " + CurrentDate() + " " + CurrentTime())
		out.Add("'")
		out.Add("SuperStrict",,2)
		out.Add("Framework wx.wxApp",,2)

		' filename of the generated code
		out.Add("Import ~q" + generatedName + ".bmx~q",,2)

		out.Add("New MyApp.run()",,2)
		out.Add("Type MyApp Extends wxApp",,2)

		out.Add("Method OnInit:Int()",1,2)

		out.Add("' Add frame creation code here",2,2)
	
		out.Add("Return True",2)
	
		out.Add("End Method",1,2)

		out.Add("End Type",,4)


		' our forms and things
		For Local child:TFBWidget = EachIn kids
			child.GenerateAppCode(out)
		Next

	End Method

	Method GetType:String(def:Int = False)
	End Method
	
	Method GetImport:String()
	End Method

End Type

Type TFBContainer Extends TFBWidget

	Field fields:TList = New TList

	Field consts:TList = New TList
	
	Field functions:TMap = New TMap
	
	Method Free()
		Super.Free()
		
		fields.Clear()
		consts.Clear()
	End Method

	Method Generate(out:TCodeOutput)
	
		' reset the functions map
		functions.Clear()
	
		Local topSizer:TFBWidget
		
		out.Add("Type " + prop("name") + "Base Extends " + GetType(), ,2)
		
		' fields
		For Local fld:TFBWidget = EachIn fields
			out.Add("Field " + fld.prop("name") + ":" + fld.GetType(True), 1)
		Next
		
		out.Add("")

		' consts
		For Local fld:TFBWidget = EachIn consts
			out.Add("Const " + fld.prop("id") + ":Int = " + fld.id, 1)
		Next

		out.Add("")

		' constructor
		DoConstructor(out)
		
		' OnInit() - variable init etc
		out.Add("Method OnInit()", 1)
		
		StandardSettings(out, True)
		
		For Local child:TFBWidget = EachIn kids
		
			If Not topSizer Then
				If TFBSizer(child) Then
					topSizer = child
				End If
			End If
			
			child.Generate(out)
		Next
		
		' the main sizer
		If topSizer Then
			out.Add("SetSizer(" + topSizer.prop("name") + ")", 2)
		End If
		
		' layout
		out.Add("Layout()", 2)
		
		' no default size? then we must fit to controls
		If (Not prop("size") Or prop("size") = "-1,-1") And topSizer Then
			out.add(topSizer.prop("name") + ".Fit(Self)", 2)
		End If
		
		If prop("center") Then
			out.Add("Center(" + prop("center") + ")", 2)
		End If
		
		ConnectEvents(out)
		
		out.Add("End Method", 1, 2)
		
		' event functions
		EventFunctions(out)
		
		out.Add("End Type", , 2)
		
	End Method

	Method GenerateAppCode(out:TCodeOutput)
	
		out.Add("Type " + prop("name") + " Extends " + prop("name") + "Base", ,2)


		' OnInit() - variable init etc
		out.Add("Method OnInit()", 1)
		out.Add("Super.OnInit()", 2, 2)
		out.Add("' Add own initialisation code here", 2, 2)
		out.Add("End Method", 1, 2)
		
		' event functions
		EventFunctions(out, True)
		
		out.Add("End Type", , 2)
		
	End Method
	
	Method DoConstructor(out:TCodeOutput)
	End Method
	
	Method ConnectEvents(out:TCodeOutput)
	
		out.Add("")
	
		' my events
		For Local evt:String = EachIn obj.events.keys()
		
			Local event:String =  String(obj.events.ValueForKey(evt))
			Local ec:String = MapEventConst(evt)
			out.Add("ConnectAny(" + ec + ", _" + event + ")", 2)
		
			ec = MapEventImport(evt)
			If ec Then
				GetProject().imports.Insert(ec, "")
			End If
		Next
	
		' child events
		For Local child:TFBWidget = EachIn kids
			ChildConnectEvents(child, out)
		Next
	
	End Method

	Method EventFunctions(out:TCodeOutput, forAppCode:Int = False)
	
		Local text:String
	
		' my events
		For Local evt:String = EachIn obj.events.keys()
		
			If Not functions.Contains(event(evt)) Then

				functions.Insert(event(evt), "")		

				If Not forAppCode Then
					out.Add("Function _" + event(evt) + "(event:wxEvent)", 1)
					
					text = prop("name") + "Base(event.parent)." + event(evt) + "(" + MapEvent(evt) + "(event))"
					out.Add(text, 2, 1)
					
					out.Add("End Function", 1, 2)
				End If
				
				out.Add("Method " + event(evt) + "(event:" + MapEvent(evt) + ")", 1)
				If Not forAppCode Then
					out.Add("DebugLog ~qPlease override " + prop("name") + "." + event(evt) + "()~q", 2)
					out.Add("event.Skip()", 2)
				Else
					out.Add("' TODO : Implement me", 2)
				End If
				out.Add("End Method", 1, 2)
			End If
		Next
		
		' child events
		For Local child:TFBWidget = EachIn kids
			ChildEventFunctions(child, out, forAppCode)
		Next
	
	End Method

	Method ChildEventFunctions(widget:TFBWidget, out:TCodeOutput, forAppCode:Int = False)
	
		Local text:String
	
		' my events
		For Local evt:String = EachIn widget.obj.events.keys()

			If Not functions.Contains(widget.event(evt)) Then

				functions.Insert(widget.event(evt), "")		
		
				If Not forAppCode Then
					out.Add("Function _" + widget.event(evt) + "(event:wxEvent)", 1)
					
					text = prop("name") + "Base(event."
					
					If Not widget.id Then
						text:+ "sink"
					Else
						text:+ "parent"
					End If
					
					text:+ ")." + widget.event(evt) + "(" + MapEvent(evt) + "(event))"
					out.Add(text, 2, 1)
					
					out.Add("End Function", 1, 2)
				End If
			
				out.Add("Method " + widget.event(evt) + "(event:" + MapEvent(evt) + ")", 1)
				If Not forAppCode Then
					out.Add("DebugLog ~qPlease override " + prop("name") + "." + widget.event(evt) + "()~q", 2)
					out.Add("event.Skip()", 2)
				Else
					out.Add("' TODO : Implement me", 2)
				End If
				out.Add("End Method", 1, 2)
		
			End If
		Next

		For Local child:TFBWidget = EachIn widget.kids
			ChildEventFunctions(child, out, forAppCode)
		Next
	
	End Method
	
	Method ChildConnectEvents(widget:TFBWidget, out:TCodeOutput)

		For Local evt:String = EachIn widget.obj.events.keys()

			Local event:String =  widget.event(evt)
			Local ec:String = MapEventConst(evt)
	
			' special connect for menu items...
			If TFBMenuItem(widget) Then
				out.Add("Connect(" + widget.prop("name") + ".GetId(), " + ec + ", _" + event + ")", 2)
			Else
				If Not widget.id And Not TFBToolItem(widget) Then
					If Not TFBStdDialogButtonSizer(widget) Then
						out.Add(widget.prop("name") + ".ConnectAny(" + ec + ", _" + event + ", Null, Self)", 2)
					Else
						TFBStdDialogButtonSizer(widget).ConnectEvent(out, evt, ec, event)
					End If
				Else
					out.Add("Connect(" + widget.prop("id") + ", " + ec + ", _" + event + ")", 2)
				End If
			End If

			ec = MapEventImport(evt)
			If ec Then
				GetProject().imports.Insert(ec, "")
			End If
		Next
		
		For Local child:TFBWidget = EachIn widget.kids
			ChildConnectEvents(child, out)
		Next

	End Method

End Type

Type TFBForm Extends TFBContainer 

End Type

Type TFBFrame Extends TFBForm

	Method Generate(out:TCodeOutput)
		Super.Generate(out)
	End Method

	Method DoConstructor(out:TCodeOutput)
		Local text:String = "Method Create:" + prop("name") + "Base(parent:wxWindow = Null,"
		text:+ "id:Int = "
		If prop("id") Then
			text:+ prop("id")
		Else
			text:+ "-1"
		End If
		
		text:+ ", title:String = ~q"
		If prop("title") Then
			text:+ prop("title")
		End If
		
		text:+ "~q, "
		
		If Not prop("pos") Then
			text:+ "x:Int = -1, y:Int = -1, "
		Else
			Local pos:String[] = prop("pos").Split(",")
			text:+ "x:Int = " + pos[0] + ", y:Int = " + pos[1] + ", "
		End If
			
		If Not prop("size") Then
			text:+ "w:Int = -1, h:Int = -1, "
		Else
			Local size:String[] = prop("size").Split(",")
			text:+ "w:Int = " + size[0] + ", h:Int = " + size[1] + ", "
		End If
		
		If Not prop("style") Then
			text:+ "style:Int = " + WindowStyle("wxDEFAULT_FRAME_STYLE")
		Else
			text:+ "style:Int = " + WindowStyle()
		End If
		
		text:+")"
		out.Add(text, 1)
		out.Add("return " + prop("name") + "Base(Super.Create(parent, id, title, x, y, w, h, style))", 2)
		out.Add("End Method", 1, 2)
	End Method

	Method GetType:String(def:Int = False)
		Return "wxFrame"
	End Method

	Method GetImport:String()
		Return "wx.wxFrame"
	End Method

End Type

Type TFBListCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new wxListCtrl.Create(" + ContainerReference() + ", " + prop("id")

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxListCtrl"
	End Method

	Method GetImport:String()
		Return "wx.wxListCtrl"
	End Method

End Type

Type TFBPanel Extends TFBContainer

	Method Generate(out:TCodeOutput)
	
		If IsMainContainer() Then
			Super.Generate(out)
		Else
		
			Local topSizer:TFBWidget
	
			StandardCreate(out)

			StandardSettings(out)
	
			' our forms and things
			For Local child:TFBWidget = EachIn kids
	
				If Not topSizer Then
					If TFBSizer(child) Then
						topSizer = child
					End If
				End If
	
				child.Generate(out)
			Next
	
			' the main sizer
			If topSizer Then
				out.Add(prop("name") + ".SetSizer(" + topSizer.prop("name") + ")", 2)
			End If
			
			' layout
			out.Add(prop("name") + ".Layout()", 2)
		End If
	End Method

	Method DoConstructor(out:TCodeOutput)
		Local text:String = "Method Create:" + prop("name") + "Base(parent:wxWindow = Null,"
		text:+ "id:Int = "
		If prop("id") Then
			text:+ prop("id")
		Else
			text:+ "-1"
		End If
		
		text:+ ", "
		
		If Not prop("pos") Then
			text:+ "x:Int = -1, y:Int = -1, "
		Else
			Local pos:String[] = prop("pos").Split(",")
			text:+ "x:Int = " + pos[0] + ", y:Int = " + pos[1] + ", "
		End If
			
		If Not prop("size") Then
			text:+ "w:Int = -1, h:Int = -1, "
		Else
			Local size:String[] = prop("size").Split(",")
			text:+ "w:Int = " + size[0] + ", h:Int = " + size[1] + ", "
		End If
		
		If Not prop("style") Then
			text:+ "style:Int = wxTAB_TRAVERSAL"
		Else
			text:+ "style:Int = " + prop("style")
		End If
		
		text:+")"
		out.Add(text, 1)
		out.Add("return " + prop("name") + "Base(Super.Create(parent, id, x, y, w, h, style))", 2)
		out.Add("End Method", 1, 2)
	End Method

	Method GetType:String(def:Int = False)
		Return GetFullType("wxPanel")
	End Method

	Method GetImport:String()
		Return GetFullImport("wx.wxPanel")
	End Method

End Type

Type TFBDialog Extends TFBContainer

	Method Generate(out:TCodeOutput)
	
		If IsMainContainer() Then
			Super.Generate(out)
		Else
		
			Local topSizer:TFBWidget
	
			StandardCreate(out)

			StandardSettings(out)
	
			' our forms and things
			For Local child:TFBWidget = EachIn kids
	
				If Not topSizer Then
					If TFBSizer(child) Then
						topSizer = child
					End If
				End If
	
				child.Generate(out)
			Next
	
			' the main sizer
			If topSizer Then
				out.Add(prop("name") + ".SetSizer(" + topSizer.prop("name") + ")", 2)
			End If
			
			' layout
			out.Add(prop("name") + ".Layout()", 2)
		End If
	End Method


	Method DoConstructor(out:TCodeOutput)
		Local text:String = "Method Create_:" + prop("name") + "Base(parent:wxWindow = Null, "
		text:+ "id:Int = "
		If prop("id") Then
			text:+ prop("id")
		Else
			text:+ "-1"
		End If
		
		text:+ ", title:String = ~q"
		If prop("title") Then
			text:+ prop("title")
		End If

		text:+ "~q, "
		
		If Not prop("pos") Then
			text:+ "x:Int = -1, y:Int = -1, "
		Else
			Local pos:String[] = prop("pos").Split(",")
			text:+ "x:Int = " + pos[0] + ", y:Int = " + pos[1] + ", "
		End If
			
		If Not prop("size") Then
			text:+ "w:Int = -1, h:Int = -1, "
		Else
			Local size:String[] = prop("size").Split(",")
			text:+ "w:Int = " + size[0] + ", h:Int = " + size[1] + ", "
		End If
		
		If Not prop("style") Then
			text:+ "style:Int = 0"
		Else
			text:+ "style:Int = " + prop("style")
		End If
		
		text:+")"
		out.Add(text, 1)
		out.Add("return " + prop("name") + "Base(Super.Create_(parent, id, title, x, y, w, h, style))", 2)
		out.Add("End Method", 1, 2)
	End Method

	Method GetType:String(def:Int = False)
		Return "wxDialog"
	End Method

	Method GetImport:String()
		Return "wx.wxDialog"
	End Method

End Type

Type TFBButton Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreateWithLabel(out)

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxButton"
	End Method

	Method GetImport:String()
		Return "wx.wxButton"
	End Method

End Type

Type TFBTextCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxTextCtrl.Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("value") + "~q")

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)
		
		If prop("maxlength") Then
			out.Add(prop("name") + ".SetMaxLength(" + prop("maxlength") + ")", 2) 
		End If

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxTextCtrl"
	End Method

	Method GetImport:String()
		Return "wx.wxTextCtrl"
	End Method

End Type

Type TFBStaticBitmap Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxStaticBitmap.Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		If prop("bitmap") Then
			text:+ DoBitmap(prop("bitmap"))
		Else
			text:+ "wxNullBitmap"
		End If

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)
		
		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxStaticBitmap"
	End Method

	Method GetImport:String()
		Return "wx.wxStaticBitmap"
	End Method

End Type

Type TFBStaticText Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreateWithLabel(out)

		Local wrap:String = prop("wrap")
		If wrap Then
			out.Add(prop("name") + ".Wrap(" + wrap + ")", 2)
		End If

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxStaticText"
	End Method

	Method GetImport:String()
		Return "wx.wxStaticText"
	End Method
	
End Type

Type TFBComboBox Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		If prop("choices") Then
			out.Add("Local " + prop("name") + "Choices:String[] = [ " + MakeChoices(prop("choices")) + " ]", 2)
		End If

		Local text:String = prop("name") + " = new wxComboBox.Create(" + ContainerReference() + ", " + prop("id") + ", "

		text:+ GetString("~q" + prop("value") + "~q")
		
		' choices
		If prop("choices") Then
			text:+ ", " + prop("name") + "Choices"
		Else
			text:+ ", Null"
		End If

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxComboBox"
	End Method

	Method GetImport:String()
		Return "wx.wxComboBox"
	End Method

End Type

Type TFBTreeCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new wxTreeCtrl.Create(" + ContainerReference() + ", " + prop("id")

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxTreeCtrl"
	End Method

	Method GetImport:String()
		Return "wx.wxTreeCtrl"
	End Method

End Type

Type TFBGauge Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ prop("range")

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		If prop("value") Then
			out.Add(prop("name") + ".SetValue(" + prop("value") + ")", 2)
		End If

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxGauge"
	End Method

	Method GetImport:String()
		Return "wx.wxGauge"
	End Method

End Type

Type TFBSlider Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxSlider.Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ prop("value") + ", " + prop("minValue") + ", " + prop("maxValue")

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxSlider"
	End Method

	Method GetImport:String()
		Return "wx.wxSlider"
	End Method

End Type

Type TFBStaticLine Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreate(out)

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxStaticLine"
	End Method

	Method GetImport:String()
		Return "wx.wxStaticLine"
	End Method

End Type

Type TFBRadioButton Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreateWithLabel(out)
		
		If prop("value") = "1" Then
			out.Add(prop("name") + ".SetValue(True)", 2)
		End If

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxRadioButton"
	End Method

	Method GetImport:String()
		Return "wx.wxRadioButton"
	End Method

End Type

Type TFBRadioBox Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		If prop("choices") Then
			out.Add("Local " + prop("name") + "Choices:String[] = [ " + MakeChoices(prop("choices")) + " ]", 2)
		End If

		Local text:String = prop("name") + " = new wxRadioBox.Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("label") + "~q")

		text:+ DoPosSize(Self)
		
		If prop("choices") Then
			text:+ ", " + prop("name") + "Choices, "
		Else
			text:+ ", Null ,"	
		End If

		text:+ prop("majorDimension") + ", " + prop("style")
		
		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxRadioBox"
	End Method

	Method GetImport:String()
		Return "wx.wxRadioBox"
	End Method

End Type

Type TFBCheckBox Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreateWithLabel(out)
		
		If prop("checked") = "1" Then
			out.Add(prop("name") + ".SetValue(True)", 2)
		End If

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxCheckBox"
	End Method

	Method GetImport:String()
		Return "wx.wxCheckBox"
	End Method

End Type

Type TFBHTMLWindow Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreate(out)

		StandardSettings(out)

	End Method

	Method GetType:String(def:Int = False)
		Return "wxHtmlWindow"
	End Method

	
	Method GetImport:String()
		Return "wx.wxHtmlWindow"
	End Method

End Type

Type TFBCheckListBox Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		If prop("choices") Then
			out.Add("Local " + prop("name") + "Choices:String[] = [ " + MakeChoices(prop("choices")) + " ]", 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")

		' choices
		If prop("choices") Then
			text:+ ", " + prop("name") + "Choices"
		Else
			text:+ ", Null"
		End If

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)
		
		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxCheckListBox"
	End Method

	
	Method GetImport:String()
		Return "wx.wxCheckListBox"
	End Method

End Type

Type TFBToggleButton Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreateWithLabel(out)

		If prop("value") = "1" Then
			out.Add(prop("name") + ".SetValue(True)", 2)
		End If

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxToggleButton"
	End Method

	
	Method GetImport:String()
		Return "wx.wxToggleButton"
	End Method

End Type

Type TFBScrollBar Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreate(out)

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxScrollBar"
	End Method

	
	Method GetImport:String()
		Return "wx.wxScrollBar"
	End Method

End Type

Type TFBSpinCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "

		text:+ GetString("~q" + prop("value") + "~q")
		

		text:+ DoPosSizeStyle(Self, True)
		
		text:+ ", " + prop("min")
		text:+ ", " + prop("max")
		text:+ ", " + prop("initial")

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxSpinCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxSpinCtrl"
	End Method

End Type


Type TFBListBook Extends TFBWidget

	Method Generate(out:TCodeOutput)

		' TODO 

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxListBook"
	End Method

	
	Method GetImport:String()
		Return "wx.wxListBook"
	End Method

End Type

Type TFBListBookPage Extends TFBWidget

	Method Generate(out:TCodeOutput)

		' TODO 

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxSpinCtrl"
	End Method

End Type

Type TFBChoicebook Extends TFBWidget

	Method Generate(out:TCodeOutput)

		' TODO 

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxChoicebook"
	End Method

	
	Method GetImport:String()
		Return "wx.wxChoicebook"
	End Method

End Type

Type TFBChoicebookPage Extends TFBWidget

	Method Generate(out:TCodeOutput)

		' TODO 

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxChoicebook"
	End Method

End Type

Type TFBRichTextCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		' TODO 

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxRichTextCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxRichTextCtrl"
	End Method

End Type


Type TFBNotebook Extends TFBContainer

	Method Generate(out:TCodeOutput)

		StandardCreate(out)

		StandardSettings(out)
 
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return GetFullType("wxNotebook")
	End Method

	
	Method GetImport:String()
		Return GetFullImport("wx.wxNotebook")
	End Method

End Type

Type TFBNotebookPage Extends TFBWidget

	Method Generate(out:TCodeOutput)

		For Local child:TFBWidget = EachIn kids
			child.Generate(out)


			Local text:String = parent.prop("name")
			text:+ ".AddPage(" + child.prop("name") + ", "
			
			text:+ GetString("~q" + prop("label") + "~q") + ", "
			
			If prop("select") = "1" Then
				text:+ "True"
			Else
				text:+ "False"
			End If
			
			text:+ ")"
			
			out.Add(text, 2)
		Next

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxNotebook"
	End Method

End Type

Type TFBFilePickerCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("value") + "~q") + ", "
		text:+ GetString("~q" + prop("message") + "~q") + ", "
		text:+ GetString("~q" + prop("wildcard") + "~q")
		
		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxFilePickerCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxFilePickerCtrl"
	End Method

End Type

Type TFBDirPickerCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("value") + "~q") + ", "
		text:+ GetString("~q" + prop("message") + "~q")

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxDirPickerCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxFilePickerCtrl"
	End Method

End Type

Type TFBStatusBar Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = " + ContainerReference() + ".CreateStatusBar(" 
		text:+ prop("fields") + ", " 
		text:+ WindowStyle("0") + ", "
		text:+ prop("id") + ")"

		out.Add(text, 2)
		
		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxStatusBar"
	End Method

	
	Method GetImport:String()
		Return "wx.wxStatusBar"
	End Method

End Type

Type TFBListBox Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		If prop("choices") Then
			out.Add("Local " + prop("name") + "Choices:String[] = [ " + MakeChoices(prop("choices")) + " ]", 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")

		' choices
		If prop("choices") Then
			text:+ ", " + prop("name") + "Choices"
		Else
			text:+ ", Null"
		End If

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxListBox"
	End Method

	
	Method GetImport:String()
		Return "wx.wxListBox"
	End Method

End Type

Type TFBGenericDirCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("defaultfolder") + "~q")
		
		text:+ DoPosSizeStyle(Self) + ", "
		
		text:+ GetString("~q" + prop("filter") + "~q") + ", "
		text:+ prop("defaultfilter")

		text:+ ")"
		
		out.Add(text, 2)

		text = prop("name") + ".ShowHidden("
		
		If prop("show_hidden") = "1" Then
			text:+ "True)"
		Else
			text:+ "False)"
		End If

		out.Add(text, 2)
	

		StandardSettings(out)
			
		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxGenericDirCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxGenericDirCtrl"
	End Method

End Type


Type TFBScintilla Extends TFBWidget

	Method Generate(out:TCodeOutput)

		StandardCreate(out)
		
		out.Add("")

		If prop("use_tabs") = "1" Then
			out.Add(prop("name") + ".SetUseTabs( True )", 2)
		Else
			out.Add(prop("name") + ".SetUseTabs( False )", 2)
		End If
		
		out.Add(prop("name") + ".SetTabWidth( " + prop("tab_width") + " )", 2)
		out.Add(prop("name") + ".SetIndent( " + prop("tab_width") + " )", 2)
		
		If prop("tab_indents") = "1" Then
			out.Add(prop("name") + ".SetTabIndents( True )", 2)
		Else
			out.Add(prop("name") + ".SetTabIndents( False )", 2)
		End If
		
		If prop("backspace_unindents") = "1" Then
			out.Add(prop("name") + ".SetBackSpaceUnIndents( True )", 2)
		Else
			out.Add(prop("name") + ".SetBackSpaceUnIndents( False )", 2)
		End If
		
		If prop("view_eol") = "1" Then
			out.Add(prop("name") + ".SetViewEOL( True )", 2)
		Else
			out.Add(prop("name") + ".SetViewEOL( False )", 2)
		End If
		
		If prop("view_whitespace") = "1" Then
			out.Add(prop("name") + ".SetViewWhiteSpace( True )", 2)
		Else
			out.Add(prop("name") + ".SetViewWhiteSpace( False )", 2)
		End If
		
		out.Add(prop("name") + ".SetMarginWidth( 2, 0 )", 2)
		
		If prop("indentation_guides") = "1" Then
			out.Add(prop("name") + ".SetIndentationGuides( True )", 2)
		Else
			out.Add(prop("name") + ".SetIndentationGuides( False )", 2)
		End If
		
		If prop("folding") = "1" Then
			out.Add(prop("name") + ".SetMarginType( 1, wxSCI_MARGIN_SYMBOL )", 2)
			out.Add(prop("name") + ".SetMarginMask( 1, wxSCI_MASK_FOLDERS )", 2)
			out.Add(prop("name") + ".SetMarginWidth( 1, 16)", 2)
			out.Add(prop("name") + ".SetMarginSensitive( 1, True )", 2)
			out.Add(prop("name") + ".SetProperty( ~qfold~q), ~q1~q )", 2)
			out.Add(prop("name") + ".SetFoldFlags( wxSCI_FOLDFLAG_LINEBEFORE_CONTRACTED | wxSCI_FOLDFLAG_LINEAFTER_CONTRACTED )", 2)
		Else
			out.Add(prop("name") + ".SetMarginWidth( 1, 0 )", 2)
		End If
	
		If prop("line_numbers") = "1" Then
			out.Add(prop("name") + ".SetMarginType( 0, wxSCI_MARGIN_NUMBER )", 2)
			out.Add(prop("name") + ".SetMarginWidth( 0, " + prop("name") + ".TextWidth( wxSCI_STYLE_LINENUMBER, ~q_99999~q ) )", 2)
		Else
			out.Add(prop("name") + ".SetMarginWidth( 0, 0 )", 2)
		End If
	
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDER, wxSCI_MARK_BOXPLUS )", 2)
		out.Add(prop("name") + ".MarkerSetBackground( wxSCI_MARKNUM_FOLDER, new wxColour.CreateNamedColour( ~qBLACK~q ) )", 2)
		out.Add(prop("name") + ".MarkerSetForeground( wxSCI_MARKNUM_FOLDER, new wxColour.CreateNamedColour( ~qWHITE~q ) )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDEROPEN, wxSCI_MARK_BOXMINUS )", 2)
		out.Add(prop("name") + ".MarkerSetBackground( wxSCI_MARKNUM_FOLDEROPEN, new wxColour.CreateNamedColour( ~qBLACK~q ) )", 2)
		out.Add(prop("name") + ".MarkerSetForeground( wxSCI_MARKNUM_FOLDEROPEN, new wxColour.CreateNamedColour( ~qWHITE~q ) )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDERSUB, wxSCI_MARK_EMPTY )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDEREND, wxSCI_MARK_BOXPLUS )", 2)
		out.Add(prop("name") + ".MarkerSetBackground( wxSCI_MARKNUM_FOLDEREND, new wxColour.CreateNamedColour( ~qBLACK~q ) )", 2)
		out.Add(prop("name") + ".MarkerSetForeground( wxSCI_MARKNUM_FOLDEREND, new wxColour.CreateNamedColour( ~qWHITE~q ) )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDEROPENMID, wxSCI_MARK_BOXMINUS )", 2)
		out.Add(prop("name") + ".MarkerSetBackground( wxSCI_MARKNUM_FOLDEROPENMID, new wxColour.CreateNamedColour( ~qBLACK~q ) )", 2)
		out.Add(prop("name") + ".MarkerSetForeground( wxSCI_MARKNUM_FOLDEROPENMID, new wxColour.CreateNamedColour( ~qWHITE~q ) )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDERMIDTAIL, wxSCI_MARK_EMPTY )", 2)
		out.Add(prop("name") + ".MarkerDefine( wxSCI_MARKNUM_FOLDERTAIL, wxSCI_MARK_EMPTY )", 2)
		out.Add(prop("name") + ".SetSelBackground( true, wxSystemSettings.GetColour( wxSYS_COLOUR_HIGHLIGHT ) )", 2)
		out.Add(prop("name") + ".SetSelForeground( true, wxSystemSettings.GetColour( wxSYS_COLOUR_HIGHLIGHTTEXT ) )", 2)
	
		Local proj:TFBProject = GetProject()
		If proj Then
			proj.imports.Insert("wx.wxSystemSettings", "")
		End If
	
		StandardSettings(out)
			
		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxScintilla"
	End Method

	
	Method GetImport:String()
		Return "wx.wxScintilla"
	End Method

End Type

Type TFBHyperlinkCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		text:+ GetString("~q" + prop("label") + "~q") + ", "
		text:+ GetString("~q" + prop("url") + "~q", True)
		
		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		If prop("hover_color") Then
			out.Add(prop("name") + ".SetHoverColour(" + DoColour(prop("hover_color")) + ")", 2)
		End If

		If prop("normal_color") Then
			out.Add(prop("name") + ".SetNormalColour(" + DoColour(prop("normal_color")) + ")", 2)
		End If

		If prop("visited_color") Then
			out.Add(prop("name") + ".SetVisitedColour(" + DoColour(prop("visited_color")) + ")", 2)
		End If

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxHyperlinkCtrl"
	End Method

	Method GetImport:String()
		Return "wx.wxHyperlinkCtrl"
	End Method

End Type

Type TFBBitmapButton Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		If prop("bitmap") Then
			text:+ DoBitmap(prop("bitmap"))
		Else
			text:+ "wxNullBitmap"
		End If
		
		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		If prop("disabled") Then
			out.Add(prop("name") + ".SetBitmapDisabled(" + DoBitmap(prop("disabled")) + ")", 2)
		End If

		If prop("selected") Then
			out.Add(prop("name") + ".SetBitmapSelected(" + DoBitmap(prop("selected")) + ")", 2)
		End If

		If prop("focus") Then
			out.Add(prop("name") + ".SetBitmapFocus(" + DoBitmap(prop("focus")) + ")", 2)
		End If

		If prop("hover") Then
			out.Add(prop("name") + ".SetBitmapHover(" + DoBitmap(prop("hover")) + ")", 2)
		End If

		StandardSettings(out)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxBitmapButton"
	End Method

	Method GetImport:String()
		Return "wx.wxBitmapButton"
	End Method

End Type

Type TFBChoice Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		If prop("choices") Then
			out.Add("Local " + prop("name") + "Choices:String[] = [ " + MakeChoices(prop("choices")) + " ]", 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")

		' choices
		If prop("choices") Then
			text:+ ", " + prop("name") + "Choices"
		Else
			text:+ ", Null"
		End If

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)
		
		If prop("selection") Then
			out.Add(prop("name") + ".SetSelection(" + prop("selection") + ")", 2)
		End If
		

		StandardSettings(out)
		
		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxChoice"
	End Method

	
	Method GetImport:String()
		Return "wx.wxChoice"
	End Method

End Type

Type TFBDatePickerCtrl Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id") + ", "
		
		' default datetime
		text:+ "Null"

		text:+ DoPosSizeStyle(Self)

		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxDatePickerCtrl"
	End Method

	
	Method GetImport:String()
		Return "wx.wxDatePickerCtrl"
	End Method

End Type

Type TFBToolBar Extends TFBWidget

	Method Generate(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
		Local text:String = prop("name") + " = "
		
		If GetForm()
			text:+ "CreateToolBar("
			text:+ prop("style") + ", " + prop("id") + ")"
		Else
			text:+ " new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")
	
			text:+ DoPosSizeStyle(Self)
	
			text:+ ")"
		End If
		
		out.Add(text, 2)
		
		If prop("bitmapsize") And Not IsDefault(prop("bitmapsize")) Then
			out.Add(prop("name") + ".SetToolBitmapSize(" + prop("bitmapsize") + ")", 2)
		End If

		If prop("margins") And Not IsDefault(prop("margins")) Then
			out.Add(prop("name") + ".SetMargins(" + prop("margins") + ")", 2)
		End If
		
		If prop("packing") <> "1" Then
			out.Add(prop("name") + ".SetToolPacking(" + prop("packing") + ")", 2)
		End If

		If prop("separation") <> "5" Then
			out.Add(prop("name") + ".SetToolSeparation(" + prop("separation") + ")", 2)
		End If

		StandardSettings(out)

		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
		out.Add(prop("name") + ".Realize()",2)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxToolBar"
	End Method
	
	Method GetImport:String()
		Return "wx.wxToolBar"
	End Method

End Type

Type TFBToolItem Extends TFBWidget

	Method Generate(out:TCodeOutput)

		Local text:String = parent.prop("name")
		text:+ ".AddTool(" + prop("id") + ", "

		text:+ GetString("~q" + prop("label") + "~q") + ", "

		If prop("bitmap") Then
			text:+ DoBitmap(prop("bitmap"))
		Else
			text:+ "wxNullBitmap"
		End If
		
		text:+ ", wxNullBitmap, "
		
		text:+ prop("kind") + ", "
		
		text:+ GetString("~q" + prop("tooltip") + "~q") + ", "
		text:+ GetString("~q" + prop("statusbar") + "~q") + ")"

		out.Add(text, 2)

	End Method

	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxToolBar"
	End Method

End Type


Type TFBToolSeparator Extends TFBWidget

	Method Generate(out:TCodeOutput)

		out.Add(parent.prop("name") + ".AddSeparator()", 2)

	End Method

	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxToolBar"
	End Method

End Type

Type TFBSplitterWindow Extends TFBContainer

	Method Generate(out:TCodeOutput)

		StandardCreate(out)

		StandardSettings(out)

		If kids.count() < 2 Then 
			For Local child:TFBWidget = EachIn kids
				child.Generate(out)
			Next
		Else
			Local splits:String = ""
			
			For Local child:TFBWidget = EachIn kids
				If splits.length > 0 Then
					splits:+ ", "
				End If
				splits:+ TFBSplitterItem(child).GenerateSplit(out)
			Next
			
			Local text:String = prop("name") + ".Split"
			If prop("splitmode") = "wxSPLIT_VERTICAL" Then
				text:+ "Vertically"
			Else
				text:+ "Horizontally"
			End If
			
			text:+ "(" + splits
			
			If prop("sashpos") And prop("sashpos") <> "0" Then
				text:+ ", " + prop("sashpos")
			End If
			
			text:+ ")"
			
			out.Add(text, 2)
			
		End If
		
		If prop("min_pane_size") And prop("min_pane_size") <> "0" Then
			out.Add(prop("name") + ".SetMinimumPaneSize(" + prop("min_pane_size") + ")", 2)
		End If

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxSplitterWindow"
	End Method

	
	Method GetImport:String()
		Return "wx.wxSplitterWindow"
	End Method

End Type

Type TFBSplitterItem Extends TFBWidget

	Method Generate(out:TCodeOutput)

		For Local child:TFBWidget = EachIn kids
			child.Generate(out)

			out.Add(parent.prop("name") + ".Initialize(" + child.prop("name") + ")", 2)
		Next

		out.Add("")

	End Method

	Method GenerateSplit:String(out:TCodeOutput)
		Local name:String
		
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
			name = child.prop("name")
		Next

		out.Add("")
		Return name
	End Method
	
	Method GetType:String(def:Int = False)
	End Method

	
	Method GetImport:String()
		Return "wx.wxSplitterWindow"
	End Method

End Type


' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==

Type TFBSizer Extends TFBWidget

	Method Generate(out:TCodeOutput)
	
		out.Add("")
	
		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If
		
	End Method

End Type

Type TFBBoxSizer Extends TFBSizer

	Method GetType:String(def:Int = False)
		Return "wxBoxSizer"
	End Method

	Method Generate(out:TCodeOutput)
	
		Super.Generate(out)
	
		out.Add(prop("name") + " = new " + GetType() + ".Create(" + prop("orient") + ")", 2)
	
		If prop("minimum_size") Then
			out.Add(prop("name") + ".SetMinSize(" + prop("minimum_size") + ")", 2)
		End If
		
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method

	Method GetImport:String()
		Return "wx.wxWindow"
	End Method

End Type

Type TFBStaticBoxSizer Extends TFBSizer

	Method GetType:String(def:Int = False)
		Return "wxStaticBoxSizer"
	End Method

	Method Generate(out:TCodeOutput)
	
		Super.Generate(out)
		
		Local text:String = prop("name") + " = new " + GetType() + ".CreateSizerWithBox( "
		text:+ "new wxStaticBox.Create(" + ContainerReference() + ", wxID_ANY, " + ..
			GetString("~q" + prop("label") + "~q") + ")"
		text:+ ", " + prop("orient") + ")"

		out.Add(text, 2)

		If prop("minimum_size") Then
			out.Add(prop("name") + ".SetMinSize(" + prop("minimum_size") + ")", 2)
		End If
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method

	Method GetImport:String()
		Return "wx.wxStaticBoxSizer"
	End Method

End Type

Type TFBGridSizer Extends TFBSizer

	Method Generate(out:TCodeOutput)
	
		Super.Generate(out)
	
		Local text:String = prop("name") + " = new " + GetType() + ".CreateRC("
	
		text:+ prop("rows") + ", " + prop("cols") + ", "
		text:+ prop("vgap") + ", " + prop("hgap")
		text:+ ")"
		
		out.Add(text, 2)

		If prop("minimum_size") Then
			out.Add(prop("name") + ".SetMinSize(" + prop("minimum_size") + ")", 2)
		End If
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxGridSizer"
	End Method

	Method GetImport:String()
		Return "wx.wxWindow"
	End Method

End Type

Type TFBFlexGridSizer Extends TFBSizer

	Method Generate(out:TCodeOutput)
	
		Super.Generate(out)
	
		Local text:String = prop("name") + " = new " + GetType() + ".CreateRC("
	
		text:+ prop("rows") + ", " + prop("cols") + ", "
		text:+ prop("vgap") + ", " + prop("hgap")
		text:+ ")"
		
		out.Add(text, 2)
	
		If prop("growablecols") Then
			Local cols:String[] = prop("growablecols").Split(",")
			For Local i:Int = 0 Until cols.length
				out.Add(prop("name") + ".AddGrowableCol( " + cols[i] + " )", 2)
			Next
		End If

		If prop("growablerows") Then	
			Local rows:String[] = prop("growablerows").Split(",")
			For Local i:Int = 0 Until rows.length
				out.Add(prop("name") + ".AddGrowableRow( " + rows[i] + " )", 2)
			Next
		End If

		If prop("flexible_direction") Then	
			out.Add(prop("name") + ".SetFlexibleDirection( " + prop("flexible_direction") + " )", 2)
		End If

		If prop("non_flexible_grow_mode") Then	
			out.Add(prop("name") + ".SetNonFlexibleGrowMode( " + prop("non_flexible_grow_mode") + " )", 2)
		End If

		If prop("minimum_size") Then
			out.Add(prop("name") + ".SetMinSize(" + prop("minimum_size") + ")", 2)
		End If
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxFlexGridSizer"
	End Method

	Method GetImport:String()
		Return "wx.wxWindow"
	End Method

End Type

Type TFBSizerItem Extends TFBWidget

	Method Generate(out:TCodeOutput)
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
			
			
			Local text:String = parent.prop("name") + ".Add"
			If TFBSizer(child) Then
				text:+ "Sizer"
			End If
			
			text:+ "(" + child.prop("name") + ", "
			text:+ prop("proportion") + ", "
			text:+ prop("flag") + ", "
			text:+ prop("border") + ")"
			
			out.Add(text, 2, 2)
			' sbSizer1->Add( m_listCtrl1, 1, wxALL|wxEXPAND, 5 );
		Next
		
	End Method
	
	Method GetType:String(def:Int = False)
	End Method
	
	Method GetImport:String()
	End Method

End Type


Type TFBStdDialogButtonSizer Extends TFBSizer

	Method Generate(out:TCodeOutput)
		Super.Generate(out)

		If Not HasPermissions() Then
			
			If prop("Apply") = "1" Then
				out.Add(prop("name") + "Apply:wxButton", 2)
			End If
			If prop("Cancel") = "1" Then
				out.Add(prop("name") + "Cancel:wxButton", 2)
			End If
			If prop("ContextHelp") = "1" Then
				out.Add(prop("name") + "ContextHelp:wxButton", 2)
			End If
			If prop("Help") = "1" Then
				out.Add(prop("name") + "Help:wxButton", 2)
			End If
			If prop("No") = "1" Then
				out.Add(prop("name") + "No:wxButton", 2)
			End If
			If prop("OK") = "1" Then
				out.Add(prop("name") + "OK:wxButton", 2)
			End If
			If prop("Save") = "1" Then
				out.Add(prop("name") + "Save:wxButton", 2)
			End If
			If prop("Yes") = "1" Then
				out.Add(prop("name") + "Yes:wxButton", 2)
			End If
		End If
		
		Local text:String = prop("name") + " = new " + GetType() + ".CreateSizer()"
		
		out.Add(text, 2)

		StandardSettings(out)
		
		If prop("Apply") = "1" Then
			addButton(out, "Apply")
		End If
		
		If prop("Cancel") = "1" Then
			addButton(out, "Cancel")
		End If

		If prop("ContextHelp") = "1" Then
			addButton(out, "ContextHelp")
		End If

		If prop("Help") = "1" Then
			addButton(out, "Help")
		End If

		If prop("No") = "1" Then
			addButton(out, "No")
		End If

		If prop("OK") = "1" Then
			addButton(out, "OK")
		End If

		If prop("Save") = "1" Then
			addButton(out, "Save")
		End If

		If prop("Yes") = "1" Then
			addButton(out, "Yes")
		End If
		
		out.Add(prop("name") + ".Realize()", 2)
	
	End Method

	Method GetType:String(def:Int = False)
		Return "wxStdDialogButtonSizer"
	End Method

	
	Method GetImport:String()
		Return "wx.wxStdDialogButtonSizer"
	End Method

	Method Configure:Int(lastId:Int)
		Super.Configure(lastId)
		
		Local perm:String = String(prop("permission"))
		If perm And perm <> "none" Then
			Local form:TFBContainer = GetMainContainer()
			If form Then
				
				If prop("Apply") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "Apply"))
				End If

				If prop("Cancel") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "Cancel"))
				End If

				If prop("ContextHelp") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "ContextHelp"))
				End If

				If prop("Help") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "Help"))
				End If

				If prop("No") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "No"))
				End If

				If prop("OK") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "OK"))
				End If

				If prop("Save") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "Save"))
				End If

				If prop("Yes") = "1" Then
					form.fields.AddLast(makeButton(prop("name") + "Yes"))
				End If
				
			End If
		End If

	End Method
	
	Method makebutton:TFBButton(name:String)
		Local but:TFBButton = New TFBButton
		but.obj = New TFBObject
		but.obj.properties.Insert("name", name)
		Return but
	End Method
	
	Method addButton(out:TCodeOutput, name:String)
		Local upperName:String = name.ToUpper()
		If upperName = "CONTEXTHELP" Then
			upperName = "CONTEXT_HELP"
		End If
		out.Add(prop("name") + name + " = new wxButton.Create(" + ContainerReference() + ", wxID_" + upperName + ")", 2)
		out.Add(prop("name") + ".AddButton( " + prop("name") + name + ")", 2)
	End Method

	Method ConnectEvent(out:TCodeOutput, evt:String, ec:String, event:String)
		out.Add(prop("name") + nameFromEvt(evt) + ".ConnectAny(" + ec + ", _" + event + ", Null, Self)", 2)
	End Method
	
	Method nameFromEvt:String(evt:String)
		Return evt.Replace("ButtonClick", "").Replace("On", "")
	End Method
	
End Type

' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==


Type TFBMenuBar Extends TFBWidget

	Method Generate(out:TCodeOutput)
	
		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxMenuBar.Create("

		text:+ WindowStyle()
		
		text:+ ")"
		
		out.Add(text, 2)

		StandardSettings(out)
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
			
			out.Add(prop("name") + ".Append(" + child.prop("name") + ", " + ..
				GetString("~q" + child.prop("label") + "~q") + ")", 2)
		Next
		
		' add the menubar to the form
		out.Add("SetMenuBar(" + prop("name") + ")", 2, 2)
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxMenuBar"
	End Method
	
	Method GetImport:String()
		Return "wx.wxMenuBar"
	End Method

End Type

Type TFBMenu Extends TFBWidget

	Method Generate(out:TCodeOutput)

		out.Add("")
		
		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxMenu.Create()"
		
		out.Add(text, 2)
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)

			If TFBMenu(child) Then
				out.Add(prop("name") + ".AppendMenu(-1, " + GetString("~q" + child.prop("label") + "~q") + ..
					", " + child.prop("name") + ")", 2)
			EndIf
			
			If TFBMenuItem(child) Then
				out.Add(prop("name") + ".AppendItem(" + child.prop("name") + ")", 2)
			End If
			
			If TFBMenuSeparator(child) Then
				out.Add(prop("name") + ".AppendSeparator()", 2)
			End If
		Next
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxMenu"
	End Method

	
	Method GetImport:String()
		Return "wx.wxMenu"
	End Method

End Type

Type TFBMenuItem Extends TFBWidget

	Method Generate(out:TCodeOutput)

		out.Add("")
	
		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new wxMenuItem.Create("
		
		text:+ parent.prop("name") + ", "
		text:+ prop("id") + ", "
		text:+ GetString("~q" + prop("label") + "~q")
		
		' a keyboard shortcut for the menu?
		If prop("shortcut") Then
			text:+ " + ~q~t" + prop("shortcut") + "~q, "
		Else
			text:+ ", "
		End If
		
		' help text?
		If prop("help") Then
			text:+ GetString("~q" + prop("help") + "~q") + ", "
		Else
			text:+ "~q~q, "
		End If
		
		text:+ prop("kind")
		text:+ ")"
					
		out.Add(text, 2)
	
		For Local child:TFBWidget = EachIn kids
			child.Generate(out)
		Next
		
	End Method

	Method GetType:String(def:Int = False)
		Return "wxMenuItem"
	End Method

	
	Method GetImport:String()
		Return "wx.wxMenu"
	End Method

End Type

Type TFBMenuSeparator Extends TFBWidget

	Method Generate(out:TCodeOutput)

		out.Add("")

	End Method

	Method GetType:String(def:Int = False)
		Return "wxMenuItem"
	End Method

	
	Method GetImport:String()
		Return "wx.wxMenu"
	End Method

End Type

' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==


Function GeneratedNotice:String()

	Local text:String = ..
		"'~n" + ..
		"' BlitzMax code generated with wxCodeGen v" + AppVersion + " : " + CurrentDate() + " " + CurrentTime() + "~n" + ..
		"' ~n" + ..
		"' ~n" + ..
		"' PLEASE DO ~qNOT~q EDIT THIS FILE!~n" + ..
		"' "
		
	Return text
End Function


Function InitEvents()

	AddEvent(TEventType.Set("OnClose", "wxCloseEvent", "wxEVT_CLOSE_WINDOW"))
	AddEvent(TEventType.Set("OnSize", "wxSizeEvent", "wxEVT_SIZE"))
	AddEvent(TEventType.Set("OnActivate", "wxActivateEvent", "wxEVT_ACTIVATE"))
	AddEvent(TEventType.Set("OnActivateApp", "wxActivateEvent", "wxEVT_ACTIVATE_APP"))
	AddEvent(TEventType.Set("OnHibernate", "wxActivateEvent", "wxEVT_HIBERNATE"))
	AddEvent(TEventType.Set("OnIconize", "wxIconizeEvent", "wxEVT_ICONIZE"))
	AddEvent(TEventType.Set("OnIdle", "wxIdleEvent", "wxEVT_IDLE"))
			
	AddEvent(TEventType.Set("OnButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
			
	AddEvent(TEventType.Set("OnChar", "wxKeyEvent", "wxEVT_CHAR"))
	AddEvent(TEventType.Set("OnKeyDown", "wxKeyEvent", "wxEVT_KEY_DOWN"))
	AddEvent(TEventType.Set("OnKeyUp", "wxKeyEvent", "wxEVT_KEY_UP"))
			
	AddEvent(TEventType.Set("OnEnterWindow", "wxMouseEvent", "wxEVT_ENTER_WINDOW", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnLeaveWindow", "wxMouseEvent", "wxEVT_LEAVE_WINDOW", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnLeftDClick", "wxMouseEvent", "wxEVT_LEFT_DCLICK", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnLeftDown", "wxMouseEvent", "wxEVT_LEFT_DOWN", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnLeftUp", "wxMouseEvent", "wxEVT_LEFT_UP", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMiddleDClick", "wxMouseEvent", "wxEVT_MIDDLE_DCLICK", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMiddleDown", "wxMouseEvent", "wxEVT_MIDDLE_DOWN", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMiddleUp", "wxMouseEvent", "wxEVT_MIDDLE_UP", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMotion", "wxMouseEvent", "wxEVT_MOTION", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMouseEvents", "wxMouseEvent", "wxEVT_MOUSE_EVENTS", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnMouseWheel", "wxMouseEvent", "wxEVT_MOUSEWHEEL", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnRightDClick", "wxMouseEvent", "wxEVT_RIGHT_DCLICK", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnRightDown", "wxMouseEvent", "wxEVT_RIGHT_DOWN", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnRightUp", "wxMouseEvent", "wxEVT_RIGHT_UP", "wx.wxMouseEvent"))
	AddEvent(TEventType.Set("OnSetFocus", "wxFocusEvent", "wxEVT_SET_FOCUS"))
	AddEvent(TEventType.Set("OnKillFocus", "wxFocusEvent", "wxEVT_KILL_FOCUS"))
	
	AddEvent(TEventType.Set("OnUpdateUI", "wxUpdateUIEvent", "wxEVT_UPDATE_UI"))
			
	AddEvent(TEventType.Set("OnEraseBackground", "wxEraseEvent", "wxEVT_ERASE_BACKGROUND"))
			
	AddEvent(TEventType.Set("OnPaint", "wxPaintEvent", "wxEVT_PAINT"))
	
	AddEvent(TEventType.Set("OnCommandScroll", "wxScrollEvent", "wxEVT_COMMAND_SCROLL"))
	AddEvent(TEventType.Set("OnCommandScrollBottom", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_BOTTOM"))
	AddEvent(TEventType.Set("OnCommandScrollChanged", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_CHANGED"))
	AddEvent(TEventType.Set("OnCommandScrollLineDown", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_LINEDOWN"))
	AddEvent(TEventType.Set("OnCommandScrollLineUp", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_LINEUP"))
	AddEvent(TEventType.Set("OnCommandScrollPageDown", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_PAGEDOWN"))
	AddEvent(TEventType.Set("OnCommandScrollPageUp", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_PAGEUP"))
	AddEvent(TEventType.Set("OnCommandScrollThumbRelease", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_THUMBRELEASE"))
	AddEvent(TEventType.Set("OnCommandScrollThumbTrack", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_THUMBTRACK"))
	AddEvent(TEventType.Set("OnCommandScrollTop", "wxScrollEvent", "wxEVT_COMMAND_SCROLL_TOP"))

	AddEvent(TEventType.Set("OnScroll", "wxScrollEvent", "wxEVT_SCROLL"))
	AddEvent(TEventType.Set("OnScrollBottom", "wxScrollEvent", "wxEVT_SCROLL_BOTTOM"))
	AddEvent(TEventType.Set("OnScrollChanged", "wxScrollEvent", "wxEVT_SCROLL_CHANGED"))
	AddEvent(TEventType.Set("OnScrollLineDown", "wxScrollEvent", "wxEVT_SCROLL_LINEDOWN"))
	AddEvent(TEventType.Set("OnScrollLineUp", "wxScrollEvent", "wxEVT_SCROLL_LINEUP"))
	AddEvent(TEventType.Set("OnScrollPageDown", "wxScrollEvent", "wxEVT_SCROLL_PAGEDOWN"))
	AddEvent(TEventType.Set("OnScrollPageUp", "wxScrollEvent", "wxEVT_SCROLL_PAGEUP"))
	AddEvent(TEventType.Set("OnScrollThumbRelease", "wxScrollEvent", "wxEVT_SCROLL_THUMBRELEASE"))
	AddEvent(TEventType.Set("OnScrollThumbTrack", "wxScrollEvent", "wxEVT_SCROLL_THUMBTRACK"))
	AddEvent(TEventType.Set("OnScrollTop", "wxScrollEvent", "wxEVT_SCROLL_TOP"))

	AddEvent(TEventType.Set("OnMenuSelection", "wxCommandEvent", "wxEVT_COMMAND_MENU_SELECTED"))

	AddEvent(TEventType.Set("OnListBeginDrag", "wxListEvent", "wxEVT_COMMAND_LIST_BEGIN_DRAG"))
	AddEvent(TEventType.Set("OnListBeginLabelEdit", "wxListEvent", "wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnListBeginRDrag", "wxListEvent", "wxEVT_COMMAND_LIST_BEGIN_RDRAG"))
	AddEvent(TEventType.Set("OnListCacheHint", "wxListEvent", "wxEVT_COMMAND_LIST_CACHE_HINT"))
	AddEvent(TEventType.Set("OnListColBeginDrag", "wxListEvent", "wxEVT_COMMAND_LIST_COL_BEGIN_DRAG"))
	AddEvent(TEventType.Set("OnListColClick", "wxListEvent", "wxEVT_COMMAND_LIST_COL_CLICK"))
	AddEvent(TEventType.Set("OnListColDragging", "wxListEvent", "wxEVT_COMMAND_LIST_COL_DRAGGING"))
	AddEvent(TEventType.Set("OnListColEndDrag", "wxListEvent", "wxEVT_COMMAND_LIST_COL_END_DRAG"))
	AddEvent(TEventType.Set("OnListColRightClick", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK"))
	AddEvent(TEventType.Set("OnListDeleteAllItems", "wxListEvent", "wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS"))
	AddEvent(TEventType.Set("OnListDeleteItem", "wxListEvent", "wxEVT_COMMAND_LIST_DELETE_ITEM"))
	AddEvent(TEventType.Set("OnListEndLabelEdit", "wxListEvent", "wxEVT_COMMAND_LIST_END_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnListInsertItem", "wxListEvent", "wxEVT_COMMAND_LIST_INSERT_ITEM"))
	AddEvent(TEventType.Set("OnListItemActivated", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_ACTIVATED"))
	AddEvent(TEventType.Set("OnListItemDeselected", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_DESELECTED"))
	AddEvent(TEventType.Set("OnListItemFocused", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_FOCUSED"))
	AddEvent(TEventType.Set("OnListItemMiddleClick", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK"))
	AddEvent(TEventType.Set("OnListItemRightClick", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK"))
	AddEvent(TEventType.Set("OnListItemSelected", "wxListEvent", "wxEVT_COMMAND_LIST_ITEM_SELECTED"))
	AddEvent(TEventType.Set("OnListKeyDown", "wxListEvent", "wxEVT_COMMAND_LIST_KEY_DOWN"))

	AddEvent(TEventType.Set("OnFileChanged", "wxFileDirPickerEvent", "wxEVT_COMMAND_FILEPICKER_CHANGED"))
	AddEvent(TEventType.Set("OnDirChanged", "wxFileDirPickerEvent", "wxEVT_COMMAND_DIRPICKER_CHANGED"))

	AddEvent(TEventType.Set("OnCheckBox", "wxCommandEvent", "wxEVT_COMMAND_CHECKBOX_CLICKED"))

	AddEvent(TEventType.Set("OnRadioBox", "wxCommandEvent", "wxEVT_COMMAND_RADIOBOX_SELECTED"))

	AddEvent(TEventType.Set("OnListBoxDClick", "wxCommandEvent", "wxEVT_COMMAND_LISTBOX_DOUBLECLICKED"))
	AddEvent(TEventType.Set("OnListBox", "wxCommandEvent", "wxEVT_COMMAND_LISTBOX_SELECTED"))
   
	AddEvent(TEventType.Set("OnTreeBeginDrag", "wxTreeEvent", "wxEVT_COMMAND_TREE_BEGIN_DRAG"))
	AddEvent(TEventType.Set("OnTreeBeginRDrag", "wxTreeEvent", "wxEVT_COMMAND_TREE_BEGIN_RDRAG"))
	AddEvent(TEventType.Set("OnTreeBeginLabelEdit", "wxTreeEvent", "wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnTreeEndLabelEdit", "wxTreeEvent", "wxEVT_COMMAND_TREE_END_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnTreeDeleteItem", "wxTreeEvent", "wxEVT_COMMAND_TREE_DELETE_ITEM"))
	AddEvent(TEventType.Set("OnTreeGetInfo", "wxTreeEvent", "wxEVT_COMMAND_TREE_GET_INFO"))
	AddEvent(TEventType.Set("OnTreeSetInfo", "wxTreeEvent", "wxEVT_COMMAND_TREE_SET_INFO"))
	AddEvent(TEventType.Set("OnTreeItemExpanded", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_EXPANDED"))
	AddEvent(TEventType.Set("OnTreeItemExpanding", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_EXPANDING"))
	AddEvent(TEventType.Set("OnTreeItemCollapsed", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_COLLAPSED"))
	AddEvent(TEventType.Set("OnTreeItemCollapsing", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_COLLAPSING"))
	AddEvent(TEventType.Set("OnTreeSelChanged", "wxTreeEvent", "wxEVT_COMMAND_TREE_SEL_CHANGED"))
	AddEvent(TEventType.Set("OnTreeSelChanging", "wxTreeEvent", "wxEVT_COMMAND_TREE_SEL_CHANGING"))
	AddEvent(TEventType.Set("OnTreeKeyDown", "wxTreeEvent", "wxEVT_COMMAND_TREE_KEY_DOWN"))
	AddEvent(TEventType.Set("OnTreeItemActivated", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_ACTIVATED"))
	AddEvent(TEventType.Set("OnTreeItemRightClick", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK"))
	AddEvent(TEventType.Set("OnTreeItemMiddleClick", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK"))
	AddEvent(TEventType.Set("OnTreeEndDrag", "wxTreeEvent", "wxEVT_COMMAND_TREE_END_DRAG"))
	AddEvent(TEventType.Set("OnTreeStateImageClick", "wxTreeEvent", "wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK"))
	AddEvent(TEventType.Set("OnTreeItemGetTooltip", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP"))
	AddEvent(TEventType.Set("OnTreeItemMenu", "wxTreeEvent", "wxEVT_COMMAND_TREE_ITEM_MENU"))

	AddEvent(TEventType.Set("OnHtmlLinkClicked", "wxHtmlLinkEvent", "wxEVT_COMMAND_HTML_LINK_CLICKED"))
	AddEvent(TEventType.Set("OnHtmlCellClicked", "wxHtmlCellEvent", "wxEVT_COMMAND_HTML_CELL_CLICKED"))
	AddEvent(TEventType.Set("OnHtmlCellHover", "wxHtmlCellEvent", "wxEVT_COMMAND_HTML_CELL_HOVER"))

	AddEvent(TEventType.Set("OnCheckListBox", "wxCommandEvent", "wxEVT_COMMAND_LISTBOX_SELECTED"))
	AddEvent(TEventType.Set("OnCheckListBoxDClick", "wxCommandEvent", "wxEVT_COMMAND_LISTBOX_DOUBLECLICKED"))
	AddEvent(TEventType.Set("OnCheckListBoxToggled", "wxCommandEvent", "wxEVT_COMMAND_CHECKLISTBOX_TOGGLED"))
		
	AddEvent(TEventType.Set("OnToggleButton", "wxCommandEvent", "wxEVT_COMMAND_TOGGLEBUTTON_CLICKED"))

	AddEvent(TEventType.Set("OnSpinCtrl", "wxCommandEvent", "wxEVT_COMMAND_SPINCTRL_UPDATED"))
	AddEvent(TEventType.Set("OnSpinCtrlText", "wxCommandEvent", "wxEVT_COMMAND_TEXT_UPDATED"))
		
	AddEvent(TEventType.Set("OnText", "wxCommandEvent", "wxEVT_COMMAND_TEXT_UPDATED"))
	AddEvent(TEventType.Set("OnTextEnter", "wxCommandEvent", "wxEVT_COMMAND_TEXT_ENTER"))
	AddEvent(TEventType.Set("OnTextMaxLen", "wxCommandEvent", "wxEVT_COMMAND_TEXT_MAXLEN"))
	AddEvent(TEventType.Set("OnTextURL", "wxTextUrlEvent", "wxEVT_COMMAND_TEXT_URL"))

	AddEvent(TEventType.Set("OnInitDialog", "wxInitDialogEvent", "wxEVT_INIT_DIALOG"))

	AddEvent(TEventType.Set("OnRadioButton", "wxCommandEvent", "wxEVT_COMMAND_RADIOBUTTON_SELECTED"))

	AddEvent(TEventType.Set("OnCombobox", "wxCommandEvent", "wxEVT_COMMAND_COMBOBOX_SELECTED"))

	AddEvent(TEventType.Set("OnHyperlink", "wxHyperlinkEvent", "wxEVT_COMMAND_HYPERLINK"))

	AddEvent(TEventType.Set("OnChoice", "wxCommandEvent", "wxEVT_COMMAND_CHOICE_SELECTED"))

	AddEvent(TEventType.Set("OnDateChanged", "wxDateEvent", "wxEVT_DATE_CHANGED"))

	AddEvent(TEventType.Set("OnToolClicked", "wxCommandEvent", "wxEVT_COMMAND_TOOL_CLICKED"))
	AddEvent(TEventType.Set("OnToolRClicked", "wxCommandEvent", "wxEVT_COMMAND_TOOL_RCLICKED"))
	AddEvent(TEventType.Set("OnToolEnter", "wxCommandEvent", "wxEVT_COMMAND_TOOL_ENTER"))

	AddEvent(TEventType.Set("OnApplyButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnCancelButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnContextHelpButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnHelpButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnNoButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnOKButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnSaveButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))
	AddEvent(TEventType.Set("OnYesButtonClick", "wxCommandEvent", "wxEVT_COMMAND_BUTTON_CLICKED"))

	AddEvent(TEventType.Set("OnNotebookPageChanged", "wxCommandEvent", "wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED"))
	AddEvent(TEventType.Set("OnNotebookPageChanging", "wxCommandEvent", "wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING"))

End Function

Function AddEvent(evt:TEventType)
	eventMap.Insert(evt.name, evt)
End Function


Type TStringTokenizer

	Field str:String
	Field curpos:Int
	Field readyToken:String
	Field delimeter:String

	Function Create:TStringTokenizer(str:String, delim:String)
		Local this:TStringTokenizer = New TStringTokenizer
		this.str = str
		this.delimeter = delim
		Return this
	End Function

	Method HasMoreTokens:Int()
	
		Local i:Int = curpos
		Local inToken:Int = False
		
		Local prevA:String
		
		While i < str.length
		
			Local a:String = str[i..i+1]
			
			If Not inToken Then
				If a = delimeter Then
					inToken = True
					readyToken = ""
				End If
			Else
				If prevA <> "~~" Then
					If a <> delimeter Then
						If a <> "~~" Then
							readyToken :+ a
						End If
					Else
						i:+ 1
						curPos = i
						Return True
					End If
				
					prevA = a
				Else
					readyToken:+ "~~" + a
					prevA = ""
				End If
			End If

			i:+ 1
		Wend
		
		curpos = str.length
		
		If inToken Then
			Return True
		End If
		
		Return False
		
	End Method
	
	Method GetNextToken:String()
		Return readyToken
	End Method


End Type

