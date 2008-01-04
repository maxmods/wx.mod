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

Import wx.wx
Import wx.wxScrolledWindow
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "glue.cpp"

Extern

	Function bmx_wxgrid_geteventtype:Int(evt:Int)
	
End Extern

Const wxGridSelectCells:Int = 1
Const wxGridSelectRows:Int = 2
Const wxGridSelectColumns:Int = 3

Const wxEVT_GRID_CELL_LEFT_CLICK:Int = 1580
Const wxEVT_GRID_CELL_RIGHT_CLICK:Int = 1581
Const wxEVT_GRID_CELL_LEFT_DCLICK:Int = 1582
Const wxEVT_GRID_CELL_RIGHT_DCLICK:Int = 1583
Const wxEVT_GRID_LABEL_LEFT_CLICK:Int = 1584
Const wxEVT_GRID_LABEL_RIGHT_CLICK:Int = 1585
Const wxEVT_GRID_LABEL_LEFT_DCLICK:Int = 1586
Const wxEVT_GRID_LABEL_RIGHT_DCLICK:Int = 1587
Const wxEVT_GRID_ROW_SIZE:Int = 1588
Const wxEVT_GRID_COL_SIZE:Int = 1589
Const wxEVT_GRID_RANGE_SELECT:Int = 1590
Const wxEVT_GRID_CELL_CHANGE:Int = 1591
Const wxEVT_GRID_SELECT_CELL:Int = 1592
Const wxEVT_GRID_EDITOR_SHOWN:Int = 1593
Const wxEVT_GRID_EDITOR_HIDDEN:Int = 1594
Const wxEVT_GRID_EDITOR_CREATED:Int = 1595
Const wxEVT_GRID_CELL_BEGIN_DRAG:Int = 1596

Const wxGRID_VALUE_STRING:String = "string"
Const wxGRID_VALUE_BOOL:String = "bool"
Const wxGRID_VALUE_NUMBER:String = "long"
Const wxGRID_VALUE_FLOAT:String = "double"
Const wxGRID_VALUE_CHOICE:String = "choice"

Const wxGRID_VALUE_TEXT:String = wxGRID_VALUE_STRING
Const wxGRID_VALUE_LONG:String = wxGRID_VALUE_NUMBER

