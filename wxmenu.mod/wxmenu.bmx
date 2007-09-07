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

Module wx.wxMenu

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
bbdoc: TODO
End Rem
Type wxMenu Extends wxEvtHandler

'	Field wxMenuPtr:Byte Ptr

	' creates a "soft link" to a wxMenu*
	Function _create:wxMenu(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMenu = New wxMenu
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a #wxMenu object.
	about: TODO
	End Rem
	Function CreateMenu:wxMenu(title:String = "", style:Int = 0)
		Return New wxMenu.Create(title, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxMenu(title:String = "", style:Int = 0)
		wxObjectPtr = bmx_wxmenu_create(Self, title, style)
		Return Self
	End Method

	Rem
	bbdoc: Adds a string item to the end of the menu.
	about: @kind may be wxITEM_SEPARATOR, wxITEM_NORMAL, wxITEM_CHECK, or wxITEM_RADIO
	TODO
	End Rem
	Method Append(id:Int, item:String = "", helpString:String = "", kind:Int = wxITEM_NORMAL)
		bmx_wxmenu_append(wxObjectPtr, id, item, helpString, kind)
	End Method
	
	Rem
	bbdoc: 
	about: TODO
	End Rem
	Method AppendMenu(id:Int, item:String = "", subMenu:wxMenu, helpString:String = "")
		bmx_wxmenu_appendmenu(wxObjectPtr, id, item, subMenu.wxObjectPtr, helpString)
	End Method

	Rem
	bbdoc: Adds a checkable item to the end of the menu.
	End Rem
	Method AppendCheckItem(id:Int, item:String = "", helpString:String = "")
		bmx_wxmenu_appendcheckitem(wxObjectPtr, id, item, helpString)
	End Method

	Rem
	bbdoc: Adds a radio item to the end of the menu.
	about: All consequent radio items form a group and when an item in the group is checked, all the others are
	automatically unchecked.
	End Rem
	Method AppendRadioItem(id:Int, item:String = "", helpString:String = "")
		bmx_wxmenu_appendradioitem(wxObjectPtr, id, item, helpString)
	End Method
	
	Rem
	bbdoc: Inserts a break in a menu, causing the next appended item to appear in a new column.
	End Rem
	Method Break()
		bmx_wxmenu_break(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method SetTitle(title:String)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method GetTitle:String()
	End Method
	
	Rem
	bbdoc: Checks or unchecks the menu item.
	End Rem
	Method Check(id:Int, value:Int)
		
	End Method
	
	Rem
	bbdoc: Determines whether a menu item is checked.
	returns: True if the menu item is checked, False otherwise.
	about: TODO
	End Rem
	Method IsChecked:Int(id:Int)
	
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method Enable(id:Int, value:Int)
	End Method
	
	Rem
	bbdoc: TODO
	End Rem
	Method IsEnabled:Int(id:Int)
	End Method
	
	Rem
	bbdoc: Adds a separator to the end of the menu.
	End Rem
	Method AppendSeparator()
		bmx_wxmenu_appendseparator(wxObjectPtr)
	End Method
	
End Type


