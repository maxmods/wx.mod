' Copyright (c) 2007 Bruce A Henderson
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

Rem
bbdoc: 
End Rem
Type wxPropertyContainerMethods Extends wxPanel

	Rem
	bbdoc: Associates the help string with property.
	about: By default, text is shown either in the manager's "description" text box or in the
	status bar. If extra window style wxPG_EX_HELP_AS_TOOLTIPS is used, then the text will appear
	as a tooltip.
	End Rem
	Method SetPropertyHelpStringId(id:wxPGId, helpString:String)
		bmx_wxpropertycontainermethods_setpropertyhelpstringid(wxObjectPtr, id.pgidPtr, helpString)
	End Method

	Rem
	bbdoc: Associates the help string with property.
	about: By default, text is shown either in the manager's "description" text box or in the
	status bar. If extra window style wxPG_EX_HELP_AS_TOOLTIPS is used, then the text will appear
	as a tooltip.
	End Rem
	Method SetPropertyHelpString(name:String, helpString:String)
		bmx_wxpropertycontainermethods_setpropertyhelpstring(wxObjectPtr, name, helpString)
	End Method
	
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
		Return Self
	End Method

	Rem
	bbdoc: Appends property to the list.
	about: wxPropertyGrid assumes ownership of the object. Becomes child of most recently added category.
	End Rem
	Method Append:wxPGId(property:wxPGProperty)
		Return wxPGId._create(bmx_wxpropertygrid_append(wxObjectPtr, property.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Deletes all properties.
	about: Does not free memory allocated for arrays etc. This should *not* be called in wxPropertyGridManager.
	End Rem
	Method Clear()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearModifiedStatus()
	End Method
	
	Method ClearModifiedStatusId(id:wxPGId)
	End Method
	
	Method ClearPropertyValue(name:String)
	End Method
	
	Method ClearPropertyValueId(id:wxPGId)
	End Method
	
	Method ClearSelection()
	End Method
	
	Method ClearTargetPage()
	End Method
	
	Method Collapse(name:String)
	End Method
	
	Method CollapseId(id:wxPGId)
	End Method
	
	Method CollapseAll()
	End Method
	
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
	
	
	Rem
	bbdoc: Returns itself.
	about: Dummy method that enables same kind of code to use wxPropertyGrid and wxPropertyGridManager.
	End Rem
	Method GetGrid:wxPropertyGrid()
		Return _find(bmx_wxpropertygrid_getgrid(wxObjectptr))
	End Method
	
	Method GetLineColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getlinecolour(wxObjectPtr))
	End Method
	
	Method GetMarginColour:wxColour()
		Return wxColour._create(bmx_wxpropertygrid_getmargincolour(wxObjectPtr))
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

End Type

Rem
bbdoc: 
End Rem
Type wxPGPropertyWithChildren Extends wxPGProperty
End Type

Rem
bbdoc: 
End Rem
Type wxStringProperty Extends wxPGProperty

	Method Create:wxStringProperty(label:String, name:String, value:String)
		wxObjectPtr = bmx_wxstringproperty_create(label, name, value)
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
Type wxCustomProperty Extends wxPGPropertyWithChildren
End Type

Rem
bbdoc: 
End Rem
Type wxFontProperty Extends wxPGPropertyWithChildren

	Method Create:wxFontProperty(label:String, name:String = Null, font:wxFont = Null)
		If font Then
			wxObjectPtr = bmx_wxfontproperty_create(label, name, font.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxfontproperty_create(label, name, Null)
		End If
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxPropertyCategory Extends wxPGPropertyWithChildren

	Method Create:wxPropertyCategory(label:String, name:String = Null)
		wxObjectPtr = bmx_wxpropertycategory_create(label, name)
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
End Type

Rem
bbdoc: 
End Rem
Type wxSystemColourProperty Extends wxEnumProperty

	Method Create: wxSystemColourProperty(label:String, name:String = Null, value:wxColour = Null)
		If value Then
			wxObjectPtr = bmx_wxsystemcolourproperty_create(label, name, value.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxsystemcolourproperty_create(label, name, Null)
		End If
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
bbdoc: 
End Rem
Type wxPGId

	Field pgidPtr:Byte Ptr

	Function _create:wxPGId(pgidPtr:Byte Ptr)
		If pgidPtr Then
			Local this:wxPGId = New wxPGId
			this.pgidPtr = pgidPtr
			Return this
		End If
	End Function
	
	Method Delete()
		If pgidPtr Then
			bmx_wxpgid_delete(pgidPtr)
			pgidPtr = Null
		End If
	End Method

End Type

