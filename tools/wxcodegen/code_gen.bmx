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


Const AppVersion:String = "0.86"


Global eventMap:TMap = New TMap
InitEvents()


Const GEN_SUPER:Int = $001
Const GEN_IMPORTS:Int = $002
Const GEN_WXLOCALE:Int = $004
Const GEN_BAHLOCALE:Int = $008



Type TFBObject

	Field class:String
	Field expanded:Int

	Field properties:TMap = New TMap
	Field events:TMap = New TMap
	
	Field objects:TList = New TList


	Method extractDetails(node:TxmlNode)
	
		class = node.GetAttribute("class")
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
	Field kind:Int
	
	Function Set:TEventType(name:String, event:String, constant:String, kind:Int = 0)
		Local this:TEventType = New TEventType
		this.name = name
		this.event = event
		this.constant = constant
		this.kind = kind
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
		Return parent.GetForm()
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
	
	' standard widget settings, like Enabled,  MinSize, MaxSize etc.
	Method StandardSettings(out:TCodeOutput, noref:Int = False)

		' Enable()
		If prop("enabled") <> "1" Then
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
				text:+ ", " + attribs[0]
			End If
			
			text:+ "))"
			
			out.Add(text, 2)
		End If
		
		' SetForegroundColour()
		Local col:String = prop("fg")
		If col Then
			Local text:String = NameReference(prop("name"), noref) + "SetForegroundColour("
			
			If col.Find("wx") >= 0 Then
				text:+ "wxSystemSettings.GetColour(" + col + ")"

				Local proj:TFBProject = GetProject()
				If proj Then
					proj.imports.Insert("wx.wxSystemSettings", "")
				End If
			Else
				text:+ "new wxColour.Create(" + col + ")"
			End If
			
			text:+ ")"
			
			out.Add( text, 2)
		End If

		' SetBackgroundColour()
		col = prop("bg")
		If col Then
			Local text:String = NameReference(prop("name"), noref) + "SetBackgroundColour("
			
			If col.Find("wx") >= 0 Then
				text:+ "wxSystemSettings.GetColour(" + col + ")"

				Local proj:TFBProject = GetProject()
				If proj Then
					proj.imports.Insert("wx.wxSystemSettings", "")
				End If
			Else
				text:+ "new wxColour.Create(" + col + ")"
			End If
			
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
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
		End If

		Local text:String = prop("name") + " = new " + GetType() + ".Create(" + ContainerReference() + ", " + prop("id")

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)

	End Method
	
	Method StandardCreateWithLabel(out:TCodeOutput)

		If Not HasPermissions() Then
			out.Add("Local " + prop("name") + ":" + GetType(), 2)
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
	
	Method GetString:String(text:String)
		text = text.Replace("~r", "")
		text = text.Replace("~n", "~~n")
		text = text.Replace("~t", "~~t")
		If genflags & GEN_WXLOCALE And Not IsEmptyQuotes(text) Then
			text = "_(" + text + ")"
		End If
		If genflags & GEN_BAHLOCALE And Not IsEmptyQuotes(text) Then
			text = "GetLocaleText(" + text + ")"
		End If
		Return text
	End Method
	
	Method GetType:String() Abstract
	Method GetImport:String() Abstract
	
End Type

Type TFBProject Extends TFBWidget

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

	Method GetType:String()
	End Method
	
	Method GetImport:String()
	End Method

End Type

Type TFBContainer Extends TFBWidget

	Field fields:TList = New TList

	Field consts:TList = New TList
	
	Method Free()
		Super.Free()
		
		fields.Clear()
		consts.Clear()
	End Method

	Method Generate(out:TCodeOutput)
	
		Local topSizer:TFBWidget
		
		out.Add("Type " + prop("name") + "Base Extends " + GetType(), ,2)
		
		' fields
		For Local fld:TFBWidget = EachIn fields
			out.Add("Field " + fld.prop("name") + ":" + fld.GetType(), 1)
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
	
	Method DoConstructor(out:TCodeOutput)
	End Method
	
	Method ConnectEvents(out:TCodeOutput)
	
		out.Add("")
	
		' my events
		For Local evt:String = EachIn obj.events.keys()
		
			Local event:String =  String(obj.events.ValueForKey(evt))
			Local ec:String = MapEventConst(evt)
			out.Add("ConnectAny(" + ec + ", _" + event + ")", 2)
		
		Next
	
		' child events
		For Local child:TFBWidget = EachIn kids
			ChildConnectEvents(child, out)
		Next
	
	End Method

	Method EventFunctions(out:TCodeOutput)
	
		Local text:String
	
		' my events
		For Local evt:String = EachIn obj.events.keys()
		
			out.Add("Function _" + event(evt) + "(event:wxEvent)", 1)
			
			text = prop("name") + "Base(event.parent)." + event(evt) + "(" + MapEvent(evt) + "(event))"
			out.Add(text, 2, 1)
			
			out.Add("End Function", 1, 2)
			
			out.Add("Method " + event(evt) + "(event:" + MapEvent(evt) + ")", 1)
			out.Add("DebugLog ~qPlease override " + prop("name") + "." + event(evt) + "()~q", 2)
			out.Add("event.Skip()", 2)
			out.Add("End Method", 1, 2)
		
		Next
		
		' child events
		For Local child:TFBWidget = EachIn kids
			ChildEventFunctions(child, out)
		Next
	
	End Method

	Method ChildEventFunctions(widget:TFBWidget, out:TCodeOutput)
	
		Local text:String
	
		' my events
		For Local evt:String = EachIn widget.obj.events.keys()
		
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
			
			out.Add("Method " + widget.event(evt) + "(event:" + MapEvent(evt) + ")", 1)
			out.Add("DebugLog ~qPlease override " + prop("name") + "." + widget.event(evt) + "()~q", 2)
			out.Add("event.Skip()", 2)
			out.Add("End Method", 1, 2)
		
		Next

		For Local child:TFBWidget = EachIn widget.kids
			ChildEventFunctions(child, out)
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
				If Not widget.id Then
					out.Add(widget.prop("name") + ".ConnectAny(" + ec + ", _" + event + ", Null, Self)", 2)
				Else
					out.Add("Connect(" + widget.prop("id") + ", " + ec + ", _" + event + ")", 2)
				End If
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
		Return "wxPanel"
	End Method

	Method GetImport:String()
		Return "wx.wxPanel"
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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
			Local bitmap:String[] = prop("bitmap").Split(";")
			text:+ "wxBitmap.CreateFromFile(~q" + bitmap[0] + "~q, wxBITMAP_TYPE_ANY)"
		Else
			text:+ "wxNullBitmap"
		End If

		text:+ DoPosSizeStyle(Self)
		
		text:+ ")"
		
		out.Add(text, 2)
		
		StandardSettings(out)

	End Method

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
		Return "wxNotebook"
	End Method

	
	Method GetImport:String()
		Return "wx.wxNotebook"
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
		Return "wxScintilla"
	End Method

	
	Method GetImport:String()
		Return "wx.wxScintilla"
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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
			out.Add(prop("name") + ".AddGrowableCol( " + prop("growablecols") + " )", 2)
		End If

		If prop("growablerows") Then	
			out.Add(prop("name") + ".AddGrowableRow( " + prop("growablerows") + " )", 2)
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

	Method GetType:String()
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
	
	Method GetType:String()
	End Method
	
	Method GetImport:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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

	Method GetType:String()
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
			
	AddEvent(TEventType.Set("OnEnterWindow", "wxMouseEvent", "wxEVT_ENTER_WINDOW"))
	AddEvent(TEventType.Set("OnLeaveWindow", "wxMouseEvent", "wxEVT_LEAVE_WINDOW"))
	AddEvent(TEventType.Set("OnLeftDClick", "wxMouseEvent", "wxEVT_LEFT_DCLICK"))
	AddEvent(TEventType.Set("OnLeftDown", "wxMouseEvent", "wxEVT_LEFT_DOWN"))
	AddEvent(TEventType.Set("OnLeftUp", "wxMouseEvent", "wxEVT_LEFT_UP"))
	AddEvent(TEventType.Set("OnMiddleDClick", "wxMouseEvent", "wxEVT_MIDDLE_DCLICK"))
	AddEvent(TEventType.Set("OnMiddleDown", "wxMouseEvent", "wxEVT_MIDDLE_DOWN"))
	AddEvent(TEventType.Set("OnMiddleUp", "wxMouseEvent", "wxEVT_MIDDLE_UP"))
	AddEvent(TEventType.Set("OnMotion", "wxMouseEvent", "wxEVT_MOTION"))
	AddEvent(TEventType.Set("OnMouseEvents", "wxMouseEvent", "wxEVT_MOUSE_EVENTS"))
	AddEvent(TEventType.Set("OnMouseWheel", "wxMouseEvent", "wxEVT_MOUSEWHEEL"))
	AddEvent(TEventType.Set("OnRightDClick", "wxMouseEvent", "wxEVT_RIGHT_DCLICK"))
	AddEvent(TEventType.Set("OnRightDown", "wxMouseEvent", "wxEVT_RIGHT_DOWN"))
	AddEvent(TEventType.Set("OnRightUp", "wxMouseEvent", "wxEVT_RIGHT_UP"))
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
   
	AddEvent(TEventType.Set("OnTreeBeginDrag", "wxCommandEvent", "wxEVT_COMMAND_TREE_BEGIN_DRAG"))
	AddEvent(TEventType.Set("OnTreeBeginRDrag", "wxCommandEvent", "wxEVT_COMMAND_TREE_BEGIN_RDRAG"))
	AddEvent(TEventType.Set("OnTreeBeginLabelEdit", "wxCommandEvent", "wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnTreeEndLabelEdit", "wxCommandEvent", "wxEVT_COMMAND_TREE_END_LABEL_EDIT"))
	AddEvent(TEventType.Set("OnTreeDeleteItem", "wxCommandEvent", "wxEVT_COMMAND_TREE_DELETE_ITEM"))
	AddEvent(TEventType.Set("OnTreeGetInfo", "wxCommandEvent", "wxEVT_COMMAND_TREE_GET_INFO"))
	AddEvent(TEventType.Set("OnTreeSetInfo", "wxCommandEvent", "wxEVT_COMMAND_TREE_SET_INFO"))
	AddEvent(TEventType.Set("OnTreeItemExpanded", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_EXPANDED"))
	AddEvent(TEventType.Set("OnTreeItemExpanding", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_EXPANDING"))
	AddEvent(TEventType.Set("OnTreeItemCollapsed", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_COLLAPSED"))
	AddEvent(TEventType.Set("OnTreeItemCollapsing", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_COLLAPSING"))
	AddEvent(TEventType.Set("OnTreeSelChanged", "wxCommandEvent", "wxEVT_COMMAND_TREE_SEL_CHANGED"))
	AddEvent(TEventType.Set("OnTreeSelChanging", "wxCommandEvent", "wxEVT_COMMAND_TREE_SEL_CHANGING"))
	AddEvent(TEventType.Set("OnTreeKeyDown", "wxCommandEvent", "wxEVT_COMMAND_TREE_KEY_DOWN"))
	AddEvent(TEventType.Set("OnTreeItemActivated", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_ACTIVATED"))
	AddEvent(TEventType.Set("OnTreeItemRightClick", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK"))
	AddEvent(TEventType.Set("OnTreeItemMiddleClick", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK"))
	AddEvent(TEventType.Set("OnTreeEndDrag", "wxCommandEvent", "wxEVT_COMMAND_TREE_END_DRAG"))
	AddEvent(TEventType.Set("OnTreeStateImageClick", "wxCommandEvent", "wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK"))
	AddEvent(TEventType.Set("OnTreeItemGetTooltip", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP"))
	AddEvent(TEventType.Set("OnTreeItemMenu", "wxCommandEvent", "wxEVT_COMMAND_TREE_ITEM_MENU"))

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

