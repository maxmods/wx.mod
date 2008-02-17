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
'


Rem
bbdoc: 
End Rem
Type wxPropertyContainerMethods Extends wxPanel

	Method AddPropertyChoice(prop:wxPGProperty, label:String, value:Int = INT_MAX) Abstract

	Method AddPropertyChoiceByName(name:String, label:String, value:Int = INT_MAX) Abstract
	
	Rem
	bbdoc: Appends property to the list.
	about: wxPropertyGrid assumes ownership of the object. Becomes child of most recently added category.
	End Rem
	Method Append:wxPGProperty(property:wxPGProperty) Abstract
		
	Method BeginAddChildren(prop:wxPGProperty) Abstract
	
	Method BeginAddChildrenByName(name:String) Abstract

	Method ClearPropertyValue:Int(prop:wxPGProperty) Abstract
	
	Method ClearPropertyValueByName:Int(name:String) Abstract

	Method ClearSelection:Int() Abstract

	Method Collapse:Int(prop:wxPGProperty) Abstract
	
	Method CollapseByName:Int(name:String) Abstract

	Method DeleteProperty(prop:wxPGProperty) Abstract
	
	Method DeletePropertyByName(name:String) Abstract

	Method DeletePropertyChoice(prop:wxPGProperty, index:Int) Abstract
	
	Method DeletePropertyChoiceByName(name:String, index:Int) Abstract

	Method DisableProperty:Int(prop:wxPGProperty) Abstract
	
	Method DisablePropertyByName:Int(name:String) Abstract

	Method EnableProperty:Int(prop:wxPGProperty, enable:Int = True) Abstract
	
	Method EnablePropertyByName:Int(name:String, enable:Int = True) Abstract

	Method EndAddChildren(prop:wxPGProperty) Abstract
	
	Method EndAddChildrenByName(name:String) Abstract
	
	Method Expand:Int(prop:wxPGProperty) Abstract

	Method ExpandByName:Int(name:String) Abstract
	
	
	Method GetFirst:wxPGProperty(flags:Int) Abstract
	
	Method GetIterator:wxPropertyGridIterator(flags:Int, firstProp:wxPGProperty = Null) Abstract
	
	Method GetNextSibling:wxPGProperty(prop:wxPGProperty) Abstract
	
	Method GetPropertiesWithFlag:wxPGProperty[](flags:Int, inverse:Int = True, iterFlags:Int) Abstract
	
	Method GetPropertyBySubName:wxPGProperty(name:String, subName:String) Abstract
	
	Method GetPropertyByName:wxPGProperty(name:String) Abstract
	
	Method GetPropertyCategory:wxPropertyCategory(prop:wxPGProperty) Abstract
	
	Method GetPropertyChoices:wxPGChoices(prop:wxPGProperty) Abstract
	
	Method GetPropertyClassName:String(prop:wxPGProperty) Abstract
	
	Method GetPropertyClientData:Object(prop:wxPGProperty) Abstract

	Method GetPropertyEditor:wxPGEditor(prop:wxPGProperty) Abstract

	Method GetPropertyHelpString:String(prop:wxPGProperty) Abstract

	Method GetPropertyImage:wxBitmap(prop:wxPGProperty) Abstract

	Method GetPropertyIndex:Int(prop:wxPGProperty) Abstract

	Method GetPropertyLabel:String(prop:wxPGProperty) Abstract

	Method GetPropertyName:String(prop:wxPGProperty) Abstract

	Method GetPropertyParent:wxPGProperty(prop:wxPGProperty) Abstract

	Method GetPropertyPtr:wxPGProperty(prop:wxPGProperty) Abstract

	Method GetPropertyShortClassName:String(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsArrayInt:Int[](prop:wxPGProperty) Abstract

	Method GetPropertyValueAsArrayString:String[](prop:wxPGProperty) Abstract

	Method GetPropertyValueAsBool:Int(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsDateTime:wxDateTime(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsDouble:Double(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsInt:Int(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsLong:Long(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsPoint(prop:wxPGProperty, x:Int Var, y:Int Var) Abstract

	Method GetPropertyValueAsSize(prop:wxPGProperty, w:Int Var, h:Int Var) Abstract

	Method GetPropertyValueAsString:String(prop:wxPGProperty) Abstract

	Method GetPropertyValueAsULong:Int(prop:wxPGProperty) Abstract

	Method GetPropertyValueType:String(prop:wxPGProperty) Abstract
	
	Method GetSelection:wxPGProperty() Abstract
	
	Method GetState:wxPropertyGridState() Abstract
	
	Method HideProperty:Int(prop:wxPGProperty, hide:Int = True) Abstract
	
	Method Insert:wxPGProperty(parent:wxPGProperty, index:Int, newproperty:wxPGProperty) Abstract
	
	Method InsertCategory:wxPGProperty(prop:wxPGProperty, index:Int, label:String) Abstract
	
	Method InsertPropertyChoice(prop:wxPGProperty, label:String, index:Int, value:Int = INT_MAX) Abstract
	
	Method IsPropertyCategory:Int(prop:wxPGProperty) Abstract
	
	Method IsPropertyEnabled:Int(prop:wxPGProperty) Abstract
	
	Method IsPropertyExpanded:Int(prop:wxPGProperty) Abstract
	
	Method IsPropertyModified:Int(prop:wxPGProperty) Abstract
	
	Method IsPropertyShown:Int(prop:wxPGProperty) Abstract
	
	Method IsPropertyUnspecified:Int(prop:wxPGProperty) Abstract
	
	Method LimitPropertyEditing(prop:wxPGProperty, limit:Int = True) Abstract
	
	Method NamesToProperties(properties:wxPGProperty[], names:String[]) Abstract
	
	Method PropertiesToNames(names:String[], properties:wxPGProperty[]) Abstract
	
	Method RefreshGrid(state:wxPropertyGridState = Null) Abstract
	
	Method ReplaceProperty:wxPGProperty(prop:wxPGProperty, property:wxPGProperty) Abstract
	
	Method SetPropertyCell(prop:wxPGProperty, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null) Abstract
	
	Method SetPropertyChoices(prop:wxPGProperty, choices:wxPGChoices) Abstract
	
	Method SetPropertyChoicesExclusive(prop:wxPGProperty) Abstract
	
	Method SetPropertyClientData(prop:wxPGProperty, clientData:Object) Abstract
	
	Method SetPropertyEditorbyName(prop:wxPGProperty, editorName:String) Abstract
	
	Method SetPropertyEditor(prop:wxPGProperty, editor:wxPGEditor) Abstract
	
	Method SetPropertyAttribute(prop:wxPGProperty, attrName:String, value:Int, argFlags:Int = 0) Abstract
	

	Method GetNextSiblingByName:wxPGProperty(name:String) Abstract
	
	Method GetPropertyByNameSubName:wxPGProperty(name:String, subName:String) Abstract
	
	Method GetPropertyCategoryName:wxPropertyCategory(name:String) Abstract
	
	Method GetPropertyChoicesByName:wxPGChoices(name:String) Abstract
	
	Method GetPropertyClassNameByName:String(name:String) Abstract
	
	Method GetPropertyClientDataByName:Object(name:String) Abstract

	Method GetPropertyEditorByName:wxPGEditor(name:String) Abstract

	Method GetPropertyHelpStringByName:String(name:String) Abstract

	Method GetPropertyImageByName:wxBitmap(name:String) Abstract

	Method GetPropertyIndexByName:Int(name:String) Abstract

	Method GetPropertyLabelByName:String(name:String) Abstract

	Method GetPropertyNameByName:String(name:String) Abstract

	Method GetPropertyParentByName:wxPGProperty(name:String) Abstract

	Method GetPropertyPtrByName:wxPGProperty(name:String) Abstract

	Method GetPropertyShortClassNameByName:String(name:String) Abstract

	Method GetPropertyValueAsArrayIntByName:Int[](name:String) Abstract

	Method GetPropertyValueAsArrayStringByName:String[](name:String) Abstract

	Method GetPropertyValueAsBoolByName:Int(name:String) Abstract

	Method GetPropertyValueAsDateTimeByName:wxDateTime(name:String) Abstract

	Method GetPropertyValueAsDoubleByName:Double(name:String) Abstract

	Method GetPropertyValueAsIntByName:Int(name:String) Abstract

	Method GetPropertyValueAsLongByName:Long(name:String) Abstract

	Method GetPropertyValueAsPointByName(name:String, x:Int Var, y:Int Var) Abstract

	Method GetPropertyValueAsSizeByName(name:String, w:Int Var, h:Int Var) Abstract

	Method GetPropertyValueAsStringByName:String(name:String) Abstract

	Method GetPropertyValueAsULongByName:Int(name:String) Abstract

	Method GetPropertyValueTypeByName:String(name:String) Abstract
	
	Method HidePropertyByName:Int(name:String, hide:Int = True) Abstract
	
	Method InsertByName:wxPGProperty(parent:String, index:Int, newproperty:wxPGProperty) Abstract
	
	Method InsertCategoryByName:wxPGProperty(name:String, index:Int, label:String) Abstract
	
	Method InsertPropertyChoiceByName(name:String, label:String, index:Int, value:Int = INT_MAX) Abstract
	
	Method IsPropertyCategoryByName:Int(name:String) Abstract
	
	Method IsPropertyEnabledByName:Int(name:String) Abstract
	
	Method IsPropertyExpandedByName:Int(name:String) Abstract
	
	Method IsPropertyModifiedByName:Int(name:String) Abstract
	
	Method IsPropertyShownByName:Int(name:String) Abstract
	
	Method IsPropertyUnspecifiedByName:Int(name:String) Abstract
	
	Method LimitPropertyEditingByName(name:String, limit:Int = True) Abstract
	
	Method ReplacePropertyByName:wxPGProperty(name:String, property:wxPGProperty) Abstract
	
	Method SetPropertyCellByName(name:String, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null) Abstract
	
	Method SetPropertyChoicesByName(name:String, choices:wxPGChoices) Abstract
	
	Method SetPropertyChoicesExclusiveByName(name:String) Abstract
	
	Method SetPropertyClientDatByNamea(name:String, clientData:Object) Abstract
	
	Method SetPropertyEditorbyPropNameAndName(name:String, editorName:String) Abstract
	
	Method SetPropertyEditorByPropName(name:String, editor:wxPGEditor) Abstract

	Method SetPropertyAttributeByName(name:String, attrName:String, value:Int, argFlags:Int = 0) Abstract
	

	Rem
	bbdoc: Associates the help string with property.
	about: By default, text is shown either in the manager's "description" text box or in the
	status bar. If extra window style wxPG_EX_HELP_AS_TOOLTIPS is used, then the text will appear
	as a tooltip.
	End Rem
	Method SetPropertyHelpString(prop:wxPGProperty, helpString:String) Abstract

	Method SetPropertyHelpStringByName(name:String, helpString:String) Abstract

	Method SetPropertyImage(prop:wxPGProperty, bmp:wxBitmap) Abstract
	
	Method SetPropertyLabel(prop:wxPGProperty, newproplabel:String) Abstract
	
	Method SetPropertyMaxLength:Int(prop:wxPGProperty, maxLen:Int) Abstract
	
	Method SetPropertyReadOnly(prop:wxPGProperty, set:Int = True) Abstract
	
	Method SetPropertyUnspecified(prop:wxPGProperty) Abstract
	
	Method SetPropertyValueIntArray(prop:wxPGProperty, value:Int[]) Abstract
	
	Method SetPropertyValueULong(prop:wxPGProperty, value:Long) Abstract
	
	Method SetPropertyValueLong(prop:wxPGProperty, value:Long) Abstract
	
	Method SetPropertyValueSize(prop:wxPGProperty, w:Int, h:Int) Abstract
	
	Method SetPropertyValuePoint(prop:wxPGProperty, x:Int, y:Int) Abstract
	
	Method SetPropertyValueBytePtr(prop:wxPGProperty, value:Byte Ptr) Abstract
	
	Method SetPropertyValueString(prop:wxPGProperty, value:String) Abstract
	
	Method SetPropertyValueDateTime(prop:wxPGProperty, time:wxDateTime) Abstract
	
	Method SetPropertyValueStringArray(prop:wxPGProperty, value:String[]) Abstract
	
	Method SetPropertyValueBool(prop:wxPGProperty, value:Int) Abstract
	
	Method SetPropertyValueDouble(prop:wxPGProperty, value:Double) Abstract
	
	Method SetPropertyValueInt(prop:wxPGProperty, value:Int) Abstract



	Method SetPropertyImageByName(name:String, bmp:wxBitmap) Abstract
	
	Method SetPropertyLabelByName(name:String, newproplabel:String) Abstract
	
	Method SetPropertyMaxLengthByName:Int(name:String, maxLen:Int) Abstract
	
	Method SetPropertyReadOnlyByName(name:String, set:Int = True) Abstract
	
	Method SetPropertyUnspecifiedByName(name:String) Abstract
	
	Method SetPropertyValueIntArrayByName(name:String, value:Int[]) Abstract
	
	Method SetPropertyValueULongByName(name:String, value:Long) Abstract
	
	Method SetPropertyValueLongByName(name:String, value:Long) Abstract
	
	Method SetPropertyValueSizeByName(name:String, w:Int, h:Int) Abstract
	
	Method SetPropertyValuePointByName(name:String, x:Int, y:Int) Abstract
	
	Method SetPropertyValueBytePtrByName(name:String, value:Byte Ptr) Abstract
	
	Method SetPropertyValueStringByName(name:String, value:String) Abstract
	
	Method SetPropertyValueDateTimeByName(name:String, time:wxDateTime) Abstract
	
	Method SetPropertyValueStringArrayByName(name:String, value:String[]) Abstract
	
	Method SetPropertyValueBoolByName(name:String, value:Int) Abstract
	
	Method SetPropertyValueDoubleByName(name:String, value:Double) Abstract
	
	Method SetPropertyValueIntByName(name:String, value:Int) Abstract
	
	Function InitAllTypeHandlers()
	End Function
	
	Function RegisterAdditionalEditors()
	End Function

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
bbdoc: 
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

	Method AddPropertyChoice(prop:wxPGProperty, label:String, value:Int = INT_MAX)
		bmx_wxpropertygrid_addpropertychoice(wxObjectPtr, prop.wxObjectPtr, label, value)
	End Method

	Method AddPropertyChoiceByName(name:String, label:String, value:Int = INT_MAX)
		bmx_wxpropertygrid_addpropertychoicebyname(wxObjectPtr, name, label, value)
	End Method

	Method Append:wxPGProperty(property:wxPGProperty)
		Return wxPGProperty._create(bmx_wxpropertygrid_append(wxObjectPtr, property.wxObjectPtr))
	End Method

'Rem
'	Rem
'	bbdoc: Deletes all properties.
'	about: Does Not free memory allocated For arrays etc. This should *Not* be called in wxPropertyGridManager.
'	End Rem
	Method Clear()
	End Method
	
	Method ClearModifiedStatus()
	End Method
	
'	Method ClearModifiedStatusId(id:wxPGPropArg)
'	End Method

	Method SetPropertyHelpString(prop:wxPGProperty, helpString:String)
		bmx_wxpropertygrid_setpropertyhelpstring(wxObjectPtr, prop.wxObjectPtr, helpString)
	End Method

	Method SetPropertyHelpStringByName(name:String, helpString:String)
		bmx_wxpropertygrid_setpropertyhelpstringbyname(wxObjectPtr, name, helpString)
	End Method
	
'	Method ClearPropertyValue(name:String)
'	End Method
	
'	Method ClearPropertyValueId(id:wxPGPropArg)
'	End Method
	
	Method ClearTargetPage()
	End Method
'	
'	Method Collapse(name:String)
'	End Method
	
'	Method CollapseId(id:wxPGPropArg)
'	End Method
'	
	Method Compact(show:Int)
	End Method
	
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
	
	Method GetPropertyBackgroundColour:wxColour(prop:wxPGProperty)
		Return wxColour._create(bmx_wxpropertygrid_getpropertybackgroundcolour(wxObjectPtr, prop.wxObjectPtr))
	End Method
	
	Method GetPropertyColour:wxColour(prop:wxPGProperty)
		Return wxColour._create(bmx_wxpropertygrid_getpropertycolour(wxObjectPtr, prop.wxObjectPtr))
	End Method
	
	Method GetPropertyTextColour:wxColour(prop:wxPGProperty)
		Return wxColour._create(bmx_wxpropertygrid_getpropertytextcolour(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyBackgroundColourByName:wxColour(name:String)
		Return wxColour._create(bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxObjectPtr, name))
	End Method
	
	Method GetPropertyColourByName:wxColour(name:String)
		Return wxColour._create(bmx_wxpropertygrid_getpropertycolourbyname(wxObjectPtr, name))
	End Method
	
	Method GetPropertyTextColourByName:wxColour(name:String)
		Return wxColour._create(bmx_wxpropertygrid_getpropertytextcolourbyname(wxObjectPtr, name))
	End Method

	Method BeginAddChildren(prop:wxPGProperty)
		bmx_wxpropertygrid_beginaddchildren(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method BeginAddChildrenByName(name:String)
		bmx_wxpropertygrid_beginaddchildrenbyname(wxObjectPtr, name)
	End Method

	Method ClearPropertyValue:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_clearpropertyvalue(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method ClearPropertyValueByName:Int(name:String)
		Return bmx_wxpropertygrid_clearpropertyvaluebyname(wxObjectPtr, name)
	End Method

	Method ClearSelection:Int()
		Return bmx_wxpropertygrid_clearselection(wxObjectPtr)
	End Method

	Method Collapse:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_collapse(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method CollapseByName:Int(name:String)
		Return bmx_wxpropertygrid_collapsebyname(wxObjectPtr, name)
	End Method

	Method DeleteProperty(prop:wxPGProperty)
		bmx_wxpropertygrid_deleteproperty(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method DeletePropertyByName(name:String)
		bmx_wxpropertygrid_deletepropertybyname(wxObjectPtr, name)
	End Method

	Method DeletePropertyChoice(prop:wxPGProperty, index:Int)
		bmx_wxpropertygrid_deletepropertychoice(wxObjectPtr, prop.wxObjectPtr, index)
	End Method
	
	Method DeletePropertyChoiceByName(name:String, index:Int)
		bmx_wxpropertygrid_deletepropertychoicebyname(wxObjectPtr, name, index)
	End Method

	Method DisableProperty:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_disableproperty(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method DisablePropertyByName:Int(name:String)
		Return bmx_wxpropertygrid_disablepropertybyname(wxObjectPtr, name)
	End Method

	Method EnableProperty:Int(prop:wxPGProperty, enable:Int = True)
		Return bmx_wxpropertygrid_enableproperty(wxObjectPtr, prop.wxObjectPtr, enable)
	End Method
	
	Method EnablePropertyByName:Int(name:String, enable:Int = True)
		Return bmx_wxpropertygrid_enablepropertybyname(wxObjectPtr, name, enable)
	End Method

	Method EndAddChildren(prop:wxPGProperty)
		bmx_wxpropertygrid_endaddchildren(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method EndAddChildrenByName(name:String)
		bmx_wxpropertygrid_endaddchildrenbyname(wxObjectPtr, name)
	End Method
	
	Method Expand:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_expand(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method ExpandByName:Int(name:String)
		Return bmx_wxpropertygrid_expandbyname(wxObjectPtr, name)
	End Method
	
	
	Method GetFirst:wxPGProperty(flags:Int)
		Return wxPGProperty._find(bmx_wxpropertygrid_getfirst(wxObjectPtr, flags))
	End Method
	
	Method GetIterator:wxPropertyGridIterator(flags:Int, firstProp:wxPGProperty = Null)
	End Method
	
	Method GetNextSibling:wxPGProperty(prop:wxPGProperty)
		Return wxPGProperty._find(bmx_wxpropertygrid_getnextsibling(wxObjectPtr, prop.wxObjectPtr))
	End Method


	Method GetPropertiesWithFlag:wxPGProperty[](flags:Int, inverse:Int = True, iterFlags:Int)
	End Method
	
	Method GetPropertyBySubName:wxPGProperty(name:String, subName:String)
	End Method
	
	Method GetPropertyByName:wxPGProperty(name:String)
	End Method
	
	Method GetPropertyCategory:wxPropertyCategory(prop:wxPGProperty)
	End Method
	
	Method GetPropertyChoices:wxPGChoices(prop:wxPGProperty)
		Return wxPGChoices._create(bmx_wxpropertygrid_getpropertychoices(wxObjectPtr, prop.wxObjectPtr))
	End Method
	
	Method GetPropertyClassName:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyclassname(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method GetPropertyClientData:Object(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyclientdata(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyEditor:wxPGEditor(prop:wxPGProperty)
		Return wxPGEditor._find(bmx_wxpropertygrid_getpropertyeditor(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyHelpString:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyhelpstring(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyImage:wxBitmap(prop:wxPGProperty)
		Return wxBitmap._create(bmx_wxpropertygrid_getpropertyimage(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyIndex:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyindex(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyLabel:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertylabel(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyName:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyname(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyParent:wxPGProperty(prop:wxPGProperty)
		Return wxPGProperty._find(bmx_wxpropertygrid_getpropertyparent(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyPtr:wxPGProperty(prop:wxPGProperty)
		Return wxPGProperty._find(bmx_wxpropertygrid_getpropertyptr(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyShortClassName:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyshortclassname(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsArrayInt:Int[](prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasarrayint(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsArrayString:String[](prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasarraystring(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsBool:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasbool(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsDateTime:wxDateTime(prop:wxPGProperty)
		Return wxDateTime._create(bmx_wxpropertygrid_getpropertyvalueasdatetime(wxObjectPtr, prop.wxObjectPtr))
	End Method

	Method GetPropertyValueAsDouble:Double(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasdouble(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsInt:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasint(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsLong:Long(prop:wxPGProperty)
		Local value:Long
		bmx_wxpropertygrid_getpropertyvalueaslong(wxObjectPtr, prop.wxObjectPtr, Varptr value)
	End Method

	Method GetPropertyValueAsPoint(prop:wxPGProperty, x:Int Var, y:Int Var)
		bmx_wxpropertygrid_getpropertyvalueaspoint(wxObjectPtr, prop.wxObjectPtr, Varptr x, Varptr y)
	End Method

	Method GetPropertyValueAsSize(prop:wxPGProperty, w:Int Var, h:Int Var)
		bmx_wxpropertygrid_getpropertyvalueassize(wxObjectPtr, prop.wxObjectPtr, Varptr w, Varptr h)
	End Method

	Method GetPropertyValueAsString:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvalueasstring(wxObjectPtr, prop.wxObjectPtr)
	End Method

	Method GetPropertyValueAsULong:Int(prop:wxPGProperty)
	End Method

	Method GetPropertyValueType:String(prop:wxPGProperty)
		Return bmx_wxpropertygrid_getpropertyvaluetype(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method GetSelection:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygrid_getselection(wxObjectPtr))
	End Method
	
	Method GetState:wxPropertyGridState()
	End Method
	
	Method HideProperty:Int(prop:wxPGProperty, hide:Int = True)
	End Method
	
	Method Insert:wxPGProperty(parent:wxPGProperty, index:Int, newproperty:wxPGProperty)
	End Method
	
	Method InsertCategory:wxPGProperty(prop:wxPGProperty, index:Int, label:String)
	End Method
	
	Method InsertPropertyChoice(prop:wxPGProperty, label:String, index:Int, value:Int = INT_MAX)
	End Method
	
	Method IsPropertyCategory:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_ispropertcategory(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method IsPropertyEnabled:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_ispropertyenabled(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method IsPropertyExpanded:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_ispropertyexpanded(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method IsPropertyModified:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_ispropertymodified(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method IsPropertyShown:Int(prop:wxPGProperty)
		Return bmx_wxpropertygrid_ispropertyshown(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method IsPropertyUnspecified:Int(prop:wxPGProperty)
	End Method
	
	Method LimitPropertyEditing(prop:wxPGProperty, limit:Int = True)
	End Method
	
	Method NamesToProperties(properties:wxPGProperty[], names:String[])
	End Method
	
	Method PropertiesToNames(names:String[], properties:wxPGProperty[])
	End Method
	
	Method RefreshGrid(state:wxPropertyGridState = Null)
	End Method
	
	Method ReplaceProperty:wxPGProperty(prop:wxPGProperty, property:wxPGProperty)
	End Method
	
	Method SetPropertyCell(prop:wxPGProperty, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null)
	End Method
	
	Method SetPropertyChoices(prop:wxPGProperty, choices:wxPGChoices)
		bmx_wxpropertygrid_setpropertychoices(wxObjectPtr, prop.wxObjectPtr, choices.wxObjectPtr)
	End Method
	
	Method SetPropertyChoicesExclusive(prop:wxPGProperty)
		bmx_wxpropertygrid_setpropertychoicesexclusive(wxObjectPtr, prop.wxObjectPtr)
	End Method
	
	Method SetPropertyClientData(prop:wxPGProperty, clientData:Object)
	End Method
	
	Method SetPropertyEditorbyName(prop:wxPGProperty, editorName:String)
	End Method
	
	Method SetPropertyEditor(prop:wxPGProperty, editor:wxPGEditor)
	End Method
	


	Method GetNextSiblingByName:wxPGProperty(name:String)
	End Method
	
	Method GetPropertyByNameSubName:wxPGProperty(name:String, subName:String)
	End Method
	
	Method GetPropertyCategoryName:wxPropertyCategory(name:String)
	End Method
	
	Method GetPropertyChoicesByName:wxPGChoices(name:String)
	End Method
	
	Method GetPropertyClassNameByName:String(name:String)
	End Method
	
	Method GetPropertyClientDataByName:Object(name:String)
	End Method

	Method GetPropertyEditorByName:wxPGEditor(name:String)
	End Method

	Method GetPropertyHelpStringByName:String(name:String)
	End Method

	Method GetPropertyImageByName:wxBitmap(name:String)
	End Method

	Method GetPropertyIndexByName:Int(name:String)
	End Method

	Method GetPropertyLabelByName:String(name:String)
	End Method

	Method GetPropertyNameByName:String(name:String)
	End Method

	Method GetPropertyParentByName:wxPGProperty(name:String)
	End Method

	Method GetPropertyPtrByName:wxPGProperty(name:String)
	End Method

	Method GetPropertyShortClassNameByName:String(name:String)
		Return bmx_wxpropertygrid_getpropertyshortclassnamebyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsArrayIntByName:Int[](name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsArrayStringByName:String[](name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsBoolByName:Int(name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsDateTimeByName:wxDateTime(name:String)
		Return wxDateTime._create(bmx_wxpropertygrid_getpropertyvalueasdatetimebyname(wxObjectPtr, name))
	End Method

	Method GetPropertyValueAsDoubleByName:Double(name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasdoublebyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsIntByName:Int(name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasintbyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsLongByName:Long(name:String)
		Local value:Long
		bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxObjectPtr, name, Varptr value)
		Return value
	End Method

	Method GetPropertyValueAsPointByName(name:String, x:Int Var, y:Int Var)
		bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxObjectPtr, name, Varptr x, Varptr y)
	End Method

	Method GetPropertyValueAsSizeByName(name:String, w:Int Var, h:Int Var)
		bmx_wxpropertygrid_getpropertyvalueassizebyname(wxObjectPtr, name, Varptr w, Varptr h)
	End Method

	Method GetPropertyValueAsStringByName:String(name:String)
		Return bmx_wxpropertygrid_getpropertyvalueasstringbyname(wxObjectPtr, name)
	End Method

	Method GetPropertyValueAsULongByName:Int(name:String)
	End Method

	Method GetPropertyValueTypeByName:String(name:String)
		Return bmx_wxpropertygrid_getpropertyvaluetypebyname(wxObjectPtr, name)
	End Method

	Method HidePropertyByName:Int(name:String, hide:Int = True)
	End Method
	
	Method InsertByName:wxPGProperty(parent:String, index:Int, newproperty:wxPGProperty)
	End Method
	
	Method InsertCategoryByName:wxPGProperty(name:String, index:Int, label:String)
	End Method
	
	Method InsertPropertyChoiceByName(name:String, label:String, index:Int, value:Int = INT_MAX)
	End Method
	
	Method IsPropertyCategoryByName:Int(name:String)
	End Method
	
	Method IsPropertyEnabledByName:Int(name:String)
	End Method
	
	Method IsPropertyExpandedByName:Int(name:String)
	End Method
	
	Method IsPropertyModifiedByName:Int(name:String)
	End Method
	
	Method IsPropertyShownByName:Int(name:String)
	End Method
	
	Method IsPropertyUnspecifiedByName:Int(name:String)
	End Method
	
	Method LimitPropertyEditingByName(name:String, limit:Int = True)
	End Method
	
	Method ReplacePropertyByName:wxPGProperty(name:String, property:wxPGProperty)
	End Method
	
	Method SetPropertyCellByName(name:String, column:Int, text:String = "", bitmap:wxBitmap = Null, fgCol:wxColour = Null, bgCol:wxColour = Null)
	End Method
	
	Method SetPropertyChoicesByName(name:String, choices:wxPGChoices)
		bmx_wxpropertygrid_setpropertychoicesbyname(wxObjectPtr, name, choices.wxObjectPtr)
	End Method
	
	Method SetPropertyChoicesExclusiveByName(name:String)
		bmx_wxpropertygrid_setpropertychoicesexclusivebyname(wxObjectPtr, name)
	End Method
	
	Method SetPropertyClientDatByNamea(name:String, clientData:Object)
	End Method
	
	Method SetPropertyEditorbyPropNameAndName(name:String, editorName:String)
	End Method
	
	Method SetPropertyEditorByPropName(name:String, editor:wxPGEditor)
	End Method
	
	Method SetPropertyImage(prop:wxPGProperty, bmp:wxBitmap)
	End Method
	
	Method SetPropertyLabel(prop:wxPGProperty, newproplabel:String)
	End Method
	
	Method SetPropertyMaxLength:Int(prop:wxPGProperty, maxLen:Int)
		Return bmx_wxpropertygrid_setpropertymaxlength(wxObjectPtr, prop.wxObjectPtr, maxLen)
	End Method
	
	Method SetPropertyReadOnly(prop:wxPGProperty, set:Int = True)
	End Method
	
	Method SetPropertyUnspecified(prop:wxPGProperty)
	End Method
	
	Method SetPropertyValueIntArray(prop:wxPGProperty, value:Int[])
	End Method
	
	Method SetPropertyValueULong(prop:wxPGProperty, value:Long)
	End Method
	
	Method SetPropertyValueLong(prop:wxPGProperty, value:Long)
	End Method
	
	Method SetPropertyValueSize(prop:wxPGProperty, w:Int, h:Int)
	End Method
	
	Method SetPropertyValuePoint(prop:wxPGProperty, x:Int, y:Int)
	End Method
	
	Method SetPropertyValueBytePtr(prop:wxPGProperty, value:Byte Ptr)
	End Method
	
	Method SetPropertyValueString(prop:wxPGProperty, value:String)
	End Method
	
	Method SetPropertyValueDateTime(prop:wxPGProperty, time:wxDateTime)
	End Method
	
	Method SetPropertyValueStringArray(prop:wxPGProperty, value:String[])
	End Method
	
	Method SetPropertyValueBool(prop:wxPGProperty, value:Int)
	End Method
	
	Method SetPropertyValueDouble(prop:wxPGProperty, value:Double)
	End Method
	
	Method SetPropertyValueInt(prop:wxPGProperty, value:Int)
	End Method

	Method SetPropertyImageByName(name:String, bmp:wxBitmap)
	End Method
	
	Method SetPropertyLabelByName(name:String, newproplabel:String)
	End Method
	
	Method SetPropertyMaxLengthByName:Int(name:String, maxLen:Int)
		Return bmx_wxpropertygrid_setpropertymaxlengthbyname(wxObjectPtr, name, maxLen)
	End Method
	
	Method SetPropertyReadOnlyByName(name:String, set:Int = True)
	End Method
	
	Method SetPropertyUnspecifiedByName(name:String)
	End Method
	
	Method SetPropertyValueIntArrayByName(name:String, value:Int[])
	End Method
	
	Method SetPropertyValueULongByName(name:String, value:Long)
	End Method
	
	Method SetPropertyValueLongByName(name:String, value:Long)
	End Method
	
	Method SetPropertyValueSizeByName(name:String, w:Int, h:Int)
	End Method
	
	Method SetPropertyValuePointByName(name:String, x:Int, y:Int)
	End Method
	
	Method SetPropertyValueBytePtrByName(name:String, value:Byte Ptr)
	End Method
	
	Method SetPropertyValueStringByName(name:String, value:String)
	End Method
	
	Method SetPropertyValueDateTimeByName(name:String, time:wxDateTime)
	End Method
	
	Method SetPropertyValueStringArrayByName(name:String, value:String[])
	End Method
	
	Method SetPropertyValueBoolByName(name:String, value:Int)
	End Method
	
	Method SetPropertyValueDoubleByName(name:String, value:Double)
	End Method
	
	Method SetPropertyValueIntByName(name:String, value:Int)
	End Method

	Method SetPropertyAttributeByName(name:String, attrName:String, value:Int, argFlags:Int = 0)
		bmx_wxpropertygrid_setpropertyattributebyname(wxObjectPtr, name, attrName, value, argFlags)
	End Method

	Method SetPropertyAttribute(prop:wxPGProperty, attrName:String, value:Int, argFlags:Int = 0)
		bmx_wxpropertygrid_setpropertyattribute(wxObjectPtr, prop.wxObjectPtr, attrName, value, argFlags)
	End Method

	Method SetPropertyAttributeStringByName(name:String, attrName:String, value:String, argFlags:Int = 0)
		bmx_wxpropertygrid_setpropertyattributestringbyname(wxObjectPtr, name, attrName, value, argFlags)
	End Method

	Method SetPropertyAttributeString(prop:wxPGProperty, attrName:String, value:String, argFlags:Int = 0)
		bmx_wxpropertygrid_setpropertyattributestring(wxObjectPtr, prop.wxObjectPtr, attrName, value, argFlags)
	End Method

End Type

Rem
bbdoc: 
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

	Method AddChild(prop:wxPGProperty)
	End Method
	
	Method AppendChoice:Int(label:String, value:Int = INT_MAX)
	End Method
	
	Method CanHaveExtraChildren:Int()
	End Method
	
	Method ClearFlag(flag:Int)
	End Method
	
	Method DeleteChoice(index:Int)
	End Method
	
	Method Empty()
	End Method
	
	Method EnsureDataExt:Int()
	End Method
	
	Method FixIndexesOfChildren(starthere:Int = 0)
	End Method
	
	Method GetArrIndex:Int()
	End Method
	
	Method GetAttributeAsInt:Int(name:String, defVal:Int)
	End Method
	
	Method GetAttributeAsString:String(name:String, defVal:String)
	End Method
	
	Method GetBaseName:String()
	End Method
	
	Method GetCell:wxPGCell(column:Int)
	End Method
	
	Method GetCellRenderer:wxPGCellRenderer(column:Int)
	End Method
	
	Method GetChildCount:Int()
	End Method
	
	Method GetChildrenHeight:Int(lh:Int, iMax:Int = -1)
	End Method
	
	Method GetChoiceCount:Int()
	End Method
	
	Method GetChoiceInfo:Int(choiceinfo:wxPGChoiceInfo)
	End Method
	
	Method GetChoices:wxPGChoices()
	End Method
	
	Method GetChoiceString:String(index:Int)
	End Method
	
	Method GetClassName:String()
	End Method
	
	Method GetClientData:Object()
	End Method
	
	Method GetColumnEditor:wxPGEditor(column:Int)
	End Method
	
	Method GetCommonValue:Int()
	End Method
	
	Method GetCount:Int()
	End Method
	
	Method GetCurrentChoice:wxPGChoiceEntry()
	End Method
	
	Method GetDataExt:wxPGPropertyDataExt()
	End Method
	
	Method GetDepth:Int()
	End Method
	
	Method GetDisplayedCommonValueCount:Int()
	End Method
	
	Method GetDisplayedString:String()
	End Method
	
	Method GetEditorClass:wxPGEditor()
	End Method
	
	Method GetEditorDialog:wxPGEditorDialogAdapter()
	End Method
	
	Method GetFlags:Int()
	End Method
	
	Method GetFlagsAsString:String(flagsMask:Int)
	End Method
	
	Method GetGrid:wxPropertyGrid()
	End Method
	
	Method GetGridIfDisplayedwxPropertyGrid()
	End Method
	
	Method GetHelpString:String()
	End Method
	
'	Method GetId:wxPGId()
'	End Method
	
	Method GetImageSize(w:Int Var, h:Int Var)
	End Method
	
	Method GetIndexInParent:Int()
	End Method
	
	Method GetItemAtY:wxPGProperty(y:Int, lh:Int, nextItemY:Int Var)
	End Method
	
	Method GetLabel:String()
	End Method
	
	Method GetLastVisibleSubItem:wxPGProperty()
	End Method
	
	Method GetMainParent:wxPGProperty()
	End Method
	
	Method GetMaxLength:Int()
	End Method
	
	Method GetName:String()
	End Method
	
	Method GetParent:wxPGProperty()
	End Method
	
	Method GetParentState:wxPropertyGridState()
	End Method
	
	Method GetPropertyByName:wxPGProperty(name:String)
	End Method
	
	Method GetType:String()
	End Method
	
	Method GetValueAsString:String()
	End Method
	
	Method GetValueAsDouble:Double()
	End Method
	
	Method GetValueAsBool:Int()
	End Method
	
	Method GetValueAsInt:Int()
	End Method
	
	Method GetValueString:String(argFlags:Int = 0)
	End Method
	
	Method GetY:Int()
	End Method
	
	Method HasFlag:Int(flag:Int)
	End Method
	
	Method Hide:Int(hide:Int)
	End Method
	
	Method Index:Int(p:wxPGProperty)
	End Method
	
	Method InsertChoice:Int(label:String, index:Int, value:Int = INT_MAX)
	End Method
	
	Method IsCategory:Int()
	End Method
	
	Method IsEnabled:Int()
	End Method
	
	Method IsExpanded:Int()
	End Method
	
	Method IsFlagSet:Int(flag:Int)
	End Method
	
	Method IsRoot:Int()
	End Method
	
	Method IsSomeParent:Int(candidateParent:wxPGProperty)
	End Method
	
	Method IsSubProperty:Int()
	End Method
	
	Method IsValueType:Int(s:String)
	End Method
	
	Method IsValueUnspecified:Int()
	End Method
	
	Method IsVisible:Int()
	End Method
	
	Method Item:wxPGProperty(i:Int)
	End Method
	
	Method Last:wxPGProperty()
	End Method
	
	Method PrepareValueForDialogEditing:Int(propgrid:wxPropertyGrid)
	End Method
	
	Method RecreateEditor:Int()
	End Method
	
	Method RefreshChildren()
	End Method
	
	Method RefreshEditor()
	End Method
	
	Method SetAttributeString(name:String, value:String)
		bmx_wxpgproperty_setattributestring(wxObjectPtr, name, value)
	End Method

	Method SetAttributeInt(name:String, value:Int)
		bmx_wxpgproperty_setattributeint(wxObjectPtr, name, value)
	End Method

	Method SetAttributeDouble(name:String, value:Double)
		bmx_wxpgproperty_setattributedouble(wxObjectPtr, name, value)
	End Method

	Method SetAttributeBool(name:String, value:Int)
		bmx_wxpgproperty_setattributebool(wxObjectPtr, name, value)
	End Method
	
	Method SetAttributes(attributes:wxPGAttributeStorage)
	End Method
	
	Method SetCell(column:Int, cellObj:wxPGCell)
	End Method
	
	Method SetChoices:Int(labels:String[], values:Int[] = Null)
	End Method
	
	Method SetChoiceSelection(newValue:Int, choiceInfo:wxPGChoiceInfo)
	End Method
	
	Method SetChoicesExclusive()
	End Method
	
	Method SetClientData(clientData:Object)
	End Method
	
	Method SetCommonValue(commonValue:Int)
	End Method
	
	Method SetEditorByName(editorName:String)
	End Method
	
	Method SetEditor(editor:wxPGEditor)
	End Method
	
	Method SetExpanded(expanded:Int)
	End Method
	
	Method SetFlag(flag:Int)
	End Method
	
	Method SetFlagsFromString(s:String)
	End Method
	
	Method SetHelpString(helpString:String)
	End Method
	
	Method SetLabel(label:String)
	End Method
	
	Method SetMaxLength:Int(maxLen:Int)
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

	Method Create:wxStringProperty(label:String = Null, name:String = Null, value:String = Null)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxstringproperty_create(Self, label, name, value)
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxIntProperty Extends wxPGProperty

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
Type wxBoolProperty Extends wxPGProperty

	Method Create:wxBoolProperty(label:String = Null, name:String = Null, value:Int = False)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxboolproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxFlagsProperty Extends wxPGProperty

	Method Create:wxFlagsProperty(label:String = Null, name:String = Null, labels:String[] = Null, ..
			values:Int[] = Null, value:Int = 0)
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxflagsproperty_create(Self, label, name, labels, values, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxFileProperty Extends wxPGProperty

	Method Create:wxFileProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxfileproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxLongStringProperty Extends wxPGProperty

	Method Create:wxLongStringProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxlongstringproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxDirProperty Extends wxPGProperty

	Method Create:wxDirProperty(label:String = Null, name:String = Null, value:String = "")
		If label = wxPG_LABEL label = Null
		If name = wxPG_LABEL name = Null
		wxObjectPtr = bmx_wxdirproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxArrayStringProperty Extends wxPGProperty

	Method Create:wxArrayStringProperty(label:String = Null, name:String = Null, value:String[] = Null)
		wxObjectPtr = bmx_wxarraystringproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type



Rem
bbdoc: 
End Rem
Type wxParentProperty Extends wxPGPropertyWithChildren
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

	Function CreateEnumPropertyWithArrays:wxEnumProperty(label:String, name:String, labels:String[], ..
			values:Int[] = Null, value:Int = 0)
		Return New wxEnumProperty.CreateWithArrays(label, name, labels, values, value)
	End Function

	Method CreateWithArrays:wxEnumProperty(label:String, name:String, labels:String[], ..
			values:Int[] = Null, value:Int = 0)
		wxObjectPtr = bmx_wxenumproperty_createwitharrays(Self, label, name, labels, values, value)
		Return Self
	End Method

	Function CreateEnumPropertyWithChoice:wxEnumProperty(label:String, name:String, choices:wxPGChoices, value:Int = 0)
		Return New wxEnumProperty.CreateWithChoices(label, name, choices, value)
	End Function

	Method CreateWithChoices:wxEnumProperty(label:String, name:String, choices:wxPGChoices, value:Int = 0)
		wxObjectPtr = bmx_wxenumproperty_createwithchoices(Self, label, name, choices.wxObjectPtr, value)
		Return Self
	End Method
	
	Method GetChoices:wxPGChoices()
	End Method
	
	Method GetEntry:String(index:Int, value:Int Var)
	End Method
	
	Method GetIndexForValue:Int(value:Int)
	End Method
	
	Method GetItemCount:Int()
	End Method
	
	
	
End Type

Rem
bbdoc: 
End Rem
Type wxSystemColourProperty Extends wxEnumProperty

	Method Create:wxSystemColourProperty(label:String, name:String = Null, value:wxColour = Null)
		If value Then
			wxObjectPtr = bmx_wxsystemcolourproperty_create(Self, label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxsystemcolourproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxCursorProperty Extends wxEnumProperty

	Method Create:wxCursorProperty(label:String = Null, name:String = Null, value:Int = 0)
		wxObjectPtr = bmx_wxcursorproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxImageFileProperty Extends wxFileProperty

	Method Create:wxImageFileProperty(label:String = Null, name:String = Null, value:String = "")
		wxObjectPtr = bmx_wximagefileproperty_create(Self, label, name, value)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxDateProperty Extends wxPGProperty

	Method Create:wxDateProperty(label:String = Null, name:String = Null, value:wxDateTime = Null)
		If value Then
			wxObjectPtr = bmx_wxdateproperty_create(Self, label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxdateproperty_create(Self, label, name, Null)
		End If
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxMultiChoiceProperty Extends wxPGProperty

	Function CreateMultiChoicePropertyWithArrays:wxMultiChoiceProperty(label:String, name:String, labels:String[], ..
			value:Int[] = Null)
		Return New wxMultiChoiceProperty.CreateWithArrays(label, name, labels, value)
	End Function

	Method CreateWithArrays:wxMultiChoiceProperty(label:String, name:String, labels:String[], ..
			value:Int[] = Null)
		wxObjectPtr = bmx_wxmultichoiceproperty_createwitharrays(Self, label, name, labels, value)
		Return Self
	End Method

	Function CreateMultiChoicePropertyWithChoice:wxMultiChoiceProperty(label:String, name:String, choices:wxPGChoices, value:Int[] = Null)
		Return New wxMultiChoiceProperty.CreateWithChoices(label, name, choices, value)
	End Function

	Method CreateWithChoices:wxMultiChoiceProperty(label:String, name:String, choices:wxPGChoices, value:Int[] = Null)
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

	Function CreateChoices:wxPGChoices()
		Return New wxPGChoices.Create()
	End Function
	
	Method Create:wxPGChoices()
		wxObjectPtr = bmx_wxpgchoices_create()
		Return Self
	End Method
	
	Method Add:wxPGChoiceEntry(label:String, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_add(wxObjectPtr, label, value))
	End Method
	
	Method AddEntries(labels:String[], values:Int[])
		bmx_wxpgchoices_addentries(wxObjectPtr, labels, values)
	End Method

	Method AddAsSorted:wxPGChoiceEntry(label:String, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_addassorted(wxObjectPtr, label, value))
	End Method
	
	Method GetCount:Int()
		Return bmx_wxpgchoices_getcount(wxObjectPtr)
	End Method
	
	Method GetLabel:String(index:Int)
		Return bmx_wxpgchoices_getlabel(wxObjectPtr, index)
	End Method
	
	Method GetLabels:String[]()
		Return bmx_wxpgchoices_getlabels(wxObjectPtr)
	End Method
	
	Method GetValue:Int(index:Int)
		Return bmx_wxpgchoices_getvalue(wxObjectPtr, index)
	End Method
	
	Method HasValue:Int(value:Int)
		Return bmx_wxpgchoices_hasvalue(wxObjectPtr, value)
	End Method
	
	Method HasValues:Int()
		Return bmx_wxpgchoices_hasvalues(wxObjectPtr)
	End Method
	
	Method Index:Int(value:Int)
		Return bmx_wxpgchoices_index(wxObjectPtr, value)
	End Method
	
	Method IndexForLabel:Int(label:String)
		Return bmx_wxpgchoices_indexforlabel(wxObjectPtr, label)
	End Method
	
	Method Insert:wxPGChoiceEntry(label:String, index:Int, value:Int = INT_MAX)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_insert(wxObjectPtr, label, index, value))
	End Method
	
	Method IsOk:Int()
		Return bmx_wxpgchoices_isok(wxObjectPtr)
	End Method
	
	Method Item:wxPGChoiceEntry(index:Int)
		Return wxPGChoiceEntry._create(bmx_wxpgchoices_item(wxObjectPtr, index))
	End Method
	
	Method RemoveAt(index:Int, count:Int = 1)
		bmx_wxpgchoices_removeat(wxObjectPtr, index, count)
	End Method
	
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

	Method GetBgCol:wxColour()
		Return wxColour._create(bmx_wxpgchoiceentry_getbgcol(wxObjectPtr))
	End Method
	
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxpgchoiceentry_getbitmap(wxObjectPtr))
	End Method
	
	Method GetFgCol:wxColour()
		Return wxColour._create(bmx_wxpgchoiceentry_getfgcol(wxObjectPtr))
	End Method
	
	Method GetText:String()
		Return bmx_wxpgchoiceentry_gettext(wxObjectPtr)
	End Method
	
	Method SetBgCol(col:wxColour)
		bmx_wxpgchoiceentry_setbgcol(wxObjectPtr, col.wxObjectPtr)
	End Method
	
	Method SetBitmap(bitmap:wxBitmap)
		bmx_wxpgchoiceentry_setbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Method SetFgCol(col:wxColour)
		bmx_wxpgchoiceentry_setfgcol(wxObjectPtr, col.wxObjectPtr)
	End Method
	
	Method SetText(text:String)
		bmx_wxpgchoiceentry_settext(wxObjectPtr, text)
	End Method
	
	Method GetValue:Int()
		Return bmx_wxpgchoiceentry_getvalue(wxObjectPtr)
	End Method
	
	Method HasValue:Int()
		Return bmx_wxpgchoiceentry_hasvalue(wxObjectPtr)
	End Method
	
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

Type wxPGCell

	Field wxObjectPtr:Byte Ptr

	Method GetBgCol:wxColour()
	End Method
	
	Method GetBitmap:wxBitmap()
	End Method
	
	Method GetFgCol:wxColour()
	End Method
	
	Method GetText:String()
	End Method
	
	Method SetBgCol(col:wxColour)
	End Method
	
	Method SetBitmap(bitmap:wxBitmap)
	End Method
	
	Method SetFgCol(col:wxColour)
	End Method
	
	Method SetText(text:String)
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

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxPropertyGridEvent = New wxPropertyGridEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Method CanVeto:Int()
	End Method
	
	Method DisableProperty()
	End Method
	
	Method EnableProperty(enable:Int = True)
	End Method
	
	Method GetMainParent:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygridevent_getmainparent(wxEventPtr))
	End Method
	
	Method GetProperty:wxPGProperty()
		Return wxPGProperty._find(bmx_wxpropertygridevent_getproperty(wxEventPtr))
	End Method
	
	Method GetPropertyClientData:Object()
	End Method
	
	Method GetPropertyLabel:String()
	End Method
	
	Method GetPropertyName:String()
	End Method
	
	Method GetPropertyPtr:wxPGProperty()
	End Method
	
	Method GetPropertyValueAsArrayInt:Int[]()
	End Method
	
	Method GetPropertyValueAsArrayString:String[]()
	End Method
	
	Method GetPropertyValueAsBool:Int()
	End Method
	
	Method GetPropertyValueAsDouble:Double()
	End Method
	
	Method GetPropertyValueAsInt:Int()
	End Method
	
	Method GetPropertyValueAsPoint(x:Int Var, y:Int Var)
	End Method
	
	Method GetPropertyValueAsSize(w:Int Var, h:Int Var)
	End Method
	
	Method GetPropertyValueAsString:String()
	End Method
	
	Method HasProperty:Int()
		Return bmx_wxpropertygridevent_hasproperty(wxEventPtr)
	End Method
	
	Method IsPropertyEnabled:Int()
		Return bmx_wxpropertygridevent_ispropertyenabled(wxEventPtr)
	End Method
	
	Method SetCanVeto(canVeto:Int)
	End Method
	
	Method SetProperty(p:wxPGProperty)
	End Method
	
	Method SetPropertyGrid(pg:wxPropertyGrid)
	End Method
	
	'method SetValue(Const wxVariant &value)
	'end method
	
	Method Veto(value:Int = True)
	End Method
	
	Method WasVetoed:Int()
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
