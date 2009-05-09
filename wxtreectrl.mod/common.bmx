' Copyright (c) 2007-2009 Bruce A Henderson
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

	Function bmx_wxtreectrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxtreectrl_addroot:Byte Ptr(handle:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreectrl_appenditem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreectrl_assignimagelist(handle:Byte Ptr, imagelist:Byte Ptr)
	Function bmx_wxtreectrl_expand(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreectrl_assignstateimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreectrl_collapse(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_collapseall(handle:Byte Ptr)
	Function bmx_wxtreectrl_collapseallchildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_collapseandreset(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_deleteitem(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_deleteallitems(handle:Byte Ptr)
	Function bmx_wxtreectrl_deletechildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_editlabel(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_endeditlabel(handle:Byte Ptr, item:Byte Ptr, cancelEdit:Int)
	Function bmx_wxtreectrl_ensurevisible(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_expandall(handle:Byte Ptr)
	Function bmx_wxtreectrl_expandallchildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getboundingrect:Int(handle:Byte Ptr, item:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr, textOnly:Int)
	Function bmx_wxtreectrl_getboundingrectrect:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, textOnly:Int)
	Function bmx_wxtreectrl_getchildrencount:Int(handle:Byte Ptr, item:Byte Ptr, recursively:Int)
	Function bmx_wxtreectrl_getcount:Int(handle:Byte Ptr)
	Function bmx_wxtreectrl_geteditcontrol:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxtreectrl_getitemdata:Object(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getfirstchild:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, idvalue:Byte Ptr)
	Function bmx_wxtreectrl_getfirstvisibleitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreectrl_getnextchild:Byte Ptr(handle:Byte Ptr, item:Byte Ptr, idvalue:Byte Ptr)
	Function bmx_wxtreectrl_getindent:Int(handle:Byte Ptr)
	Function bmx_wxtreectrl_getitembackgroundcolour:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)	
	Function bmx_wxtreectrl_getitemfont:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getitemimage:Int(handle:Byte Ptr, item:Byte Ptr, which:Int)
	Function bmx_wxtreectrl_getitemtext:String(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getitemtextcolour:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getlastchild:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getnextsibling:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getnextvisible:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getitemparent:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getprevsibling:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getprevvisible:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_getquickbestsize(handle:Byte Ptr)
	Function bmx_wxtreectrl_getrootitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreectrl_getselection:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreectrl_isbold:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_isempty:Int(handle:Byte Ptr)
	Function bmx_wxtreectrl_isexpanded:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_isselected:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_isvisible:Int(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_itemhaschildren:Int(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreectrl_scrollto(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_selectitem(handle:Byte Ptr, item:Byte Ptr, selected:Int)
	Function bmx_wxtreectrl_setindent(handle:Byte Ptr, indent:Int)
	Function bmx_wxtreectrl_setimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreectrl_setitembackgroundcolour(handle:Byte Ptr, item:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxtreectrl_setitembold(handle:Byte Ptr, item:Byte Ptr, bold:Int)
	Function bmx_wxtreectrl_setitemdata(handle:Byte Ptr, item:Byte Ptr, data:Object)
	Function bmx_wxtreectrl_setitemdrophighlight(handle:Byte Ptr, item:Byte Ptr, highlight:Int)
	Function bmx_wxtreectrl_setitemfont(handle:Byte Ptr, item:Byte Ptr, font:Byte Ptr)
	Function bmx_wxtreectrl_setitemhaschildren(handle:Byte Ptr, item:Byte Ptr, hasChildren:Int)
	Function bmx_wxtreectrl_setitemimage(handle:Byte Ptr, item:Byte Ptr, image:Int, which:Int)
	Function bmx_wxtreectrl_setitemtext(handle:Byte Ptr, item:Byte Ptr, text:String)
	Function bmx_wxtreectrl_setitemtextcolour(handle:Byte Ptr, item:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxtreectrl_setquickbestsize(handle:Byte Ptr, quickBestSize:Int)
	Function bmx_wxtreectrl_setstateimagelist(handle:Byte Ptr, imageList:Byte Ptr)
	Function bmx_wxtreectrl_setwindowstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxtreectrl_sortchildren(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_toggle(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_toggleitemselection(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxtreectrl_unselect(handle:Byte Ptr)
	Function bmx_wxtreectrl_unselectall(handle:Byte Ptr)
	Function bmx_wxtreectrl_unselectitem(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreectrl_hittest:Byte Ptr(handle:Byte Ptr, x:Int, y:Int, flags:Int Ptr)
	Function bmx_wxtreectrl_insertitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, previous:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreectrl_insertitembefore:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, before:Int, text:String, image:Int, selImage:Int, data:Object)
	Function bmx_wxtreectrl_prependitem:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, text:String, image:Int, selImage:Int, data:Object)

	Function bmx_wxtreeitemidvalue_create:Byte Ptr()
	Function bmx_wxtreeitemidvalue_delete(handle:Byte Ptr)

	Function bmx_wxtreeitemid_isok:Int(handle:Byte Ptr)
	Function bmx_wxtreeitemid_equals:Int(handle:Byte Ptr, item:Byte Ptr)

	Function bmx_wxtreeitemid_delete(item:Byte Ptr)
	Function bmx_wxtreectrl_geteventtype:Int(evt:Int)

	Function bmx_wxtreeevent_getkeycode:Int(handle:Byte Ptr)
	Function bmx_wxtreeevent_getitem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreeevent_getkeyevent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreeevent_getlabel:String(handle:Byte Ptr)
	Function bmx_wxtreeevent_getolditem:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxtreeevent_getpoint(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxtreeevent_iseditcancelled(handle:Byte Ptr)
	Function bmx_wxtreeevent_settooltip(handle:Byte Ptr, tip:String)

End Extern

Const wxTR_NO_BUTTONS:Int = $0000     ' For convenience
Const wxTR_HAS_BUTTONS:Int = $0001     ' draw collapsed/expanded btns
Const wxTR_NO_LINES:Int = $0004     ' don't draw lines at all
Const wxTR_LINES_AT_ROOT:Int = $0008     ' connect top-level nodes
Const wxTR_TWIST_BUTTONS:Int = $0010     ' still used by wxTreeListCtrl

Const wxTR_SINGLE:Int = $0000     ' For convenience
Const wxTR_MULTIPLE:Int = $0020     ' can Select multiple items
Const wxTR_EXTENDED:Int = $0040     ' TODO: allow extended selection
Const wxTR_HAS_VARIABLE_ROW_HEIGHT:Int = $0080     ' what it says

Const wxTR_EDIT_LABELS:Int = $0200     ' can edit item labels
Const wxTR_ROW_LINES:Int = $0400     ' put border around items
Const wxTR_HIDE_ROOT:Int = $0800     ' don't display root node

Const wxTR_FULL_ROW_HIGHLIGHT:Int = $2000     ' highlight full horz space

?linux
Const wxTR_DEFAULT_STYLE:Int = wxTR_HAS_BUTTONS | wxTR_NO_LINES
?macos
Const wxTR_DEFAULT_STYLE:Int = wxTR_HAS_BUTTONS | wxTR_LINES_AT_ROOT
?win32
Const wxTR_DEFAULT_STYLE:Int = wxTR_HAS_BUTTONS | wxTR_LINES_AT_ROOT
?

Const wxEVT_COMMAND_TREE_BEGIN_DRAG:Int = 600
Const wxEVT_COMMAND_TREE_BEGIN_RDRAG:Int = 601
Const wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT:Int = 602
Const wxEVT_COMMAND_TREE_END_LABEL_EDIT:Int = 603
Const wxEVT_COMMAND_TREE_DELETE_ITEM:Int = 604
Const wxEVT_COMMAND_TREE_GET_INFO:Int = 605
Const wxEVT_COMMAND_TREE_SET_INFO:Int = 606
Const wxEVT_COMMAND_TREE_ITEM_EXPANDED:Int = 607
Const wxEVT_COMMAND_TREE_ITEM_EXPANDING:Int = 608
Const wxEVT_COMMAND_TREE_ITEM_COLLAPSED:Int = 609
Const wxEVT_COMMAND_TREE_ITEM_COLLAPSING:Int = 610
Const wxEVT_COMMAND_TREE_SEL_CHANGED:Int = 611
Const wxEVT_COMMAND_TREE_SEL_CHANGING:Int = 612
Const wxEVT_COMMAND_TREE_KEY_DOWN:Int = 613
Const wxEVT_COMMAND_TREE_ITEM_ACTIVATED:Int = 614
Const wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK:Int = 615
Const wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK:Int = 616
Const wxEVT_COMMAND_TREE_END_DRAG:Int = 617
Const wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK:Int = 618
Const wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP:Int = 619
Const wxEVT_COMMAND_TREE_ITEM_MENU:Int = 620

Const wxTREE_HITTEST_ABOVE:Int = $0001
Const wxTREE_HITTEST_BELOW:Int = $0002
Const wxTREE_HITTEST_NOWHERE:Int = $0004
' on the button associated with an item.
Const wxTREE_HITTEST_ONITEMBUTTON:Int = $0008
' on the bitmap associated with an item.
Const wxTREE_HITTEST_ONITEMICON:Int = $0010
' on the indent associated with an item.
Const wxTREE_HITTEST_ONITEMINDENT:Int = $0020
' on the label (String) associated with an item.
Const wxTREE_HITTEST_ONITEMLABEL:Int = $0040
' on the Right of the label associated with an item.
Const wxTREE_HITTEST_ONITEMRIGHT:Int = $0080
' on the label (String) associated with an item.
Const wxTREE_HITTEST_ONITEMSTATEICON:Int = $0100
' on the Left of the wxTreeCtrl.
Const wxTREE_HITTEST_TOLEFT:Int = $0200
' on the Right of the wxTreeCtrl.
Const wxTREE_HITTEST_TORIGHT:Int = $0400
' on the Upper part (First half) of the item.
Const wxTREE_HITTEST_ONITEMUPPERPART:Int = $0800
' on the Lower part (Second half) of the item.
Const wxTREE_HITTEST_ONITEMLOWERPART:Int = $1000

' anywhere on the item
Const wxTREE_HITTEST_ONITEM:Int = wxTREE_HITTEST_ONITEMICON | wxTREE_HITTEST_ONITEMLABEL

Const wxTreeItemIcon_Normal:Int = 0              ' Not selected, Not expanded
Const wxTreeItemIcon_Selected:Int = 1            '     selected, Not expanded
Const wxTreeItemIcon_Expanded:Int = 2            ' Not selected,     expanded
Const wxTreeItemIcon_SelectedExpanded:Int = 3    '     selected,     expanded
 
