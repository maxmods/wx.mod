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
bbdoc: wxPen
End Rem
Module wx.wxPen

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
	
	Method GetCap:Int()
	End Method
	
	Method GetColour:wxColour()
	End Method
	
	Method GetDashes()
	End Method
	
	Method GetJoin:Int()
	End Method
	
	Method GetStipple:wxBitmap()
	End Method
	
	Method GetStyle:Int()
	End Method
	
	Method GetWidth:Int()
	End Method
	
	Method IsOk:Int()
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpen_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Null colour
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

