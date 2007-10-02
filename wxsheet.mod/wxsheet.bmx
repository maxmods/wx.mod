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
		bmx_wxsheet_getcellsize(wxObjectPtr, row, col, Varptr w, Varptr h)
	End Method
	
	Method IsCellShown:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscellshown(wxObjectPtr, row, col)
	End Method

	Method SetMargins(width:Int, height:Int)
		bmx_wxsheet_setmargins(wxObjectPtr, width, height)
	End Method
	
	Method GetCellBestSize(row:Int, col:Int, w:Int Var, h:Int Var, dc:wxDC = Null)
	End Method
	
	Method GetRowBestHeight:Int(row:Int)
		Return bmx_wxsheet_getrowbestheight(wxObjectPtr, row)
	End Method
	
	Method GetColBestWidth:Int(col:Int)
		Return bmx_wxsheet_getcolbestwidth(wxObjectPtr, col)
	End Method
	
	Method GetRowLabelWidth:Int(zeroNotShown:Int = True)
		Return bmx_wxsheet_getrowlabelwidth(wxObjectPtr, zeroNotShown)
	End Method
	
	Method GetColLabelHeight:Int(zeroNotShown:Int = True)
		Return bmx_wxsheet_getcollabelheight(wxObjectPtr, zeroNotShown)
	End Method
	
	Method SetRowLabelWidth( width:Int )
		bmx_wxsheet_setrowlabelwidth(wxObjectPtr, width)
	End Method
	
	Method SetColLabelHeight( height:Int )
		bmx_wxsheet_setcollabelheight(wxObjectPtr, height)
	End Method
	
	Method AutoSizeRow:Int( row:Int, setAsMin:Int = True )
		Return bmx_wxsheet_autosizerow(wxObjectPtr, row, setAsMin)
	End Method
	
	Method AutoSizeCol:Int( col:Int, setAsMin:Int = True )
		Return bmx_wxsheet_autosizecol(wxObjectPtr, col, setAsMin)
	End Method
	
	
	Method AutoSizeRows( setAsMin:Int = True )
		bmx_wxsheet_autosizerows(wxObjectPtr, setAsMin)
	End Method
	
	Method AutoSizeCols( setAsMin:Int = True )
		bmx_wxsheet_autosizecols(wxObjectPtr, setAsMin)
	End Method
	
	
	Method AutoSize( setAsMin:Int = True )
		bmx_wxsheet_autosize(wxObjectPtr, setAsMin)
	End Method
	
	Method AutoSizeRowLabelHeight( row:Int )
		bmx_wxsheet_autosizerowlabelheight(wxObjectPtr, row)
	End Method
	
	Method AutoSizeColLabelWidth( col:Int )
		bmx_wxsheet_autosizecollabelwidth(wxObjectPtr, col)
	End Method
	
	Method SetEqualColWidths(minWidth:Int)
		bmx_wxsheet_setequalcolwidths(wxObjectPtr, minWidth)
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
		Return bmx_wxsheet_getrowlabelvalue(wxObjectPtr, row)
	End Method
	
	Method GetColLabelValue:String( col:Int )
		Return bmx_wxsheet_getcollabelvalue(wxObjectPtr, col)
	End Method
	
	Method SetRowLabelValue( row:Int, value:String )
		bmx_wxsheet_setrowlabelvalue(wxObjectPtr, row, value)
	End Method
	
	Method SetColLabelValue( col:Int, value:String )
		bmx_wxsheet_setcollabelvalue(wxObjectPtr, col, value)
	End Method
	
	Method GetCornerLabelValue:String()
		Return bmx_wxsheet_getcornerlabelvalue(wxObjectPtr)
	End Method
	
	Method SetCornerLabelValue(value:String)
		bmx_wxsheet_setcornerlabelvalue(wxObjectPtr, value)
	End Method

	Method GetAttrBackgroundColour:wxColour( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxColour._create(bmx_wxsheet_getattrbackgroundcolour(wxObjectPtr, row, col, attrType))
	End Method
	
	Method GetAttrForegroundColour:wxColour( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxColour._create(bmx_wxsheet_getattrforegroundcolour(wxObjectPtr, row, col, attrType))
	End Method
	
	Method GetAttrFont:wxFont( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxFont._create(bmx_wxsheet_getattrfont(wxObjectPtr, row, col, attrType))
	End Method
	
	Method GetAttrAlignment:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattralignment(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrOrientation:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrorientation(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrLevel:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrlevel(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrOverflow:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattroverflow(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrOverflowMarker:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattroverflowmarker(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrShowEditor:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrshoweditor(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrReadOnly:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrreadonly(wxObjectPtr, row, col, attrType)
	End Method
	
	Method GetAttrRenderer:wxSheetCellRenderer( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxSheetCellRenderer._create(bmx_wxsheet_getattrrenderer(wxObjectPtr, row, col, attrType))
	End Method
	
	Method GetAttrEditor:wxSheetCellEditor( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny ) 
		Return wxSheetCellEditor._create(bmx_wxsheet_getattreditor(wxObjectPtr, row, col, attrType))
	End Method

	Method SetAttrBackgroundColour( row:Int, col:Int, colour:wxColour, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrbackgroundcolour(wxObjectPtr, row, col, colour.wxObjectPtr, attrType)
	End Method
	
	Method SetAttrForegroundColour( row:Int, col:Int, colour:wxColour, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrforegroundcolour(wxObjectPtr, row, col, colour.wxObjectPtr, attrType)
	End Method
	
	Method SetAttrFont( row:Int, col:Int, font:wxFont, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrfont(wxObjectPtr, row, col, font.wxObjectPtr, attrType)
	End Method
	
	Method SetAttrAlignment( row:Int, col:Int, align:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattralignment(wxObjectPtr, row, col, align, attrType)
	End Method
	
	Method SetAttrLevel( row:Int, col:Int, level:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrlevel(wxObjectPtr, row, col, level, attrType)
	End Method
	
	Method SetAttrOverflow( row:Int, col:Int, allow:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattroverflow(wxObjectPtr, row, col, allow, attrType)
	End Method
	
	Method SetAttrOverflowMarker( row:Int, col:Int, drawMarker:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattroverflowmarker(wxObjectPtr, row, col, drawMarker, attrType)
	End Method
	
	Method SetAttrShowEditor( row:Int, col:Int, showEditor:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrshoweditor(wxObjectPtr, row, col,showEditor, attrType)
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

	Method SetColFormatBool(col:Int)
		bmx_wxsheet_setcolformatbool(wxObjectPtr, col)
	End Method
	
	Method SetColFormatNumber(col:Int)
		bmx_wxsheet_setcolformatnumber(wxObjectPtr, col)
	End Method
	
	Method SetColFormatFloat(col:Int, width:Int = -1, precision:Int = -1)
		bmx_wxsheet_setcolformatfloat(wxObjectPtr, col, width, precision)
	End Method
	
	Method SetColFormatCustom(col:Int, typeName:String)
		bmx_wxsheet_setcolformatcustom(wxObjectPtr, col, typeName)
	End Method
	
	Method IsCellVisible:Int( row:Int, col:Int, wholeCellVisible:Int = True )
		Return bmx_wxsheet_iscellvisible(wxObjectPtr, row, col, wholeCellVisible)
	End Method
	
	Method IsRowVisible:Int( row:Int, wholeRowVisible:Int = True )
		Return bmx_wxsheet_isrowvisible(wxObjectPtr, row, wholeRowVisible)
	End Method
	
	Method IsColVisible:Int( col:Int, wholeColVisible:Int = True )
		Return bmx_wxsheet_iscolvisible(wxObjectPtr, col, wholeColVisible)
	End Method
	
	Method MakeCellVisible( row:Int, col:Int )
		bmx_wxsheet_makecellvisible(wxObjectPtr, row, col)
	End Method
	
	Method GetGridCursorCell(row:Int Var, col:Int Var)
		bmx_wxsheet_getgridcursorcell(wxObjectPtr, Varptr row, Varptr col)
	End Method
	
	Method GetGridCursorRow:Int()
		Return bmx_wxsheet_getgridcursorrow(wxObjectPtr)
	End Method
	
	Method GetGridCursorCol:Int()
		Return bmx_wxsheet_getgridcursorcol(wxObjectPtr)
	End Method
	
	Method SetGridCursorCell(row:Int, col:Int)
		bmx_wxsheet_setgridcursorcell(wxObjectPtr, row, col)
	End Method

	Method GetOrCreateAttr:wxSheetCellAttr( row:Int, col:Int, attrType:Int )
		Return wxSheetCellAttr._create(bmx_wxsheet_getorcreateattr(wxObjectPtr, row, col, attrType))
	End Method
	
	Method GetAttr:wxSheetCellAttr( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny)
		Return wxSheetCellAttr._create(bmx_wxsheet_getattr(wxObjectPtr, row, col, attrType))
	End Method
	
	Method SetAttr(row:Int, col:Int, attr:wxSheetCellAttr, attrType:Int )
		bmx_wxsheet_setattr(wxObjectPtr, row, col, attr.wxObjectPtr, attrType)
	End Method
	
	Method GetGridAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridattr(wxObjectPtr, row, col))
	End Method
	
	Method GetGridCellAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridcellattr(wxObjectPtr, row, col))
	End Method
	
	Method GetGridRowAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridrowattr(wxObjectPtr, row))
	End Method
	
	Method GetGridColAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridcolattr(wxObjectPtr, col))
	End Method
	
	Method SetGridCellAttr(row:Int, col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridcellattr(wxObjectPtr, row, col, attr.wxObjectPtr)
	End Method
	
	Method SetGridRowAttr(row:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridrowattr(wxObjectPtr, row, attr.wxObjectPtr)
	End Method
	
	Method SetGridColAttr(col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridcolattr(wxObjectPtr, col, attr.wxObjectPtr)
	End Method
	
	
	Method GetRowLabelAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getrowlabelattr(wxObjectPtr, row))
	End Method
	
	Method GetColLabelAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getcollabelattr(wxObjectPtr, col))
	End Method

	Method GetCornerLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getcornerlabelattr(wxObjectPtr))
	End Method

	
	Method GetRowLabelCellAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getrowlabelcellattr(wxObjectPtr, row))
	End Method

	Method GetColLabelCellAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getcollabelcellattr(wxObjectPtr, col))
	End Method

	
	Method SetRowLabelCellAttr(row:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setrowlabelcellattr(wxObjectPtr, row, attr.wxObjectPtr)
	End Method

	Method SetColLabelCellAttr(col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setcollabelcellattr(wxObjectPtr, col, attr.wxObjectPtr)
	End Method

	Method SetCornerLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setcornerlabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Method GetDefaultAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultattr(wxObjectPtr, row, col))
	End Method

	Method GetDefaultGridCellAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultgridcellattr(wxObjectPtr))
	End Method

	Method GetDefaultRowLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultrowlabelattr(wxObjectPtr))
	End Method

	Method GetDefaultColLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultcollabelattr(wxObjectPtr))
	End Method

	Method SetDefaultAttr(row:Int, col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultattr(wxObjectPtr, row, col, attr.wxObjectPtr)
	End Method

	Method SetDefaultGridCellAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultgridcellattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Method SetDefaultRowLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultrowlabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Method SetDefaultColLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultcollabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method


	Method HasSpannedCells:Int()
		Return bmx_wxsheet_hasspannedcells(wxObjectPtr)
	End Method
	
	Method GetCellOwner(row:Int, col:Int, ownerRow:Int Var, ownerCol:Int Var )
		bmx_wxsheet_getcellowner(wxObjectPtr, row, col, Varptr ownerRow, Varptr ownerCol)
	End Method
	
	Method GetCellBlock(row:Int, col:Int, oRow:Int Var, oCol:Int Var, oWidth:Int Var, oHeight:Int Var)
		bmx_wxsheet_getcellblock(wxObjectPtr, row, col, Varptr oRow, Varptr oCol, Varptr oWidth, Varptr oHeight)
	End Method
	
	Method GetCellSpan(row:Int, col:Int, rowSpan:Int Var, colSpan:Int Var)
		bmx_wxsheet_getcellspan(wxObjectPtr, row, col, Varptr rowSpan, Varptr colSpan)
	End Method
		
	Method SetCellSpan(row:Int, col:Int, rows:Int, cols:Int)
		bmx_wxsheet_setcellspan(wxObjectPtr, row, col, rows, cols)
	End Method

End Type


Rem
bbdoc: 
End Rem
Type wxSheetCellRenderer Extends wxObject

	Function _create:wxSheetCellRenderer(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellRenderer = New wxSheetCellRenderer
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

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

	Method Create:wxSheetCellStringRendererRefData()
		wxObjectPtr = bmx_wxsheetcellstringrendererrefdata_create()
		Return Self
	End Method

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

	Method Create:wxSheetCellNumberRendererRefData()
		wxObjectPtr = bmx_wxsheetcellnumberrendererrefdata_create()
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellFloatRendererRefData Extends wxSheetCellStringRendererRefData

	Method CreateData:wxSheetCellFloatRendererRefData(width:Int = -1, precision:Int = -1)
		wxObjectPtr = bmx_wxsheetcellfloatrendererrefdata_create(width, precision)
		Return Self
	End Method

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

	Method Create:wxSheetCellBoolRendererRefData()
		wxObjectPtr = bmx_wxsheetcellboolrendererrefdata_create()
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellDateTimeRendererRefData Extends wxSheetCellStringRendererRefData
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellEnumRendererRefData Extends wxSheetCellStringRendererRefData

	Method CreateData:wxSheetCellEnumRendererRefData(choices:String)
		wxObjectPtr = bmx_wxsheetcellenumrendererrefdata_create(choices)
		Return Self
	End Method


End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellEditor Extends wxObject

	Function _create:wxSheetCellEditor(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellEditor = New wxSheetCellEditor
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function


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

	Function _create:wxSheetCellTextEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellTextEditorRefData = New wxSheetCellTextEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellTextEditorRefData(na1:Int = -1, na2:Int = -1)
		wxObjectPtr = bmx_wxsheetcelltexteditorrefdata_create()
		Return Self
	End Method
	
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

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellAutoWrapStringEditorRefData(na1:Int = -1, na2:Int = -1)
		wxObjectPtr = bmx_wxsheetcellautowrapstringeditorrefdata_create()
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellNumberEditorRefData Extends wxSheetCellTextEditorRefData

	Function _create:wxSheetCellNumberEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellNumberEditorRefData = New wxSheetCellNumberEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellNumberEditorRefData(minimum:Int = -1, maximum:Int = -1)
		wxObjectPtr = bmx_wxsheetcellnumbereditorrefdata_create(minimum, maximum)
		Return Self
	End Method
	
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellFloatEditorRefData Extends wxSheetCellTextEditorRefData

	Function _create:wxSheetCellFloatEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellFloatEditorRefData = New wxSheetCellFloatEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellFloatEditorRefData(width:Int = -1, precision:Int = -1)
		wxObjectPtr = bmx_wxsheetcellfloateditorrefdata_create(width, precision)
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellBoolEditorRefData Extends wxSheetCellEditorRefData

	Function _create:wxSheetCellBoolEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellBoolEditorRefData = New wxSheetCellBoolEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellBoolEditorRefData()
		wxObjectPtr = bmx_wxsheetcellbooleditorrefdata_create()
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellChoiceEditorRefData Extends wxSheetCellEditorRefData

	Function _create:wxSheetCellChoiceEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellChoiceEditorRefData = New wxSheetCellChoiceEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellChoiceEditorRefData(choices:String[], allowOthers:Int = False)
		wxObjectPtr = bmx_wxsheetcellchoiceeditorrefdata_create(choices, allowOthers)
		Return Self
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellEnumEditorRefData Extends wxSheetCellChoiceEditorRefData

	Function _create:wxSheetCellEnumEditorRefData(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellEnumEditorRefData = New wxSheetCellEnumEditorRefData
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method CreateData:wxSheetCellEnumEditorRefData(choices:String)
		wxObjectPtr = bmx_wxsheetcellenumeditorrefdata_create(choices)
		Return Self
	End Method

End Type

Rem
bbdoc: Contains all the attributes for a wxSheet cell
End Rem
Type wxSheetCellAttr Extends wxObject

	Function _create:wxSheetCellAttr(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetCellAttr = New wxSheetCellAttr
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function CreateSheeCellAttr:wxSheetCellAttr(createData:Int = False)
		Return New wxSheetCellAttr.Create(createData)
	End Function
	
	Method Create:wxSheetCellAttr(createData:Int = False)
		wxObjectPtr = bmx_wxsheetcellattr_create(createData)
		Return Self
	End Method
	
	Method SetForegroundColour(colour:wxColour)
		bmx_wxsheetcellattr_setforegroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxsheetcellattr_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Method SetFont(font:wxFont)
		bmx_wxsheetcellattr_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Method SetAlignment(align:Int)
		bmx_wxsheetcellattr_setalignment(wxObjectPtr, align)
	End Method
	
	Method SetAlignmentHV(horzAlign:Int, vertAlign:Int)
		bmx_wxsheetcellattr_setalignmenthv(wxObjectPtr, horzAlign, vertAlign)
	End Method
	
	Method SetOrientation(orientation:Int)
		bmx_wxsheetcellattr_setorientation(wxObjectPtr, orientation)
	End Method
	
	Method SetLevel(level:Int)
		bmx_wxsheetcellattr_setlevel(wxObjectPtr, level)
	End Method
	
	Method SetOverflow(allow:Int)
		bmx_wxsheetcellattr_setoverflow(wxObjectPtr, allow)
	End Method
	
	Method SetOverflowMarker(drawMarker:Int)
		bmx_wxsheetcellattr_setoverflowmarker(wxObjectPtr, drawMarker)
	End Method
	
	Method SetShowEditor(showEditor:Int)
		bmx_wxsheetcellattr_setshoweditor(wxObjectPtr, showEditor)
	End Method
	
	Method SetReadOnly(isReadOnly:Int)
		bmx_wxsheetcellattr_setreadonly(wxObjectPtr, isReadOnly)
	End Method
	
	Method SetRenderer(renderer:wxSheetCellRenderer)
		bmx_wxsheetcellattr_setrenderer(wxObjectPtr, renderer.wxObjectPtr)
	End Method
	
	Method SetEditor(editor:wxSheetCellEditor)
		bmx_wxsheetcellattr_seteditor(wxObjectPtr, editor.wxObjectPtr)
	End Method
	
	Method SetKind(kind:Int)
		bmx_wxsheetcellattr_setkind(wxObjectPtr, kind)
	End Method
	
	Method HasForegroundColour:Int()
		Return bmx_wxsheetcellattr_hasforegroundcolour(wxObjectPtr)
	End Method
	
	Method HasBackgroundColour:Int()
		Return bmx_wxsheetcellattr_hasbackgroundcolour(wxObjectPtr)
	End Method
	
	Method HasFont:Int()
		Return bmx_wxsheetcellattr_hasfont(wxObjectPtr)
	End Method
	
	Method HasAlignment:Int()
		Return bmx_wxsheetcellattr_hasalignment(wxObjectPtr)
	End Method
	
	Method HasOrientation:Int()
		Return bmx_wxsheetcellattr_hasorientation(wxObjectPtr)
	End Method
	
	Method HasLevel:Int()
		Return bmx_wxsheetcellattr_haslevel(wxObjectPtr)
	End Method
	
	Method HasOverflowMode:Int()
		Return bmx_wxsheetcellattr_hasoverflowmode(wxObjectPtr)
	End Method
	
	Method HasOverflowMarkerMode:Int()
		Return bmx_wxsheetcellattr_hasoverflowmarkermode(wxObjectPtr)
	End Method
	
	Method HasShowEditorMode:Int()
		Return bmx_wxsheetcellattr_hasshoweditormode(wxObjectPtr)
	End Method
	
	Method HasReadWriteMode:Int()
		Return bmx_wxsheetcellattr_hasreadwritemode(wxObjectPtr)
	End Method
	
	Method HasRenderer:Int()
		Return bmx_wxsheetcellattr_hasrenderer(wxObjectPtr)
	End Method
	
	Method HasEditor:Int()
		Return bmx_wxsheetcellattr_haseditor(wxObjectPtr)
	End Method
	
	Method HasDefaultAttr:Int()
		Return bmx_wxsheetcellattr_hasdefaultattr(wxObjectPtr)
	End Method
	
	Method IsComplete:Int()
		Return bmx_wxsheetcellattr_iscomplete(wxObjectPtr)
	End Method
	
	Method GetForegroundColour:wxColour()
		Return wxColour._create(bmx_wxsheetcellattr_getforegroundcolour(wxObjectPtr))
	End Method
	
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxsheetcellattr_getbackgroundcolour(wxObjectPtr))
	End Method
	
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxsheetcellattr_getfont(wxObjectPtr))
	End Method
	
	Method GetAlignment:Int()
		Return bmx_wxsheetcellattr_getalignment(wxObjectPtr)
	End Method
	
	Method GetOrientation:Int()
		Return bmx_wxsheetcellattr_getorientation(wxObjectPtr)
	End Method
	
	Method GetLevel:Int()
		Return bmx_wxsheetcellattr_getlevel(wxObjectPtr)
	End Method
	
	Method GetOverflow:Int()
		Return bmx_wxsheetcellattr_getoverflow(wxObjectPtr)
	End Method
	
	Method GetOverflowMarker:Int()
		Return bmx_wxsheetcellattr_getoverflowmarker(wxObjectPtr)
	End Method
	
	Method GetShowEditor:Int()
		Return bmx_wxsheetcellattr_getshoweditor(wxObjectPtr)
	End Method
	
	Method GetReadOnly:Int()
		Return bmx_wxsheetcellattr_getreadonly(wxObjectPtr)
	End Method
	
	Method GetRenderer:wxSheetCellRenderer(sheet:wxSheet, row:Int, col:Int)
		Return wxSheetCellRenderer._create(bmx_wxsheetcellattr_getrenderer(wxObjectPtr, sheet.wxObjectPtr, row, col))
	End Method
	
	Method GetEditor:wxSheetCellEditor(sheet:wxSheet, row:Int, col:Int)
		Return wxSheetCellEditor._create(bmx_wxsheetcellattr_geteditor(wxObjectPtr, sheet.wxObjectPtr, row, col))
	End Method
	
	Method GetKind:Int()
		Return bmx_wxsheetcellattr_getkind(wxObjectPtr)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxsheetcellattr_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
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

