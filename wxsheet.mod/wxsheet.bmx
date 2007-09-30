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
bbdoc: wxSheet
End Rem
Module wx.wxSheet

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
Type wxSheet Extends wxWindow

	Function CreateSheet:wxSheet(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxWANTS_CHARS)
		Return New wxSheet.Create(parent, id, x, y, w, h, style)
	End Function

	Method Create:wxSheet(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxWANTS_CHARS)
		wxObjectPtr = bmx_wxsheet_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		Return Self
	End Method

	Method GetTable:wxSheetTable()
	
	End Method
	
	Method SetTable(table:wxSheetTable, takeOwnership:Int)
	End Method
	
	Method CreateGrid:Int(numRows:Int, numCols:Int, options:Int = 0)
		Return bmx_wxsheet_creategrid(wxObjectPtr, numRows, numCols, options)
	End Method
	
	Method GetNumberRows:Int()
		Return bmx_wxsheet_getnumberrows(wxObjectPtr)
	End Method
	
	Method GetNumberCols:Int()
		Return bmx_wxsheet_getnumbercols(wxObjectPtr)
	End Method

	Method ContainsCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containscell(wxObjectPtr, row, col)
	End Method
	
	Method ContainsGridRow:Int(row:Int)
		Return bmx_wxsheet_containsgridrow(wxObjectPtr, row)
	End Method
	
	Method ContainsGridCol:Int(col:Int)
		Return bmx_wxsheet_containsgridcol(wxObjectPtr, col)
	End Method
	
	Method ContainsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containsgridcell(wxObjectPtr, row, col)
	End Method
	
	Method ContainsRowLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containsrowlabelcell(wxObjectPtr, row, col)
	End Method
	
	Method ContainsColLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containscollabelcell(wxObjectPtr, row, col)
	End Method
	
	Method IsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_isgridcell(wxObjectPtr, row, col)
	End Method

	Method IsLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_islabelcell(wxObjectPtr, row, col)
	End Method

	Method IsRowLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_isrowlabelcell(wxObjectPtr, row, col)
	End Method

	Method IsColLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscollabelcell(wxObjectPtr, row, col)
	End Method

	Method IsCornerLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscornerlabelcell(wxObjectPtr, row, col)
	End Method

	Method ClearValues(update:Int = wxSHEET_UpdateValues)
		bmx_wxsheet_clearvalues(wxObjectPtr, update)
	End Method
	
	Method InsertRows:Int(row:Int, numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_insertrows(wxObjectPtr, row, numRows, update)
	End Method

	Method AppendRows:Int(numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_appendrows(wxObjectPtr, numRows, update)
	End Method

	Method DeleteRows:Int(row:Int, numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_deleterows(wxObjectPtr, row, numRows, update)
	End Method

	Method InsertCols:Int(col:Int, numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_insertcols(wxObjectPtr, col, numCols, update)
	End Method

	Method AppendCols:Int(numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_appendcols(wxObjectPtr, numCols, update)
	End Method

	Method DeleteCols:Int(col:Int, numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_deletecols(wxObjectPtr, col, numCols, update)
	End Method

	Method SetNumberRows:Int(rows:Int, update:Int = wxSHEET_UpdateAll)
	End Method

	Method SetNumberCols:Int(cols:Int, update:Int = wxSHEET_UpdateAll)
	End Method

	Method SetNumberCells:Int(rows:Int, cols:Int, update:Int = wxSHEET_UpdateAll)
	End Method

	Method GetDefaultRowHeight:Int()
	End Method
	
	Method GetDefaultColWidth:Int()
	End Method
	
	Method SetDefaultRowHeight( height:Int, resizeExistingRows:Int = False )
	End Method
	
	Method SetDefaultColWidth( width:Int, resizeExistingCols:Int = False )
	End Method
	
	Method GetMinimalAcceptableRowHeight:Int()
	End Method
	
	Method GetMinimalAcceptableColWidth:Int()
	End Method
	
	Method SetMinimalAcceptableRowHeight(height:Int)
	End Method
	
	Method SetMinimalAcceptableColWidth(width:Int)
	End Method
	
	Method GetMinimalRowHeight:Int(row:Int)
	End Method
	
	Method GetMinimalColWidth:Int(col:Int)
	End Method
	
	Method SetMinimalRowHeight(row:Int, height:Int)
	End Method
	
	Method SetMinimalColWidth(col:Int, width:Int)
	End Method
	
	Method SetRowHeight(row:Int, height:Int, ignoreMinSize:Int = False )
		bmx_wxsheet_setrowheight(wxObjectPtr, row, height, ignoreMinSize)
	End Method
	
	Method SetColWidth(col:Int, width:Int, ignoreMinSize:Int = False )
		bmx_wxsheet_setcolwidth(wxObjectPtr, col, width, ignoreMinSize)
	End Method
	
	Method GetRowHeight:Int(row:Int)
		Return bmx_wxsheet_getrowheight(wxObjectPtr, row)
	End Method
	
	Method GetRowTop:Int(row:Int)
		Return bmx_wxsheet_getrowtop(wxObjectPtr, row)
	End Method
	
	Method GetRowBottom:Int(row:Int)
		Return bmx_wxsheet_getrowbottom(wxObjectPtr, row)
	End Method
	
	Method GetColWidth:Int(col:Int)
		Return bmx_wxsheet_getcolwidth(wxObjectPtr, col)
	End Method
	
	Method GetColLeft:Int(col:Int)
		Return bmx_wxsheet_getcolleft(wxObjectPtr, col)
	End Method
	
	Method GetColRight:Int(col:Int)
		Return bmx_wxsheet_getcolright(wxObjectPtr, col)
	End Method
	
	Method GetCellSize(row:Int, col:Int, w:Int Var, h:Int Var)
	End Method
	
	Method IsCellShown:Int(row:Int, col:Int)
	End Method

	Method SetMargins(width:Int, height:Int)
	End Method
	
	Method GetCellBestSize(row:Int, col:Int, w:Int Var, h:Int Var, dc:wxDC = Null)
	End Method
	
	Method GetRowBestHeight:Int(row:Int)
	End Method
	
	Method GetColBestWidth:Int(col:Int)
	End Method
	
	Method GetRowLabelWidth:Int(zeroNotShown:Int = True)
	End Method
	
	Method GetColLabelHeight:Int(zeroNotShown:Int = True)
	End Method
	
	Method SetRowLabelWidth( width:Int )
	End Method
	
	Method SetColLabelHeight( height:Int )
	End Method
	
	Method AutoSizeRow:Int( row:Int, setAsMin:Int = True )
	End Method
	
	Method AutoSizeCol:Int( col:Int, setAsMin:Int = True )
	End Method
	
	
	Method AutoSizeRows( setAsMin:Int = True )
	End Method
	
	Method AutoSizeCols( setAsMin:Int = True )
	End Method
	
	
	Method AutoSize( setAsMin:Int = True )
	End Method
	
	Method AutoSizeRowLabelHeight( row:Int )
	End Method
	
	Method AutoSizeColLabelWidth( col:Int )
	End Method
	
	Method SetEqualColWidths(minWidth:Int)
	End Method
	
	Method GetCellValue:String( row:Int, col:Int )
		Return bmx_wxsheet_getcellvalue(wxObjectPtr, row, col)
	End Method
	
	Method SetCellValue( row:Int, col:Int, value:String )
		bmx_wxsheet_setcellvalue(wxObjectPtr, row, col, value)
	End Method
	
	Method HasCellValue:Int( row:Int, col:Int )
		Return bmx_wxsheet_hascellvalue(wxObjectPtr, row, col)
	End Method
	
	Method GetRowLabelValue:String( row:Int )
	End Method
	
	Method GetColLabelValue:String( col:Int )
	End Method
	
	Method SetRowLabelValue( row:Int, value:String )
	End Method
	
	Method SetColLabelValue( col:Int, value:String )
	End Method
	
	Method GetCornerLabelValue:String()
	End Method
	
	Method SetCornerLabelValue(value:String)
	End Method

	Method SetAttrRenderer(row:Int, col:Int, renderer:wxSheetCellRenderer, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrrenderer(wxObjectPtr, row, col, renderer.wxObjectPtr, attrType)
	End Method
	
	Method SetAttrEditor(row:Int, col:Int, editor:wxSheetCellEditor, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattreditor(wxObjectPtr, row, col, editor.wxObjectPtr, attrType)
	End Method
	
	Method SetAttrReadOnly(row:Int, col:Int, isReadOnly:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrreadonly(wxObjectPtr, row, col, isReadOnly, attrType)
	End Method

	Method SetAttrOrientation(row:Int, col:Int, orientation:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrorientation(wxObjectPtr, row, col, orientation, attrType)
	End Method

End Type


Rem
bbdoc: 
End Rem
Type wxSheetCellRenderer Extends wxObject

	Method Create:wxSheetCellRenderer(renderer:wxSheetCellRendererRefData)
		wxObjectPtr = bmx_wxsheetcellrenderer_create(renderer.wxObjectPtr)
		Return Self
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxsheetcellrenderer_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellRendererRefData Extends wxObject
End Type


Rem
bbdoc: 
End Rem
Type wxSheetCellStringRendererRefData Extends wxSheetCellRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type  wxSheetCellAutoWrapStringRendererRefData Extends wxSheetCellStringRendererRefData

	Method Create:wxSheetCellAutoWrapStringRendererRefData()
		wxObjectPtr = bmx_wxsheetcellautowrapstringrendererrefdata_create()
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellNumberRendererRefData Extends wxSheetCellStringRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellFloatRendererRefData Extends wxSheetCellStringRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellBitmapRendererRefData Extends wxSheetCellStringRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellBoolRendererRefData Extends wxSheetCellRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellDateTimeRendererRefData Extends wxSheetCellStringRendererRefData
End Type


Rem
bbdoc: 
End Rem
Type wxSheetCellEditor Extends wxObject

	Method Create:wxSheetCellEditor(editor:wxSheetCellEditorRefData)
		wxObjectPtr = bmx_wxsheetcelleditor_create(editor.wxObjectPtr)
		Return Self
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxsheetcelleditor_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellEditorRefData Extends wxObject

End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellTextEditorRefData Extends wxSheetCellEditorRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellAutoWrapStringEditorRefData Extends wxSheetCellTextEditorRefData

	Function _create:wxSheetCellAutoWrapStringEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellAutoWrapStringEditorRefData = New wxSheetCellAutoWrapStringEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method Create:wxSheetCellAutoWrapStringEditorRefData()
		wxObjectPtr = bmx_wxsheetcellautowrapstringeditorrefdata_create()
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellNumberEditorRefData Extends wxSheetCellTextEditorRefData

	Method Create:wxSheetCellNumberEditorRefData(minimum:Int = -1, maximum:Int = -1)
	End Method
	
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellFloatEditorRefData Extends wxSheetCellTextEditorRefData

	Method Create:wxSheetCellFloatEditorRefData(width:Int = -1, precision:Int = -1)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellBoolEditorRefData Extends wxSheetCellEditorRefData

	Method Create:wxSheetCellBoolEditorRefData()
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellChoiceEditorRefData Extends wxSheetCellEditorRefData

	Method Create:wxSheetCellChoiceEditorRefData(choices:String[], allowOthers:Int = False)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellEnumEditorRefData Extends wxSheetCellChoiceEditorRefData
End Type


Rem
bbdoc: 
End Rem
Type wxSheetTable Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Method GetView:wxSheet()

	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetView(sheet:wxSheet)
		bmx_wxsheettable_setview(wxObjectPtr, sheet.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberRows:Int()
		Return bmx_wxsheettable_getnumberrows(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberCols:Int()
		Return bmx_wxsheettable_getnumbercols(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ContainsGridRow:Int(row:Int)
		Return bmx_wxsheettable_containsgridrow(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ContainsGridCol:Int(col:Int)
		Return bmx_wxsheettable_containsgridcol(wxObjectPtr, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ContainsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheettable_containsgridcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValue:String(row:Int, col:Int)
		Return bmx_wxsheettable_getvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValue(row:Int, col:Int, value:String)
		bmx_wxsheettable_setvalue(wxObjectPtr, row, col, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasValue:Int(row:Int, col:Int)
		Return bmx_wxsheettable_hasvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFirstNonEmptyColToLeft:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getfirstnonemptycoltoleft(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearValues(update:Int = wxSHEET_UpdateValues)
		bmx_wxsheettable_clearvalues(wxObjectPtr, update)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowLabelValue:String(row:Int)
		Return bmx_wxsheettable_getdefaultrowlabelvalue(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColLabelValue:String(col:Int)
		Return bmx_wxsheettable_getdefaultcollabelvalue(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsInt:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasint(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsDouble:Double(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasdouble(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsBool:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasbool(wxObjectPtr, row, col)
	End Method
	
	
End Type

Rem
bbdoc: A 4 way splitter class for the wxSheet
End Rem
Type wxSheetSplitter Extends wxWindow

	Function CreateSheetSplitter:wxSheetSplitter(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, ..
			h:Int = -1, style:Int = wxSP_3D|wxSP_3DBORDER)
		Return New wxSheetSplitter.Create(parent, id, x, y, w, h, style)
	End Function
	
	Method Create:wxSheetSplitter(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSP_3D|wxSP_3DBORDER)
		wxObjectPtr = bmx_wxsheetsplitter_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		Return Self
	End Method

	Rem
	bbdoc: Initialize the splitter with one window
	about: The splitter must be sheet's parent
	End Rem
	Method Initialize(sheet:wxSheet)
		bmx_wxsheetsplitter_initialize(wxObjectPtr, sheet.wxObjectPtr)
	End Method
	
	Method GetEnableSplitVertically:Int()
	End Method
	
	Method GetEnableSplitHorizontally:Int()
	End Method
	
	Method EnableSplitVertically(canSplit:Int)
	End Method
	
	Method EnableSplitHorizontally(canSplit:Int)
	End Method
	
	Method IsSplitVertically:Int()
	End Method
	
	Method IsSplitHorizontally:Int()
	End Method
	
	Method CanSplitVertically:Int()
	End Method
	
	Method CanSplitHorizontally:Int()
	End Method
	
	
End Type




Type wxSheetSelection Extends wxObject

End Type



Type wxSheetEvent Extends wxNotifyEvent

End Type

Type wxSheetCellSizeEvent Extends wxSheetEvent

End Type

Type wxSheetRangeSelectEvent Extends wxSheetEvent

	

End Type

Type wxSheetEditorCreatedEvent Extends wxCommandEvent

	Method GetCoords(row:Int Var, col:Int Var)
	End Method
	
	Method GetControl:wxWindow()
	End Method
	
	Method SetCoords(row:Int, col:Int)
	End Method
	
	Method SetControl(control:wxWindow)
	End Method
	
	
End Type

