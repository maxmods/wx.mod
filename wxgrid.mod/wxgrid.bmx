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

Module wx.wxGrid

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
	about: Call either wxGrid::CreateGrid or wxGrid::SetTable directly after this to initialize the grid before using it.
	End Rem
	Function CreateGrid:wxGrid(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxWANTS_CHARS)
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
	BeginBatch must be matched by a later call to wxGrid::EndBatch. Code that does a lot of grid
	modification can be enclosed between BeginBatch and EndBatch calls to avoid screen flicker.
	The final EndBatch will cause the grid to be repainted.
	End Rem
	Method BeginBatch()
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
wxGrid::SetDefaultRenderer() to change the view of all cells. This is an abstract type, and you will
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

