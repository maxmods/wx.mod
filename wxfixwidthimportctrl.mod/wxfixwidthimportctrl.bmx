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

Rem
bbdoc: wxFixWidthImportCtrl
End Rem
Module wx.wxFixWidthImportCtrl

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: A control for defining columns-widths in a file or block of text.
about: The control displays the text and the user can set delimiters (marks).
The widths these marks represent will be used to break each line into pieces.
End Rem
Type wxFixWidthImportCtrl Extends wxControl

	Rem
	bbdoc: Creates a new wxFixWidthImportCtrl object.
	End Rem
	Function CreateFixWidthImportCtrl:wxFixWidthImportCtrl(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxFixWidthImportCtrl.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxFixWidthImportCtrl object.
	End Rem
	Method Create:wxFixWidthImportCtrl(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxfixwidthimportctrl_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the number of 'delimiters'.
	End Rem
	Method GetValCount:Int()
		Return bmx_wxfixwidthimportctrl_getvalcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the 'delimiters' positions.
	End Rem
	Method GetValues:Int[]()
		Return bmx_wxfixwidthimportctrl_getvalues(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the 'delimiters' positions.
	End Rem
	Method SetValues(values:Int[])
		bmx_wxfixwidthimportctrl_setvalues(wxObjectPtr, values)
	End Method
	
	Rem
	bbdoc: Returns the number of lines of file/text.
	End Rem
	Method GetLinesCount:Int()
		Return bmx_wxfixwidthimportctrl_getlinescount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of the line currently selected.
	End Rem
	Method GetSelectedLineNo:Int()
		Return bmx_wxfixwidthimportctrl_getselectedlineno(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns currently selected line.
	End Rem
	Method GetSelectedLine:String()
		Return bmx_wxfixwidthimportctrl_getselectedline(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Selects (changes colour) @line.
	End Rem
	Method SelectLine(line:Int)
		bmx_wxfixwidthimportctrl_selectline(wxObjectPtr, line)
	End Method
	
	Rem
	bbdoc: Returns @line of file/text.
	End Rem
	Method GetLine:String(line:Int)
		Return bmx_wxfixwidthimportctrl_getline(wxObjectPtr, line)
	End Method
	
	Rem
	bbdoc: Returns the colour used to draw 'delimiters'.
	End Rem
	Method GetDelimColor:wxColour()
		Return wxColour._create(bmx_wxfixwidthimportctrl_getdelimcolor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the colour used to draw the selected line.
	End Rem
	Method GetSelectColor:wxColour()
		Return wxColour._create(bmx_wxfixwidthimportctrl_getselectcolor(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the colour used to draw 'delimiters'.
	End Rem
	Method SetDelimColor(colour:wxColour)
		bmx_wxfixwidthimportctrl_setdelimcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the colour used to draw the selected line.
	End Rem
	Method SetSelectColor(colour:wxColour)
		bmx_wxfixwidthimportctrl_setselectcolor(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Open 'filename', reads it and fills the control.
	retuns: False if something went wrong (opening, converting to Unicode, etc.)
	End Rem
	Method LoadFile:Int(filename:String)
		Return bmx_wxfixwidthimportctrl_loadfile(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Fills the control with a text. End of line (EOL) can be any of Mac, Unix, Win.
	End Rem
	Method LoadText(text:String)
		bmx_wxfixwidthimportctrl_loadtext(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: TABs in each line may be replaced with at most 'tabSize' spaces, so the line becomes 'tabulated' in columns.
	about: The default value (-1) means no tab->spaces conversion. A value of 0 means 'erase all TABs'
	The conversion is done at LoadFile/LoadText. You can also call ConvertTabsToSpaces() later on.
	End Rem
	Method SetTabSize(tabSize:Int)
		bmx_wxfixwidthimportctrl_settabsize(wxObjectPtr, tabSize)
	End Method
	
	Rem
	bbdoc: Returns the number of spaces to be used for each TAB.
	End Rem
	Method GetTabSize:Int()
		Return bmx_wxfixwidthimportctrl_gettabsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: You can use this function after LoadFile/LoadText.
	about: Because once TABs are converted there are no more TABS, using this method again is a waste of time.
	End Rem
	Method ConvertTabsToSpaces()
		bmx_wxfixwidthimportctrl_converttabstospaces(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: If you just want to see the text and select a line, but you don't want the 'delimiters' to be drawn.
	End Rem
	Method EnableDelim(enable:Int = True)
		bmx_wxfixwidthimportctrl_enabledelim(wxObjectPtr, enable)
	End Method

End Type

Type TFixWidthImportCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_FIXW_UPDATED Then
			Return wxCommandEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_FIXW_UPDATED Then
			Return bmx_wxfixwidthimportctrl_geteventtype(eventType)
		End If
	End Method
		
End Type

New TFixWidthImportCtrlEventFactory

