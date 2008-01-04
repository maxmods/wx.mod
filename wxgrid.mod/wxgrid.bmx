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
bbdoc: wxGrid
End Rem
Module wx.wxGrid

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
bbdoc: wxGrid and its related classes are used for displaying and editing tabular data.
about: They provide a rich set of features for display, editing, and interacting with a variety
of data sources. For simple applications, and to help you get started, wxGrid is the only class
you need to refer to directly. It will set up default instances of the other classes and manage
them for you. For more complex applications you can derive your own classes for custom grid views,
grid data tables, cell editors and renderers. The wxGrid classes overview has examples of simple and
more complex applications, explains the relationship between the various grid classes and has a summary
of the keyboard shortcuts and mouse functions provided by wxGrid.
End Rem
Type wxGrid Extends wxScrolledWindow

	Rem
	bbdoc: Constructor to create a grid object.
	about: Call either ()
	End Method
	
	Method CreateGrid or ()
	End Method
	
	Method SetTable directly after this to initialize the grid before using it.
	End Rem
	Function CreatewxGrid:wxGrid(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxWANTS_CHARS)
		Local this:wxGrid = New wxGrid
		
'		this.wxObjectPtr = bmx_wxgrid_create(this, parent.wxObjectPtr, id, x, y, w, h, style)
		
		Return this
	End Function

	Method AppendCols:Int(numCols:Int = 1, updateLabels:Int = True)
		
	End Method
	
	Method AppendRows:Int(numRows:Int = 1, updateLabels:Int = True)
	End Method
	
	Method AutoSize()
	End Method
	
	Method AutoSizeColumn(col:Int, setAsMin:Int = True)
	End Method
	
	Method AutoSizeColumns(setAsMin:Int = True)
	End Method
	
	Method AutoSizeRow(row:Int, setAsMin:Int = True)
	End Method
	
	Method AutoSizeRows(setAsMin:Int = True)
	End Method
	
	Rem
	bbdoc: Increments the grid's batch count.
	about: When the count is greater than zero repainting of the grid is suppressed. Each call to
	BeginBatch must be matched by a later call to ()
	End Method
	
	Method EndBatch. Code that does a lot of grid
	modification can be enclosed between BeginBatch and EndBatch calls to avoid screen flicker.
	The final EndBatch will cause the grid to be repainted.
	End Rem
	Method BeginBatch()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method BlockToDeviceRect(row1:Int, col1:Int, row2:Int, col2:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragColMove:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragColSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragRowSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragGridSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanEnableCellControl:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanHaveAttributes:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CellToRect(row:Int, col:Int, x:Int Var, y:Int Var, w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearGrid()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearSelection()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateGrid:Int(numRows:Int, numCols:Int, selMode:Int = wxGridSelectCells)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeleteCols:Int(pos:Int = 0, numCols:Int = 1, updateLabels:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeleteRows:Int(pos:Int = 0, numRows:Int = 1, updateLabels:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableCellEditControl()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragColMove()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragColSize()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragGridSize()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragRowSize()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableCellEditControl(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragColSize(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragColMove(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragGridSize(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragRowSize(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableEditing(edit:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableGridLines(enable:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndBatch()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Fit()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ForceRefresh()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBatchCount:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellAlignment(row:Int, col:Int, horiz:Int Var, vert:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellBackgroundColour:wxColour(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellEditor:wxGridCellEditor(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellFont:wxFont(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellRenderer:wxGridCellRenderer(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellTextColour:wxColour(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellValue:String(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColAt:Int(colPos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLeft:Int(colPos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelAlignment(horiz:Int Var, vert:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelValue:String(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColMinimalAcceptableWidth:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColMinimalWidth:Int(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColPos:Int(colId:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColRight:Int(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColSize:Int(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultCellAlignment(horiz:Int Var, vert:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultCellBackgroundColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultCellFont:wxFont()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultCellTextColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColLabelSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultEditor:wxGridCellEditor()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultEditorForCell:wxGridCellEditor(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultEditorForType:wxGridCellEditor(typeName:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRenderer:wxGridCellRenderer()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRendererForCell:wxGridCellRenderer()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRendererForType:wxGridCellRenderer(typeName:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowLabelSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowSize:Int()
	End Method
		
	Rem
	bbdoc: 
	End Rem
	Method GetGridCursorCol:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridCursorRow:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridLineColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultGridLinePen:wxPen()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowGridLinePen:wxPen(row:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColGridLinePen:wxPen(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GridLinesEnabled:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabelBackgroundColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabelFont:wxFont()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabelTextColour:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberCols:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberRows:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOrCreateCellAttr:wxGridCellAttr(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowMinimalAcceptableHeight:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowMinimalHeight:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelAlignment(horiz:Int Var, vert:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelSize:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelValue:String(row:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowSize:Int(row:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScrollLineX:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScrollLineY:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionMode:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectedCells() ' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectedCols:Int[]()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectedRows:Int[]()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionBackground:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionBlockTopLeft() ' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionBlockBottomRight() ' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionForeground:wxColour()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTable:wxGridTableBase()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetViewWidth:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HideCellEditControl()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InitColWidths()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InitRowHeights()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertCols:Int(pos:Int = 0, numCols:Int = 1, updateLabels:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertRows:Int(pos:Int = 0, numRows:Int = 1, updateLabels:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCellEditControlEnabled:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCurrentCellReadOnly:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsEditable:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsInSelection:Int(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsReadOnly:Int(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsSelection:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsVisible:Int(row:Int, col:Int, wholeCellVisible:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeCellVisible(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorDown:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorLeft:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorRight:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorUp:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorDownBlock:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorLeftBlock:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorRightBlock:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MoveCursorUpBlock:Int(expandSelection:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MovePageDown:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MovePageUp:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RegisterDataType(typeName:String, renderer:wxGridCellRenderer, editor:wxGridCellEditor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SaveEditControlValue()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectAll()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectBlock(topRow:Int, leftCol:Int, bottomRow:Int, rightCol:Int, addToSelected:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectCol(col:Int, addToSelected:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectionToDeviceRect(x:Int Var, y:Int Var, w:Int Var, h:Int Var)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectRow(row:Int, addToSelected:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellAlignment(align:Int, row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellBackgroundColour(row:Int, col:Int, colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellEditor(row:Int, col:Int, editor:wxGridCellEditor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellFont(row:Int, col:Int, font:wxFont)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellRenderer(row:Int, col:Int, renderer:wxGridCellRenderer)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellTextColour(row:Int, col:Int, colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellValue(row:Int, col:Int, value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColAttr(col:Int, attr:wxGridCellAttr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatBool(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatNumber(col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatFloat(col:Int, width:Int = -1, precision:Int = -1)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatCustom(col:Int, typeName:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColLabelAlignment(horiz:Int, vert:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColLabelSize(height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColLabelValue(col:Int, value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColMinimalWidth(col:Int, width:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColMinimalAcceptableWidth(width:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColPos(colId:Int, newPos:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColSize(col:Int, width:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultCellAlignment(horiz:Int, vert:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultCellBackgroundColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultCellFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultCellTextColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultEditor(editor:wxGridCellEditor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultRenderer(renderer:wxGridCellRenderer)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultColSize(width:Int, resizeExistingCols:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultRowSize(height:Int, resizeExistingRows:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridCursor(row:Int, col:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridLineColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabelBackgroundColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabelFont(font:wxFont)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabelTextColour(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMargins(extraWidth:Int, extraHeight:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOrCalcColumnSizes:Int(calcOnly:Int, setAsMin:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOrCalcRowSizes:Int(calcOnly:Int, setAsMin:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetReadOnly(row:Int, col:Int, isReadOnly:Int = True)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowAttr(row:Int, attr:wxGridCellAttr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelAlignment(horiz:Int, vert:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelSize(width:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelValue(row:Int, value:String)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowMinimalHeight(row:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowMinimalAcceptableHeight(height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowSize(row:Int, height:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetScrollLineX(x:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetScrollLineY(y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionBackground(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionForeground(colour:wxColour)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionMode(selMode:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTable(table:wxGridTableBase, takeOwnership:Int = False, selMode:Int = wxGridSelectCells)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowCellEditControl()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method XToCol:Int(x:Int, clipToMinMax:Int = False)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method XToEdgeOfCol:Int(x:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method YToEdgeOfRow:Int(y:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method YToRow:Int(y:Int)
	End Method
	
End Type




Type wxGridTableBase



End Type


Type wxGridCellAttr
	
	Field wxGridCellAttrPtr:Byte Ptr
	
	
	
	Method IncRef()
	End Method
	
	Method DecRef()
	End Method
	
	Method SetTextColour(color:wxColour)
	End Method
	
	Method SetBackgroundColour(color:wxColour)
	End Method
	
	Method SetFont(font:wxFont)
	End Method
	
	Method SetAlignment(hAlign:Int, vAlign:Int)
	End Method
	
	Method SetReadOnly(isReadOnly:Int = True)
	End Method
	
End Type

Rem
bbdoc: This type is responsible for actually drawing the cell in the grid.
about: You may pass it to the wxGridCellAttr to change the format of one given cell or to
()
	End Method
	
	Method SetDefaultRenderer() to change the view of all cells. This is an abstract type, and you will
normally use one of the predefined derived types or derive your own type from it.
End Rem
Type wxGridCellRenderer Abstract

	Field wxGridCellRendererPtr:Byte Ptr

End Type

Rem
bbdoc: This type may be used to format string data in a cell.
about: It is the default for string cells.
End Rem
Type wxGridCellStringRenderer Extends wxGridCellRenderer

End Type

Rem
bbdoc: This type may be used to format integer data in a cell.
End Rem
Type wxGridCellNumberRenderer Extends wxGridCellStringRenderer

End Type

Rem
bbdoc: This type may be used to format floating point data in a cell.
End Rem
Type wxGridCellFloatRenderer Extends wxGridCellStringRenderer

	Rem
	bbdoc: Creates a new wxGridCellFloatRenderer object.
	about: width
Minimum number of characters to be shown.
precision
Number of digits after the decimal dot.
	End Rem
	Function CreateGridCellFloatRenderer:wxGridCellFloatRenderer(width:Int = -1, precision:Int = -1)
		Local this:wxGridCellFloatRenderer = New wxGridCellFloatRenderer
		
		'this.wxGridCellRenderer = bmx_wxgridcellfloatrenderer.create(width, precision)
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns the width.
	End Rem
	Method GetWidth:Int()
	End Method
	
	Rem
	bbdoc: Parameters string format is "width[,precision]".
	End Rem
	Method SetParameters(params:String)
	End Method
	
	Rem
	bbdoc: Sets the precision
	End Rem
	Method SetPrecision(precision:Int)
	End Method
	
	Rem
	bbdoc: Sets the width.
	End Rem
	Method SetWidth(width:Int)
	End Method

End Type

Rem
bbdoc: This type may be used to format boolean data in a cell. for string cells.
End Rem
Type wxGridCellBoolRenderer Extends wxGridCellRenderer

	Function CreateGridCellBoolRenderer:wxGridCellBoolRenderer()
		Local this:wxGridCellBoolRenderer = New wxGridCellBoolRenderer
		
		'this.wxGridCellRenderer = bmx_wxgridcellboolrenderer.create()
		
		Return this
	End Function

End Type


Rem
bbdoc: This type is responsible for providing and manipulating the in-place edit controls for the grid.
about: Instances of wxGridCellEditor (actually, instances of derived classes since it is an abstract type)
can be associated with the cell attributes for individual cells, rows, columns, or even for the entire grid.
End Rem
Type wxGridCellEditor
	
	Field wxGridCellEditorPtr:Byte Ptr

End Type


Type wxGridCellTextEditor Extends wxGridCellEditor
End Type


Type wxGridCellFloatEditor Extends wxGridCellTextEditor
End Type

Type wxGridCellNumberEditor Extends wxGridCellTextEditor
End Type

Type wxGridCellBoolEditor Extends wxGridCellEditor
End Type

Type wxGridCellChoiceEditor Extends wxGridCellEditor
End Type




Type wxGridEvent Extends wxNotifyEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxGridEvent = New wxGridEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type


Type wxGridSizeEvent Extends wxNotifyEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxGridSizeEvent = New wxGridSizeEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type

Type wxGridRangeSelectEvent Extends wxNotifyEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxGridRangeSelectEvent = New wxGridRangeSelectEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type

Type wxGridEditorCreatedEvent Extends wxCommandEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxGridEditorCreatedEvent = New wxGridEditorCreatedEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type



Type TGridEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_GRID_CELL_LEFT_CLICK, ..
					wxEVT_GRID_CELL_RIGHT_CLICK, ..
					wxEVT_GRID_CELL_LEFT_DCLICK, ..
					wxEVT_GRID_CELL_RIGHT_DCLICK, ..
					wxEVT_GRID_LABEL_LEFT_CLICK, ..
					wxEVT_GRID_LABEL_RIGHT_CLICK, ..
					wxEVT_GRID_LABEL_LEFT_DCLICK, ..
					wxEVT_GRID_LABEL_RIGHT_DCLICK, ..
					wxEVT_GRID_SELECT_CELL, ..
					wxEVT_GRID_CELL_CHANGE, ..
					wxEVT_GRID_EDITOR_HIDDEN, ..
					wxEVT_GRID_EDITOR_SHOWN
				Return wxGridEvent.create(wxEventPtr, evt)
			Case wxEVT_GRID_COL_SIZE, wxEVT_GRID_ROW_SIZE
				Return wxGridSizeEvent.create(wxEventPtr, evt)
			Case wxEVT_GRID_RANGE_SELECT
				Return wxGridRangeSelectEvent.create(wxEventPtr, evt)
			Case wxEVT_GRID_EDITOR_CREATED
				Return wxGridEditorCreatedEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_GRID_CELL_LEFT_CLICK, ..
					wxEVT_GRID_CELL_RIGHT_CLICK, ..
					wxEVT_GRID_CELL_LEFT_DCLICK, ..
					wxEVT_GRID_CELL_RIGHT_DCLICK, ..
					wxEVT_GRID_LABEL_LEFT_CLICK, ..
					wxEVT_GRID_LABEL_RIGHT_CLICK, ..
					wxEVT_GRID_LABEL_LEFT_DCLICK, ..
					wxEVT_GRID_LABEL_RIGHT_DCLICK, ..
					wxEVT_GRID_SELECT_CELL, ..
					wxEVT_GRID_CELL_CHANGE, ..
					wxEVT_GRID_EDITOR_HIDDEN, ..
					wxEVT_GRID_EDITOR_SHOWN, ..
					wxEVT_GRID_COL_SIZE, wxEVT_GRID_ROW_SIZE, ..
					wxEVT_GRID_RANGE_SELECT, ..
					wxEVT_GRID_EDITOR_CREATED
				Return bmx_wxgrid_geteventtype(eventType)
		End Select
	End Method

End Type

New TGridEventFactory

