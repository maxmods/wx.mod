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
bbdoc: wxStatusBar
End Rem
Module wx.wxStatusBar

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
bbdoc: A status bar is a narrow window that can be placed along the bottom of a frame to give small amounts of status information.
about: It can contain one or more fields, one or more of which can be variable length according to the
size of the window.
<p>
It is possible to create controls and other windows on the status bar. Position these windows from an 
OnSize event handler.
</p>
End Rem
Type wxStatusBar Extends wxWindow

	Rem
	bbdoc: Constructor, creating the window.
	End Rem
	Function CreateStatusBar:wxStatusBar(parent:wxWindow, id:Int = -1, style:Int = wxST_SIZEGRIP)
		Return New wxStatusBar.Create(parent, id, style)
	End Function
	
	Rem
	bbdoc: Creates the window, for two-step construction.
	End Rem
	Method Create:wxStatusBar(parent:wxWindow, id:Int = -1, style:Int = wxST_SIZEGRIP)
		wxObjectPtr = bmx_wxstatusbar_create(Self, parent.wxObjectPtr, id, style)
		OnInit()
		Return Self
	End Method

	Function _create:wxStatusBar(wxObjectPtr:Byte Ptr)
		Local this:wxStatusBar = New wxStatusBar
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function

	Function _xrcNew:wxStatusBar(wxObjectPtr:Byte Ptr)
		Return wxStatusBar._create(wxObjectPtr)
	End Function

	Method injectSelf()
		bmx_wxstatusbar_injectSelf(wxObjectPtr, Self)
	End Method
	
	Rem
	bbdoc: Returns the size and position of a field's internal bounding rectangle.
	End Rem
	Method GetFieldRect:Int(index:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		Return bmx_wxstatusbar_getfieldrect(wxObjectPtr, index, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method

	Rem
	bbdoc: Returns the size and position of a field's internal bounding rectangle, or Null if the field is invalid.
	End Rem
	Method GetFieldRectRect:wxRect(index:Int)
		Return wxRect._create(bmx_wxstatusbar_getfieldrectrect(wxObjectPtr, index))
	End Method
	
	Rem
	bbdoc: Returns the number of fields in the status bar.
	End Rem
	Method GetFieldsCount:Int()
		Return bmx_wxstatusbar_getfieldscount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string associated with a status bar field.
	returns: The status field string if the field is valid, otherwise the empty string.
	End Rem
	Method GetStatusText:String(index:Int = 0)
		Return bmx_wxstatusbar_getstatustext(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Sets the field text to the top of the stack, and pops the stack of saved strings.
	End Rem
	Method PopStatusText(index:Int = 0)
		bmx_wxstatusbar_popstatustext(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Saves the current field text in a per field stack, and sets the field text to the string passed as argument.
	End Rem
	Method PushStatusText(text:String, index:Int = 0)
		bmx_wxstatusbar_pushstatustext(wxObjectPtr, text, index)
	End Method
	
	Rem
	bbdoc: Sets the number of fields
	End Rem
	Method SetFieldsCount(count:Int = 1)
		bmx_wxstatusbar_setfieldscount(wxObjectPtr, count)
	End Method
	
	Rem
	bbdoc: Sets the minimal possible height for the status bar.
	about: The real height may be bigger than the height specified here depending on the size of the
	font used by the status bar.
	End Rem
	Method SetMinHeight(height:Int)
		bmx_wxstatusbar_setminheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: Sets the text for one field.
	End Rem
	Method SetStatusText(text:String, index:Int = 0)
		bmx_wxstatusbar_setstatustext(wxObjectPtr, text, index)
	End Method
	
	Rem
	bbdoc: Sets the widths of the fields in the status line.
	about: There are two types of fields: fixed widths one and variable width fields. For the fixed width
	fields you should specify their (constant) width in pixels. For the variable width fields, specify a
	negative number which indicates how the field should expand: the space left for all variable width
	fields is divided between them according to the absolute value of this number. A variable width field
	with width of -2 gets twice as much of it as a field with width -1 and so on.
	<p>
	For example, to create one fixed width field of width 100 in the right part of the status bar and two
	more fields which get 66% and 33% of the remaining space correspondingly, you should use an array
	containing -2, -1 and 100.
	</p>
	End Rem
	Method SetStatusWidths(widths:Int[])
		bmx_wxstatusbar_setstatuswidths(wxObjectPtr, widths)
	End Method
	
	Rem
	bbdoc: Sets the styles of the fields in the status line which can make fields appear flat or raised instead of the standard sunken 3D border.
	End Rem
	Method SetStatusStyles(styles:Int[])
		bmx_wxstatusbar_setstatusstyles(wxObjectPtr, styles)
	End Method
		
End Type


Type TStatusBarResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxstatusbar_addresourcehandler()
	End Method
		
End Type

New TStatusBarResourceFactory
