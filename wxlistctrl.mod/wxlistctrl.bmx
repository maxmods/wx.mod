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
bbdoc: wxListCtrl
End Rem
Module wx.wxListCtrl

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
bbdoc: 
End Rem
Type wxListCtrl Extends wxControl


End Type



Type TListEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_LIST_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_RDRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_END_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_DELETE_ITEM, ..
					wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, ..
					wxEVT_COMMAND_LIST_ITEM_SELECTED, ..
					wxEVT_COMMAND_LIST_ITEM_DESELECTED, ..
					wxEVT_COMMAND_LIST_KEY_DOWN, ..
					wxEVT_COMMAND_LIST_INSERT_ITEM, ..
					wxEVT_COMMAND_LIST_COL_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_LIST_CACHE_HINT, ..
					wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_COL_DRAGGING, ..
					wxEVT_COMMAND_LIST_COL_END_DRAG, ..
					wxEVT_COMMAND_LIST_ITEM_FOCUSED

		End Select
		
		Return Null
	End End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_LIST_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_RDRAG, ..
					wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_END_LABEL_EDIT, ..
					wxEVT_COMMAND_LIST_DELETE_ITEM, ..
					wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, ..
					wxEVT_COMMAND_LIST_ITEM_SELECTED, ..
					wxEVT_COMMAND_LIST_ITEM_DESELECTED, ..
					wxEVT_COMMAND_LIST_KEY_DOWN, ..
					wxEVT_COMMAND_LIST_INSERT_ITEM, ..
					wxEVT_COMMAND_LIST_COL_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK, ..
					wxEVT_COMMAND_LIST_ITEM_ACTIVATED, ..
					wxEVT_COMMAND_LIST_CACHE_HINT, ..
					wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, ..
					wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, ..
					wxEVT_COMMAND_LIST_COL_DRAGGING, ..
					wxEVT_COMMAND_LIST_COL_END_DRAG, ..
					wxEVT_COMMAND_LIST_ITEM_FOCUSED
				Return bmx_wxlistctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TListEventFactory

