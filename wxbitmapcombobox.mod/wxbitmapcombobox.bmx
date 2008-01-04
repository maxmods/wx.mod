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
bbdoc: wxBitmapComboBox
End Rem
Module wx.wxBitmapComboBox

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
bbdoc: A combobox that displays bitmap in front of the list items.
about: It currently only allows using bitmaps of one size, and resizes itself so that a bitmap can be shown
next to the text field.
<p>
Notes: Since BlitzMax doesn't allow method overloading, some of the methods here have the suffix "Bitmap". For example,
instead of Append(), we use AppendBitmap().
</p>
End Rem
Type wxBitmapComboBox Extends wxComboBox

	Rem
	bbdoc: Constructor, creating and showing a combobox.
	End Rem
	Function CreateBitmapComboBox:wxBitmapComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, ..
			y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		
		Return New wxBitmapComboBox.Create(parent, id, value, choices, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates the combobox for two-step construction. 
	about: See wxBitmapComboBox::wxBitmapComboBox for further details.
	End Rem
	Method Create:wxBitmapComboBox(parent:wxWindow, id:Int, value:String, choices:String[], x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxbitmapcombobox_create(Self, parent.wxObjectPtr, id, value, choices, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Adds the item to the end of the combo box, associating the given client data with the item.
	End Rem
	Method AppendBitmap:Int(item:String, bitmap:wxBitmap = Null, clientData:Object = Null)
		If bitmap Then
			Return bmx_wxbitmapcombobox_append(wxObjectPtr, item, bitmap.wxObjectPtr, clientData)
		Else
			Return bmx_wxbitmapcombobox_append(wxObjectPtr, item, Null, clientData)
		End If
	End Method
	
	Rem
	bbdoc: Returns size of bitmaps used in the list.
	End Rem
	Method GetBitmapSize(w:Int Var, h:Int Var)
		bmx_wxbitmapcombobox_getbitmapsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the bitmap of the item with the given index.
	End Rem
	Method GetItemBitmap:wxBitmap(item:Int)
		Return wxBitmap._create(bmx_wxbitmapcombobox_getitembitmap(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Inserts the item into the list before pos, associating the given client data with the item.
	about: Not valid for wxCB_SORT style, use Append instead.
	End Rem
	Method InsertBitmap:Int(pos:Int, item:String, bitmap:wxBitmap = Null, clientData:Object = Null)
		If bitmap Then
			Return bmx_wxbitmapcombobox_insert(wxObjectPtr, pos, item, bitmap.wxObjectPtr, clientData)
		Else
			Return bmx_wxbitmapcombobox_insert(wxObjectPtr, pos, item, Null, clientData)
		End If
	End Method
	
	Rem
	bbdoc: Sets the bitmap for the given item.
	End Rem
	Method SetItemBitmap(item:Int, bitmap:wxBitmap)
		bmx_wxbitmapcombobox_setitembitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
End Type
