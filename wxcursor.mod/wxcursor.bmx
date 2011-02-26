' Copyright (c) 2007-2011 Bruce A Henderson
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
bbdoc: wxCursor
End Rem
Module wx.wxCursor

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: A cursor is a small bitmap usually used for denoting where the mouse pointer is, with a picture that might indicate the interpretation of a mouse click.
about: As with icons, cursors in X and MS Windows are created in a different manner. Therefore, separate
cursors will be created for the different environments. Platform-specific methods for creating a wxCursor
object are catered for, and this is an occasion where conditional compilation will probably be required
(see wxIcon for an example).
<p>
A single cursor object may be used in many windows (any subwindow type). The wxWidgets convention is to
set the cursor for a window, as in X, rather than to set it globally as in MS Windows, although a
global ::wxSetCursor is also available for MS Windows use.
</p>
End Rem
Type wxCursor Extends wxBitmap

	Function _create:wxCursor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxCursor = New wxCursor
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a cursor using a stock cursor identifier.
	about: A stock cursor may be one of:
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxCURSOR_ARROW</td><td>A standard arrow cursor.</td></tr>
	<tr><td>wxCURSOR_RIGHT_ARROW</td><td>A standard arrow cursor pointing to the right. </td></tr>
	<tr><td>wxCURSOR_BLANK</td><td>Transparent cursor.</td></tr>
	<tr><td>wxCURSOR_BULLSEYE</td><td>Bullseye cursor.</td></tr>
	<tr><td>wxCURSOR_CHAR</td><td>Rectangular character cursor.</td></tr>
	<tr><td>wxCURSOR_CROSS</td><td>A cross cursor.</td></tr>
	<tr><td>wxCURSOR_HAND</td><td>A hand cursor.</td></tr>
	<tr><td>wxCURSOR_IBEAM</td><td>An I-beam cursor (vertical line). </td></tr>
	<tr><td>wxCURSOR_LEFT_BUTTON</td><td>Represents a mouse with the left button depressed. </td></tr>
	<tr><td>wxCURSOR_MAGNIFIER</td><td>A magnifier icon. </td></tr>
	<tr><td>wxCURSOR_MIDDLE_BUTTON</td><td>Represents a mouse with the middle button depressed. </td></tr>
	<tr><td>wxCURSOR_NO_ENTRY</td><td>A no-entry sign cursor.</td></tr>
	<tr><td>wxCURSOR_PAINT_BRUSH</td><td>A paintbrush cursor.</td></tr>
	<tr><td>wxCURSOR_PENCIL</td><td>A pencil cursor.</td></tr>
	<tr><td>wxCURSOR_POINT_LEFT</td><td>A cursor that points left. </td></tr>
	<tr><td>wxCURSOR_POINT_RIGHT</td><td>A cursor that points right. </td></tr>
	<tr><td>wxCURSOR_QUESTION_ARROW</td><td>An arrow and question mark. </td></tr>
	<tr><td>wxCURSOR_RIGHT_BUTTON</td><td>Represents a mouse with the right button depressed. </td></tr>
	<tr><td>wxCURSOR_SIZENESW</td><td>A sizing cursor pointing NE-SW.</td></tr>
	<tr><td>wxCURSOR_SIZENS</td><td>A sizing cursor pointing N-S. </td></tr>
	<tr><td>wxCURSOR_SIZENWSE</td><td>A sizing cursor pointing NW-SE. </td></tr>
	<tr><td>wxCURSOR_SIZEWE</td><td>A sizing cursor pointing W-E. </td></tr>
	<tr><td>wxCURSOR_SIZING</td><td>A general sizing cursor.</td></tr>
	<tr><td>wxCURSOR_SPRAYCAN</td><td>A spraycan cursor.</td></tr>
	<tr><td>wxCURSOR_WAIT</td><td>A wait cursor.</td></tr>
	<tr><td>wxCURSOR_WATCH</td><td>A watch cursor.</td></tr>
	<tr><td>wxCURSOR_ARROWWAIT</td><td>A cursor with both an arrow and an hourglass, (windows.) </td></tr>
	</table>
	Note that not all cursors are available on all platforms.
	End Rem
	Method StockCreate:wxCursor(id:Int)
		wxObjectPtr = bmx_wxcursor_stockcreate(id)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a cursor from a wxImage.
	about: The cursor is monochrome, colors with the RGB elements all greater than 127 will be
	foreground, colors less than this background. The mask (if any) will be used as transparent.
	End Rem
	Method CreateWithImage:wxCursor(image:wxImage)
		wxObjectPtr = bmx_wxcursor_createfromimage(image.wxObjectPtr)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if cursor data is present.
	End Rem
	Method IsOk:Int()
		Return bmx_wxcursor_isok(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcursor_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Globally sets the cursor.
End Rem
Function wxSetCursor(cursor:wxCursor)
	If cursor Then
		bmx_wxsetcursor(cursor.wxObjectPtr)
	Else
		bmx_wxsetcursor(Null)
	End If
End Function

Rem
bbdoc: 
End Rem
Function wxCROSS_CURSOR:wxCursor()
	Return wxCursor._create(bmx_wxstockgdi_cursor_cross())
End Function

Rem
bbdoc: 
End Rem
Function wxHOURGLASS_CURSOR:wxCursor()
	Return wxCursor._create(bmx_wxstockgdi_cursor_hourglass())
End Function

Rem
bbdoc: 
End Rem
Function wxSTANDARD_CURSOR:wxCursor()
	Return wxCursor._create(bmx_wxstockgdi_cursor_standard())
End Function

