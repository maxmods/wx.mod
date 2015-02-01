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
Import wx.wxImageList
Import wx.wxTextCtrl
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

	Function bmx_wxlistctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxlistctrl_arrange:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxlistctrl_assignimagelist(handle:Byte Ptr, imageList:Byte Ptr, which:Int)
	Function bmx_wxlistctrl_clearall(handle:Byte Ptr)
	Function bmx_wxlistctrl_deleteallitems:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_deletecolumn:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxlistctrl_deleteitem:Int(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_editlabel(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_ensurevisible:Int(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_finditem:Int(handle:Byte Ptr, start:Int, text:String, partial:Int)
	Function bmx_wxlistctrl_finditemdata:Int(handle:Byte Ptr, data:Object)
	Function bmx_wxlistctrl_finditematpos:Int(handle:Byte Ptr, start:Int, x:Int, y:Int, direction:Int)
	Function bmx_wxlistctrl_getcolumn:Int(handle:Byte Ptr, col:Int, item:Byte Ptr)
	Function bmx_wxlistctrl_getcolumncount:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_getcolumnwidth:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxlistctrl_getcountperpage:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_geteditcontrol:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistctrl_getimagelist:Byte Ptr(handle:Byte Ptr, which:Int)
	Function bmx_wxlistctrl_getitem:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxlistctrl_getitembackgroundcolour:Byte Ptr(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_getitemcount:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_getitemdata:Object(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_getitemfont:Byte Ptr(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_getitemposition:Int(handle:Byte Ptr, item:Int, x:Int Ptr, y:Int Ptr)
	Function bmx_wxlistctrl_getitemrect:Int(handle:Byte Ptr, item:Int, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr, code:Int)
	Function bmx_wxlistctrl_getsubitemrect:Int(handle:Byte Ptr, item:Int, subItem:Int, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr, code:Int)
	Function bmx_wxlistctrl_getitemspacing(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxlistctrl_getitemstate:Int(handle:Byte Ptr, item:Int, stateMask:Int)
	Function bmx_wxlistctrl_getitemtext:String(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_getitemtextcolour:Byte Ptr(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_getnextitem:Int(handle:Byte Ptr, item:Int, geometry:Int, state:Int)
	Function bmx_wxlistctrl_getselecteditemcount:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_gettextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistctrl_gettopitem:Int(handle:Byte Ptr)
	Function bmx_wxlistctrl_getviewrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxlistctrl_hittest:Int(handle:Byte Ptr, x:Int, y:Int, flags:Int Ptr, subitem:Int Ptr)
	Function bmx_wxlistctrl_insertcolumn:Int(handle:Byte Ptr, col:Int, heading:String, format:Int, width:Int)
	Function bmx_wxlistctrl_insertcolumnitem:Int(handle:Byte Ptr, col:Int, info:Byte Ptr)
	Function bmx_wxlistctrl_insertitem:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxlistctrl_insertstringitem:Int(handle:Byte Ptr, index:Int, label:String)
	Function bmx_wxlistctrl_insertimageitem:Int(handle:Byte Ptr, index:Int, imageIndex:Int)
	Function bmx_wxlistctrl_insertimagestringitem:Int(handle:Byte Ptr, index:Int, label:String, imageIndex:Int)
	Function bmx_wxlistctrl_refreshitem(handle:Byte Ptr, item:Int)
	Function bmx_wxlistctrl_refreshitems(handle:Byte Ptr, itemFrom:Int, itemTo:Int)
	Function bmx_wxlistctrl_scrolllist:Int(handle:Byte Ptr, dx:Int, dy:Int)
	Function bmx_wxlistctrl_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistctrl_setcolumn:Int(handle:Byte Ptr, col:Int, item:Byte Ptr)
	Function bmx_wxlistctrl_setcolumnwidth:Int(handle:Byte Ptr, col:Int, width:Int)
	Function bmx_wxlistctrl_setimagelist(handle:Byte Ptr, imageList:Byte Ptr, which:Int)
	Function bmx_wxlistctrl_setitem:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxlistctrl_setstringitem:Int(handle:Byte Ptr, item:Int, col:Int, label:String, imageId:Int)
	Function bmx_wxlistctrl_setitembackgroundcolour(handle:Byte Ptr, item:Int, colour:Byte Ptr)
	Function bmx_wxlistctrl_setitemcount(handle:Byte Ptr, count:Int)
	Function bmx_wxlistctrl_setitemdata:Int(handle:Byte Ptr, item:Int, data:Object)
	Function bmx_wxlistctrl_setitemfont(handle:Byte Ptr, item:Int, font:Byte Ptr)
	Function bmx_wxlistctrl_setitemimage:Int(handle:Byte Ptr, item:Int, image:Int)
	Function bmx_wxlistctrl_setitemcolumnimage:Int(handle:Byte Ptr, item:Int, col:Int, image:Int)
	Function bmx_wxlistctrl_setitemposition:Int(handle:Byte Ptr, item:Int, x:Int, y:Int)
	Function bmx_wxlistctrl_setitemstate:Int(handle:Byte Ptr, item:Int, state:Int, stateMask:Int)
	Function bmx_wxlistctrl_setitemtext(handle:Byte Ptr, item:Int, text:String)
	Function bmx_wxlistctrl_setitemtextcolour(handle:Byte Ptr, item:Int, colour:Byte Ptr)
	Function bmx_wxlistctrl_setsinglestyle(handle:Byte Ptr, style:Int, add:Int)
	Function bmx_wxlistctrl_settextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistctrl_setwindowstyleflag(handle:Byte Ptr, style:Int)
	Function bmx_wxlistctrl_sortitems:Int(handle:Byte Ptr)

	Function bmx_wxlistitem_create:Byte Ptr()
	Function bmx_wxlistitem_delete(handle:Byte Ptr)
	Function bmx_wxlistitem_clear(handle:Byte Ptr)
	Function bmx_wxlistitem_getalign:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitem_getcolumn:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_getdata:Object(handle:Byte Ptr)
	Function bmx_wxlistitem_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitem_getid:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_getimage:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_getmask:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_getstate:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_gettext:String(handle:Byte Ptr)
	Function bmx_wxlistitem_gettextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitem_getwidth:Int(handle:Byte Ptr)
	Function bmx_wxlistitem_setalign(handle:Byte Ptr, align:Int)
	Function bmx_wxlistitem_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistitem_setcolumn(handle:Byte Ptr, col:Int)
	Function bmx_wxlistitem_setdata(handle:Byte Ptr, data:Object)
	Function bmx_wxlistitem_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxlistitem_setid(handle:Byte Ptr, id:Int)
	Function bmx_wxlistitem_setimage(handle:Byte Ptr, image:Int)
	Function bmx_wxlistitem_setmask(handle:Byte Ptr, mask:Int)
	Function bmx_wxlistitem_setstate(handle:Byte Ptr, state:Int)
	Function bmx_wxlistitem_setstatemask(handle:Byte Ptr, stateMask:Int)
	Function bmx_wxlistitem_settext(handle:Byte Ptr, text:String)
	Function bmx_wxlistitem_settextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistitem_setwidth(handle:Byte Ptr, width:Int)
	Function bmx_wxlistitem_getattributes:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitem_hasattributes:Int(handle:Byte Ptr)

	Function bmx_wxlistitemattr_create:Byte Ptr(textCol:Byte Ptr, backCol:Byte Ptr, font:Byte Ptr)
	Function bmx_wxlistitemattr_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitemattr_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitemattr_gettextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistitemattr_hasbackgroundcolour:Int(handle:Byte Ptr)
	Function bmx_wxlistitemattr_hasfont:Int(handle:Byte Ptr)
	Function bmx_wxlistitemattr_hastextcolour:Int(handle:Byte Ptr)
	Function bmx_wxlistitemattr_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistitemattr_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxlistitemattr_settextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxlistitemattr_delete(handle:Byte Ptr)

	Function bmx_wxlistevent_getcachefrom:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getcacheto:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getkeycode:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getindex:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getcolumn:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getpoint(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxlistevent_getlabel:String(handle:Byte Ptr)
	Function bmx_wxlistevent_gettext:String(handle:Byte Ptr)
	Function bmx_wxlistevent_getimage:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getdata:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getmask:Int(handle:Byte Ptr)
	Function bmx_wxlistevent_getitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxlistevent_iseditcancelled:Int(handle:Byte Ptr)

	Function bmx_wxlistctrl_geteventtype:Int(evt:Int)
	
	Function bmx_wxlistctrl_addresourcehandler()
	
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


Const wxLC_VRULES:Int = $0001
Const wxLC_HRULES:Int = $0002

Const wxLC_ICON:Int = $0004
Const wxLC_SMALL_ICON:Int = $0008
Const wxLC_LIST:Int = $0010
Const wxLC_REPORT:Int = $0020

Const wxLC_ALIGN_TOP:Int = $0040
Const wxLC_ALIGN_LEFT:Int = $0080
Const wxLC_AUTOARRANGE:Int = $0100
Const wxLC_VIRTUAL:Int = $0200
Const wxLC_EDIT_LABELS:Int = $0400
Const wxLC_NO_HEADER:Int = $0800
Const wxLC_NO_SORT_HEADER:Int = $1000
Const wxLC_SINGLE_SEL:Int = $2000
Const wxLC_SORT_ASCENDING:Int = $4000
Const wxLC_SORT_DESCENDING:Int = $8000

Const wxLC_MASK_TYPE:Int = wxLC_ICON | wxLC_SMALL_ICON | wxLC_LIST | wxLC_REPORT
Const wxLC_MASK_ALIGN:Int = wxLC_ALIGN_TOP | wxLC_ALIGN_LEFT
Const wxLC_MASK_SORT:Int = wxLC_SORT_ASCENDING | wxLC_SORT_DESCENDING

' For compatibility only
Const wxLC_USER_TEXT:Int = wxLC_VIRTUAL


Const wxLIST_NEXT_ABOVE:Int = 0          ' Searches For an item above the specified item
Const wxLIST_NEXT_ALL:Int = 1            ' Searches For subsequent item by index
Const wxLIST_NEXT_BELOW:Int = 2          ' Searches For an item below the specified item
Const wxLIST_NEXT_LEFT:Int = 3           ' Searches For an item To the Left of the specified item
Const wxLIST_NEXT_RIGHT:Int = 4           ' Searches For an item To the Right of the specified item


' Alignment flags For Arrange (MSW only except wxLIST_ALIGN_LEFT)
Const wxLIST_ALIGN_DEFAULT:Int = 0
Const wxLIST_ALIGN_LEFT:Int = 1
Const wxLIST_ALIGN_TOP:Int = 2
Const wxLIST_ALIGN_SNAP_TO_GRID:Int = 3

' Column format (MSW only except wxLIST_FORMAT_LEFT)
Const wxLIST_FORMAT_LEFT:Int = 0
Const wxLIST_FORMAT_RIGHT:Int = 1
Const wxLIST_FORMAT_CENTRE:Int = 2
Const wxLIST_FORMAT_CENTER:Int = wxLIST_FORMAT_CENTRE

Const wxLIST_AUTOSIZE:Int = -1
Const wxLIST_AUTOSIZE_USEHEADER:Int = -2      ' partly supported by generic version


' Flag values For GetItemRect
Const wxLIST_RECT_BOUNDS:Int = 0
Const wxLIST_RECT_ICON:Int = 1
Const wxLIST_RECT_LABEL:Int = 2


' Flag values For FindItem (MSW only)
Const wxLIST_FIND_UP:Int = 0
Const wxLIST_FIND_DOWN:Int = 1
Const wxLIST_FIND_LEFT:Int = 2
Const wxLIST_FIND_RIGHT:Int = 3


Const wxLIST_MASK_STATE:Int = $0001
Const wxLIST_MASK_TEXT:Int = $0002
Const wxLIST_MASK_IMAGE:Int = $0004
Const wxLIST_MASK_DATA:Int = $0008
Const wxLIST_SET_ITEM:Int = $0010
Const wxLIST_MASK_WIDTH:Int = $0020
Const wxLIST_MASK_FORMAT:Int = $0040

' State flags For indicating the state of an item
Const wxLIST_STATE_DONTCARE:Int = $0000
Const wxLIST_STATE_DROPHILITED:Int = $0001      ' MSW only
Const wxLIST_STATE_FOCUSED:Int = $0002
Const wxLIST_STATE_SELECTED:Int = $0004
Const wxLIST_STATE_CUT:Int = $0008      ' MSW only
Const wxLIST_STATE_DISABLED:Int = $0010      ' OS2 only
Const wxLIST_STATE_FILTERED:Int = $0020      ' OS2 only
Const wxLIST_STATE_INUSE:Int = $0040      ' OS2 only
Const wxLIST_STATE_PICKED:Int = $0080      ' OS2 only
Const wxLIST_STATE_SOURCE:Int = $0100      ' OS2 only

' Hit test flags, used in HitTest
Const wxLIST_HITTEST_ABOVE:Int = $0001  ' Above the client area.
Const wxLIST_HITTEST_BELOW:Int = $0002  ' Below the client area.
Const wxLIST_HITTEST_NOWHERE:Int = $0004  ' In the client area but below the last item.
Const wxLIST_HITTEST_ONITEMICON:Int = $0020  ' On the bitmap associated with an item.
Const wxLIST_HITTEST_ONITEMLABEL:Int = $0080  ' On the label (String) associated with an item.
Const wxLIST_HITTEST_ONITEMRIGHT:Int = $0100  ' In the area To the Right of an item.
Const wxLIST_HITTEST_ONITEMSTATEICON:Int = $0200  ' On the state icon For a tree view item that is in a user-defined state.
Const wxLIST_HITTEST_TOLEFT:Int = $0400  ' To the Left of the client area.
Const wxLIST_HITTEST_TORIGHT:Int = $0800  ' To the Right of the client area.

