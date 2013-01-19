' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxImageList
End Rem
Module wx.wxImageList

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
bbdoc: A wxImageList contains a list of images, which are stored in an unspecified form.
about: Images can have masks for transparent drawing, and can be made from a variety of sources including
bitmaps and icons.
<p>
wxImageList is used principally in conjunction with wxTreeCtrl and wxListCtrl type.
</p>
End Rem
Type wxImageList Extends wxObject

	Function _create:wxImageList(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxImageList = New wxImageList
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructor specifying the image size, whether image masks should be created, and the initial size of the list.
	End Rem
	Function CreateImageList:wxImageList(width:Int, height:Int, mask:Int = True, initialCount:Int = 1)
		Return New wxImageList.Create(width, height, mask, initialCount)
	End Function
	
	Rem
	bbdoc: Constructor specifying the image size, whether image masks should be created, and the initial size of the list.
	End Rem
	Method Create:wxImageList(width:Int, height:Int, mask:Int = True, initialCount:Int = 1)
		wxObjectPtr = bmx_wximagelist_create(Self, width, height, mask, initialCount)
		Return Self
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wximagelist_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Rem
	bbdoc: Adds a new image or images using a bitmap and optional mask bitmap.
	End Rem
	Method Add:Int(bitmap:wxBitmap, mask:wxBitmap = Null)
		If mask Then
			Return bmx_wximagelist_add(wxObjectPtr, bitmap.wxObjectPtr, mask.wxObjectPtr)
		Else
			Return bmx_wximagelist_add(wxObjectPtr, bitmap.wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Adds a new image or images using a bitmap and mask colour.
	End Rem
	Method AddWithColourMask:Int(bitmap:wxBitmap, maskColour:wxColour)
		Return bmx_wximagelist_addwithcolourmask(wxObjectPtr, bitmap.wxObjectPtr, maskColour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds a new image using an icon.
	End Rem
	Method AddIcon:Int(icon:wxIcon)
		Return bmx_wximagelist_addicon(wxObjectPtr, icon.wxObjectPtr)
	End Method

	Rem
	bbdoc: Draws a specified image onto a device context.
	End Rem
	Method Draw:Int(index:Int, dc:wxDC, x:Int, y:Int, flags:Int = wxIMAGELIST_DRAW_NORMAL, solidBackground:Int = False)
		Return bmx_wximagelist_draw(wxObjectPtr, index, dc.wxObjectPtr, x, y, flags, solidBackground)
	End Method
	
	Rem
	bbdoc: Returns the bitmap corresponding to the given index.
	End Rem
	Method GetBitmap:wxBitmap(index:Int)
		Return wxBitmap._create(bmx_wximagelist_getbitmap(wxObjectPtr, index))
	End Method
	
	Rem
	bbdoc: Returns the icon corresponding to the given index.
	End Rem
	Method GetIcon:wxIcon(index:Int)
		Return wxIcon._create(bmx_wximagelist_geticon(wxObjectPtr, index))
	End Method
	
	Rem
	bbdoc: Returns the number of images in the list.
	End Rem
	Method GetImageCount:Int()
		Return bmx_wximagelist_getimagecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Retrieves the size of the images in the list.
	about: Currently, the index parameter is ignored as all images in the list have the same size.
	End Rem
	Method GetSize:Int(index:Int, width:Int Var, height:Int Var)
		Return bmx_wximagelist_getsize(wxObjectPtr, index, Varptr width, Varptr height)
	End Method
	
	Rem
	bbdoc: Removes the image at the given position.
	End Rem
	Method Remove:Int(index:Int)
		Return bmx_wximagelist_remove(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Removes all the images in the list.
	End Rem
	Method RemoveAll:Int()
		Return bmx_wximagelist_removeall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Replaces the existing image with the bitmap.
	End Rem
	Method Replace:Int(index:Int, bitmap:wxBitmap, mask:wxBitmap = Null)
		If mask Then
			Return bmx_wximagelist_replace(wxObjectPtr, index, bitmap.wxObjectPtr, mask.wxObjectPtr)
		Else
			Return bmx_wximagelist_replace(wxObjectPtr, index, bitmap.wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Replaces the existing image with the icon.
	End Rem
	Method ReplaceIcon:Int(index:Int, icon:wxIcon)
		Return bmx_wximagelist_replaceicon(wxObjectPtr, index, icon.wxObjectPtr)
	End Method
	
End Type


