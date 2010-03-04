' Copyright (c) 2010 Bruce A Henderson
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
Import wx.wxTreeCtrl
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

Import "include/*.h"
Import "src/treelistctrl.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxtreelistctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxtreelistctrl_addroot:Byte Ptr(handle:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreelistctrl_appenditem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreelistctrl_assignimagelist(handle:Byte Ptr, imagelist:Byte Ptr)
	Function bmx_wxtreelistctrl_expand(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreelistctrl_assignstateimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreelistctrl_collapse(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_collapseandreset(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_deleteitem(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_deletechildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_editlabel(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_ensurevisible(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getboundingrect:Int(handle:Byte Ptr, item:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr, textOnly:Int)
	Function bmx_wxtreelistctrl_getboundingrectrect:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, textOnly:Int)
	Function bmx_wxtreelistctrl_getchildrencount:Int(handle:Byte Ptr, item:Byte Ptr, recursively:Int)
	Function bmx_wxtreelistctrl_getcount:Int(handle:Byte Ptr)

	Function bmx_wxtreelistctrl_getitemdata:Object(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getfirstchild:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, idvalue:Byte Ptr)
	Function bmx_wxtreelistctrl_getfirstvisibleitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_getindent:Int(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_getitembackgroundcolour:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)	
	Function bmx_wxtreelistctrl_getitemfont:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getitemimage:Int(handle:Byte Ptr, item:Byte Ptr, which:Int)
	Function bmx_wxtreelistctrl_getitemtextcolour:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getlastchild:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, itemvalue:Byte Ptr)
	Function bmx_wxtreelistctrl_getnextsibling:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getnextvisible:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getitemparent:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getprevsibling:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getprevvisible:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getrootitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_getselection:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_isbold:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_isexpanded:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_isselected:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_isvisible:Int(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreelistctrl_scrollto(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_selectitem:Int(handle:Byte Ptr, item:Byte Ptr, last:Byte Ptr, selected:Int)
	Function bmx_wxtreelistctrl_setindent(handle:Byte Ptr, indent:Int)
	Function bmx_wxtreelistctrl_setimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreelistctrl_setitembackgroundcolour(handle:Byte Ptr, item:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxtreelistctrl_setitembold(handle:Byte Ptr, item:Byte Ptr, bold:Int)
	Function bmx_wxtreelistctrl_setitemdata(handle:Byte Ptr, item:Byte Ptr, data:Object)
	Function bmx_wxtreelistctrl_setitemfont(handle:Byte Ptr, item:Byte Ptr, font:Byte Ptr)
	Function bmx_wxtreelistctrl_setitemhaschildren(handle:Byte Ptr, item:Byte Ptr, hasChildren:Int)
	Function bmx_wxtreelistctrl_setitemtextcolour(handle:Byte Ptr, item:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxtreelistctrl_setstateimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreelistctrl_setwindowstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxtreelistctrl_sortchildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_toggle(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_unselect(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_unselectall(handle:Byte Ptr)

	Function bmx_wxtreelistctrl_hittest:Byte Ptr(handle:Byte Ptr, x:Int, y:Int, flags:Int Ptr)
	Function bmx_wxtreelistctrl_insertitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, previous:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreelistctrl_insertitembefore:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, before:Int, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreelistctrl_prependitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)

	Function bmx_wxtreelistctrl_deleteroot(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_finditem:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, text:String, flags:Int)
	Function bmx_wxtreelistctrl_getfirstexpandeditem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_expandall(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getitemtext:String(handle:Byte Ptr, item:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_getlinespacing:Int(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_getnext:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getnextexpanded:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getprev:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_getprevexpanded:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_haschildren:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreelistctrl_setitemimage(handle:Byte Ptr, item:Byte Ptr, image:Int, column:Int, which:Int)
	Function bmx_wxtreelistctrl_setitemtext(handle:Byte Ptr, item:Byte Ptr, text:String, column:Int)
	Function bmx_wxtreelistctrl_setlinespacing(handle:Byte Ptr, value:Int)

	Function bmx_wxtreelistctrl_addcolumn(handle:Byte Ptr, text:String, width:Int, alignment:Int)
	Function bmx_wxtreelistctrl_getcolumnalignment:Int(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_getcolumncount:Int(handle:Byte Ptr)
	Function bmx_wxtreelistctrl_getcolumnimage:Int(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_getcolumntext:String(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_getcolumnwidth:Int(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_insertcolumn(handle:Byte Ptr, before:Int, text:String, width:Int, alignment:Int)
	Function bmx_wxtreelistctrl_iscolumnshown:Int(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_removecolumn(handle:Byte Ptr, column:Int)
	Function bmx_wxtreelistctrl_setcolumnalignment(handle:Byte Ptr, column:Int, align:Int)
	Function bmx_wxtreelistctrl_setcolumnimage(handle:Byte Ptr, column:Int, image:Int)
	Function bmx_wxtreelistctrl_setcolumntext(handle:Byte Ptr, column:Int, text:String)
	Function bmx_wxtreelistctrl_setcolumnwidth(handle:Byte Ptr, column:Int, width:Int)
	Function bmx_wxtreelistctrl_setmaincolumn(handle:Byte Ptr, column:Int)

End Extern

' modes for navigation
Const wxTL_MODE_NAV_FULLTREE:Int = $0000
Const wxTL_MODE_NAV_EXPANDED:Int = $0001
Const wxTL_MODE_NAV_VISIBLE:Int = $0002
Const wxTL_MODE_NAV_LEVEL:Int = $0004

' modes For FindItem
Const wxTL_MODE_FIND_EXACT:Int = $0000
Const wxTL_MODE_FIND_PARTIAL:Int = $0010
Const wxTL_MODE_FIND_NOCASE:Int = $0020

' additional flag For HitTest
Const wxTREE_HITTEST_ONITEMCOLUMN:Int = $2000
