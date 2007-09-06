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

Module wx.wxTextCtrl

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
bbdoc: A text control allows text to be displayed and edited.
about: It may be single line or multi-line.
End Rem
Type wxTextCtrl Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a text control.
	about: The horizontal scrollbar (wxHSCROLL style flag) will only be created for multi-line
	text controls. Without a horizontal scrollbar, text lines that don't fit in the control's size will
	be wrapped (but no newline character is inserted). Single line controls don't have a horizontal
	scrollbar, the text is automatically scrolled so that the insertion point is always visible.
	End Rem
	Function CreateTextCtrl:wxTextCtrl(parent:wxWindow, id:Int, value:String = "", x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxTextCtrl.Create(parent, id, value, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxTextCtrl(parent:wxWindow, id:Int, value:String = "", x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxtextctrl_create(Self, parent.wxObjectPtr, id, value, x, y, w, h, style)
		Return Self
	End Method
	
	Rem
	bbdoc: Appends the text to the end of the text control.
	about: After the text is appended, the insertion point will be at the end of the text control.
	If this behaviour is not desired, the programmer should use GetInsertionPoint and SetInsertionPoint.
	End Rem
	Method AppendText(text:String)
		bmx_wxtextctrl_appendtext(wxObjectPtr, text)
	End Method
	
	Rem
	bbdoc: Returns True if the selection can be copied to the clipboard.
	End Rem
	Method CanCopy:Int()
		Return bmx_wxtextctrl_cancopy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the selection can be cut to the clipboard.
	End Rem
	Method CanCut:Int()
		Return bmx_wxtextctrl_cancut(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the contents of the clipboard can be pasted into the text control.
	about: On some platforms (Motif, GTK) this is an approximation and returns True if the control is editable,
	False otherwise.
	End Rem
	Method CanPaste:Int()
		Return bmx_wxtextctrl_canpaste(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if there is a redo facility available and the last operation can be redone.
	End Rem
	Method CanRedo:Int()
		Return bmx_wxtextctrl_canredo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns True if there is an undo facility available and the last operation can be undone.
	End Rem
	Method CanUndo:Int()
		Return bmx_wxtextctrl_canundo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Clears the text in the control.
	about: Note that this function will generate a wxEVT_COMMAND_TEXT_UPDATED event.
	End Rem
	Method Clear()
		bmx_wxtextctrl_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Copies the selected text to the clipboard under Motif and MS Windows.
	End Rem
	Method Copy()
		bmx_wxtextctrl_copy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Copies the selected text to the clipboard and removes the selection.
	End Rem
	Method Cut()
		bmx_wxtextctrl_cut(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resets the internal 'modified' flag as if the current edits had been saved.
	End Rem
	Method DiscardEdits()
		bmx_wxtextctrl_discardedits(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EmulateKeyPress:Int() ' FIXME
	End Method
	
	Rem
	bbdoc: Returns the style currently used for the new text.
	End Rem
	Method GetDefaultStyle:wxTextAttr()
		Return wxTextAttr._create(bmx_wxtextctrl_getdefaultstyle(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the insertion point.
	about: This is defined as the zero based index of the character position to the right of the insertion point.
	For example, if the insertion point is at the end of the text control, it is equal to both GetValue().Length()
	and GetLastPosition().
	End Rem
	Method GetInsertionPoint:Int()
		Return bmx_wxtextctrl_getinsertionpoint(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the zero based index of the last position in the text control, which is equal to the number of characters in the control.
	End Rem
	Method GetLastPosition:Int()
		Return bmx_wxtextctrl_getlastposition(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the length of the specified line, not including any trailing newline character(s).
	returns: The length of the line, or -1 if lineNo was invalid.
	about: 
	End Rem
	Method GetLineLength:Int(lineNo:Int)
		Return bmx_wxtextctrl_getlinelength(wxObjectPtr, lineNo)
	End Method
	
	Rem
	bbdoc: Returns the contents of a given line in the text control, not including any trailing newline character(s).
	returns: The contents of the line.
	End Rem
	Method GetLineText:String(lineNo:Int)
		Return bmx_wxtextctrl_getlinetext(wxObjectPtr, lineNo)
	End Method
	
	Rem
	bbdoc: Returns the number of lines in the text control buffer.
	about: Note that even empty text controls have one line (where the insertion point is), so
	GetNumberOfLines() never returns 0.
	<p>
	The number of physical lines in the control is returned.
	</p>
	<p>
	Also note that you may wish to avoid using functions that work with line numbers if you are
	working with controls that contain large amounts of text as this function has O(N) complexity
	for N being the number of lines.
	</p>
	End Rem
	Method GetNumberOfLines:Int()
		Return bmx_wxtextctrl_getnumberoflines(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the string containing the text starting in the positions from and up to to in the control.
	about: The positions must have been returned by another wxTextCtrl method.
	<p>
	Please note that the positions in a multiline wxTextCtrl do <b>not</b> correspond to the indices in the
	string returned by GetValue because of the different new line representations (CR or CR LF) and so this
	method should be used to obtain the correct results instead of extracting parts of the entire value.
	It may also be more efficient, especially if the control contains a lot of data.
	</p>
	End Rem
	Method GetRange:String(fromPos:Int, toPos:Int)
		Return bmx_wxtextctrl_getrange(wxObjectPtr, fromPos, toPos)
	End Method
	
	Rem
	bbdoc: Gets the current selection span.
	about: If the returned values are equal, there was no selection.
	<p>
	Please note that the indices returned may be used with the other wxTextctrl methods but don't
	necessarily represent the correct indices into the string returned by GetValue() for multiline
	controls under Windows (at least,) you should use GetStringSelection() to get the selected text.
	</p>
	End Rem
	Method GetSelection(fromPos:Int Var, toPos:Int Var)
		bmx_wxtextctrl_getselection(wxObjectPtr, Varptr fromPos, Varptr toPos)
	End Method
	
	Rem
	bbdoc: Gets the text currently selected in the control.
	about: If there is no selection, the returned string is empty.
	End Rem
	Method GetStringSelection:String()
		Return bmx_wxtextctrl_getstringselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the style at this position in the text control.
	about: Not all platforms support this function.
	End Rem
	Method GetStyle:wxTextAttr(position:Int)
		Return wxTextAttr._create(bmx_wxtextctrl_getstyle(wxObjectPtr, position))
	End Method
	
	Rem
	bbdoc: Gets the contents of the control.
	about: Notice that for a multiline text control, the lines will be separated by (Unix-style) \n
	characters, even under Windows where they are separated by a \r\n sequence in the native control.
	End Rem
	Method GetValue:String()
		Return bmx_wxtextctrl_getvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HitTest() ' fixme
	End Method
	
	Rem
	bbdoc: Returns true if the controls contents may be edited by user.
	about: Note that it always can be changed by the program. i.e. if the control hasn't been put in
	read-only mode by a previous call to SetEditable.
	End Rem
	Method IsEditable:Int()
		Return bmx_wxtextctrl_iseditable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the control is currently empty.
	about: This is the same as GetValue(). Empty() but can be much more efficient for the multiline
	controls containing big amounts of text.
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxtextctrl_isempty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the text has been modified by user.
	about: Note that calling SetValue doesn't make the control modified.
	End Rem
	Method IsModified:Int()
		Return bmx_wxtextctrl_ismodified(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this is a multi line edit control and false otherwise.
	End Rem
	Method IsMultiLine:Int()
		Return bmx_wxtextctrl_ismultiline(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this is a single line edit control and false otherwise.
	End Rem
	Method IsSingleLine:Int()
		Return bmx_wxtextctrl_issingleline(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadFile:Int() ' fixme
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MarkDirty()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Paste()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PositionToXY:Int(pos:Int, x:Int Var, y:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Redo()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Remove(fromPos:Int, toPos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Replace(fromPos:Int, toPos:Int, value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SaveFile:Int() ' fixme
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultStyle:Int(style:wxTextAttr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEditable(editable:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetInsertionPoint(pos:Int)
	End Method
	
	Rem
	bbdoc: Sets the insertion point at the end of the text control.
	about: This is equivalent to SetInsertionPoint(GetLastPosition()).
	End Rem
	Method SetInsertionPointEnd()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMaxLength(length:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetModified(modified:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelection(fromPos:Int, toPos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetStyle(fromPos:Int, toPos:Int, style:wxTextAttr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValue(value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ChangeValue(value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowPosition(pos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Undo()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WriteText(text:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method XYToPosition:Int(x:Int, y:Int)
	End Method
	
End Type


Rem
bbdoc: wxTextAttr represents the character and paragraph attributes, or style, for a range of text in a wxTextCtrl.
about: When setting up a wxTextAttr object, pass a bitlist mask to SetFlags to indicate which style
elements should be changed. As a convenience, when you call a setter such as SetFont, the relevant bit
will be set.
End Rem
Type wxTextAttr

	Field wxTextAttrPtr:Byte Ptr
	
	Function _create:wxTextAttr(wxTextAttrPtr:Byte Ptr)
		If wxTextAttrPtr Then
			Local this:wxTextAttr = New wxTextAttr
			
			this.wxTextAttrPtr = wxTextAttrPtr
			
			Return this
		End If
		
		Return Null
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetAlignment:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBackgroundColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFont:wxFont()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLeftIndent:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLeftSubIndent:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRightIndent:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTabs:Int[]()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTextColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasAlignment:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasBackgroundColour:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasFont:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasLeftIndent:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasRightIndent:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasTab:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasTextColour:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFlags:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsDefault:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Merge(overlay:wxTextAttr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAlignment(alignment:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBackgroundColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFlags(flags:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLeftIndent(indent:Int, subIndent:Int = 0)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRightIndent(indent:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTabs(tabs:Int[])
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTextColour(colour:wxColour)
	End Method
	
End Type



Type TTextCtrlEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TEXT_UPDATED, ..
					wxEVT_COMMAND_TEXT_ENTER, ..
					wxEVT_COMMAND_TEXT_URL, ..
					wxEVT_COMMAND_TEXT_MAXLEN
				Return wxCommandEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TEXT_UPDATED, ..
					wxEVT_COMMAND_TEXT_ENTER, ..
					wxEVT_COMMAND_TEXT_URL, ..
					wxEVT_COMMAND_TEXT_MAXLEN
				Return bmx_wxtextctrl_geteventtype(eventType)
		End Select
	End Method

End Type

New TTextCtrlEventFactory


