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

Rem
bbdoc: wxRadioBox
End Rem
Module wx.wxRadioBox

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
bbdoc: A radio box item is used to select one of number of mutually exclusive choices.
about: It is displayed as a vertical column or horizontal row of labelled buttons.
End Rem
Type wxRadioBox Extends wxControlWithItems

	Rem
	bbdoc: Constructor, creating and showing a radiobox.
	End Rem
	Function CreateRadioBox:wxRadioBox(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, choices:String[] = Null, majorDimension:Int = 0, style:Int = wxRA_SPECIFY_COLS)
		Return New wxRadioBox.Create(parent, id, label, x, y, w, h, choices, majorDimension, style)
	End Function
	
	Rem
	bbdoc: Creates the radiobox for two-step construction.
	about: See CreateRadioBox for further details.
	End Rem
	Method Create:wxRadioBox(parent:wxWindow, id:Int, label:String, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, choices:String[] = Null, majorDimension:Int = 0, style:Int = wxRA_SPECIFY_COLS)
		wxObjectPtr = bmx_wxradiobox_create(Self, parent.wxObjectPtr, id, label, x, y, w, h, choices, majorDimension, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Enables or disables the entire radiobox.
	End Rem
	Method Enable:Int(value:Int = True)
		Return bmx_wxradiobox_enable(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Enables or disables an individual button in the radiobox.
	End Rem
	Method EnableItem:Int(item:Int, value:Int = True)
		Return bmx_wxradiobox_enableitem(wxObjectPtr, item, value)
	End Method
	
	Rem
	bbdoc: Finds a button matching the given string, returning the position if found, or -1 if not found.
	End Rem
	Method FindString:Int(text:String, caseSensitive:Int = False)
		Return bmx_wxradiobox_findstring(wxObjectPtr, text, caseSensitive)
	End Method
	
	Rem
	bbdoc: Returns the number of columns in the radiobox.
	End Rem
	Method GetColumnCount:Int()
		Return bmx_wxradiobox_getcolumncount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the helptext associated with the specified item if any or wxEmptyString.
	End Rem
	Method GetItemHelpText:String(item:Int)
		Return bmx_wxradiobox_getitemhelptext(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the tooltip associated with the specified item if any or NULL.
	End Rem
	Method GetItemToolTip:wxToolTip(item:Int)
		Return wxToolTip._create(bmx_wxradiobox_getitemtooltip(wxObjectPtr, item))
	End Method
	
	Rem
	bbdoc: Returns a radio box item under the point, a zero-based item index, or wxNOT_FOUND if no item is under the point.
	End Rem
	Method GetItemFromPoint:Int(x:Int, y:Int)
		Return bmx_wxradiobox_getitemfrompoint(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns the radiobox label.
	End Rem
	Method GetLabel:String()
		Return bmx_wxradiobox_getlabel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the label for the given button.
	End Rem
	Method GetItemLabel:String(item:Int)
		Return bmx_wxradiobox_getitemlabel(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns the number of rows in the radiobox.
	End Rem
	Method GetRowCount:Int()
		Return bmx_wxradiobox_getrowcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the zero-based position of the selected button.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxradiobox_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the selected string.
	End Rem
	Method GetStringSelection:String()
		Return bmx_wxradiobox_getstringselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the label for the button at the given position.
	End Rem
	Method GetString:String(item:Int)
		Return bmx_wxradiobox_getstring(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns true if the item is enabled or false if it was disabled using Enable(n, false).
	End Rem
	Method IsItemEnabled:Int(item:Int)
		Return bmx_wxradiobox_isitemenabled(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Returns true if the item is currently shown or false if it was hidden using Show(n, false).
	End Rem
	Method IsItemShown:Int(item:Int)
		Return bmx_wxradiobox_isitemshown(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Sets the helptext for an item.
	about: Empty string erases any existing helptext.
	End Rem
	Method SetItemHelpText(item:Int, helpText:String)
		bmx_wxradiobox_setitemhelptext(wxObjectPtr, item, helpText)
	End Method
	
	Rem
	bbdoc: Sets the radiobox label.
	End Rem
	Method SetLabel(label:String)
		bmx_wxradiobox_setlabel(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: Sets the label for the given radio button.
	End Rem
	Method SetItemLabel(item:Int, label:String)
		bmx_wxradiobox_setitemlabel(wxObjectPtr, item, label)
	End Method
	
	Rem
	bbdoc: Sets a button by passing the desired string position.
	about: This does not cause a wxEVT_COMMAND_RADIOBOX_SELECTED event to get emitted.
	End Rem
	Method SetSelection(item:Int)
		bmx_wxradiobox_setselection(wxObjectPtr, item)
	End Method
	
	Rem
	bbdoc: Sets the selection to a button by passing the desired string.
	about: This does not cause a wxEVT_COMMAND_RADIOBOX_SELECTED event to get emitted.
	End Rem
	Method SetStringSelection(text:String)
		bmx_wxradiobox_setstringselection(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Sets the tooltip text for the specified item in the radio group.
	End Rem
	Method SetItemToolTip(item:Int, text:String)
		bmx_wxradiobox_setitemtooltip(wxObjectPtr, item, text)
	End Method
	
	Rem
	bbdoc: Shows or hides the entire radiobox.
	End Rem
	Method Show:Int(value:Int = True)
		Return bmx_wxradiobox_show(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Shows or hides individual buttons.
	End Rem
	Method ShowItem:Int(item:Int, value:Int = True)
		Return bmx_wxradiobox_showItem(wxObjectPtr, item, value)
	End Method
	
End Type

Type TRadioBoxEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_RADIOBOX_SELECTED Then
			Return wxCommandEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_RADIOBOX_SELECTED Then
			Return bmx_wxradiobox_geteventtype(eventType)
		End If
	End Method
		
End Type

New TRadioBoxEventFactory

