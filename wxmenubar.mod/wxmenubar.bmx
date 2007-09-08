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

Rem
bbdoc: wxMenuBar
End Rem
Module wx.wxMenuBar

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
bbdoc: A menu bar is a series of menus accessible from the top of a frame.
about: To respond to a menu selection, provide a handler for wxEVT_COMMAND_MENU, in the frame that contains
the menu bar. If you have a toolbar which uses the same identifiers as your EVT_MENU entries, events from
the toolbar will also be processed by your EVT_MENU event handlers.
<p>
Tip: under Windows, if you discover that menu shortcuts (for example, Alt-F to show the file menu) are
not working, check any EVT_CHAR events you are handling in child windows. If you are not calling
event.Skip() for events that you don't process in these event handlers, menu shortcuts may cease to work.
</p>
End Rem
Type wxMenuBar Extends wxWindow
	
	Rem
	bbdoc: 
	End Rem
	Function CreateMenuBar:wxMenuBar(style:Int = 0)
		Return New wxMenuBar.Create(style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMenuBar(style:Int = 0)
		wxObjectPtr = bmx_wxmenubar_create(Self, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Adds the menu to the end of the menu bar.
	returns: True on success, False if an error occured.
	End Rem
	Method Append:Int(menu:wxMenu, title:String)
		Return bmx_wxmenubar_append(wxObjectPtr, menu.wxObjectPtr, title)
	End Method
	
	Rem
	bbdoc: Checks or unchecks a menu item.
	about: Only use this when the menu bar has been associated with a frame; otherwise, use the
	wxMenu equivalent call.
	End Rem
	Method Check(id:Int, value:Int)
		bmx_wxmenubar_check(wxObjectPtr, id, value)
	End Method
	
	Rem
	bbdoc: Enables or disables (greys out) a menu item.
	about: Only use this when the menu bar has been associated with a frame; otherwise, use the
	wxMenu equivalent call.
	End Rem
	Method EnableItem(id:Int, value:Int)
		bmx_wxmenubar_enable(wxObjectPtr, id, value)
	End Method
	
	Rem
	bbdoc: Enables or disables a whole menu.
	about: Only use this when the menu bar has been associated with a frame.
	End Rem
	Method EnableTop(pos:Int, value:Int)
		bmx_wxmenubar_enabletop(wxObjectPtr, pos, value)
	End Method
	
	Rem
	bbdoc: Returns the index of the menu with the given title or wxNOT_FOUND if no such menu exists in this menubar.
	about: The title parameter may specify either the menu title (with accelerator characters, i.e. "&File")
	or just the menu label ("File") indifferently.
	End Rem
	Method FindMenu:Int(title:String)
		Return bmx_wxmenubar_findmenu(wxObjectPtr, title)
	End Method
	
	Rem
	bbdoc: Finds the menu item id for a menu name/menu item string pair.
	End Rem
	Method FindMenuItem:Int(menuString:String, itemString:String)
		Return bmx_wxmenubar_findmenuitem(wxObjectPtr, menuString, itemString)
	End Method
	
'	Rem
'	bbdoc: Finds the menu item object associated with the given menu item identifier.
'	End Rem
'	Method FindItem:wxMenuItem(id:Int)
'	End Method
	
	Rem
	bbdoc: Gets the help string associated with the menu item identifier.
	returns: The help string, or the empty string if there was no help string or the menu item was not found.
	End Rem
	Method GetHelpString:String(id:Int)
		Return bmx_wxmenubar_gethelpstring(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Gets the label associated with a menu item.
	returns: The menu item label, or the empty string if the item was not found.
	about: Use only after the menubar has been associated with a frame.
	End Rem
	Method GetItemLabel:String(id:Int)
		Return bmx_wxmenubar_getlabel(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Returns the label of a top-level menu.
	returns: The menu label, or the empty string if the menu was not found.
	about: Note that the returned string does not include the accelerator characters which could have
	been specified in the menu title string during its construction.
	<p>
	Use only after the menubar has been associated with a frame.
	</p>
	End Rem
	Method GetLabelTop:String(pos:Int)
		Return bmx_wxmenubar_getlabeltop(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Returns the menu at menuIndex (zero-based).
	End Rem
	Method GetMenu:wxMenu(menuIndex:Int)
		Local mPtr:Byte Ptr = bmx_wxmenubar_getmenu(wxObjectPtr, menuIndex)
		Local menu:wxMenu = wxMenu(wxfind(mPtr))
		If Not menu Then
			menu = wxMenu._create(mPtr)
		End If
		Return menu
	End Method
	
	Rem
	bbdoc: Returns the number of menus in this menubar.
	End Rem
	Method GetMenuCount:Int()
		Return bmx_wxmenubar_getmenucount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Inserts the menu at the given position into the menu bar.
	returns: True on success, False if an error occurred.
	about: Inserting menu at position 0 will insert it in the very beginning of it, inserting at
	position GetMenuCount() is the same as calling Append().
	End Rem
	Method insert:Int(pos:Int, menu:wxMenu, title:String)
		Return bmx_wxmenubar_insert(wxObjectPtr, pos, menu.wxObjectPtr, title)
	End Method

	Rem
	bbdoc: Determines whether an item is checked.
	returns: True if the item was found and is checked, False otherwise.
	End Rem
	Method IsChecked:Int(id:Int)
		Return bmx_wxmenubar_ischecked(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Determines whether an item is enabled.
	returns: True if the item was found and is enabled, False otherwise.
	End Rem
	Method IsItemEnabled:Int(id:Int)
		Return bmx_wxmenubar_isenabled(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Redraw the menu bar
	End Rem
	Method RefreshMenuBar()
		bmx_wxmenubar_refresh(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the menu from the menu bar and returns the menu object - the caller is responsible for deleting it.
	about: This method may be used together with wxMenuBar::Insert to change the menubar dynamically.
	End Rem
	Method Remove:wxMenu(pos:Int)
		Local mPtr:Byte Ptr = bmx_wxmenubar_remove(wxObjectPtr, pos)
		Local menu:wxMenu = wxMenu(wxfind(mPtr))
		If Not menu Then
			menu = wxMenu._create(mPtr)
		End If
		Return menu
	End Method
	
	Rem
	bbdoc: Replaces the menu at the given position with another one.
	returns: The menu which was previously at position pos. The caller is responsible for deleting it.
	End Rem
	Method Replace:wxMenu(pos:Int, menu:wxMenu, title:String)
		Local mPtr:Byte Ptr = bmx_wxmenubar_replace(wxObjectPtr, pos, menu.wxObjectPtr, title)
		Local retMenu:wxMenu = wxMenu(wxfind(mPtr))
		If Not retMenu Then
			retMenu = wxMenu._create(mPtr)
		End If
		Return retMenu
	End Method
	
	Rem
	bbdoc: Sets the help string associated with a menu item.
	End Rem
	Method SetHelpString(id:Int, helpString:String)
		bmx_wxmenubar_sethelpstring(wxObjectPtr, id, helpString)
	End Method
	
	Rem
	bbdoc: Sets the label of a menu item.
	about: Use only after the menubar has been associated with a frame.
	End Rem
	Method SetItemLabel(id:Int, label:String)
		bmx_wxmenubar_setlabel(wxObjectPtr, id, label)
	End Method
	
	Rem
	bbdoc: Sets the label of a top-level menu.
	about: Use only after the menubar has been associated with a frame.
	End Rem
	Method SetLabelTop(pos:Int, label:String)
		bmx_wxmenubar_setlabeltop(wxObjectPtr, pos, label)
	End Method
	
End Type

