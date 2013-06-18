' Copyright (c) 2007-2013 Bruce A Henderson
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

Module wx.wxDataViewCtrl

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
bbdoc: A control to display data either in a tree like fashion or in a tabular form or both.
End Rem
Type wxDataViewCtrl Extends wxControl

	Method GetSelection:wxDataViewItem()
		Return wxDataViewItem._create(bmx_wxdataviewctrl_getselection(wxObjectPtr))
	End Method

End Type

Rem
bbdoc: The event class for wxDataViewCtrl notifications.
End Rem
Type wxDataViewEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxDataViewEvent = New wxDataViewEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Method GetItem:wxDataViewItem()
		Return wxDataViewItem._create(bmx_wxdataviewevent_getitem(wxEventPtr))
	End Method
	
End Type

Type TDataViewEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_START_EDITING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED, ..
				wxEVT_COMMAND_DATAVIEW_CACHE_HINT, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_BEGIN_DRAG, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_DROP_POSSIBLE, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_DROP
					Return wxDataViewEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_DATAVIEW_SELECTION_CHANGED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_ACTIVATED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_COLLAPSING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EXPANDING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_START_EDITING, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_STARTED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_EDITING_DONE, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_VALUE_CHANGED, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_CONTEXT_MENU, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_CLICK, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_HEADER_RIGHT_CLICK, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_SORTED, ..
				wxEVT_COMMAND_DATAVIEW_COLUMN_REORDERED, ..
				wxEVT_COMMAND_DATAVIEW_CACHE_HINT, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_BEGIN_DRAG, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_DROP_POSSIBLE, ..
				wxEVT_COMMAND_DATAVIEW_ITEM_DROP
			Return bmx_wxdataviewctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TDataViewEventFactory
