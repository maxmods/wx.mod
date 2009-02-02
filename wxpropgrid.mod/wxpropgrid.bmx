' Copyright (c) 2007,2008 Bruce A Henderson
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

Rem
bbdoc: wxPropGrid
End Rem
Module wx.wxPropGrid

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"


' Important notes !
' propgrid.cpp
'
' set wxPG_REFRESH_CONTROLS_AFTER_REPAINT to 1 for wxMAC !!
' otherwise, it doesn't refresh properly...
'
' in wxPGProperty::Init(), must include the check for "_LABEL_AS_NAME"
'

Rem
bbdoc: 
End Rem
Type wxPropertyContainerMethods Extends wxPanel

	Rem
	bbdoc: 
	End Rem
	Method AddPropertyChoice(prop:Object, label:String, value:Int = INT_MAX) Abstract

'	Rem
'	bbdoc: 
'	End Rem
'	Method AddPropertyChoiceByName(name:String, label:String, value:Int = INT_MAX) Abstract
	
	Rem
	bbdoc: Appends property to the list.
	about: wxPropertyGrid assumes ownership of the object. Becomes child of most recently added category.
	End Rem
	Method Append:wxPGProperty(property:wxPGProperty) Abstract

	Rem
	bbdoc: 
	End Rem
	Method AppendIn:wxPGProperty(prop:wxPGProperty, newProperty:wxPGProperty) Abstract
		
	Rem
	bbdoc: Inorder to add new items into a property with fixed children (for instance, wxFlagsProperty), you need to call this method.
	about: After populating has been finished, you need to call EndAddChildren/Name.	
	End Rem
	Method BeginAddChildren(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueIntArray:Int(prop:Object, value:Int[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueULong:Int(prop:Object, value:Long) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueLong:Int(prop:Object, value:Long) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueSize:Int(prop:Object, w:Int, h:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValuePoint:Int(prop:Object, x:Int, y:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueBytePtr:Int(prop:Object, value:Byte Ptr) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueString:Int(prop:Object, value:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueDateTime:Int(prop:Object, time:wxDateTime) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueStringArray:Int(prop:Object, value:String[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueBool:Int(prop:Object, value:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueDouble:Int(prop:Object, value:Double) Abstract

	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueFloat:Int(prop:Object, value:Float) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ChangePropertyValueInt:Int(prop:Object, value:Int) Abstract

	Rem
	bbdoc: Resets value of a property to its default.
	End Rem
	Method ClearPropertyValue:Int(prop:Object) Abstract
	
	Rem
	bbdoc: Deselect current selection, If any.
	returns: True If success (ie. validator did Not intercept).
	End Rem
	Method ClearSelection:Int() Abstract

	Rem
	bbdoc: Collapses given category or property with children.
	returns: True if actually collapses.
	End Rem
	Method Collapse:Int(prop:Object) Abstract
	
	Rem
	bbdoc: Deletes a property.
	about: If category is deleted, all children are automatically deleted as well.
	End Rem
	Method DeleteProperty(prop:Object) Abstract

	Rem
	bbdoc: Deletes choice from a property.
	about: If selected item is deleted, then the value is set to unspecified.
	<p>
	See AddPropertyChoice for more details.
	</p>
	End Rem
	Method DeletePropertyChoice(prop:Object, index:Int) Abstract
	
	Rem
	bbdoc: Disables property.
	End Rem
	Method DisableProperty:Int(prop:Object) Abstract
	
	Rem
	bbdoc: Enables or disables property, depending on whether enable is true or false.
	End Rem
	Method EnableProperty:Int(prop:Object, enable:Int = True) Abstract
	
	Rem
	bbdoc: Called after population of property with fixed children has finished.
	End Rem
	Method EndAddChildren(prop:Object) Abstract
	
	Rem
	bbdoc: Expands given category or property with children.
	returns: True if actually expands.
	End Rem
	Method Expand:Int(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetFirst:wxPGProperty(flags:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetIterator:wxPropertyGridIterator(flags:Int, firstProp:wxPGProperty = Null) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertiesWithFlag:wxPGProperty[](flags:Int, inverse:Int = False, iterFlags:Int = wxPG_ITERATE_PROPERTIES | wxPG_ITERATE_HIDDEN | wxPG_ITERATE_CATEGORIES) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyBySubName:wxPGProperty(name:String, subName:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyByName:wxPGProperty(name:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyCategory:wxPropertyCategory(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyChoices:wxPGChoices(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyClassName:String(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyClientData:Object(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyEditor:wxPGEditor(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyHelpString:String(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyImage:wxBitmap(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyIndex:Int(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyLabel:String(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyName:String(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyParent:wxPGProperty(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyPtr:wxPGProperty(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyShortClassName:String(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsArrayInt:Int[](prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsArrayString:String[](prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsBool:Int(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsDateTime:wxDateTime(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsDouble:Double(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsFloat:Float(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsInt:Int(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsLong:Long(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsPoint(prop:Object, x:Int Var, y:Int Var) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsSize(prop:Object, w:Int Var, h:Int Var) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsString:String(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsULong:Int(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueAsColour:wxColour(prop:Object) Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetPropertyValueType:String(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelection:wxPGProperty() Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method GetState:wxPropertyGridState() Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method HideProperty:Int(prop:Object, hide:Int = True) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method Insert:wxPGProperty(parent:Object, index:Int, newproperty:wxPGProperty) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method InsertCategory:wxPGProperty(prop:Object, index:Int, label:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method InsertPropertyChoice(prop:Object, label:String, index:Int, value:Int = INT_MAX) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyCategory:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyEnabled:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyExpanded:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyModified:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyShown:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyUnspecified:Int(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method LimitPropertyEditing(prop:Object, limit:Int = True) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method NamesToProperties:wxPGProperty[](names:String[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method PropertiesToNames:String[](properties:wxPGProperty[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshGrid(state:wxPropertyGridState = Null) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ReplaceProperty:wxPGProperty(prop:Object, property:wxPGProperty) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyCell(prop:Object, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyChoices(prop:Object, choices:wxPGChoices) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyChoicesExclusive(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyClientData(prop:Object, clientData:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyEditorbyName(prop:Object, editorName:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyEditor(prop:Object, editor:wxPGEditor) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyAttribute(prop:Object, attrName:String, value:Int, argFlags:Int = 0) Abstract
	
	Rem
	bbdoc: Associates the help string with property.
	about: By default, text is shown either in the manager's "description" text box or in the
	status bar. If extra window style wxPG_EX_HELP_AS_TOOLTIPS is used, then the text will appear
	as a tooltip.
	End Rem
	Method SetPropertyHelpString(prop:Object, helpString:String) Abstract

	Rem
	bbdoc: 
	End Rem
	Method SetPropertyImage(prop:Object, bmp:wxBitmap) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyLabel(prop:Object, newproplabel:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyMaxLength:Int(prop:Object, maxLen:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyReadOnly(prop:Object, set:Int = True) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyUnspecified(prop:Object) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueIntArray(prop:Object, value:Int[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueULong(prop:Object, value:Long) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueLong(prop:Object, value:Long) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueSize(prop:Object, w:Int, h:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValuePoint(prop:Object, x:Int, y:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueBytePtr(prop:Object, value:Byte Ptr) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueString(prop:Object, value:String) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueDateTime(prop:Object, time:wxDateTime) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueStringArray(prop:Object, value:String[]) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueBool(prop:Object, value:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueDouble(prop:Object, value:Double) Abstract

	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueFloat(prop:Object, value:Float) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SetPropertyValueInt(prop:Object, value:Int) Abstract

	
'	Function InitAllTypeHandlers()
'	End Function
'	Function RegisterAdditionalEditors()
'	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxPropertyGridState Extends wxPropertyContainerMethods
End Type

Rem
bbdoc: 
End Rem
Type wxPropertyGridPage Extends wxPropertyGridState
End Type


Rem
bbdoc: 
End Rem
Type wxPropertyGridManager Extends wxPropertyContainerMethods
End Type

Rem
bbdoc: A specialized two-column grid for editing properties such as strings, numbers, flagsets, fonts, and colours. 
about: wxPropertyGrid is modeled after .NET propertygrid (hence the name), and thus features are similar.
However, inorder to keep the widget lightweight, it does not (and will not) have toolbar for mode and page
selection, nor the help text box. wxAdvancedPropertyGrid (or something similarly named) is planned to have
these features in some distant future.
End Rem
Type wxPropertyGrid Extends wxPropertyContainerMethods

	' soft linking
	Function _create:wxPropertyGrid(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPropertyGrid = New wxPropertyGrid
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxPropertyGrid(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local grid:wxPropertyGrid = wxPropertyGrid(wxfind(wxObjectPtr))
			If Not grid Then
				Return wxPropertyGrid._create(wxObjectPtr)
			End If
			Return grid
		End If
	End Function

	Function _xrcNew:wxPropertyGrid(wxObjectPtr:Byte Ptr)
		Return wxPropertyGrid._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreatePropertyGrid:wxPropertyGrid(parent:wxWindow, id:Int = wxID_ANY, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxPropertyGrid.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPropertyGrid(parent:wxWindow, id:Int = wxID_ANY, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxpropertygrid_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Method AddPropertyChoice(prop:Object, label:String, value:Int = INT_MAX)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_addpropertychoice(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, label, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_addpropertychoicebyname(wxObjectPtr, String(prop), label, value)
		End If
	End Method

	Method Append:wxPGProperty(property:wxPGProperty)
		Return wxPGProperty._create(bmx_wxpropertygrid_append(wxObjectPtr, property.wxObjectPtr))
	End Method

	Method AppendIn:wxPGProperty(prop:wxPGProperty, newProperty:wxPGProperty)
		Return wxPGProperty._create(bmx_wxpropertygrid_appendin(wxObjectPtr, prop.wxObjectPtr, newProperty.wxObjectPtr))
	End Method

	Rem
	bbdoc: Centers the splitter.
	about: If argument is true, automatic splitter centering is enabled (only applicapple if style
	wxPG_SPLITTER_AUTO_CENTER was defined).
	End Rem
	Method CenterSplitter(enableAutoCentering:Int = False)
		bmx_wxpropertygrid_centersplitter(wxObjectPtr, enableAutoCentering)
	End Method
	
	Rem
	bbdoc: Returns current splitter x position.
	End Rem
	Method GetSplitterPosition:Int()
		Return bmx_wxpropertygrid_getsplitterposition(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves splitter as left as possible, while still allowing all labels to be shown in full.
	about: If @subProps is False, will still allow sub-properties (ie. properties which parent
	is not root or category) to be cropped.
	End Rem
	Method SetSplitterLeft(subProps:Int = False)
		bmx_wxpropertygrid_setsplitterleft(wxObjectPtr, subProps)
	End Method
	
	Rem
	bbdoc: Sets x coordinate of the splitter.
	End Rem
	Method SetSplitterPosition(xPos:Int, refresh:Int = True)
		bmx_wxpropertygrid_setsplitterposition(wxObjectPtr, xPos, refresh)
	End Method
	
	Method CommitChangesFromEditor:Int(flags:Int = 0)
		Return bmx_wxpropertygrid_commitchangesfromeditor(wxObjectPtr, flags)
	End Method
	
	Method SelectProperty:Int(prop:wxPGProperty = Null, focus:Int = False)
		If prop Then
			Return bmx_wxpropertygrid_selectproperty(wxObjectPtr, prop.wxObjectPtr, focus)
		Else
			Return bmx_wxpropertygrid_selectproperty(wxObjectPtr, prop.wxObjectPtr, focus)
		End If
	End Method
	
	Method ChangePropertyValueIntArray:Int(prop:Object, value:Int[])
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueULong:Int(prop:Object, value:Long) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueLong:Int(prop:Object, value:Long) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueSize:Int(prop:Object, w:Int, h:Int) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValuePoint:Int(prop:Object, x:Int, y:Int) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueBytePtr:Int(prop:Object, value:Byte Ptr) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueString:Int(prop:Object, value:String) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueDateTime:Int(prop:Object, time:wxDateTime) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueStringArray:Int(prop:Object, value:String[]) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueBool:Int(prop:Object, value:Int) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueDouble:Int(prop:Object, value:Double) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method
	
	Method ChangePropertyValueFloat:Int(prop:Object, value:Float)
		Return ChangePropertyValueDouble(prop, value)
	End Method
	
	Method ChangePropertyValueInt:Int(prop:Object, value:Int) 
		' TODO
		If wxPGProperty(prop) Then
		Else If String(prop) Then
		End If
	End Method

	Rem
	bbdoc: Deletes all properties.
	about: Does Not free memory allocated For arrays etc. This should *Not* be called in wxPropertyGridManager.
	End Rem
	Method Clear()
		bmx_wxpropertygrid_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets modified status of all properties.
	End Rem
	Method ClearModifiedStatus()
		bmx_wxpropertygrid_clearmodifiedstatus(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets modified status of a property and all sub-properties.
	End Rem
	Method ClearPropertyModifiedStatus(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_clearpropertymodifiedstatus(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_clearpropertymodifiedstatusbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method SetPropertyHelpString(prop:Object, helpString:String)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyhelpstring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, helpString)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyhelpstringbyname(wxObjectPtr, String(prop), helpString)
		End If
	End Method


'	Method ClearPropertyValue(name:String)
'	End Method
	
'	Method ClearPropertyValueId(id:wxPGPropArg)
'	End Method
	
'	Method Collapse(name:String)
'	End Method
	
'	Method CollapseId(id:wxPGPropArg)
'	End Method
'	
	Method GetCaptionBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getcaptionbackgroundcolour(wxObjectPtr))
	End Method
	
	Method GetCaptionForegroundColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getcaptionforegroundcolour(wxObjectPtr))
	End Method
	
	Method GetCellBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getcellbackgroundcolour(wxObjectPtr))
	End Method
	
	Method GetCellDisabledTextColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getcelldisabledtextcolour(wxObjectPtr))
	End Method
	
	Method GetCellTextColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getcelltextcolour(wxObjectPtr))
	End Method
	
	
'	Rem
'	bbdoc: Returns itself.
'	about: Dummy Method that enables same kind of code To use wxPropertyGrid And wxPropertyGridManager.
'	End Rem
	Method GetGrid:wxPropertyGrid()
		Return _find(bmx_wxpropertygrid_getgrid(wxObjectptr))
	End Method
	
	Method GetLineColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getlinecolour(wxObjectPtr))
	End Method
	
	Method GetMarginColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getmargincolour(wxObjectPtr))
	End Method
	
	Method GetPropertyBackgroundColour:wxColour(prop:Object)
		If wxPGProperty(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertybackgroundcolour(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxObjectPtr, String(prop)))
		End If
	End Method
	
	Method GetPropertyColour:wxColour(prop:Object)
		If wxPGProperty(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertycolour(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertycolourbyname(wxObjectPtr, String(prop)))
		End If
	End Method
	
	Method GetPropertyTextColour:wxColour(prop:Object)
		If wxPGProperty(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertytextcolour(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertytextcolourbyname(wxObjectPtr, String(prop)))
		End If
	End Method

	Method BeginAddChildren(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_beginaddchildren(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_beginaddchildrenbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method ClearPropertyValue:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_clearpropertyvalue(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_clearpropertyvaluebyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method ClearSelection:Int()
		Return bmx_wxpropertygrid_clearselection(wxObjectPtr)
	End Method

	Method Collapse:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_collapse(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_collapsebyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method DeleteProperty(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_deleteproperty(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_deletepropertybyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method DeletePropertyChoice(prop:Object, index:Int)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_deletepropertychoice(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, index)
		Else If String(prop) Then
			bmx_wxpropertygrid_deletepropertychoicebyname(wxObjectPtr, String(prop), index)
		End If
	End Method
	
	Method DisableProperty:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_disableproperty(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_disablepropertybyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method EnableProperty:Int(prop:Object, enable:Int = True)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_enableproperty(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, enable)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_enablepropertybyname(wxObjectPtr, String(prop), enable)
		End If
	End Method
	
	Method EndAddChildren(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_endaddchildren(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_endaddchildrenbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method Expand:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_expand(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_expandbyname(wxObjectPtr, String(prop))
		End If
	End Method

	
	Method GetFirst:wxPGProperty(flags:Int)
		Return wxPGProperty._find(bmx_wxpropertygrid_getfirst(wxObjectPtr, flags))
	End Method
	
	Method GetIterator:wxPropertyGridIterator(flags:Int, firstProp:wxPGProperty = Null)
		' TODO
	End Method
	
	Method GetPropertiesWithFlag:wxPGProperty[](flags:Int, inverse:Int = False, iterFlags:Int = wxPG_ITERATE_PROPERTIES | wxPG_ITERATE_HIDDEN | wxPG_ITERATE_CATEGORIES)
		Return bmx_wxpropertygrid_getpropertieswithflag(wxObjectPtr, flags, inverse, iterFlags)
	End Method
	
	Function _newPropertiesArray:wxPGProperty[](size:Int)
		Return New wxPGProperty[size]
	End Function
	
	Function _addProperty(arr:wxPGProperty[], index:Int, prop:Byte Ptr)
		arr[index] = wxPGProperty._find(prop)
	End Function

	Function _getProperty:Byte Ptr(arr:wxPGProperty[], index:Int)
		Return arr[index].wxObjectPtr
	End Function
	
	Method GetPropertyBySubName:wxPGProperty(name:String, subName:String)
		Return wxPGProperty._find(bmx_wxpropertygrid_getpropertybysubname(wxObjectPtr, name, subName))
	End Method
	
	Method GetPropertyByName:wxPGProperty(name:String)
		Return wxPGProperty._find(bmx_wxpropertygrid_getpropertybyname(wxObjectPtr, name))
	End Method
	
	Method GetPropertyCategory:wxPropertyCategory(prop:Object)
		If wxPGProperty(prop) Then
			Return wxPropertyCategory._find(bmx_wxpropertygrid_getpropertycategory(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxPropertyCategory._find(bmx_wxpropertygrid_getpropertycategorybyname(wxObjectPtr, String(prop)))
		End If
	End Method
	
	Method GetPropertyChoices:wxPGChoices(prop:Object)
		If wxPGProperty(prop) Then
			Return wxPGChoices._create(bmx_wxpropertygrid_getpropertychoices(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxPGChoices._create(bmx_wxpropertygrid_getpropertychoicesbyname(wxObjectPtr, String(prop)))
		End If
	End Method
	
	Method GetPropertyClassName:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyclassname(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyclassnamebyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method GetPropertyClientData:Object(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyclientdata(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
		' TODO
		End If
	End Method

	Method GetPropertyEditor:wxPGEditor(prop:Object)
		If wxPGProperty(prop) Then
			Return wxPGEditor._find(bmx_wxpropertygrid_getpropertyeditor(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
		' TODO
		End If
	End Method

	Method GetPropertyHelpString:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyhelpstring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyhelpstringbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyImage:wxBitmap(prop:Object)
		If wxPGProperty(prop) Then
			Return wxBitmap._create(bmx_wxpropertygrid_getpropertyimage(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxBitmap._create(bmx_wxpropertygrid_getpropertyimagebyname(wxObjectPtr, String(prop)))
		End If
	End Method

	Method GetPropertyIndex:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyindex(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyindexbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyLabel:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertylabel(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertylabelbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyName:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyname(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertynamebyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyParent:wxPGProperty(prop:Object)
		If wxPGProperty(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_getpropertyparent(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
		' TODO
		End If
	End Method

	Method GetPropertyPtr:wxPGProperty(prop:Object)
		If wxPGProperty(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_getpropertyptr(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
		' TODO
		End If
	End Method

	Method GetPropertyShortClassName:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyshortclassname(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyshortclassnamebyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsArrayInt:Int[](prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasarrayint(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsArrayString:String[](prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasarraystring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsBool:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasbool(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsDateTime:wxDateTime(prop:Object)
		If wxPGProperty(prop) Then
			Return wxDateTime._create(bmx_wxpropertygrid_getpropertyvalueasdatetime(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxDateTime._create(bmx_wxpropertygrid_getpropertyvalueasdatetimebyname(wxObjectPtr, String(prop)))
		End If
	End Method

	Method GetPropertyValueAsDouble:Double(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasdouble(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasdoublebyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsFloat:Float(prop:Object)
		Return GetPropertyValueAsDouble(prop)
	End Method

	Method GetPropertyValueAsInt:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasint(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasintbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsLong:Long(prop:Object)
		Local value:Long
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_getpropertyvalueaslong(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, Varptr value)
		Else If String(prop) Then
			bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxObjectPtr, String(prop), Varptr value)
		End If
		Return value
	End Method

	Method GetPropertyValueAsPoint(prop:Object, x:Int Var, y:Int Var)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_getpropertyvalueaspoint(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, Varptr x, Varptr y)
		Else If String(prop) Then
			bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxObjectPtr, String(prop), Varptr x, Varptr y)
		End If
	End Method

	Method GetPropertyValueAsSize(prop:Object, w:Int Var, h:Int Var)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_getpropertyvalueassize(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, Varptr w, Varptr h)
		Else If String(prop) Then
			bmx_wxpropertygrid_getpropertyvalueassizebyname(wxObjectPtr, String(prop), Varptr w, Varptr h)
		End If
	End Method

	Method GetPropertyValueAsString:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasstring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvalueasstringbyname(wxObjectPtr, String(prop))
		End If
	End Method

	Method GetPropertyValueAsULong:Int(prop:Object)
		If wxPGProperty(prop) Then
			' TODO
		Else If String(prop) Then
		End If
	End Method

	Method GetPropertyValueType:String(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_getpropertyvaluetype(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_getpropertyvaluetypebyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method GetSelection:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygrid_getselection(wxObjectPtr))
	End Method
	
	Method GetState:wxPropertyGridState()
		' TODO
	End Method
	
	Method HideProperty:Int(prop:Object, hide:Int = True)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_hideproperty(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, hide)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_hidepropertybyname(wxObjectPtr, String(prop), hide)
		End If
	End Method
	
	Method Insert:wxPGProperty(parent:Object, index:Int, newproperty:wxPGProperty)
		If wxPGProperty(parent) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_insert(wxObjectPtr, wxPGProperty(parent).wxObjectPtr, index, newproperty.wxObjectPtr))
		Else If String(parent) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_insertbyname(wxObjectPtr, String(parent), index, newproperty.wxObjectPtr))
		End If
	End Method
	
	Method InsertCategory:wxPGProperty(prop:Object, index:Int, label:String)
		If wxPGProperty(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_insertcategory(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, index, label))
		Else If String(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_insertcategorybyname(wxObjectPtr, String(prop), index, label))
		End If
	End Method
	
	Method InsertPropertyChoice(prop:Object, label:String, index:Int, value:Int = INT_MAX)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_insertpropertychoice(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, label, index, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_insertpropertychoicebyname(wxObjectPtr, String(prop), label, index, value)
		End If
	End Method
	
	Method IsPropertyCategory:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertcategory(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertycategorybyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method IsPropertyEnabled:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertyenabled(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertyenabledbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method IsPropertyExpanded:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertyexpanded(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertyexpandedbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method IsPropertyModified:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertymodified(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertymodifiedbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method IsPropertyShown:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertyshown(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertyshownbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method IsPropertyUnspecified:Int(prop:Object)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_ispropertyunspecified(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_ispropertyunspecifiedbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method LimitPropertyEditing(prop:Object, limit:Int = True)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_limitpropertyediting(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, limit)
		Else If String(prop) Then
			bmx_wxpropertygrid_limitpropertyeditingbyname(wxObjectPtr, String(prop), limit)
		End If
	End Method
	
	Method NamesToProperties:wxPGProperty[](names:String[])
		Return bmx_wxpropertygrid_namestoproperties(wxObjectPtr, names)
	End Method
	
	Method PropertiesToNames:String[](properties:wxPGProperty[])
		Return bmx_wxpropertygrid_propertiestonames(wxObjectPtr, properties)
	End Method
	
	Method RefreshGrid(state:wxPropertyGridState = Null)
	End Method
	
	Method ReplaceProperty:wxPGProperty(prop:Object, property:wxPGProperty)
		If wxPGProperty(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_replaceproperty(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, property.wxObjectPtr))
		Else If String(prop) Then
			Return wxPGProperty._find(bmx_wxpropertygrid_replacepropertybyname(wxObjectPtr, String(prop), property.wxObjectPtr))
		End If
	End Method
	
	Method SetPropertyCell(prop:Object, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null)
		If wxPGProperty(prop) Then
			If bitmap Then
				If fgCol Then
					If bgCol Then
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, bitmap.wxObjectPtr, fgCol.wxObjectPtr, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, bitmap.wxObjectPtr, fgCol.wxObjectPtr, Null)
					End If
				Else
					If bgCol Then
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, bitmap.wxObjectPtr, Null, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, bitmap.wxObjectPtr, Null, Null)
					End If
				End If
			Else
				If fgCol Then
					If bgCol Then
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, Null, fgCol.wxObjectPtr, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, Null, fgCol.wxObjectPtr, Null)
					End If
				Else
					If bgCol Then
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, Null, Null, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycell(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, column, text, Null, Null, Null)
					End If
				End If
			End If
		Else If String(prop) Then
			If bitmap Then
				If fgCol Then
					If bgCol Then
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, bitmap.wxObjectPtr, fgCol.wxObjectPtr, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, bitmap.wxObjectPtr, fgCol.wxObjectPtr, Null)
					End If
				Else
					If bgCol Then
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, bitmap.wxObjectPtr, Null, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, bitmap.wxObjectPtr, Null, Null)
					End If
				End If
			Else
				If fgCol Then
					If bgCol Then
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, Null, fgCol.wxObjectPtr, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, Null, fgCol.wxObjectPtr, Null)
					End If
				Else
					If bgCol Then
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, Null, Null, bgCol.wxObjectPtr)
					Else
						bmx_wxpropertygrid_setpropertycellbyname(wxObjectPtr, String(prop), column, text, Null, Null, Null)
					End If
				End If
			End If
		End If
	End Method
	
	Method SetPropertyChoices(prop:Object, choices:wxPGChoices)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertychoices(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, choices.wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertychoicesbyname(wxObjectPtr, String(prop), choices.wxObjectPtr)
		End If
	End Method
	
	Method SetPropertyChoicesExclusive(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertychoicesexclusive(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertychoicesexclusivebyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method SetPropertyClientData(prop:Object, clientData:Object)
		If wxPGProperty(prop) Then
		' TODO
		Else If String(prop) Then
		End If
	End Method
	
	Method SetPropertyEditorByName(prop:Object, editorName:String)
		If wxPGProperty(prop) Then
		' TODO
		Else If String(prop) Then
		End If
	End Method
	
	Method SetPropertyEditor(prop:Object, editor:wxPGEditor)
		If wxPGProperty(prop) Then
		' TODO
		Else If String(prop) Then
		End If
	End Method
	
	
	Method SetPropertyImage(prop:Object, bmp:wxBitmap)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyimage(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, bmp.wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyimagebyname(wxObjectPtr, String(prop), bmp.wxObjectPtr)
		End If
	End Method
	
	Method SetPropertyLabel(prop:Object, label:String)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertylabel(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, label)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertylabelbyname(wxObjectPtr, String(prop), label)
		End If
	End Method
	
	Method SetPropertyMaxLength:Int(prop:Object, maxLen:Int)
		If wxPGProperty(prop) Then
			Return bmx_wxpropertygrid_setpropertymaxlength(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, maxLen)
		Else If String(prop) Then
			Return bmx_wxpropertygrid_setpropertymaxlengthbyname(wxObjectPtr, String(prop), maxLen)
		End If
	End Method

	Method SetPropertyReadOnly(prop:Object, set:Int = True)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyreadonly(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, set)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyreadonlybyname(wxObjectPtr, String(prop), set)
		End If
	End Method
	
	Method SetPropertyUnspecified(prop:Object)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyunspecified(wxObjectPtr, wxPGProperty(prop).wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyunspecifiedbyname(wxObjectPtr, String(prop))
		End If
	End Method
	
	Method SetPropertyValueIntArray(prop:Object, value:Int[])
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvalueintarray(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvalueintarraybyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueULong(prop:Object, value:Long)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvalueulong(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvalueulongbyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueLong(prop:Object, value:Long)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluelong(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluelongbyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueSize(prop:Object, w:Int, h:Int)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluesize(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, w, h)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluesizebyname(wxObjectPtr, String(prop), w, h)
		End If
	End Method
	
	Method SetPropertyValuePoint(prop:Object, x:Int, y:Int)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluepoint(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, x, y)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluepointbyname(wxObjectPtr, String(prop), x, y)
		End If
	End Method
	
	Method SetPropertyValueBytePtr(prop:Object, value:Byte Ptr)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluebyteptr(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluebyteptrbyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueString(prop:Object, value:String)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluestring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluestringbyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueDateTime(prop:Object, time:wxDateTime)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluedatetime(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, time.wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluedatetimebyname(wxObjectPtr, String(prop), time)
		End If
	End Method
	
	Method SetPropertyValueStringArray(prop:Object, value:String[])
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluestringarray(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluestringarraybyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueBool(prop:Object, value:Int)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluebool(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvalueboolbyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueDouble(prop:Object, value:Double)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluedouble(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluedoublebyname(wxObjectPtr, String(prop), value)
		End If
	End Method
	
	Method SetPropertyValueFloat(prop:Object, value:Float)
		SetPropertyValueDouble(prop, value)
	End Method

	Method SetPropertyValueInt(prop:Object, value:Int)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvalueint(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvalueintbyname(wxObjectPtr, String(prop), value)
		End If
	End Method

	Method SetPropertyAttribute(prop:Object, attrName:String, value:Int, argFlags:Int = 0)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyattribute(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, attrName, value, argFlags)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyattributebyname(wxObjectPtr, String(prop), attrName, value, argFlags)
		End If
	End Method

	Method SetPropertyAttributeString(prop:Object, attrName:String, value:String, argFlags:Int = 0)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyattributestring(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, attrName, value, argFlags)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyattributestringbyname(wxObjectPtr, String(prop), attrName, value, argFlags)
		End If
	End Method

	Method GetPropertyValueAsColour:wxColour(prop:Object)
		If wxPGProperty(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertyvalueascolour(wxObjectPtr, wxPGProperty(prop).wxObjectPtr))
		Else If String(prop) Then
			Return wxColour._create(bmx_wxpropertygrid_getpropertyvalueascolourbyname(wxObjectPtr, String(prop)))
		End If
	End Method

	Method SetPropertyValueColour(prop:Object, value:wxColour)
		If wxPGProperty(prop) Then
			bmx_wxpropertygrid_setpropertyvaluecolour(wxObjectPtr, wxPGProperty(prop).wxObjectPtr, value.wxObjectPtr)
		Else If String(prop) Then
			bmx_wxpropertygrid_setpropertyvaluecolourbyname(wxObjectPtr, String(prop), value.wxObjectPtr)
		End If
	End Method

End Type

Extern
	Function bmx_wxpropertygrid_getpropertieswithflag:wxPGProperty[](handle:Byte Ptr, flags:Int, inverse:Int, iterFlags:Int)
	Function bmx_wxpropertygrid_propertiestonames:String[](handle:Byte Ptr, properties:wxPGProperty[])
	Function bmx_wxpropertygrid_namestoproperties:wxPGProperty[](handle:Byte Ptr, names:String[])
End Extern

Rem
bbdoc: wxPGProperty, is base type for properties.
End Rem
Type wxPGProperty Extends wxObject

	Function _create:wxPGProperty(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPGProperty = New wxPGProperty
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxPGProperty(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local prop:wxPGProperty = wxPGProperty(wxfind(wxObjectPtr))
			If Not prop Then
				Return wxPGProperty._create(wxObjectPtr)
			End If
			Return prop
		End If
	End Function

	Rem
	bbdoc: This is used by properties that have fixed sub-properties.
	End Rem
	Method AddChild(prop:wxPGProperty)
		bmx_wxpgproperty_addchild(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds entry to property's wxPGChoices and editor control (if it is active).
	returns: Index of item added.
	End Rem
	Method AppendChoice:Int(label:String, value:Int = INT_MAX)
		Return bmx_wxpgproperty_appendchoice(wxObjectPtr, label, value)
	End Method
	
	Rem
	bbdoc: Returns true if extra children can be added for this property (i.e. it is wxPropertyCategory or wxCustomProperty)
	End Rem
	Method CanHaveExtraChildren:Int()
		Return bmx_wxpgproperty_canhaveextrachildren(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearFlag(flag:Int)
		bmx_wxpgproperty_clearflag(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Removes entry from property's wxPGChoices and editor control (if it is active).
	about: If selected item is deleted, then the value is set to unspecified.
	End Rem
	Method DeleteChoice(index:Int)
		bmx_wxpgproperty_deletechoice(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Deletes all sub-properties.
	End Rem
	Method Empty()
		bmx_wxpgproperty_empty(wxObjectPtr)
	End Method
	
	'Rem
	'bbdoc: If property did Not have data extension, one is created now (returns True in that Case).
	'End Rem
	'Method EnsureDataExt:Int()
	'	Return bmx_wxpgproperty_ensuredataext(wxObjectPtr)
	'End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FixIndexesOfChildren(starthere:Int = 0)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetArrIndex:Int()
		Return bmx_wxpgproperty_getarrindex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns named attribute, as Int, if found.
	about: Otherwise defVal is returned.
	End Rem
	Method GetAttributeAsInt:Int(name:String, defVal:Int)
		Return bmx_wxpgproperty_getattributeasint(wxObjectPtr, name, defVal)
	End Method
	
	Rem
	bbdoc: Returns named attribute, as String, if found.
	about: Otherwise defVal is returned.
	End Rem
	Method GetAttributeAsString:String(name:String, defVal:String)
		Return bmx_wxpgproperty_getattributeasstring(wxObjectPtr, name, defVal)
	End Method
	
	Rem
	bbdoc: Returns named attribute, as Double.
	End Rem
	Method GetAttributeAsDouble:Double(name:String)
		Return bmx_wxpgproperty_getattributeasdouble(wxObjectPtr, name)
	End Method

	Rem
	bbdoc: Returns named attribute, as Float.
	End Rem
	Method GetAttributeAsFloat:Float(name:String)
		Return GetAttributeAsDouble(name)
	End Method

	Rem
	bbdoc: Returns named attribute, as Long.
	End Rem
	Method GetAttributeAsLong:Long(name:String)
		Local value:Long
		bmx_wxpgproperty_getattributeaslong(wxObjectPtr, name, Varptr value)
		Return value
	End Method

	Rem
	bbdoc: Returns property's base name (ie. parent's name is not added in any case)
	End Rem
	Method GetBaseName:String()
		Return bmx_wxpgproperty_getbasename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCell:wxPGCell(column:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellRenderer:wxPGCellRenderer(column:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: Returns number of child properties.
	End Rem
	Method GetChildCount:Int()
		Return bmx_wxpgproperty_getchildcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns height of children, recursively, and by taking expanded/collapsed status into account.
	about: iMax is used when finding property y-positions.
	End Rem
	Method GetChildrenHeight:Int(lh:Int, iMax:Int = -1)
		Return bmx_wxpgproperty_getchildrenheight(wxObjectPtr, lh, iMax)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChoiceCount:Int()
		Return bmx_wxpgproperty_getchoicecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChoiceInfo:Int(choiceinfo:wxPGChoiceInfo)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChoices:wxPGChoices()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChoiceString:String(index:Int)
		Return bmx_wxpgproperty_getchoicestring(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetClassName:String()
		Return bmx_wxpgproperty_getclassname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetClientData:Object()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColumnEditor:wxPGEditor(column:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: Returns common value selected for this property, -1 for none.
	End Rem
	Method GetCommonValue:Int()
		Return bmx_wxpgproperty_getcommonvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns number of child properties.
	End Rem
	Method GetCount:Int()
		Return bmx_wxpgproperty_getcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCurrentChoice:wxPGChoiceEntry()
		Return wxPGChoiceEntry._create(bmx_wxpgproperty_getcurrentchoice(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDataExt:wxPGPropertyDataExt()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDepth:Int()
		Return bmx_wxpgproperty_getdepth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return number of displayed common values for this property.
	End Rem
	Method GetDisplayedCommonValueCount:Int()
		Return bmx_wxpgproperty_getdisplayedcommonvaluecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDisplayedString:String()
		Return bmx_wxpgproperty_getdisplayedstring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEditorClass:wxPGEditor()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEditorDialog:wxPGEditorDialogAdapter()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFlags:Int()
		Return bmx_wxpgproperty_getflags(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFlagsAsString:String(flagsMask:Int)
		Return bmx_wxpgproperty_getflagsasstring(wxObjectPtr, flagsMask)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGrid:wxPropertyGrid()
		Return wxPropertyGrid._create(bmx_wxpgproperty_getgrid(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridIfDisplayedwxPropertyGrid()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetHelpString:String()
		Return bmx_wxpgproperty_gethelpstring(wxObjectPtr)
	End Method
	
'	Method GetId:wxPGId()
'	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetImageSize(w:Int Var, h:Int Var)
		bmx_wxpgproperty_getimagesize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetIndexInParent:Int()
		Return bmx_wxpgproperty_getindexinparent(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemAtY:wxPGProperty(y:Int, lh:Int, nextItemY:Int Var)
		Return wxPGProperty._create(bmx_wxpgproperty_getitematy(wxObjectPtr, y, lh, Varptr nextItemY))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabel:String()
		Return bmx_wxpgproperty_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLastVisibleSubItem:wxPGProperty()
		Return wxPGProperty._create(bmx_wxpgproperty_getlastvisiblesubitem(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMainParent:wxPGProperty()
		Return wxPGProperty._create(bmx_wxpgproperty_getmainparent(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxLength:Int()
		Return bmx_wxpgproperty_getmaxlength(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetName:String()
		Return bmx_wxpgproperty_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetParent:wxPGProperty()
		Return wxPGProperty._create(bmx_wxpgproperty_getparent(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetParentState:wxPropertyGridState()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPropertyByName:wxPGProperty(name:String)
		Return wxPGProperty._create(bmx_wxpgproperty_getpropertybyname(wxObjectPtr, name))
	End Method
	
	Rem
	bbdoc: Returns type name of property that is compatible with CreatePropertyByType. 
	End Rem
	Method GetType:String()
		Return bmx_wxpgproperty_gettype(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValueAsArrayInt:Int[]()
		Return bmx_wxpgproperty_getvalueasarrayint(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValueAsArrayString:String[]()
		Return bmx_wxpgproperty_getvalueasarraystring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsString:String()
		Return bmx_wxpgproperty_getvalueasstring(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsDouble:Double()
		Return bmx_wxpgproperty_getvalueasdouble(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValueAsFloat:Float()
		Return GetValueAsDouble()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsBool:Int()
		Return bmx_wxpgproperty_getvalueasbool(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsInt:Int()
		Return bmx_wxpgproperty_getvalueasint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsLong:Long()
		Local value:Long
		bmx_wxpgproperty_getvalueaslong(wxObjectPtr, Varptr value)
		Return value
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValueAsPoint(x:Int Var, y:Int Var)
		bmx_wxpgproperty_getvalueaspoint(wxObjectPtr, Varptr x, Varptr y)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValueAsSize(w:Int Var, h:Int Var)
		bmx_wxpgproperty_getvalueassize(wxObjectPtr, Varptr w, Varptr h)
	End Method


	Rem
	bbdoc: Returns the property value as a wxColour.
	End Rem
	Method GetValueAsColour:wxColour()
		Return wxColour._create(bmx_wxpgproperty_getvalueascolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns text representation of property's value. 
	about: Parameters:
	<ul>
	<li><b>argFlags</b> 	If wxPG_FULL_VALUE is set, returns complete, storable string value instead of
	displayable. If wxPG_EDITABLE_VALUE is set, returns string value that must be editable in textctrl. If
	wxPG_COMPOSITE_FRAGMENT is set, returns text that is appropriate to display as a part of composite
	property string value.</li>
	</ul>
	End Rem
	Method GetValueString:String(argFlags:Int = 0)
		Return bmx_wxpgproperty_getvaluestring(wxObjectPtr, argFlags)
	End Method
	
	Rem
	bbdoc: Returns coordinate to the top y of the property.
	about: Note that the position of scrollbars is not taken into account. 
	End Rem
	Method GetY:Int()
		Return bmx_wxpgproperty_gety(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasFlag:Int(flag:Int)
		Return bmx_wxpgproperty_hasflag(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Hides or reveals the property. 
	End Rem
	Method Hide:Int(hide:Int)
		Return bmx_wxpgproperty_hide(wxObjectPtr, hide)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Index:Int(p:wxPGProperty)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertChoice:Int(label:String, index:Int, value:Int = INT_MAX)
		' TODO
	End Method
	
	Rem
	bbdoc: Returns true if this property is actually a wxPropertyCategory. 
	End Rem
	Method IsCategory:Int()
		Return bmx_wxpgproperty_iscategory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this property is enabled.
	End Rem
	Method IsEnabled:Int()
		Return bmx_wxpgproperty_isenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this property is expanded.
	End Rem
	Method IsExpanded:Int()
		Return bmx_wxpgproperty_isexpanded(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the specified flag is set.
	End Rem
	Method IsFlagSet:Int(flag:Int)
		Return bmx_wxpgproperty_isflagset(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Returns true if this property is actually a wxRootProperty. 
	End Rem
	Method IsRoot:Int()
		Return bmx_wxpgproperty_isroot(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsSomeParent:Int(candidateParent:wxPGProperty)
		' TODO
	End Method
	
	Rem
	bbdoc: Returns true if this is a sub-property. 
	End Rem
	Method IsSubProperty:Int()
		Return bmx_wxpgproperty_issubproperty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsValueUnspecified:Int()
		Return bmx_wxpgproperty_isvalueunspecified(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if all parents expanded. 
	End Rem
	Method IsVisible:Int()
		Return bmx_wxpgproperty_isvisible(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns sub-property at index i.
	End Rem
	Method Item:wxPGProperty(i:Int)
		Return wxPGProperty._create(bmx_wxpgproperty_item(wxObjectPtr, i))
	End Method
	
	Rem
	bbdoc: Returns last sub-property.
	End Rem
	Method Last:wxPGProperty()
		Return wxPGProperty._create(bmx_wxpgproperty_last(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PrepareValueForDialogEditing:Int(propgrid:wxPropertyGrid)
		' TODO
	End Method
	
	Rem
	bbdoc: If property's editor is created this forces its recreation.
	about: Useful in SetAttribute etc. Returns true if actually did anything.
	End Rem
	Method RecreateEditor:Int()
		Return bmx_wxpgproperty_recreateeditor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Refresh values of child properties.
	about: Automatically called after value is set. 
	End Rem
	Method RefreshChildren()
		bmx_wxpgproperty_refreshchildren(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: If property's editor is active, then update it's value. 
	End Rem
	Method RefreshEditor()
		bmx_wxpgproperty_refresheditor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets a string attribute of a property.
	about: Ids and relevants values are totally specific to property classes and may affect either the given instance or all instances of that class.
	End Rem
	Method SetAttributeString(name:String, value:String)
		bmx_wxpgproperty_setattributestring(wxObjectPtr, name, value)
	End Method

	Rem
	bbdoc: Sets an int attribute of a property.
	about: Ids and relevants values are totally specific to property classes and may affect either the given instance or all instances of that class.
	End Rem
	Method SetAttributeInt(name:String, value:Int)
		bmx_wxpgproperty_setattributeint(wxObjectPtr, name, value)
	End Method

	Rem
	bbdoc: Sets a double attribute of a property.
	about: Ids and relevants values are totally specific to property classes and may affect either the given instance or all instances of that class.
	End Rem
	Method SetAttributeDouble(name:String, value:Double)
		bmx_wxpgproperty_setattributedouble(wxObjectPtr, name, value)
	End Method

	Rem
	bbdoc: Sets a float attribute of a property.
	about: Ids and relevants values are totally specific to property classes and may affect either the given instance or all instances of that class.
	End Rem
	Method SetAttributeFloat(name:String, value:Float)
		SetAttributeDouble(name, value)
	End Method

	Rem
	bbdoc: Sets a bool attribute of a property.
	about: Ids and relevants values are totally specific to property classes and may affect either the given instance or all instances of that class.
	End Rem
	Method SetAttributeBool(name:String, value:Int)
		bmx_wxpgproperty_setattributebool(wxObjectPtr, name, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttributes(attributes:wxPGAttributeStorage)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCell(column:Int, cellObj:wxPGCell)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetChoices:Int(labels:String[], values:Int[] = Null)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetChoiceSelection(newValue:Int, choiceInfo:wxPGChoiceInfo)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetChoicesExclusive()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetClientData(clientData:Object)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCommonValue(commonValue:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEditorByName(editorName:String)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEditor(editor:wxPGEditor)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetExpanded(expanded:Int)
		bmx_wxpgproperty_setexpanded(wxObjectPtr, expanded)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFlag(flag:Int)
		bmx_wxpgproperty_setflag(wxObjectPtr, flag)
	End Method
	
	Rem
	bbdoc: Sets flags from a '|' delimited string.
	about: Note that flag names are not prepended with 'wxPG_PROP_'.
	End Rem
	Method SetFlagsFromString(s:String)
		bmx_wxpgproperty_setflagsfromstring(wxObjectPtr, s)
	End Method
	
	Rem
	bbdoc: Sets the help string.
	End Rem
	Method SetHelpString(helpString:String)
		bmx_wxpgproperty_sethelpstring(wxObjectPtr, helpString)
	End Method
	
	Rem
	bbdoc: Sets the property label.
	End Rem
	Method SetLabel(label:String)
		bmx_wxpgproperty_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: Set max length of text editor.
	End Rem
	Method SetMaxLength:Int(maxLen:Int)
		Return bmx_wxpgproperty_setmaxlength(wxObjectPtr, maxLen)
	End Method

	Rem
	bbdoc: Sets the value (Int[]) of the property.
	End Rem
	Method SetValueIntArray(value:Int[])
		bmx_wxpgproperty_setvalueintarray(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (ULong) of the property.
	End Rem
	Method SetValueULong(value:Long) 
		bmx_wxpgproperty_setvalueulong(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (Long) of the property.
	End Rem
	Method SetValueLong(value:Long) 
		bmx_wxpgproperty_setvaluelong(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (w, y) of the property.
	End Rem
	Method SetValueSize(w:Int, h:Int) 
		bmx_wxpgproperty_setvaluesize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Sets the value (x, y) of the property.
	End Rem
	Method SetValuePoint(x:Int, y:Int) 
		bmx_wxpgproperty_setvaluepoint(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Sets the value (Byte Ptr) of the property.
	End Rem
	Method SetValueBytePtr(value:Byte Ptr) 
		bmx_wxpgproperty_setvaluebyteptr(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (String) of the property.
	End Rem
	Method SetValueString(value:String) 
		bmx_wxpgproperty_setvaluestring(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (String[]) of the property.
	End Rem
	Method SetValueStringArray(value:String[]) 
		bmx_wxpgproperty_setvaluestringarray(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (Bool) of the property.
	End Rem
	Method SetValueBool(value:Int) 
		bmx_wxpgproperty_setvaluebool(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (Double) of the property.
	End Rem
	Method SetValueDouble(value:Double) 
		bmx_wxpgproperty_setvaluedouble(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Sets the value (Float) of the property.
	End Rem
	Method SetValueFloat(value:Float) 
		SetValueDouble(value)
	End Method
	
	Rem
	bbdoc: Sets the value (Int) of the property.
	End Rem
	Method SetValueInt(value:Int) 
		bmx_wxpgproperty_setvalueint(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: Sets the value (wxColour) of the property.
	End Rem
	Method SetValueColour(value:wxColour)
		bmx_wxpgproperty_setvaluecolour(wxObjectPtr, value.wxObjectPtr)
	End Method

	Rem
	bbdoc: Set wxBitmap in front of the value.
	about: This bitmap may be ignored by custom cell renderers. 
	End Rem
	Method SetValueImage(bmp:wxBitmap)
		' TODO
	End Method
	
	Rem
	bbdoc: Call with 'false' in OnSetValue to cancel value changes after all.
	End Rem
	Method SetWasModified(set:Int = True)
		' TODO
	End Method
	
	Rem
	bbdoc: Updates composed values of parent non-category properties, recursively.
	returns: Topmost property updated.
	End Rem
	Method UpdateParentValues:wxPGProperty()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns true if containing grid uses wxPG_EX_AUTO_UNSPECIFIED_VALUES. 
	End Rem
	Method UsesAutoUnspecified:Int()
		' TODO
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxPGPropertyWithChildren Extends wxPGProperty

	Function _create:wxPGPropertyWithChildren(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPGPropertyWithChildren = New wxPGPropertyWithChildren
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxStringProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxStringProperty(label:String = Null, name:String = Null, value:String = Null)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxstringproperty_create(Self, label, name, value)
		Return Self
	End Method
	
End Type

Rem
bbdoc: Basic property with integer value.
about: Seamlessly supports 64-bit integer (Long) on overflow.
End Rem
Type wxIntProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxIntProperty(label:String = Null, name:String = Null, value:Int = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxintproperty_create(Self, label, name, value)
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxUIntProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxUIntProperty(label:String = Null, name:String = Null, value:Int = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxuintproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxDoubleProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxDoubleProperty(label:String = Null, name:String = Null, value:Double = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxdoubleproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxFloatProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxFloatProperty(label:String = Null, name:String = Null, value:Float = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxfloatproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Basic property with boolean value.
about: Supported special attributes:
<ul>
<li>"UseCheckbox": Set to 1 to use check box editor instead of combo box.</li>
<li>"UseDClickCycling": Set to 1 to cycle combo box instead showing the list.</li>
</ul>
End Rem
Type wxBoolProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxBoolProperty(label:String = Null, name:String = Null, value:Int = False)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxboolproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Represents a bit set that fits in a long integer.
about: wxBoolProperty sub-properties are created for editing individual bits. Textctrl is created to
manually edit the flags as a text; a continous sequence of spaces, commas and semicolons is considered
as a flag id separator. Note: When changing "choices" (ie. flag labels) of wxFlagsProperty, you will need
to use SetPropertyChoices - otherwise they will not get updated properly. 
End Rem
Type wxFlagsProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxFlagsProperty(label:String = Null, name:String = Null, labels:String[] = Null, ..
			values:Int[] = Null, value:Int = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxflagsproperty_create(Self, label, name, labels, values, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Like wxLongStringProperty, but the button triggers file selector instead. 
about: Supported special attributes:
<ul>
<li>"Wildcard": Sets wildcard (see wxFileDialog for format details), "All files..." is default.</li>
<li>"ShowFullPath": Default 1. When 0, only the file name is shown (i.e. drive and directory are hidden).</li>
<li>"ShowRelativePath": If set, then the filename is shown relative to the given path string.</li>
<li>"InitialPath": Sets the initial path of where to look for files.</li>
<li>"DialogTitle": Sets a specific title for the dir dialog. </li>
</ul>
End Rem
Type wxFileProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxFileProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxfileproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Like wxStringProperty, but has a button that triggers a small text editor dialog. 
End Rem
Type wxLongStringProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxLongStringProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxlongstringproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Like wxLongStringProperty, but the button triggers dir selector instead.
about: Supported special attributes:
<ul>
<li>"DialogMessage": Sets specific message in the dir selector. </li>
</ul>
End Rem
Type wxDirProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxDirProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxdirproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Property that manages a list of strings. 
End Rem
Type wxArrayStringProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxArrayStringProperty(label:String = Null, name:String = Null, value:String[] = Null)
		wxObjectPtr = bmx_wxarraystringproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxCustomProperty Extends wxPGProperty
End Type

Rem
bbdoc: 
End Rem
Type wxFontProperty Extends wxPGPropertyWithChildren

	Rem
	bbdoc: 
	End Rem
	Method Create:wxFontProperty(label:String, name:String = Null, font:wxFont = Null)
		If font Then
			wxObjectPtr = bmx_wxfontproperty_create(Self, label, name, font.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxfontproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxPropertyCategory Extends wxPGPropertyWithChildren

	Function _create:wxPropertyCategory(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPropertyCategory = New wxPropertyCategory
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxPropertyCategory(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local prop:wxPropertyCategory = wxPropertyCategory(wxfind(wxObjectPtr))
			If Not prop Then
				Return wxPropertyCategory._create(wxObjectPtr)
			End If
			Return prop
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPropertyCategory(label:String, name:String = Null)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxpropertycategory_create(Self, label, name)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxBaseEnumProperty Extends wxPGProperty
End Type

Rem
bbdoc: 
End Rem
Type wxEnumProperty Extends wxBaseEnumProperty

	Rem
	bbdoc: 
	End Rem
	Function CreateEnumPropertyWithArrays:wxEnumProperty(label:String, name:String, labels:String[], ..
			values:Int[] = Null, value:Int = 0)
		Return New wxEnumProperty.CreateWithArrays(label, name, labels, values, value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateWithArrays:wxEnumProperty(label:String, name:String, labels:String[], ..
			values:Int[] = Null, value:Int = 0)
		wxObjectPtr = bmx_wxenumproperty_createwitharrays(Self, label, name, labels, values, value)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateEnumPropertyWithChoice:wxEnumProperty(label:String, name:String, choices:wxPGChoices, value:Int = 0)
		Return New wxEnumProperty.CreateWithChoices(label, name, choices, value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateWithChoices:wxEnumProperty(label:String, name:String, choices:wxPGChoices, value:Int = 0)
		wxObjectPtr = bmx_wxenumproperty_createwithchoices(Self, label, name, choices.wxObjectPtr, value)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChoices:wxPGChoices()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEntry:String(index:Int, value:Int Var)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetIndexForValue:Int(value:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemCount:Int()
		' TODO
	End Method
	
End Type

Rem
bbdoc: Has dropdown list of wxWidgets system colours. 
End Rem
Type wxSystemColourProperty Extends wxEnumProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSystemColourProperty(label:String, name:String = Null, value:wxColour = Null)
		If value Then
			wxObjectPtr = bmx_wxsystemcolourproperty_create(Self, label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxsystemcolourproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Default is to use wxSystemSettings::GetColour(index). 
	End Rem
	Method GetColour:wxColour(index:Int)	
		' TODO
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxColourProperty Extends wxSystemColourProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxColourProperty(label:String, name:String = Null, value:wxColour = Null)
		If value Then
			wxObjectPtr = bmx_wxcolourproperty_create(Self, label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxcolourproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method

End Type

Rem
bbdoc: Property representing wxCursor. 
End Rem
Type wxCursorProperty Extends wxEnumProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxCursorProperty(label:String = Null, name:String = Null, value:Int = 0)
		wxObjectPtr = bmx_wxcursorproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Property representing image file(name). 
End Rem
Type wxImageFileProperty Extends wxFileProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxImageFileProperty(label:String = Null, name:String = Null, value:String = "")
		wxObjectPtr = bmx_wximagefileproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: Property representing wxDateTime.
about: <b>Supported special attributes:</b>
<ul>
<li>"DateFormat": Determines displayed date format.</li>
<li>"PickerStyle": Determines window style used with wxDatePickerCtrl. Default is wxDP_DEFAULT | wxDP_SHOWCENTURY. </li>
</ul>
End Rem
Type wxDateProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Method Create:wxDateProperty(label:String = Null, name:String = Null, value:wxDateTime = Null)
		If value Then
			wxObjectPtr = bmx_wxdateproperty_create(Self, label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxdateproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDatePickerStyle:Int()
		Return bmx_wxdateproperty_getdatepickerstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDateValue:wxDateTime()
		Return wxDateTime._create(bmx_wxdateproperty_getdatevalue(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFormat:String()
		Return bmx_wxdateproperty_getformat(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDateValue(dt:wxDateTime)
		bmx_wxdateproperty_setdatevalue(wxObjectPtr, dt.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFormat(format:String)
		bmx_wxdateproperty_setformat(wxObjectPtr, format)
	End Method
	
End Type

Rem
bbdoc: Property that manages a value resulting from wxMultiChoiceDialog.
about: Value is array of strings. You can get value as array of choice values/indices by calling
wxMultiChoiceProperty::GetValueAsArrayInt().
<p>
Supported special attributes:
<ul>
<li>"UserStringMode": If > 0, allow user to manually enter strings that are not in the list of choices. If
this value is 1, user strings are preferably placed in front of valid choices. If value is 2, then those
strings will placed behind valid choices. </li>
</ul>
</p>
End Rem
Type wxMultiChoiceProperty Extends wxPGProperty

	Rem
	bbdoc: 
	End Rem
	Function CreateMultiChoicePropertyWithArrays:wxMultiChoiceProperty(label:String, name:String, labels:String[], ..
			value:String[] = Null)
		Return New wxMultiChoiceProperty.CreateWithArrays(label, name, labels, value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateWithArrays:wxMultiChoiceProperty(label:String, name:String, labels:String[], ..
			value:String[] = Null)
		wxObjectPtr = bmx_wxmultichoiceproperty_createwitharrays(Self, label, name, labels, value)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function CreateMultiChoicePropertyWithChoice:wxMultiChoiceProperty(label:String, name:String, choices:wxPGChoices, value:String[] = Null)
		Return New wxMultiChoiceProperty.CreateWithChoices(label, name, choices, value)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateWithChoices:wxMultiChoiceProperty(label:String, name:String, choices:wxPGChoices, value:String[] = Null)
		wxObjectPtr = bmx_wxmultichoiceproperty_createwithchoices(Self, label, name, choices.wxObjectPtr, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxColourPropertyValue Extends wxObject

	Function _create:wxColourPropertyValue(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxColourPropertyValue = New wxColourPropertyValue
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcolourpropertyvalue_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
'bbdoc: 
'End Rem
Type wxPGPropArg

	Field pgidPtr:Byte Ptr

	Function _create:wxPGPropArg(pgidPtr:Byte Ptr)
		If pgidPtr Then
			Local this:wxPGPropArg = New wxPGPropArg
			this.pgidPtr = pgidPtr
			Return this
		End If
	End Function
	
	Method Delete()
		If pgidPtr Then
			bmx_wxpgproparg_delete(pgidPtr)
			pgidPtr = Null
		End If
	End Method

End Type
End Rem

Rem
bbdoc: Helper type for managing choices for properties.
about: Each entry can have label, value, bitmap, text colour, and background colour.
End Rem
Type wxPGChoices

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPGChoices(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPGChoices = New wxPGChoices
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateChoices:wxPGChoices()
		Return New wxPGChoices.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPGChoices()
		wxObjectPtr = bmx_wxpgchoices_create()
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Add:wxPGChoiceEntry(label:String, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_add(wxObjectPtr, label, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddEntries(labels:String[], values:Int[])
		bmx_wxpgchoices_addentries(wxObjectPtr, labels, values)
	End Method

	Rem
	bbdoc: Adds single item, sorted. 
	End Rem
	Method AddAsSorted:wxPGChoiceEntry(label:String, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_addassorted(wxObjectPtr, label, value))
	End Method
	
	Rem
	bbdoc: Deletes all items.
	End Rem
	Method Clear()
		bmx_wxpgchoices_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns number of items. 
	End Rem
	Method GetCount:Int()
		Return bmx_wxpgchoices_getcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns label of item.
	End Rem
	Method GetLabel:String(index:Int)
		Return bmx_wxpgchoices_getlabel(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabels:String[]()
		Return bmx_wxpgchoices_getlabels(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValue:Int(index:Int)
		Return bmx_wxpgchoices_getvalue(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasValue:Int(value:Int)
		Return bmx_wxpgchoices_hasvalue(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasValues:Int()
		Return bmx_wxpgchoices_hasvalues(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Index:Int(value:Int)
		Return bmx_wxpgchoices_index(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IndexForLabel:Int(label:String)
		Return bmx_wxpgchoices_indexforlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Insert:wxPGChoiceEntry(label:String, index:Int, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_insert(wxObjectPtr, label, index, value))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsOk:Int()
		Return bmx_wxpgchoices_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Item:wxPGChoiceEntry(index:Int)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_item(wxObjectPtr, index))
	End Method
	
	Rem
	bbdoc: Removes @count items starting at position @index.
	End Rem
	Method RemoveAt(index:Int, count:Int = 1)
		bmx_wxpgchoices_removeat(wxObjectPtr, index, count)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Set(labels:String[], values:Int[] = Null)
		bmx_wxpgchoices_set(wxObjectPtr, labels, values)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxpgchoices_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Attribute of a single choice.
End Rem
Type wxPGChoiceEntry Extends wxPGCell

	Function _create:wxPGChoiceEntry(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPGChoiceEntry = New wxPGChoiceEntry
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetBgCol:wxColour()
		Return wxColour._create(bmx_wxpgchoiceentry_getbgcol(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxpgchoiceentry_getbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFgCol:wxColour()
		Return wxColour._create(bmx_wxpgchoiceentry_getfgcol(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetText:String()
		Return bmx_wxpgchoiceentry_gettext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBgCol(col:wxColour)
		bmx_wxpgchoiceentry_setbgcol(wxObjectPtr, col.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxpgchoiceentry_setbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFgCol(col:wxColour)
		bmx_wxpgchoiceentry_setfgcol(wxObjectPtr, col.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetText(text:String)
		bmx_wxpgchoiceentry_settext(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValue:Int()
		Return bmx_wxpgchoiceentry_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasValue:Int()
		Return bmx_wxpgchoiceentry_hasvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValue(value:Int)
		bmx_wxpgchoiceentry_setvalue(wxObjectPtr, value)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxpgchoiceentry_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type


Rem
bbdoc: 
End Rem
Type wxPropertyGridIteratorBase

	Field wxObjectPtr:Byte Ptr

	Function _create:wxPropertyGridIteratorBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPropertyGridIteratorBase = New wxPropertyGridIteratorBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Returns True if at the end.
	End Rem
	Method AtEnd:Int()
		Return bmx_wxpropertygriditeratorbase_atend(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get current property.
	End Rem
	Method GetProperty:wxPGProperty()
		Return wxPGProperty._create(bmx_wxpropertygriditeratorbase_getproperty(wxObjectPtr))
	End Method
	
'	Rem
'	bbdoc: Get current property, as wxPGPropertyWithChildren, but Null If Not valid as such.
'	End Rem
'	Method GetPropertyWithChildren:wxPGPropertyWithChildren()
'		Return wxPGPropertyWithChildren._create(bmx_wxpropertygriditeratorbase_getpropertywithchildren(wxObjectPtr))
'	End Method
	
	Rem
	bbdoc: Iterate to the next property.
	End Rem
	Method NextProperty(iterateChildren:Int = True)
		bmx_wxpropertygriditeratorbase_nextproperty(wxObjectPtr, iterateChildren)
	End Method
	
	Rem
	bbdoc: Iterate to the previous property.
	End Rem
	Method PrevProperty()
		bmx_wxpropertygriditeratorbase_prevproperty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set base parent, ie. a property when, in which iteration returns, it ends.
	about: Default base parent is the root of the used wxPropertyGridState.
	End Rem
	Method SetBaseParent(baseParent:wxPGPropertyWithChildren)
		bmx_wxpropertygriditeratorbase_setbaseparent(wxObjectPtr, baseParent.wxObjectPtr)
	End Method

End Type

Rem
bbdoc: Preferable way to iterate through contents of wxPropertyGrid, wxPropertyGridManager, and wxPropertyGridPage.
about: See wxPropertyContainerMethods::GetIterator() for more information about usage.
End Rem
Type wxPropertyGridIterator Extends wxPropertyGridIteratorBase

End Type

Rem
bbdoc: 
End Rem
Type wxPGEditor Extends wxObject

	Function _create:wxPGEditor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPGEditor = New wxPGEditor
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxPGEditor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local prop:wxPGEditor = wxPGEditor(wxfind(wxObjectPtr))
			If Not prop Then
				Return wxPGEditor._create(wxObjectPtr)
			End If
			Return prop
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxPGCell

	Field wxObjectPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Method GetBgCol:wxColour()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBitmap:wxBitmap()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFgCol:wxColour()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetText:String()
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBgCol(col:wxColour)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBitmap(bitmap:wxBitmap)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFgCol(col:wxColour)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetText(text:String)
		' TODO
	End Method

End Type

Type wxPGCellRenderer
End Type

Type wxPGChoiceInfo
End Type

Type wxPGPropertyDataExt
End Type

Type wxPGEditorDialogAdapter
End Type

Type wxPGAttributeStorage
End Type

Rem
bbdoc: Holds information about events associated with wxPropertyGrid objects.
End Rem
Type wxPropertyGridEvent Extends wxCommandEvent

	Rem
	bbdoc: 
	End Rem
	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPropertyGridEvent = New wxPropertyGridEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns true if you can veto the action that the event is signaling.
	End Rem
	Method CanVeto:Int()
		Return bmx_wxpropertygridevent_canveto(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Disables property. 
	End Rem
	Method DisableProperty()
		bmx_wxpropertygridevent_disableproperty(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Enables property. 
	End Rem
	Method EnableProperty(enable:Int = True)
		bmx_wxpropertygridevent_enableproperty(wxEventPtr, enable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMainParent:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygridevent_getmainparent(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Returns associated property. 
	End Rem
	Method GetProperty:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygridevent_getproperty(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Returns client data of relevant property. 
	End Rem
	Method GetPropertyClientData:Object()
		' TODO
	End Method
	
	Rem
	bbdoc: Returns label of associated property. 
	End Rem
	Method GetPropertyLabel:String()
		Return bmx_wxpropertygridevent_getpropertylabel(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns global name of associated property. 
	End Rem
	Method GetPropertyName:String()
		Return bmx_wxpropertygridevent_getpropertyname(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as array of ints.
	End Rem
	Method GetPropertyValueAsArrayInt:Int[]()
		Return bmx_wxpropertygridevent_getpropertyvalueasarrayint(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as array of strings.
	End Rem
	Method GetPropertyValueAsArrayString:String[]()
		Return bmx_wxpropertygridevent_getpropertyvalueasarraystring(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as bool.
	End Rem
	Method GetPropertyValueAsBool:Int()
		Return bmx_wxpropertygridevent_getpropertyvalueasbool(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as double.
	End Rem
	Method GetPropertyValueAsDouble:Double()
		Return bmx_wxpropertygridevent_getpropertyvalueasdouble(wxEventPtr)
	End Method

	Rem
	bbdoc: Returns value of relevant property, as float.
	End Rem
	Method GetPropertyValueAsFloat:Float()
		Return GetPropertyValueAsDouble()
	End Method

	Rem
	bbdoc: Returns value of relevant property, as int.
	End Rem
	Method GetPropertyValueAsInt:Int()
		Return bmx_wxpropertygridevent_getpropertyvalueasint(wxEventPtr)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as (x, y) point.
	End Rem
	Method GetPropertyValueAsPoint(x:Int Var, y:Int Var)
		bmx_wxpropertygridevent_getpropertyvalueaspoint(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as (x, h) size.
	End Rem
	Method GetPropertyValueAsSize(w:Int Var, h:Int Var)
		bmx_wxpropertygridevent_getpropertyvalueassize(wxEventPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns value of relevant property, as string.
	End Rem
	Method GetPropertyValueAsString:String()
		Return bmx_wxpropertygridevent_getpropertyvalueasstring(wxEventPtr)
	End Method

	Rem
	bbdoc: Returns true if event has associated property.
	End Rem
	Method HasProperty:Int()
		Return bmx_wxpropertygridevent_hasproperty(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsPropertyEnabled:Int()
		Return bmx_wxpropertygridevent_ispropertyenabled(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCanVeto(canVeto:Int)
		' TODO or not required
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetProperty(p:wxPGProperty)
		' TODO
	End Method
	
	Rem
	bbdoc: Changes the associated property.
	End Rem
	Method SetPropertyGrid(pg:wxPropertyGrid)
		' TODO
	End Method
	
	'method SetValue(Const wxVariant &value)
	'end method
	
	Rem
	bbdoc: Set override validation failure behavior.
	about: Only effective if Veto was also called, and only allowed if event type is wxEVT_PG_CHANGING. 
	End Rem
	Method SetValidationFailureBehavior(flags:Int)
		' TODO
	End Method
	
	Rem
	bbdoc: Sets custom failure message for this time only.
	about: Only applies if wxPG_VFB_SHOW_MESSAGE is set in validation failure flags. 
	End Rem
	Method SetValidationFailureMessage(message:String)
		' TODO
	End Method
	
	Rem
	bbdoc: Call this from your event handler to veto action that the event is signaling.
	about: You can only veto a shutdown if wxPropertyGridEvent::CanVeto returns true.
	End Rem
	Method Veto(value:Int = True)
		bmx_wxpropertygridevent_veto(wxEventPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WasVetoed:Int()
		' TODO
	End Method
	

End Type

Type TPropertyGridEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_PG_SELECTED, ..
					wxEVT_PG_CHANGING, ..
					wxEVT_PG_CHANGED, ..
					wxEVT_PG_HIGHLIGHTED, ..
					wxEVT_PG_RIGHT_CLICK, ..
					wxEVT_PG_PAGE_CHANGED, ..
					wxEVT_PG_ITEM_EXPANDED, ..
					wxEVT_PG_ITEM_COLLAPSED, ..
					wxEVT_PG_DOUBLE_CLICK

					
				Return wxPropertyGridEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_PG_SELECTED, ..
					wxEVT_PG_CHANGING, ..
					wxEVT_PG_CHANGED, ..
					wxEVT_PG_HIGHLIGHTED, ..
					wxEVT_PG_RIGHT_CLICK, ..
					wxEVT_PG_PAGE_CHANGED, ..
					wxEVT_PG_ITEM_EXPANDED, ..
					wxEVT_PG_ITEM_COLLAPSED, ..
					wxEVT_PG_DOUBLE_CLICK
					
				Return bmx_wxpropertygrid_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TPropertyGridEventFactory


Type TPropertyGridResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxpropertygrid_addresourcehandler()
	End Method
		
End Type

New TPropertyGridResourceFactory
