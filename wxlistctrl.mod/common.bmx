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

Import wx.wx
Import wx.wxControl
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

	Function bmx_wxlistctrl_geteventtype:Int(evt:Int)
End Extern


Const wxEVT_COMMAND_LIST_BEGIN_DRAG:Int = 700
Const wxEVT_COMMAND_LIST_BEGIN_RDRAG:Int = 701
Const wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT:Int = 702
Const wxEVT_COMMAND_LIST_END_LABEL_EDIT:Int = 703
Const wxEVT_COMMAND_LIST_DELETE_ITEM:Int = 704
Const wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS:Int = 705
Const wxEVT_COMMAND_LIST_ITEM_SELECTED:Int = 708
Const wxEVT_COMMAND_LIST_ITEM_DESELECTED:Int = 709
Const wxEVT_COMMAND_LIST_KEY_DOWN:Int = 710
Const wxEVT_COMMAND_LIST_INSERT_ITEM:Int = 711
Const wxEVT_COMMAND_LIST_COL_CLICK:Int = 712
Const wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK:Int = 713
Const wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK:Int = 714
Const wxEVT_COMMAND_LIST_ITEM_ACTIVATED:Int = 715
Const wxEVT_COMMAND_LIST_CACHE_HINT:Int = 716
Const wxEVT_COMMAND_LIST_COL_RIGHT_CLICK:Int = 717
Const wxEVT_COMMAND_LIST_COL_BEGIN_DRAG:Int = 718
Const wxEVT_COMMAND_LIST_COL_DRAGGING:Int = 719
Const wxEVT_COMMAND_LIST_COL_END_DRAG:Int = 720
Const wxEVT_COMMAND_LIST_ITEM_FOCUSED:Int = 721


