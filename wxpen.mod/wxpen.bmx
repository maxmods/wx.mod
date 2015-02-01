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
bbdoc: wxPen
End Rem
Module wx.wxPen

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
bbdoc: A pen is a drawing tool for drawing outlines.
about: It is used for drawing lines and painting the outline of rectangles, ellipses, etc. It has a
colour, a width and a style.
End Rem
Type wxPen Extends wxGDIObject

	Function _create:wxPen(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPen = New wxPen
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a pen from a colour name, pen width and style.
	End Rem
	Method Create:wxPen(name:String, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_create(name, width, style)
		Return Self
	End Method

	Rem
	bbdoc: Constructs a pen from a colour object, pen width and style.
	End Rem
	Method CreateFromColour:wxPen(colour:wxColour, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_createfromcolour(colour.wxObjectPtr, width, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the pen cap style, which may be one of wxCAP_ROUND, wxCAP_PROJECTING and wxCAP_BUTT.
	about: The default is wxCAP_ROUND.
	End Rem
	Method GetCap:Int()
		Return bmx_wxpen_getcap(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a reference to the pen colour.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxpen_getcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Gets an array of dashes.
	End Rem
	Method GetDashes:wxDashes()
		Local count:Int
		Local bp:Byte Ptr = bmx_wxpen_getdashes(wxObjectPtr, Varptr count)
		Return wxDashes._create(bp, count)
	End Method
	
	Rem
	bbdoc: Returns the pen join style, which may be one of wxJOIN_BEVEL, wxJOIN_ROUND and wxJOIN_MITER.
	about: The default is wxJOIN_ROUND.
	End Rem
	Method GetJoin:Int()
		Return bmx_wxpen_getjoin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets a the stipple bitmap.
	End Rem
	Method GetStipple:wxBitmap()
		Return wxBitmap._create(bmx_wxpen_getstipple(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the pen style.
	End Rem
	Method GetStyle:Int()
		Return bmx_wxpen_getstyle(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the pen width.
	End Rem
	Method GetWidth:Int()
		Return bmx_wxpen_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the pen is initialised.
	End Rem
	Method IsOk:Int()
		Return bmx_wxpen_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the pen cap style, which may be one of wxCAP_ROUND, wxCAP_PROJECTING and wxCAP_BUTT.
	about: The default is wxCAP_ROUND.
	End Rem
	Method SetCap(style:Int)
		bmx_wxpen_setcap(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: The pen's colour is changed to the given colour.
	End Rem
	Method SetColour(name:String)
		bmx_wxpen_setcolour(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: The pen's colour is changed to the given colour.
	End Rem
	Method SetFromColour(colour:wxColour)
		bmx_wxpen_setfromcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: The pen's colour is changed to the given colour.
	End Rem
	Method SetFromRGB(red:Int, green:Int, blue:Int)
		bmx_wxpen_setfromrgb(wxObjectPtr, red, green, blue)
	End Method
	
	Rem
	bbdoc: Associates dashes with the pen.
	End Rem
	Method SetDashes(dashes:wxDashes)
		bmx_wxpen_setdashes(wxObjectPtr, dashes.wxDashesPtr, dashes.count)
	End Method
	
	Rem
	bbdoc: Sets the pen join style, which may be one of wxJOIN_BEVEL, wxJOIN_ROUND and wxJOIN_MITER.
	about: The default is wxJOIN_ROUND.
	End Rem
	Method SetJoin(style:Int)
		bmx_wxpen_setjoin(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Sets the bitmap for stippling.
	End Rem
	Method SetStipple(stipple:wxBitmap)
		bmx_wxpen_setstipple(wxObjectPtr, stipple.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the pen style.
	End Rem
	Method SetStyle(style:Int)
		bmx_wxpen_setstyle(wxObjectPtr, style)
	End Method
	
	Rem
	bbdoc: Sets the pen width.
	End Rem
	Method SetWidth(width:Int)
		bmx_wxpen_setwidth(wxObjectPtr, width)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpen_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Null Pen
End Rem
Global wxNullPen:wxPen = wxPen._create(bmx_wxpen_null())


Function wxBLACK_DASHED_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_blackdashed())
End Function

Function wxBLACK_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_black())
End Function

Function wxCYAN_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_cyan())
End Function

Function wxGREEN_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_green())
End Function

Function wxGREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_grey())
End Function

Function wxLIGHT_GREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_lightgrey())
End Function

Function wxMEDIUM_GREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_mediumgrey())
End Function

Function wxRED_PEN :wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_red())
End Function

Function wxTRANSPARENT_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_transparent())
End Function

Function wxWHITE_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_white())
End Function

Rem
bbdoc: Represents a set of dashes.
about: Although it is created with an Int array, each "dash" is assumed to be a maximum of 8 bits in size.
End Rem
Type wxDashes

	Field count:Int
	Field dashes:Int[]
	
	Field wxDashesPtr:Byte Ptr
	
	Field owner:Int
	
	Rem
	bbdoc: Creates a new dashes object using the specified array.
	End Rem
	Function CreateDashes:wxDashes(dashes:Int[])
		Return New wxDashes.Create(dashes)
	End Function
	
	Rem
	bbdoc: Creates a new dashes object using the specified array.
	End Rem
	Method Create:wxDashes(_dashes:Int[])
		count = _dashes.length
		dashes = _dashes[0.._dashes.length]
		wxDashesPtr = bmx_wxdashes_create(dashes)
		owner = True
		Return Self
	End Method

	Function _create:wxDashes(wxObjectPtr:Byte Ptr, count:Int)
		If wxObjectPtr Then
			Local this:wxDashes = New wxDashes
			this.wxDashesPtr = wxObjectPtr
			this.dashes = bmx_wxdashes_populate(wxObjectPtr, count)
			this.count = count
			Return this
		End If
	End Function
	
	Method Delete()
		If wxDashesPtr Then
			If owner Then
				bmx_wxdashes_delete(wxDashesPtr)
			End If
			wxDashesPtr = Null
		End If
	End Method
	
End Type
