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
bbdoc: wxRichTextCtrl
End Rem
Module wx.wxRichTextCtrl

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
bbdoc: Provides a generic, ground-up implementation of a text control capable of showing multiple styles and images.
about: wxRichTextCtrl sends notification events: see wxRichTextEvent. It also sends the standard
wxTextCtrl events wxEVT_COMMAND_TEXT_ENTER and wxEVT_COMMAND_TEXT_UPDATED, and wxTextUrlEvent when
URL content is clicked.
End Rem
Type wxRichTextCtrl Extends wxTextCtrl


	Rem
	bbdoc: Adds an image to the control's buffer.
	end rem
	Method AddImage:wxRichTextRange(image:wxImage)
	End Method
	
	Rem
	bbdoc: Adds a new paragraph of text to the end of the buffer.
	end rem
	Method AddParagraph:wxRichTextRange(text:String)
	End Method
	
	Rem
	bbdoc: Sets the insertion point to the end of the buffer and writes the text.
	end rem
	Method AppendText(text:String)
	End Method
	
	Rem
	bbdoc: Applies the given alignment to the selection (undoable).
	For alignment values, see wxTextAttrEx.
	end rem
	Method ApplyAlignmentToSelection:Int(alignment:Int)
	End Method
	
	Rem
	bbdoc: Apples bold to the selection (undoable).
	end rem
	Method ApplyBoldToSelection:Int()
	End Method
	
	Rem
	bbdoc: Applies italic to the selection (undoable).
	end rem
	Method ApplyItalicToSelection:Int()
	End Method
	
	Rem
	bbdoc: Applies the given style to the selection.
	end rem
	Method ApplyStyle:Int(def:wxRichTextStyleDefinition)
	End Method
	
	Rem
	bbdoc: Applies the style sheet to the buffer, matching paragraph styles in the sheet against named styles in the buffer. This might be useful if the styles have changed. If sheet is NULL, the sheet set with SetStyleSheet is used.
	Currently this applies paragraph styles only.
	end rem
	Method ApplyStyleSheet:Int(sheet:wxRichTextStyleSheet = Null)
	End Method
	
	Rem
	bbdoc: Applies underline to the selection (undoable).
	end rem
	Method ApplyUnderlineToSelection:Int()
	End Method
	
	Rem
	bbdoc: Returns true if undo commands are being batched.
	end rem
	Method BatchingUndo:Int()
	End Method
	
	Rem
	bbdoc: Begins using alignment
	For alignment values, see wxTextAttrEx.
	end rem
	Method BeginAlignment:Int(alignment:Int)
	End Method
	
	Rem
	bbdoc: Starts batching undo history for commands.
	end rem
	Method BeginBatchUndo:Int(cmdName:String)
	End Method
	
	Rem
	bbdoc: Begins using bold.
	end rem
	Method BeginBold:Int()
	End Method
	
	Rem
	bbdoc: Begins using the named character style.
	end rem
	Method BeginCharacterStyle:Int(characterStyle:String)
	End Method
	
	Rem
	bbdoc: Begins using this font.
	end rem
	Method BeginFont:Int(font:wxFont)
	End Method
	
	Rem
	bbdoc: Begins using the given point size.
	end rem
	Method BeginFontSize:Int(pointSize:Int)
	End Method
	
	Rem
	bbdoc: Begins using italic.
	end rem
	Method BeginItalic:Int()
	End Method
	
	Rem
	bbdoc: Begins applying a left indent and subindent in tenths of a millimetre.
	The sub-indent is an offset from the left of the paragraph, and is used for all but the first line in a paragraph. A positive value will cause the first line to appear to the left of the subsequent lines, and a negative value will cause the first line to be indented relative to the subsequent lines.
	wxRichTextBuffer uses indentation to render a bulleted item. The left indent is the distance between the margin and the bullet. The content of the paragraph, including the first line, starts at leftMargin + leftSubIndent. So the distance between the left edge of the bullet and the left of the actual paragraph is leftSubIndent.
	end rem
	Method BeginLeftIndent:Int(leftIndent:Int, leftSubIndent:Int = 0)
	End Method
	
	Rem
	bbdoc: Begins appling line spacing. spacing is a multiple, where 10 means single-spacing, 15 means 1.5 spacing, and 20 means double spacing. The following constants are defined for convenience:
	#define wxTEXT_ATTR_LINE_SPACING_NORMAL         10 
	#define wxTEXT_ATTR_LINE_SPACING_HALF           15 
	#define wxTEXT_ATTR_LINE_SPACING_TWICE          20 
	end rem
	Method BeginLineSpacing:Int(lineSpacing:Int)
	End Method
	
	Rem
	bbdoc: Begins using a specified list style. Optionally, you can also pass a level and a number.
	end rem
	Method BeginListStyle:Int(listStyle:String, level:Int = 1, number:Int = 1)
	End Method
	
	Rem
	bbdoc: Begins a numbered bullet. This call will be needed for each item in the list, and the application should take care of incrementing the numbering.
	bulletNumber is a number, usually starting with 1.
	leftIndent and leftSubIndent are values in tenths of a millimetre.
	bulletStyle is a bitlist of the following values:
	
	#define wxTEXT_ATTR_BULLET_STYLE_NONE               0x00000000 
	#define wxTEXT_ATTR_BULLET_STYLE_ARABIC             0x00000001 
	#define wxTEXT_ATTR_BULLET_STYLE_LETTERS_UPPER      0x00000002 
	#define wxTEXT_ATTR_BULLET_STYLE_LETTERS_LOWER      0x00000004 
	#define wxTEXT_ATTR_BULLET_STYLE_ROMAN_UPPER        0x00000008 
	#define wxTEXT_ATTR_BULLET_STYLE_ROMAN_LOWER        0x00000010 
	#define wxTEXT_ATTR_BULLET_STYLE_SYMBOL             0x00000020 
	#define wxTEXT_ATTR_BULLET_STYLE_BITMAP             0x00000040 
	#define wxTEXT_ATTR_BULLET_STYLE_PARENTHESES        0x00000080 
	#define wxTEXT_ATTR_BULLET_STYLE_PERIOD             0x00000100 
	#define wxTEXT_ATTR_BULLET_STYLE_STANDARD           0x00000200 
	#define wxTEXT_ATTR_BULLET_STYLE_RIGHT_PARENTHESIS  0x00000400 
	#define wxTEXT_ATTR_BULLET_STYLE_OUTLINE            0x00000800 
	#define wxTEXT_ATTR_BULLET_STYLE_ALIGN_LEFT         0x00000000 
	#define wxTEXT_ATTR_BULLET_STYLE_ALIGN_RIGHT        0x00001000 
	#define wxTEXT_ATTR_BULLET_STYLE_ALIGN_CENTRE       0x00002000 
	wxRichTextBuffer uses indentation to render a bulleted item. The left indent is the distance between the margin and the bullet. The content of the paragraph, including the first line, starts at leftMargin + leftSubIndent. So the distance between the left edge of the bullet and the left of the actual paragraph is leftSubIndent.
	end rem
	Method BeginNumberedBullet:Int(bulletNumber:Int, leftIndent:Int, leftSubIndent:Int, bulletStyle:Int = wxTEXT_ATTR_BULLET_STYLE_ARABIC|wxTEXT_ATTR_BULLET_STYLE_PERIOD)
	End Method
	
	Rem
	bbdoc: Begins paragraph spacing; pass the before-paragraph and after-paragraph spacing in tenths of a millimetre.
	end rem
	Method BeginParagraphSpacing:Int(before:Int, after:Int)
	End Method
	
	Rem
	bbdoc: Begins applying the named paragraph style.
	end rem
	Method BeginParagraphStyle:Int(paragraphStyle:String)
	End Method
	
	Rem
	bbdoc: Begins a right indent, specified in tenths of a millimetre.
	end rem
	Method BeginRightIndent:Int(rightIndent:Int)
	End Method
	
	Rem
	bbdoc: Begins applying a style.
	end rem
	Method BeginStyle:Int(style:wxTextAttrEx)
	End Method
	
	Rem
	bbdoc: Starts suppressing undo history for commands.
	end rem
	Method BeginSuppressUndo:Int()
	End Method
	
	Rem
	bbdoc: Begins applying a symbol bullet, using a character from the current font. See BeginNumberedBullet for an explanation of how indentation is used to render the bulleted paragraph.
	end rem
	Method BeginSymbolBullet:Int(symbol:String, leftIndent:Int, leftSubIndent:Int, bulletStyle:Int = wxTEXT_ATTR_BULLET_STYLE_SYMBOL)
	End Method
	
	Rem
	bbdoc: Begins using this colour.
	end rem
	Method BeginTextColour:Int(colour:wxColour)
	End Method
	
	Rem
	bbdoc: Begins using underlining.
	end rem
	Method BeginUnderline:Int()
	End Method
	
	Rem
	bbdoc: Begins applying wxTEXT_ATTR_URL to the content. Pass a URL and optionally, a character style to apply, since it is common to mark a URL with a familiar style such as blue text with underlining.
	end rem
	Method BeginURL:Int(url:String, characterStyle:String = "")
	End Method
	
	Rem
	bbdoc: Returns true if selected content can be copied to the clipboard.
	end rem
	Method CanCopy:Int()
	End Method
	
	Rem
	bbdoc: Returns true if selected content can be copied to the clipboard and deleted.
	end rem
	Method CanCut:Int()
	End Method
	
	Rem
	bbdoc: Returns true if selected content can be deleted.
	end rem
	Method CanDeleteSelection:Int()
	End Method
	
	Rem
	bbdoc: Returns true if the clipboard content can be pasted to the buffer.
	end rem
	Method CanPaste:Int()
	End Method
	
	Rem
	bbdoc: Returns true if there is a command in the command history that can be redone.
	end rem
	Method CanRedo:Int()
	End Method
	
	Rem
	bbdoc: Returns true if there is a command in the command history that can be undone.
	end rem
	Method CanUndo:Int()
	End Method
	
	Rem
	bbdoc: Clears the buffer content, leaving a single empty paragraph. Cannot be undone.
	end rem
	Method Clear()
	End Method
	
	Rem
	bbdoc: Clears the list style from the given range, clearing list-related attributes and applying any named paragraph style associated with each paragraph.
	flags is a bit list of the following:
	
	wxRICHTEXT_SETSTYLE_WITH_UNDO: specifies that this command will be undoable. 
	See also wxRichTextCtrl::SetListStyle, wxRichTextCtrl::PromoteList, wxRichTextCtrl::NumberList.
	end rem
	Method ClearListStyle:Int(range:wxRichTextRange, flags:Int = wxRICHTEXT_SETSTYLE_WITH_UNDO)
	End Method
	
	Rem
	bbdoc: Copies the selected content (if any) to the clipboard.
	end rem
	Method Copy()
	End Method
	
	Rem
	bbdoc: Copies the selected content (if any) to the clipboard and deletes the selection. This is undoable.
	end rem
	Method Cut()
	End Method
	
	Rem
	bbdoc: Deletes the content within the given range.
	end rem
	Method DeleteRange:Int(range:wxRichTextRange)
	End Method
	
	Rem
	bbdoc: Deletes content if there is a selection, e.g. when pressing a key. Returns the new caret position in newPos, or leaves it if there was no action. This is undoable.
	end rem
	Method DeleteSelectedContent:Int(newPos:Int Var)
	End Method
	
	Rem
	bbdoc: Deletes the content in the selection, if any. This is undoable.
	end rem
	Method DeleteSelection()
	End Method
	
	Rem
	bbdoc: Sets the buffer's modified status to false, and clears the buffer's command history.
	end rem
	Method DiscardEdits()
	End Method
	
	Rem
	bbdoc: Ends alignment.
	end rem
	Method EndAlignment:Int()
	End Method
	
	Rem
	bbdoc: Ends application of all styles in the current style stack.
	end rem
	Method EndAllStyles:Int()
	End Method
	
	Rem
	bbdoc: Ends batching undo command history.
	end rem
	Method EndBatchUndo:Int()
	End Method
	
	Rem
	bbdoc: Ends using bold.
	end rem
	Method EndBold:Int()
	End Method

	Rem
	bbdoc: Ends application of a named character style.
	end rem
	Method EndCharacterStyle:Int()
	End Method
	
	Rem
	bbdoc: Ends using a font.
	end rem
	Method EndFont:Int()
	End Method
	
	
	Rem
	bbdoc: Ends using a point size.
	end rem
	Method EndFontSize:Int()
	End Method
	
	
	Rem
	bbdoc: Ends using italic.
	end rem
	Method EndItalic:Int()
	End Method
	
	
	Rem
	bbdoc: Ends left indent.
	end rem
	Method EndLeftIndent:Int()
	End Method
	
	
	Rem
	bbdoc: Ends line spacing.
	end rem
	Method EndLineSpacing:Int()
	End Method
	
	
	Rem
	bbdoc: Ends using a specified list style.
	end rem
	Method EndListStyle:Int()
	End Method
	
	
	Rem
	bbdoc: Ends application of a numbered bullet.
	end rem
	Method EndNumberedBullet:Int()
	End Method
	
	
	Rem
	bbdoc: Ends paragraph spacing.
	end rem
	Method EndParagraphSpacing:Int()
	End Method
	
	
	Rem
	bbdoc: Ends application of a named character style.
	end rem
	Method EndParagraphStyle:Int()
	End Method
	
	
	Rem
	bbdoc: Ends right indent.
	end rem
	Method EndRightIndent:Int()
	End Method
	
	
	Rem
	bbdoc: Ends the current style.
	end rem
	Method EndStyle:Int()
	End Method
	
	
	Rem
	bbdoc: Ends suppressing undo command history.
	end rem
	Method EndSuppressUndo:Int()
	End Method
	
	
	Rem
	bbdoc: Ends applying a symbol bullet.
	end rem
	Method EndSymbolBullet:Int()
	End Method
	
	
	Rem
	bbdoc: Ends applying a text colour.
	end rem
	Method EndTextColour:Int()
	End Method
	
	
	Rem
	bbdoc: End applying underlining.
	end rem
	Method EndUnderline:Int()
	End Method
	
	
	Rem
	bbdoc: Ends applying a URL.
	end rem
	Method EndURL:Int()
	End Method
	
	
	Rem
	bbdoc: Helper function for extending the selection, returning true if the selection was changed. Selections are in caret positions.
	end rem
	Method ExtendSelection:Int(oldPosition:Int, newPosition:Int, flags:Int)
	End Method
	
	
	Rem
	bbdoc: Helper function for finding the caret position for the next word. Direction is 1 (forward) or -1 (backwards).
	end rem
	Method FindNextWordPosition:Int(direction:Int = 1)
	End Method
	
	
	Rem
	bbdoc: Call this function to prevent refresh and allow fast updates, and then Thaw to refresh the control.
	end rem
	Method Freeze()
	End Method
	
	
	Rem
	bbdoc: Gets the basic (overall) style. This is the style of the whole buffer before further styles are applied, unlike the default style, which only affects the style currently being applied (for example, setting the default style to bold will cause subsequently inserted text to be bold).
	end rem
	Method GetBasicStyle:wxTextAttrEx()
	End Method
	
	
	Rem
	bbdoc: Returns the buffer associated with the control.
	end rem
	Method GetBuffer:wxRichTextBuffer()
	End Method
	
	Rem
	bbdoc: Returns the current caret position.
	end rem
	Method GetCaretPosition:Int()
	End Method
	
	Rem
	bbdoc: Returns the caret height and position for the given character position
	end rem
	Method GetCaretPositionForIndex:Int(position:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: Gets the command processor associated with the control's buffer.
	end rem
'	Method GetCommandProcessor:wxCommandProcessor()
'	End Method
	
	
	Rem
	bbdoc: Returns the current default style, which can be used to change how subsequently inserted text is displayed. When wxTextAttrEx is merged with wxTextAttr, this function will become GetDefaultStyle.
	end rem
	Method GetDefaultStyleEx:wxTextAttrEx()
	End Method
	
	
	Rem
	bbdoc: Gets the size of the buffer beyond which layout is delayed during resizing. This optimizes sizing for large buffers. The default is 20000.
	end rem
	Method GetDelayedLayoutThreshold:Int()
	End Method
	
	
	Rem
	bbdoc: Gets the current filename associated with the control.
	end rem
	Method GetFilename:String()
	End Method
	
	
	Rem
	bbdoc: Returns the first visible position in the current view.
	end rem
	Method GetFirstVisiblePosition:Int()
	End Method
	
	
	Rem
	bbdoc: Returns flags that change the behaviour of loading or saving. See the documentation for each handler class to see what flags are relevant for each handler.
	end rem
	Method GetHandlerFlags:Int()
	End Method
	
	
	Rem
	bbdoc: Returns the current insertion point.
	end rem
	Method GetInsertionPoint:Int()
	End Method
	
	
	Rem
	bbdoc: Returns the last position in the buffer.
	end rem
	Method GetLastPosition:Int()
	End Method
	
	
	Rem
	bbdoc: Returns the length of the specified line in characters.
	end rem
	Method GetLineLength:Int(lineNo:Int)
	End Method
	
	
	Rem
	bbdoc: Returns the text for the given line.
	end rem
	Method GetLineText:String(lineNo:Int)
	End Method
	
	
	Rem
	bbdoc: Transforms physical window position to logical (unscrolled) position.
	end rem
	Method GetLogicalPoint(ptPhysicalX:Int, ptPhysicalY:Int, logicalX:Int Var, logicalY:Int Var)
	End Method
	
	
	Rem
	bbdoc: Returns the number of lines in the buffer.
	end rem
	Method GetNumberOfLines:Int()
	End Method
	
	
	Rem
	bbdoc: Transforms logical (unscrolled) position to physical window position.
	end rem
	Method GetPhysicalPoint(ptLogicalX:Int, ptLogicalY:Int, physicalX:Int Var, physicalY:Int Var)
	End Method
	
	
	Rem
	bbdoc: Gets the text for the given range.
	The end point of range is specified as the last character position of the span of text, plus one.
	end rem
	Method GetRange:String(fromPos:Int, toPos:Int)
	End Method
	
	
	Rem
	bbdoc: Returns the range of the current selection.
	The end point of range is specified as the last character position of the span of text, plus one.
	If the return values from and to are the same, there is no selection.
	end rem
	Method GetSelection(fromPos:Int Var, toPos:Int Var)
	End Method
	
	
	Rem
	bbdoc: Returns the selection range in character positions. -1, -1 means no selection.
	end rem
	Method GetSelectionRange:wxRichTextRange()
	End Method
	
	
	Rem
	bbdoc: Returns the text within the current selection range, if any.
	end rem
	Method GetStringSelection:String()
	End Method
	
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the combined style - that is, the style you see on the screen as a result of combining base style, paragraph style and character style attributes. To get the character or paragraph style alone, use GetUncombinedStyle.
	end rem
	Method GetStyleRichTextAttr:wxRichTextAttr(position:Int)
	End Method
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the combined style - that is, the style you see on the screen as a result of combining base style, paragraph style and character style attributes. To get the character or paragraph style alone, use GetUncombinedStyle.
	end rem
	Method GetStyleTextAttrEx:wxTextAttrEx(position:Int)
	End Method
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the combined style - that is, the style you see on the screen as a result of combining base style, paragraph style and character style attributes. To get the character or paragraph style alone, use GetUncombinedStyle.
	end rem
	Method GetStyletextAttr:wxTextAttr(position:Int)
	End Method
	
	
	Rem
	bbdoc: Gets the attributes common to the specified range. Attributes that differ in value within the range will not be included in style's flags.
	end rem
	Method GetStyleForRangeRichTextAttr:wxRichTextAttr(range:wxRichTextRange)
	End Method
	
	Rem
	bbdoc: Gets the attributes common to the specified range. Attributes that differ in value within the range will not be included in style's flags.
	end rem
	Method GetStyleForRangeTextAttrEx:wxTextAttrEx(range:wxRichTextRange)
	End Method
	
	
	Rem
	bbdoc: Returns the style sheet associated with the control, if any. A style sheet allows named character and paragraph styles to be applied.
	end rem
	Method GetStyleSheet:wxRichTextStyleSheet()
	End Method
	
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the uncombined style - that is, the attributes associated with the paragraph or character content, and not necessarily the combined attributes you see on the screen. To get the combined attributes, use GetStyle.
	If you specify (any) paragraph attribute in style's flags, this function will fetch the paragraph attributes. Otherwise, it will return the character attributes.
	end rem
	Method GetUncombinedStyleRichTextAttr:wxRichTextAttr(position:Int)
	End Method
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the uncombined style - that is, the attributes associated with the paragraph or character content, and not necessarily the combined attributes you see on the screen. To get the combined attributes, use GetStyle.
	If you specify (any) paragraph attribute in style's flags, this function will fetch the paragraph attributes. Otherwise, it will return the character attributes.
	end rem
	Method GetUncombinedStyleTextAttrEx:wxTextAttrEx(position:Int)
	End Method
	
	Rem
	bbdoc: Gets the attributes at the given position. The wxRichTextAttr version is generally more efficient because it does not use wxFont objects.
	This function gets the uncombined style - that is, the attributes associated with the paragraph or character content, and not necessarily the combined attributes you see on the screen. To get the combined attributes, use GetStyle.
	If you specify (any) paragraph attribute in style's flags, this function will fetch the paragraph attributes. Otherwise, it will return the character attributes.
	end rem
	Method GetUncombinedStyleTextAttr:wxTextAttr(position:Int)
	End Method
	
	
	Rem
	bbdoc: Returns the content of the entire control as a string.
	end rem
	Method GetValue:String()
	End Method
	
	
	Rem
	bbdoc: Internal helper function returning the line for the visible caret position. If the caret is shown at the very end of the line, it means the next character is actually on the following line. So this function gets the line we're expecting to find if this is the case.
	end rem
	Method GetVisibleLineForCaretPosition:Int(caretPosition:Int)
	End Method
	
End Type
	
Rem
bbdoc: This type represents the whole buffer associated with a wxRichTextCtrl.
End Rem
Type wxRichTextBuffer

	Field wxObjectPtr:Byte Ptr

End Type


Type wxRichTextRange

	Field wxObjectPtr:Byte Ptr
	

End Type

Type wxRichTextStyleDefinition Extends wxObject


End Type

Type wxRichTextParagraphStyleDefinition Extends wxRichTextStyleDefinition

End Type


Type wxRichTextListStyleDefinition Extends wxRichTextParagraphStyleDefinition

End Type

Rem
bbdoc: A style sheet contains named paragraph and character styles that make it easy for a user to apply combinations of attributes to a wxRichTextCtrl.
about: You can use a wxRichTextStyleListBox in your user interface to show available styles to
the user, and allow application of styles to the control.
End Rem
Type wxRichTextStyleSheet Extends wxObject


End Type


Type wxRichTextPrinting Extends wxObject

End Type

Type wxRichTextPrintout Extends wxPrintout
End Type

Rem
bbdoc: This type incorporates a wxRichTextStyleListBox and a choice control that allows the user to select the category of style to view.
about: To use wxRichTextStyleListCtrl, add the control to your window hierarchy and call SetStyleType
with one of wxRichTextStyleListBox::wxRICHTEXT_STYLE_ALL, wxRichTextStyleListBox::wxRICHTEXT_STYLE_PARAGRAPH,
wxRichTextStyleListBox::wxRICHTEXT_STYLE_CHARACTER and wxRichTextStyleListBox::wxRICHTEXT_STYLE_LIST
to set the current view. Associate the control with a style sheet and rich text control with SetStyleSheet
and SetRichTextCtrl, so that when a style is double-clicked, it is applied to the selection.
End Rem
Type wxRichTextStyleListCtrl Extends wxControl

End Type


Type wxRichTextStyleComboCtrl Extends wxComboCtrl

End Type

Rem
bbdoc: This type represents header and footer data to be passed to the wxRichTextPrinting and wxRichTextPrintout types.
about: Headers and footers can be specified independently for odd, even or both page sides. Different
text can be specified for left, centre and right locations on the page, and the font and text colour
can also be specified. You can specify the following keywords in header and footer text, which will
be substituted for the actual values during printing and preview.
<pre>
@DATE@: the current date. 
@PAGESCNT@: the total number of pages. 
@PAGENUM@: the current page number. 
@TIME@: the current time. 
@TITLE@: the title of the document, as passed to the wxRichTextPrinting or wxRichTextLayout constructor. 
</pre>
End Rem
Type wxRichTextHeaderFooterData Extends wxObject

End Type

Type wxTextAttrEx
End Type

Type wxRichTextAttr
End Type
