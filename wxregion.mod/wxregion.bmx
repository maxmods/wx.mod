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
bbdoc: wxRegion
End Rem
Module wx.wxRegion

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
bbdoc: A wxRegion represents a simple or complex region on a device context or window.
End Rem
Type wxRegion Extends wxGDIObject

	Rem
	bbdoc: Constructs a rectangular region with the given position and size.
	End Rem
	Function CreateRegion:wxRegion(x:Int, y:Int, width:Int, height:Int)
		Return New wxRegion.Create(x, y, width, height)
	End Function
	
	Rem
	bbdoc: Constructs a rectangular region with the given position and size.
	End Rem
	Method Create:wxRegion(x:Int, y:Int, width:Int, height:Int)
		wxObjectPtr = bmx_wxregion_create(x, y, width, height)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a rectangular region a wxRect object.
	End Rem
	Function CreateRegionWithRect:wxRegion(rect:wxRect)
		Return New wxRegion.CreateWithRect(rect)
	End Function
	
	Rem
	bbdoc: Constructs a rectangular region a wxRect object.
	End Rem
	Method CreateWithRect:wxRegion(rect:wxRect)
		wxObjectPtr = bmx_wxregion_createwithrect(rect.wxObjectPtr)
		Return Self
	End Method

	Rem
	bbdoc: Constructs a region corresponding to the polygon made of @points in the provided array.
	about: @fillStyle parameter may have values wxWINDING_RULE or wxODDEVEN_RULE.
	End Rem
	Function CreateRegionWithPoints:wxRegion(points:Int[], fillStyle:Int = wxWINDING_RULE)
		Return New wxRegion.CreateWithPoints(points, fillStyle)
	End Function

	Rem
	bbdoc: Constructs a region corresponding to the polygon made of @points in the provided array.
	about: @fillStyle parameter may have values wxWINDING_RULE or wxODDEVEN_RULE.
	End Rem
	Method CreateWithPoints:wxRegion(points:Int[], fillStyle:Int = wxWINDING_RULE)
		wxObjectPtr = bmx_wxregion_createwithpoints(points, fillStyle)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a region using the non-transparent pixels of a bitmap.
	End Rem
	Function CreateRegionWithBitmap:wxRegion(bmp:wxBitmap, transColour:wxColour = Null, tolerance:Int = 0)
		Return New wxRegion.CreateWithBitmap(bmp, transColour, tolerance)
	End Function

	Rem
	bbdoc: Constructs a region using the non-transparent pixels of a bitmap.
	End Rem
	Method CreateWithBitmap:wxRegion(bmp:wxBitmap, transColour:wxColour = Null, tolerance:Int = 0)
		If transColour Then
			wxObjectPtr = bmx_wxregion_createwithbitmap(bmp.wxObjectPtr, transColour.wxObjectPTr, tolerance)
		Else
			wxObjectPtr = bmx_wxregion_createwithbitmap(bmp.wxObjectPtr, Null, 0)
		End If
		Return Self
	End Method
	
	Rem
	bbdoc: Clears the region.
	End Rem
	Method Clear()
		bmx_wxregion_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a value indicating whether the given point is contained within the region.
	End Rem
	Method Contains:Int(x:Int, y:Int)
		bmx_wxregion_contains(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns a value indicating whether the given rectangle is contained within the region.
	End Rem
	Method ContainsRect:Int(rect:wxRect)
		bmx_wxregion_containsrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Convert the region to a black and white bitmap with the white pixels being inside the region.
	End Rem
	Method ConvertToBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxregion_converttobitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the outer bounds of the region.
	End Rem
	Method GetBox(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
		bmx_wxregion_getbox(wxObjectPtr, Varptr x, Varptr y, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns the outer bounds of the region.
	End Rem
	Method GetBoxRect:wxRect()
		Return wxRect._create(bmx_wxregion_getboxrect(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Finds the intersection of this region and another, rectangular region, specified using position and size.
	returns: True if successful, False otherwise.
	End Rem
	Method Intersect:Int(x:Int, y:Int, w:Int, h:Int)	
		Return bmx_wxregion_intersect(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Finds the intersection of this region and another, rectangular region.
	returns: True if successful, False otherwise.
	End Rem
	Method IntersectRect:Int(rect:wxRect)
		Return bmx_wxregion_intersectrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the intersection of this region and another region.
	returns: True if successful, False otherwise.
	End Rem
	Method IntersectRegion:Int(region:wxRegion)
		Return bmx_wxregion_intersectregion(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the region is empty, false otherwise.
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxregion_isempty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the region is equal to, i.e. covers the same area as, another one.
	about: Note that if both this region and region are invalid, they are considered to be
	equal.
	End Rem
	Method IsEqual:Int(region:wxRegion)
		Return bmx_wxregion_isequal(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Subtracts a rectangular region from this region.
	returns: True if successful, False otherwise.
	End Rem
	Method Subtract:Int(x:Int, y:Int, w:Int, h:Int)
		Return bmx_wxregion_subtract(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Subtracts a rectangular region from this region.
	returns: True if successful, False otherwise.
	End Rem
	Method SubtractRect:Int(rect:wxRect)
		Return bmx_wxregion_subtractrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Subtracts a region from this region.
	returns: True if successful, False otherwise.
	End Rem
	Method SubtractRegion:Int(region:wxRegion)
		Return bmx_wxregion_subtractregion(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves the region by the specified offsets in horizontal and vertical directions.
	returns: True if successful, False otherwise (the region is unchanged then).
	End Rem
	Method Offset:Int(x:Int, y:Int)
		Return bmx_wxregion_offset(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Finds the union of this region and another, rectangular region, specified using position and size.
	returns: True if successful, False otherwise.
	End Rem
	Method Union:Int(x:Int, y:Int, w:Int, h:Int)
		Return bmx_wxregion_union(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Finds the union of this region and another, rectangular region.
	returns: True if successful, False otherwise.
	End Rem
	Method UnionRect:Int(rect:wxRect)
		Return bmx_wxregion_unionrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the union of this region and another region.
	returns: True if successful, False otherwise.
	End Rem
	Method UnionRegion:Int(region:wxRegion)
		Return bmx_wxregion_unionregion(wxObjectPtr, region.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the union of this region and the non-transparent pixels of a bitmap.
	returns: True if successful, False otherwise.
	about: Bitmap's mask is used to determine transparency. If the bitmap doesn't have a
	mask, solid rectangle of bitmap's dimensions is used.
	End Rem
	Method UnionBitmap:Int(bmp:wxBitmap)
		Return bmx_wxregion_unionbitmap(wxObjectPtr, bmp.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the Xor of this region and another, rectangular region, specified using position and size.
	returns: True if successful, False otherwise.
	End Rem
	Method Xor:Int(x:Int, y:Int, w:Int, h:Int)
		Return bmx_wxregion_xor(wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: Finds the Xor of this region and another, rectangular region.
	returns: True if successful, False otherwise.
	End Rem
	Method XorRect:Int(rect:wxRect)
		Return bmx_wxregion_xorrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Finds the Xor of this region and another region.
	returns: True if successful, False otherwise.
	End Rem
	Method XorRegion:Int(region:wxRegion)
		Return bmx_wxregion_xorregion(wxObjectPtr, region.wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxregion_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
		
End Type

