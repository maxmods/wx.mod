' Copyright (c) 2007-2015 Bruce A Henderson
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
bbdoc: wxToolBar
End Rem
Module wx.wxToolBar

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: The toolbar allows an application to use toolbars in a variety of configurations and styles.
about: The toolbar is a popular user interface component and contains a set of bitmap buttons or toggles.
A toolbar gives faster access to an application's facilities than menus, which have to be popped up
and selected rather laboriously.
<p>
A toolbar might appear as a single row of images under the menubar, or it might be in a separate
frame layout in several rows and columns. The class handles the layout of the images, unless explicit
positioning is requested.
</p>
<p>
A tool is a bitmap which can either be a button (there is no 'state', it just generates an event when
clicked) or it can be a toggle. If a toggle, a second bitmap can be provided to depict the 'on' state;
if the second bitmap is omitted, either the inverse of the first bitmap will be used (for
monochrome displays) or a thick border is drawn around the bitmap (for colour displays where
inverting will not have the desired result).
</p>
<p>
The Windows-specific toolbar classes expect 16-colour bitmaps that are 16 pixels wide and 15 pixels high.
If you want to use a different size, call SetToolBitmapSize as the demo shows, before adding tools to
the button bar. Don't supply more than one bitmap for each tool, because the toolbar generates all
three images (normal, depressed and checked) from the single bitmap you give it.
</p>
End Rem
Type wxToolBar Extends wxControl

	Rem
	bbdoc: 
	End Rem
	Function CreateToolBar:wxToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTB_DEFAULT_STYLE)
			
		Return New wxToolBar.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateToolBar.
	End Rem
	Method Create:wxToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTB_DEFAULT_STYLE)
			
		wxObjectPtr = bmx_wxtoolbar_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit() ' let's call OnInit, just in case the user wants to do some initialization!
		Return Self
	End Method

	Function _create:wxToolBar(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxToolBar = New wxToolBar
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxToolBar(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local tb:wxToolBar = wxToolBar(wxfind(wxObjectPtr))
			If Not tb Then
				Return wxToolBar._create(wxObjectPtr)
			End If
			Return tb
		End If
	End Function
	
	Function _xrcNew:wxToolBar(wxObjectPtr:Byte Ptr)
		Return wxToolBar._create(wxObjectPtr)
	End Function

	Method injectSelf()
		bmx_wxtoolbar_injectSelf(wxObjectPtr, Self)
	End Method

	Rem
	bbdoc: Adds any control to the toolbar, typically e.g. a combobox.
	End Rem
	Method AddControl(control:wxControl, label:String = Null)
		bmx_wxtoolbar_addcontrol(wxObjectPtr, control.wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: Adds a separator for spacing groups of tools.
	End Rem
	Method AddSeparator:wxToolBarToolBase()
		Return wxToolBarToolBase._create(bmx_wxtoolbar_addseparator(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Adds a stretchable space to the toolbar.
	about: Any space not taken up by the fixed items (all items except for stretchable spaces) is distributed in equal measure
	between the stretchable spaces in the toolbar. The most common use for this method is to add a single stretchable space before
	the items which should be right-aligned in the toolbar, but more exotic possibilities are possible, e.g. a stretchable space may
	be added in the beginning and the end of the toolbar to centre all toolbar items.
	End Rem
	Method AddStretchableSpace:wxToolBarToolBase()
		Return wxToolBarToolBase._create(bmx_wxtoolbar_addstretchablespace(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Adds a tool to the toolbar.
	End Rem
	Method AddTool:wxToolBarToolBase(toolId:Int, label:String, bitmap1:wxBitmap, bitmap2:wxBitmap = Null, kind:Int = wxITEM_NORMAL, ..
			shortHelpString:String = "", longHelpString:String = "", clientData:Object = Null)
	
		If bitmap2 Then
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					shortHelpString, longHelpString, Null))
			End If
		Else
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					shortHelpString, longHelpString, Null))
			End If
		End If
	
	End Method
	
	Rem
	bbdoc: Adds a new check (or toggle) tool to the toolbar.
	about: The parameters are the same as in wxToolBar::AddTool.
	End Rem
	Method AddCheckTool:wxToolBarToolBase(toolId:Int, label:String, bitmap1:wxBitmap, bitmap2:wxBitmap = Null, ..
			shortHelpString:String = "", longHelpString:String = "", clientData:Object = Null)

		If bitmap2 Then
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addchecktool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addchecktool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, ..
					shortHelpString, longHelpString, Null))
			End If
		Else
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addchecktool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addchecktool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, ..
					shortHelpString, longHelpString, Null))
			End If
		End If
	
	End Method
	
	Rem
	bbdoc: Adds a new radio tool to the toolbar.
	about: Consecutive radio tools form a radio group such that exactly one button in the group is pressed at any
	moment, in other words whenever a button in the group is pressed the previously pressed button is automatically
	released. You should avoid having the radio groups of only one element as it would be impossible for the user
	to use such button.
	<p>
	By default, the first button in the radio group is initially pressed, the others are not.
	</p>
	End Rem
	Method AddRadioTool:wxToolBarToolBase(toolId:Int, label:String, bitmap1:wxBitmap, bitmap2:wxBitmap = Null, ..
			shortHelpString:String = "", longHelpString:String = "", clientData:Object = Null)

		If bitmap2 Then
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addradiotool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addradiotool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, ..
					shortHelpString, longHelpString, Null))
			End If
		Else
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addradiotool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, ..
					shortHelpString, longHelpString, clientData))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_addradiotool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, ..
					shortHelpString, longHelpString, Null))
			End If
		End If
	
	End Method
	
	Rem
	bbdoc: Deletes all the tools in the toolbar.
	End Rem
	Method ClearTools()
		bmx_wxtoolbar_cleartools(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the specified tool from the toolbar and deletes it.
	returns: True if the tool was deleted, False otherwise.
	about: If you don't want to delete the tool, but just to remove it from the toolbar (to possibly add it back
	later), you may use RemoveTool instead.
	<p>
	Note that it is unnecessary to call Realize for the change to take place, it will happen immediately.
	</p>
	End Rem
	Method DeleteTool:Int(toolId:Int)
		Return bmx_wxtoolbar_deletetool(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Behaves like DeleteTool but it deletes the tool at the specified position and not the one with the given id.
	End Rem
	Method DeleteToolByPos:Int(pos:Int)
		Return bmx_wxtoolbar_deletetoolbypos(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Enables or disables the tool.
	about: Some implementations will change the visible state of the tool to indicate that it is disabled.
	<p>
	NB: This method should only be called after Realize.
	</p>
	End Rem
	Method EnableTool(toolId:Int, enable:Int)
		bmx_wxtoolbar_enabletool(wxObjectPtr, toolId, enable)
	End Method
	
	Rem
	bbdoc: Returns the tool identified by id or Null if no corresponding tool is found.
	End Rem
	Method FindById:wxToolBarToolBase(id:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_findbyid(wxObjectPtr, id))
	End Method
	
	Rem
	bbdoc: Returns the control identified by id or Null if no corresponding control is found.
	End Rem
	Method FindControl:wxControl(id:Int)
		Local ctrl:Byte Ptr = bmx_wxtoolbar_findcontrol(wxObjectPtr, id)
		If ctrl Then
			Local control:wxControl = wxControl(wxfind(ctrl))
			If Not control Then
				Return wxControl._create(ctrl)
			End If
			Return control
		End If
	End Method
	
	Rem
	bbdoc: Finds a tool for the given mouse position.
	about: Currently not implemented in wxGTK (always returns NULL there).
	End Rem
	Method FindToolForPosition:wxToolBarToolBase(x:Int, y:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_findtoolforposition(wxObjectPtr, x, y))
	End Method
	
	Rem
	bbdoc: Returns a pointer to the tool at ordinal position @pos.
	about: Don't confuse this with FindToolForPosition().
	End Rem
	Method GetToolByPos:wxToolBarToolBase(pos:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_gettoolbypos(wxObjectPtr, pos))
	End Method
	
	Rem
	bbdoc: Returns the number of tools in the toolbar.
	End Rem
	Method GetToolsCount:Int()
		Return bmx_wxtoolbar_gettoolscount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the size of a whole button, which is usually larger than a tool bitmap because of added 3D effects.
	End Rem
	Method GetToolSize(width:Int Var, height:Int Var)
		bmx_wxtoolbar_gettoolsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Returns the size of bitmap that the toolbar expects to have.
	about: The default bitmap size is 16 by 15 pixels.
	<p>
	Note that this is the size of the bitmap you pass to wxToolBar::AddTool, and not the eventual size of the tool button.
	</p>
	End Rem
	Method GetToolBitmapSize(width:Int Var, height:Int Var)
		bmx_wxtoolbar_gettoolbitmapsize(wxObjectPtr, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Returns the left/right and top/bottom margins, which are also used for inter-toolspacing.
	End Rem
	Method GetMargins(leftRight:Int Var, topBottom:Int Var)
		bmx_wxtoolbar_getmargins(wxObjectPtr, Varptr leftRight, Varptr topBottom)
	End Method
	
	Rem
	bbdoc: Get any client data associated with the tool.
	End Rem
	Method GetToolClientData:Object(toolId:Int)
		Return bmx_wxtoolbar_gettoolclientdata(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Called to determine whether a tool is enabled (responds to user input).
	returns: True if the tool is enabled, False otherwise.
	End Rem
	Method GetToolEnabled:Int(toolId:Int)
		Return bmx_wxtoolbar_gettoolenabled(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Returns the long help for the given tool.
	End Rem
	Method GetToolLongHelp:String(toolId:Int)
		Return bmx_wxtoolbar_gettoollonghelp(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Returns the value used for packing tools.
	End Rem
	Method GetToolPacking:Int()
		Return bmx_wxtoolbar_gettoolpacking(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the tool position in the toolbar, or wxNOT_FOUND if the tool is not found.
	End Rem
	Method GetToolPos:Int(toolId:Int)
		Return bmx_wxtoolbar_gettoolpos(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Returns the default separator size.
	End Rem
	Method GetToolSeparation:Int()
		Return bmx_wxtoolbar_gettoolseparation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the short help for the given tool.
	End Rem
	Method GetToolShortHelp:String(toolId:Int)
		Return bmx_wxtoolbar_gettoolshorthelp(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Gets the on/off state of a toggle tool.
	returns: True if the tool is toggled on, False otherwise.
	End Rem
	Method GetToolState:Int(toolId:Int)
		Return bmx_wxtoolbar_gettoolstate(wxObjectPtr, toolId)
	End Method
	
	Rem
	bbdoc: Inserts the control into the toolbar at the given position.
	about: You must call Realize for the change to take place.
	End Rem
	Method InsertControl:wxToolBarToolBase(pos:Int, control:wxControl)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_insertcontrol(wxObjectPtr, pos, control.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Inserts the separator into the toolbar at the given position.
	about: You must call Realize for the change to take place.
	End Rem
	Method InsertSeparator:wxToolBarToolBase(pos:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_insertseparator(wxObjectPtr, pos))
	End Method

	Rem
	bbdoc: Inserts a stretchable space at the given position.
	about: You must call Realize for the change to take place.
	End Rem
	Method InsertStretchableSpace:wxToolBarToolBase(pos:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_insertstretchablespace(wxObjectPtr, pos))
	End Method
	
	Rem
	bbdoc: Inserts the tool with the specified attributes into the toolbar at the given position.
	about: You must call Realize for the change to take place.
	End Rem
	Method InsertTool:wxToolBarToolBase(pos:Int, toolId:Int, label:String, bitmap1:wxBitmap, bitmap2:wxBitmap = Null, kind:Int = wxITEM_NORMAL, ..
			clientData:Object = Null, shortHelpString:String = "", longHelpString:String = "")

		If bitmap2 Then
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_inserttool(wxObjectPtr, pos, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					clientData, shortHelpString, longHelpString))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_inserttool(wxObjectPtr, pos, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					Null, shortHelpString, longHelpString))
			End If
		Else
			If clientData Then
				Return wxToolBarToolBase._create(bmx_wxtoolbar_inserttool(wxObjectPtr, pos, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					clientData, shortHelpString, longHelpString))
			Else
				Return wxToolBarToolBase._create(bmx_wxtoolbar_inserttool(wxObjectPtr, pos, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					Null, shortHelpString, longHelpString))
			End If
		End If
	
	End Method
	
	Rem
	bbdoc: This method should be called after you have added tools.
	End Rem
	Method Realize:Int()
		Return bmx_wxtoolbar_realize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the given tool from the toolbar but doesn't delete it.
	about: This allows to insert/add this tool back to this (or another) toolbar later.
	<p>
	Note that it is unnecessary to call Realize for the change to take place, it will happen immediately.
	</p>
	End Rem
	Method RemoveTool:wxToolBarToolBase(id:Int)
		Return wxToolBarToolBase._create(bmx_wxtoolbar_removetool(wxObjectPtr, id))
	End Method
	
	Rem
	bbdoc: Set the values to be used as margins for the toolbar.
	about: This must be called before the tools are added if absolute positioning is to be used, and the default
	(zero-size) margins are to be overridden.
	End Rem
	Method SetMargins(leftRight:Int, topBottom:Int)
		bmx_wxtoolbar_setmargins(wxObjectPtr, leftRight, topBottom)
	End Method
	
	Rem
	bbdoc: Sets the dropdown menu for the tool given by its id.
	about: The tool itself will delete the menu when it's no longer needed. Only supported under GTK+ und MSW.
	If you define a wxEVT_COMMAND_TOOL_DROPDOWN_CLICKED handler in your program, you must call wxEvent::Skip() from it or the menu won't be displayed.
	End Rem
	Method SetDropdownMenu:Int(id:Int, menu:wxMenu)
		bmx_wxtoolbar_setdropdownmenu(wxObjectPtr, id, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default size of each tool bitmap.
	about: The default bitmap size is 16 by 15 pixels.
	End Rem
	Method SetToolBitmapSize(width:Int, height:Int)
		bmx_wxtoolbar_settoolbitmapsize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Sets the client data associated with the tool.
	End Rem
	Method SetToolClientData(id:Int, clientData:Object)
		bmx_wxtoolbar_settoolclientdata(wxObjectPtr, id, clientData)
	End Method
	
	Rem
	bbdoc: Sets the bitmap to be used by the tool with the given ID when the tool is in a disabled state.
	about: This can only be used on Button tools, not controls. NOTE: The native toolbar classes on the main
	platforms all synthesize the disabled bitmap from the normal bitmap, so this function will have no effect
	on those platforms.
	End Rem
	Method SetToolDisabledBitmap(id:Int, bitmap:wxBitmap)
		bmx_wxtoolbar_settooldisabledbitmap(wxObjectPtr, id, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the long help for the given tool.
	End Rem
	Method SetToolLongHelp(id:Int, helpString:String)
		bmx_wxtoolbar_settoollonghelp(wxObjectPtr, id, helpString)
	End Method
	
	Rem
	bbdoc: Sets the value used for spacing tools. The default value is 1.
	End Rem
	Method SetToolPacking(packing:Int)
		bmx_wxtoolbar_settoolpacking(wxObjectPtr, packing)
	End Method
	
	Rem
	bbdoc: Sets the short help for the given tool.
	End Rem
	Method SetToolShortHelp(id:Int, helpString:String)
		bmx_wxtoolbar_settoolshorthelp(wxObjectPtr, id, helpString)
	End Method

	Rem
	bbdoc: Sets the bitmap to be used by the tool with the given ID.
	about: This can only be used on Button tools, not controls.
	End Rem
	Method SetToolNormalBitmap(id:Int, bitmap:wxBitmap)
		bmx_wxtoolbar_settoolnormalbitmap(wxObjectPtr, id, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default separator size.
	about: The default value is 5.
	End Rem
	Method SetToolSeparation(separation:Int)
		bmx_wxtoolbar_settoolseparation(wxObjectPtr, separation)
	End Method
	
	Rem
	bbdoc: Toggles a tool on or off.
	about: This does not cause any event to get emitted.
	End Rem
	Method ToggleTool(toolId:Int, toggle:Int)
		bmx_wxtoolbar_toggletool(wxObjectPtr, toolId, toggle)
	End Method
	
End Type


Rem
bbdoc: A toolbar element.
about: It has a unique id (except for the separators which always have id wxID_ANY), the
 style (telling whether it is a normal button, separator or a control), the
 state (toggled or not, enabled or not) and short and long help strings. The
 default implementations use the short help string for the tooltip text which
 is popped up when the mouse pointer enters the tool and the long help string
 for the applications status bar.
End Rem
Type wxToolBarToolBase Extends wxObject

	Function _create:wxToolBarToolBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxToolBarToolBase = New wxToolBarToolBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetId:Int()
		Return bmx_wxtoolbartoolbase_getid(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if this item is a button.
	End Rem
	Method IsButton:Int()
		Return bmx_wxtoolbartoolbase_isbutton(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if this item is a control.
	End Rem
	Method IsControl:Int()
		Return bmx_wxtoolbartoolbase_iscontrol(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if this item is a separator.
	End Rem
	Method IsSeparator:Int()
		Return bmx_wxtoolbartoolbase_isseparator(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetStyle:Int()
		Return bmx_wxtoolbartoolbase_getstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetKind:Int()
		Return bmx_wxtoolbartoolbase_getkind(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsEnabled:Int()
		Return bmx_wxtoolbartoolbase_isenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsToggled:Int()
		Return bmx_wxtoolbartoolbase_istoggled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanBeToggled:Int()
		Return bmx_wxtoolbartoolbase_canbetoggled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the normal item bitmap.
	End Rem
	Method GetNormalBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxtoolbartoolbase_getnormalbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the disabled item bitmap
	End Rem
	Method GetDisabledBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxtoolbartoolbase_getdisabledbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the bitmap for the item current state.
	End Rem
	Method GetBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxtoolbartoolbase_getbitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the item label
	End Rem
	Method GetLabel:String()
		Return bmx_wxtoolbartoolbase_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the item short help.
	End Rem
	Method GetShortHelp:String()
		Return bmx_wxtoolbartoolbase_getshorthelp(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the item long help.
	End Rem
	Method GetLongHelp:String()
		Return bmx_wxtoolbartoolbase_getlonghelp(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetClientData:Object()
		Return bmx_wxtoolbartoolbase_getclientdata(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Enable:Int(value:Int)
		Return bmx_wxtoolbartoolbase_enable(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Toggle the check item.
	End Rem
	Method Toggle()
		bmx_wxtoolbartoolbase_toggle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToggle:Int(value:Int)
		Return bmx_wxtoolbartoolbase_settoggle(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetShortHelp:Int(help:String)
		Return bmx_wxtoolbartoolbase_setshorthelp(wxObjectPtr, help)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLongHelp:Int(help:String)
		Return bmx_wxtoolbartoolbase_setlonghelp(wxObjectPtr, help)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetNormalBitmap(bitmap:wxBitmap)
		bmx_wxtoolbartoolbase_setnormalbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDisabledBitmap(bitmap:wxBitmap)
		bmx_wxtoolbartoolbase_setdisabledbitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabel(label:String)
		bmx_wxtoolbartoolbase_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetClientData(data:Object)
		bmx_wxtoolbartoolbase_setclientdata(wxObjectPtr, data)
	End Method
	
	Rem
	bbdoc: Remove tool from the toolbar
	End Rem
	Method Detach()
		bmx_wxtoolbartoolbase_detach(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Add tool to the toolbar
	End Rem
	Method Attach(toolbar:wxToolBar)
		bmx_wxtoolbartoolbase_attach(wxObjectPtr, toolbar.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDropdownMenu(menu:wxMenu)
		bmx_wxtoolbartoolbase_setdropdownmenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDropdownMenu:wxMenu()
		Return wxMenu._find(bmx_wxtoolbartoolbase_getdropdownmenu(wxObjectPtr))
	End Method
	
End Type



Type TToolBarEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TOOL_CLICKED, ..
					wxEVT_COMMAND_TOOL_RCLICKED, ..
					wxEVT_COMMAND_TOOL_ENTER, ..
					wxEVT_COMMAND_TOOL_DROPDOWN_CLICKED
				Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TOOL_CLICKED, ..
				wxEVT_COMMAND_TOOL_RCLICKED, ..
				wxEVT_COMMAND_TOOL_ENTER, ..
				wxEVT_COMMAND_TOOL_DROPDOWN_CLICKED
			Return bmx_wxtoolbar_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TToolBarEventFactory

Type TToolBarResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxtoolbar_addresourcehandler()
	End Method
		
End Type

New TToolBarResourceFactory

