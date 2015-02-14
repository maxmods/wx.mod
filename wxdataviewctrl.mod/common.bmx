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

Import wx.wx
Import wx.wxControl
Import wx.wxDataViewModel
Import BRL.Blitz


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk2-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk2-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxdataviewctrl_getselection:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxdataviewctrl_geteventtype:Int(eventType:Int)
	
	
	Function bmx_wxdataviewevent_getitem:Byte Ptr(handle:Byte Ptr)
	
End Extern

Rem
bbdoc: Single selection mode.
about: This is the default.
End Rem
Const wxDV_SINGLE:Int = $0000
Rem
bbdoc: Multiple selection mode.
End Rem
Const wxDV_MULTIPLE:Int = $0001
Rem
bbdoc: Do not show column headers (which are shown by default).
End Rem
Const wxDV_NO_HEADER:Int = $0002
Rem
bbdoc: Display the separator lines between rows.
End Rem
Const wxDV_HORIZ_RULES:Int = $0004
Rem
bbdoc: Display the separator lines between columns.
End Rem
Const wxDV_VERT_RULES:Int = $0008
Rem
bbdoc: Use alternating colours for rows if supported by platform and theme.
about: Currently only supported by the native GTK and OS X implementations but not by the generic one.
End Rem
Const wxDV_ROW_LINES:Int = $0010
Rem
bbdoc: Allow variable line heights.
about: This can be inefficient when displaying large number of items.
End Rem
Const wxDV_VARIABLE_LINE_HEIGHT:Int = $0020



Const wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED:Int = -361
Const wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED:Int = -362
Const wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED:Int = -363
Const wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED:Int = -364
Const wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING:Int = -365
Const wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING:Int = -366
Const wxEVT_COMMAND_DATAVIEW_ITEM_START_EDITING:Int = -367
Const wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED:Int = -368
Const wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE:Int = -369
Const wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED:Int = -370
Const wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU:Int = -371
Const wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK:Int = -372
Const wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK:Int = -373
Const wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED:Int = -374
Const wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED:Int = -375
Const wxEVT_COMMAND_DATAVIEW_CACHE_HINT:Int = -376
Const wxEVT_COMMAND_DATAVIEW_ITEM_BEGIN_DRAG:Int = -377
Const wxEVT_COMMAND_DATAVIEW_ITEM_DROP_POSSIBLE:Int = -378
Const wxEVT_COMMAND_DATAVIEW_ITEM_DROP:Int = -379
