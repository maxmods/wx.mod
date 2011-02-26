' Copyright (c) 2007-2011 Bruce A Henderson
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
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?
'?fixme
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
		
		OnInit()
		
		Return Self
	End Method
	
'	Function createForSplitter:wxSheet(splitter:wxSheetSplitter, id:Int)
'		Local this:wxSheet = New wxSheet
'		this.wxObjectPtr = bmx_wxsheet_createforsplitter(Self, splitter.wxObjectPtr, id)
'		Return this
'	End Function

	' soft linking
	Function _create:wxSheet(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheet = New wxSheet
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxSheet(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local sheet:wxSheet = wxSheet(wxfind(wxObjectPtr))
			If Not sheet Then
				Return wxSheet._create(wxObjectPtr)
			End If
			Return sheet
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetTable:wxSheetTable()
	
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetTable(table:wxSheetTable, takeOwnership:Int)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateGrid:Int(numRows:Int, numCols:Int, options:Int = 0)
		Return bmx_wxsheet_creategrid(wxObjectPtr, numRows, numCols, options)
	End Method
	
	Rem
	bbdoc: Returns the number of rows on the sheet.
	End Rem
	Method GetNumberRows:Int()
		Return bmx_wxsheet_getnumberrows(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of columns on the sheet.
	End Rem
	Method GetNumberCols:Int()
		Return bmx_wxsheet_getnumbercols(wxObjectPtr)
	End Method

	Rem
	bbdoc: Returns True if coords are anywhere in labels or grid, -1 to GetNumberRows/Cols()-1
	End Rem
	Method ContainsCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containscell(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: Returns True if the row is within the grid cells of the sheet.
	End Rem
	Method ContainsGridRow:Int(row:Int)
		Return bmx_wxsheet_containsgridrow(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: Returns True if the column is within the grid cells of the sheet.
	End Rem
	Method ContainsGridCol:Int(col:Int)
		Return bmx_wxsheet_containsgridcol(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: Returns True if the coord is within the grid cells of the sheet.
	End Rem
	Method ContainsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containsgridcell(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: Returns True if the coords are within the row/col label cells
	End Rem
	Method ContainsRowLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containsrowlabelcell(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: Returns True if the coords are within the row/col label cells
	End Rem
	Method ContainsColLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_containscollabelcell(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_isgridcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_islabelcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsRowLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_isrowlabelcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsColLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscollabelcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsCornerLabelCell:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscornerlabelcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ClearValues(update:Int = wxSHEET_UpdateValues)
		bmx_wxsheet_clearvalues(wxObjectPtr, update)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertRows:Int(row:Int, numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_insertrows(wxObjectPtr, row, numRows, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AppendRows:Int(numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_appendrows(wxObjectPtr, numRows, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method DeleteRows:Int(row:Int, numRows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_deleterows(wxObjectPtr, row, numRows, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method InsertCols:Int(col:Int, numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_insertcols(wxObjectPtr, col, numCols, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AppendCols:Int(numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_appendcols(wxObjectPtr, numCols, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method DeleteCols:Int(col:Int, numCols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_deletecols(wxObjectPtr, col, numCols, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetNumberRows:Int(rows:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_setnumberrows(wxObjectPtr, rows, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetNumberCols:Int(cols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_setnumbercols(wxObjectPtr, cols, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetNumberCells:Int(rows:Int, cols:Int, update:Int = wxSHEET_UpdateAll)
		Return bmx_wxsheet_setnumbercells(wxObjectPtr, rows, cols, update)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowHeight:Int()
		Return bmx_wxsheet_getdefaultrowheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColWidth:Int()
		Return bmx_wxsheet_getdefaultcolwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultRowHeight( height:Int, resizeExistingRows:Int = False )
		bmx_wxsheet_setdefaultrowheight(wxObjectPtr, height, resizeExistingRows)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDefaultColWidth( width:Int, resizeExistingCols:Int = False )
		bmx_wxsheet_setdefaultcolwidth(wxObjectPtr, width, resizeExistingCols)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinimalAcceptableRowHeight:Int()
		Return bmx_wxsheet_getminimalacceptablerowheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinimalAcceptableColWidth:Int()
		Return bmx_wxsheet_getminimalacceptablecolwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinimalAcceptableRowHeight(height:Int)
		bmx_wxsheet_setminimalacceptablerowheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinimalAcceptableColWidth(width:Int)
		bmx_wxsheet_setminimalacceptablecolwidth(wxObjectPtr, width)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinimalRowHeight:Int(row:Int)
		Return bmx_wxsheet_getminimalrowheight(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinimalColWidth:Int(col:Int)
		Return bmx_wxsheet_getminimalcolwidth(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinimalRowHeight(row:Int, height:Int)
		bmx_wxsheet_setminimalrowheight(wxObjectPtr, row, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMinimalColWidth(col:Int, width:Int)
		bmx_wxsheet_setminimalcolwidth(wxObjectPtr, col, width)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetRowHeight(row:Int, height:Int, ignoreMinSize:Int = False )
		bmx_wxsheet_setrowheight(wxObjectPtr, row, height, ignoreMinSize)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColWidth(col:Int, width:Int, ignoreMinSize:Int = False )
		bmx_wxsheet_setcolwidth(wxObjectPtr, col, width, ignoreMinSize)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowHeight:Int(row:Int)
		Return bmx_wxsheet_getrowheight(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowTop:Int(row:Int)
		Return bmx_wxsheet_getrowtop(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowBottom:Int(row:Int)
		Return bmx_wxsheet_getrowbottom(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColWidth:Int(col:Int)
		Return bmx_wxsheet_getcolwidth(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLeft:Int(col:Int)
		Return bmx_wxsheet_getcolleft(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColRight:Int(col:Int)
		Return bmx_wxsheet_getcolright(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellSize(row:Int, col:Int, w:Int Var, h:Int Var)
		bmx_wxsheet_getcellsize(wxObjectPtr, row, col, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCellShown:Int(row:Int, col:Int)
		Return bmx_wxsheet_iscellshown(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetMargins(width:Int, height:Int)
		bmx_wxsheet_setmargins(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellBestSize(row:Int, col:Int, w:Int Var, h:Int Var, dc:wxDC = Null)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowBestHeight:Int(row:Int)
		Return bmx_wxsheet_getrowbestheight(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColBestWidth:Int(col:Int)
		Return bmx_wxsheet_getcolbestwidth(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelWidth:Int(zeroNotShown:Int = True)
		Return bmx_wxsheet_getrowlabelwidth(wxObjectPtr, zeroNotShown)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelHeight:Int(zeroNotShown:Int = True)
		Return bmx_wxsheet_getcollabelheight(wxObjectPtr, zeroNotShown)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelWidth( width:Int )
		bmx_wxsheet_setrowlabelwidth(wxObjectPtr, width)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColLabelHeight( height:Int )
		bmx_wxsheet_setcollabelheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeRow:Int( row:Int, setAsMin:Int = True )
		Return bmx_wxsheet_autosizerow(wxObjectPtr, row, setAsMin)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeCol:Int( col:Int, setAsMin:Int = True )
		Return bmx_wxsheet_autosizecol(wxObjectPtr, col, setAsMin)
	End Method
	
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeRows( setAsMin:Int = True )
		bmx_wxsheet_autosizerows(wxObjectPtr, setAsMin)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeCols( setAsMin:Int = True )
		bmx_wxsheet_autosizecols(wxObjectPtr, setAsMin)
	End Method
	
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSize( setAsMin:Int = True )
		bmx_wxsheet_autosize(wxObjectPtr, setAsMin)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeRowLabelHeight( row:Int )
		bmx_wxsheet_autosizerowlabelheight(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AutoSizeColLabelWidth( col:Int )
		bmx_wxsheet_autosizecollabelwidth(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEqualColWidths(minWidth:Int)
		bmx_wxsheet_setequalcolwidths(wxObjectPtr, minWidth)
	End Method
	
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellValue:String( row:Int, col:Int )
		Return bmx_wxsheet_getcellvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCellValue( row:Int, col:Int, value:String )
		bmx_wxsheet_setcellvalue(wxObjectPtr, row, col, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasCellValue:Int( row:Int, col:Int )
		Return bmx_wxsheet_hascellvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelValue:String( row:Int )
		Return bmx_wxsheet_getrowlabelvalue(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelValue:String( col:Int )
		Return bmx_wxsheet_getcollabelvalue(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelValue( row:Int, value:String )
		bmx_wxsheet_setrowlabelvalue(wxObjectPtr, row, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColLabelValue( col:Int, value:String )
		bmx_wxsheet_setcollabelvalue(wxObjectPtr, col, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCornerLabelValue:String()
		Return bmx_wxsheet_getcornerlabelvalue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCornerLabelValue(value:String)
		bmx_wxsheet_setcornerlabelvalue(wxObjectPtr, value)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetAttrBackgroundColour:wxColour( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxColour._create(bmx_wxsheet_getattrbackgroundcolour(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrForegroundColour:wxColour( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxColour._create(bmx_wxsheet_getattrforegroundcolour(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrFont:wxFont( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxFont._create(bmx_wxsheet_getattrfont(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrAlignment:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattralignment(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrOrientation:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrorientation(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrLevel:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrlevel(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrOverflow:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattroverflow(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrOverflowMarker:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattroverflowmarker(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrShowEditor:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrshoweditor(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrReadOnly:Int( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return bmx_wxsheet_getattrreadonly(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrRenderer:wxSheetCellRenderer( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny )
		Return wxSheetCellRenderer._create(bmx_wxsheet_getattrrenderer(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttrEditor:wxSheetCellEditor( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny ) 
		Return wxSheetCellEditor._create(bmx_wxsheet_getattreditor(wxObjectPtr, row, col, attrType))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetAttrBackgroundColour( row:Int, col:Int, colour:wxColour, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrbackgroundcolour(wxObjectPtr, row, col, colour.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrForegroundColour( row:Int, col:Int, colour:wxColour, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrforegroundcolour(wxObjectPtr, row, col, colour.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrFont( row:Int, col:Int, font:wxFont, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrfont(wxObjectPtr, row, col, font.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrAlignment( row:Int, col:Int, align:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattralignment(wxObjectPtr, row, col, align, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrLevel( row:Int, col:Int, level:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrlevel(wxObjectPtr, row, col, level, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrOverflow( row:Int, col:Int, allow:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattroverflow(wxObjectPtr, row, col, allow, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrOverflowMarker( row:Int, col:Int, drawMarker:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattroverflowmarker(wxObjectPtr, row, col, drawMarker, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrShowEditor( row:Int, col:Int, showEditor:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrshoweditor(wxObjectPtr, row, col,showEditor, attrType)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetAttrRenderer(row:Int, col:Int, renderer:wxSheetCellRenderer, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrrenderer(wxObjectPtr, row, col, renderer.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrEditor(row:Int, col:Int, editor:wxSheetCellEditor, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattreditor(wxObjectPtr, row, col, editor.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttrReadOnly(row:Int, col:Int, isReadOnly:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrreadonly(wxObjectPtr, row, col, isReadOnly, attrType)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetAttrOrientation(row:Int, col:Int, orientation:Int, attrType:Int = wxSHEET_AttrCell )
		bmx_wxsheet_setattrorientation(wxObjectPtr, row, col, orientation, attrType)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetColFormatBool(col:Int)
		bmx_wxsheet_setcolformatbool(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatNumber(col:Int)
		bmx_wxsheet_setcolformatnumber(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatFloat(col:Int, width:Int = -1, precision:Int = -1)
		bmx_wxsheet_setcolformatfloat(wxObjectPtr, col, width, precision)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetColFormatCustom(col:Int, typeName:String)
		bmx_wxsheet_setcolformatcustom(wxObjectPtr, col, typeName)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCellVisible:Int( row:Int, col:Int, wholeCellVisible:Int = True )
		Return bmx_wxsheet_iscellvisible(wxObjectPtr, row, col, wholeCellVisible)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsRowVisible:Int( row:Int, wholeRowVisible:Int = True )
		Return bmx_wxsheet_isrowvisible(wxObjectPtr, row, wholeRowVisible)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsColVisible:Int( col:Int, wholeColVisible:Int = True )
		Return bmx_wxsheet_iscolvisible(wxObjectPtr, col, wholeColVisible)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MakeCellVisible( row:Int, col:Int )
		bmx_wxsheet_makecellvisible(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridCursorCell(row:Int Var, col:Int Var)
		bmx_wxsheet_getgridcursorcell(wxObjectPtr, Varptr row, Varptr col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridCursorRow:Int()
		Return bmx_wxsheet_getgridcursorrow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridCursorCol:Int()
		Return bmx_wxsheet_getgridcursorcol(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridCursorCell(row:Int, col:Int)
		bmx_wxsheet_setgridcursorcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetOrCreateAttr:wxSheetCellAttr( row:Int, col:Int, attrType:Int )
		Return wxSheetCellAttr._create(bmx_wxsheet_getorcreateattr(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAttr:wxSheetCellAttr( row:Int, col:Int, attrType:Int = wxSHEET_AttrAny)
		Return wxSheetCellAttr._create(bmx_wxsheet_getattr(wxObjectPtr, row, col, attrType))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAttr(row:Int, col:Int, attr:wxSheetCellAttr, attrType:Int )
		bmx_wxsheet_setattr(wxObjectPtr, row, col, attr.wxObjectPtr, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridattr(wxObjectPtr, row, col))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridCellAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridcellattr(wxObjectPtr, row, col))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridRowAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridrowattr(wxObjectPtr, row))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridColAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getgridcolattr(wxObjectPtr, col))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridCellAttr(row:Int, col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridcellattr(wxObjectPtr, row, col, attr.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridRowAttr(row:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridrowattr(wxObjectPtr, row, attr.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridColAttr(col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setgridcolattr(wxObjectPtr, col, attr.wxObjectPtr)
	End Method
	
	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getrowlabelattr(wxObjectPtr, row))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColLabelAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getcollabelattr(wxObjectPtr, col))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetCornerLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getcornerlabelattr(wxObjectPtr))
	End Method

	
	Rem
	bbdoc: 
	End Rem
	Method GetRowLabelCellAttr:wxSheetCellAttr(row:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getrowlabelcellattr(wxObjectPtr, row))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetColLabelCellAttr:wxSheetCellAttr(col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getcollabelcellattr(wxObjectPtr, col))
	End Method

	
	Rem
	bbdoc: 
	End Rem
	Method SetRowLabelCellAttr(row:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setrowlabelcellattr(wxObjectPtr, row, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetColLabelCellAttr(col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setcollabelcellattr(wxObjectPtr, col, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetCornerLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setcornerlabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultAttr:wxSheetCellAttr(row:Int, col:Int)
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultattr(wxObjectPtr, row, col))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultGridCellAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultgridcellattr(wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultrowlabelattr(wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColLabelAttr:wxSheetCellAttr()
		Return wxSheetCellAttr._create(bmx_wxsheet_getdefaultcollabelattr(wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetDefaultAttr(row:Int, col:Int, attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultattr(wxObjectPtr, row, col, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetDefaultGridCellAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultgridcellattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetDefaultRowLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultrowlabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetDefaultColLabelAttr(attr:wxSheetCellAttr)
		bmx_wxsheet_setdefaultcollabelattr(wxObjectPtr, attr.wxObjectPtr)
	End Method


	Rem
	bbdoc: 
	End Rem
	Method HasSpannedCells:Int()
		Return bmx_wxsheet_hasspannedcells(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellOwner(row:Int, col:Int, ownerRow:Int Var, ownerCol:Int Var )
		bmx_wxsheet_getcellowner(wxObjectPtr, row, col, Varptr ownerRow, Varptr ownerCol)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellBlock(row:Int, col:Int, oRow:Int Var, oCol:Int Var, oWidth:Int Var, oHeight:Int Var)
		bmx_wxsheet_getcellblock(wxObjectPtr, row, col, Varptr oRow, Varptr oCol, Varptr oWidth, Varptr oHeight)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCellSpan(row:Int, col:Int, rowSpan:Int Var, colSpan:Int Var)
		bmx_wxsheet_getcellspan(wxObjectPtr, row, col, Varptr rowSpan, Varptr colSpan)
	End Method
		
	Rem
	bbdoc: 
	End Rem
	Method SetCellSpan(row:Int, col:Int, rows:Int, cols:Int)
		bmx_wxsheet_setcellspan(wxObjectPtr, row, col, rows, cols)
	End Method


	Rem
	bbdoc: 
	End Rem
	Method IsAreaEditable:Int( cellType:Int )
		Return bmx_wxsheet_isareaeditable(wxObjectPtr, cellType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAreaEditable:Int()
		Return bmx_wxsheet_getareaeditable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAreaEditable( cellType:Int )
		bmx_wxsheet_setareaeditable(wxObjectPtr, cellType)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method EnableDragRowSize( enable:Int = True )
		bmx_wxsheet_enabledragrowsize(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragColSize( enable:Int = True )
		bmx_wxsheet_enabledragcolsize(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EnableDragGridSize( enable:Int = True )
		bmx_wxsheet_enabledraggridsize(wxObjectPtr, enable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragRowSize()
		bmx_wxsheet_disabledragrowsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragColSize()
		bmx_wxsheet_disabledragcolsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DisableDragGridSize()
		bmx_wxsheet_disabledraggridsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragRowSize:Int()
		Return bmx_wxsheet_candragrowsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragColSize:Int()
		Return bmx_wxsheet_candragcolsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CanDragGridSize:Int()
		Return bmx_wxsheet_candraggridsize(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method EnableGridLines( dir:Int = wxBOTH )
		bmx_wxsheet_enablegridlines(wxObjectPtr, dir)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GridLinesEnabled:Int()
		Return bmx_wxsheet_gridlinesenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetGridLineColour:wxColour()
		Return wxColour._create(bmx_wxsheet_getgridlinecolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetGridLineColour(colour:wxColour )
		bmx_wxsheet_setgridlinecolour(wxObjectPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetSelection:wxSheetSelection()
		Return wxSheetSelection._create(bmx_wxsheet_getselection(wxObjectPtr))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AdjustScrollbars(calcWinSizes:Int = True)
		bmx_wxsheet_adjustscrollbars(wxObjectPtr, calcWinSizes)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScrollBarMode:Int()
		Return bmx_wxsheet_getscrollbarmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetScrollBarMode(Mode:Int)
		bmx_wxsheet_setscrollbarmode(wxObjectPtr, Mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetHorizontalScrollBarMode(Mode:Int)
		bmx_wxsheet_sethorizontalscrollbarmode(wxObjectPtr, Mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetVerticalScrollBarMode(Mode:Int)
		bmx_wxsheet_setverticalscrollbarmode(wxObjectPtr, Mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method NeedsVerticalScrollBar:Int()
		Return bmx_wxsheet_needsverticalscrollbar(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method NeedsHorizontalScrollBar:Int()
		Return bmx_wxsheet_needshorizontalscrollbar(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method RefreshCell(row:Int, col:Int, singleCell:Int = True)
		bmx_wxsheet_refreshcell(wxObjectPtr, row, col, singleCell)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshBlock(block:wxSheetBlock)
		bmx_wxsheet_refreshblock(wxObjectPtr, block.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshRow(row:Int)
		bmx_wxsheet_refreshrow(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshCol(col:Int)
		bmx_wxsheet_refreshcol(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshGridCellBlock(block:wxSheetBlock)
		bmx_wxsheet_refreshgridcellblock(wxObjectPtr, block.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshAttrChange(row:Int, col:Int, attrType:Int)
		bmx_wxsheet_refreshattrchange(wxObjectPtr, row, col, attrType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshSheet(eraseb:Int = True, rect:wxRect = Null)
		If rect Then
			bmx_wxsheet_refreshsheet(wxObjectPtr, eraseb, rect.wxObjectPtr)
		Else
			bmx_wxsheet_refreshsheet(wxObjectPtr, eraseb, Null)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method HasSelection:Int(selecting:Int = True)
		Return bmx_wxsheet_hasselection(wxObjectPtr, selecting)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsCellSelected:Int( row:Int, col:Int )
		Return bmx_wxsheet_iscellselected(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsRowSelected:Int( row:Int )
		Return bmx_wxsheet_isrowselected(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsColSelected:Int( col:Int )
		Return bmx_wxsheet_iscolselected(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsBlockSelected:Int(block:wxSheetBlock )
		Return bmx_wxsheet_isblockselected(wxObjectPtr, block.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsSelecting:Int()
		Return bmx_wxsheet_isselecting(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionMode(selmode:Int)
		bmx_wxsheet_setselectionmode(wxObjectPtr, selmode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method  GetSelectionMode:Int()
		Return bmx_wxsheet_getselectionmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasSelectionMode:Int(Mode:Int)
		Return bmx_wxsheet_hasselectionmode(wxObjectPtr, Mode)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method BeginBatch()
		bmx_wxsheet_beginbatch(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EndBatch(refresh:Int = True)
		bmx_wxsheet_endbatch(wxObjectPtr, refresh)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBatchCount:Int()
		Return bmx_wxsheet_getbatchcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ForceRefresh()
		bmx_wxsheet_forcerefresh(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method FixSelectionBlock:wxSheetBlock(block:wxSheetBlock, selMode:Int = -1)
		Return wxSheetBlock._create(bmx_wxsheet_fixselectionblock(wxObjectPtr, block.wxObjectPtr, selMode))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectRow:Int( row:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectrow(wxObjectPtr, row, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectRows:Int( rowTop:Int, rowBottom:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectrows(wxObjectPtr, rowTop, rowBottom, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectCol:Int( col:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectCol(wxObjectPtr, col, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectCols:Int( colLeft:Int, colRight:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectcols(wxObjectPtr, colLeft, colRight, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectCell:Int( row:Int, col:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectcell(wxObjectPtr, row, col, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectBlock:Int( block:wxSheetBlock, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_selectblock(wxObjectPtr, block.wxObjectPtr, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SelectAll:Int(sendEvt:Int = False)
		Return bmx_wxsheet_selectall(wxObjectPtr, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectRow:Int( row:Int, sendEvt:Int = False )
		Return bmx_wxsheet_deselectrow(wxObjectPtr, row, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectRows:Int( rowTop:Int, rowBottom:Int, sendEvt:Int = False )
		Return bmx_wxsheet_deselectrows(wxObjectPtr, rowTop, rowBottom, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectCol:Int( col:Int, sendEvt:Int = False )
		Return bmx_wxsheet_deselectcol(wxObjectPtr, col, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectCols:Int( colLeft:Int, colRight:Int, sendEvt:Int = False )
		Return bmx_wxsheet_deselectcols(wxObjectPtr, colLeft, colRight, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectCell:Int( row:Int, col:Int, sendEvt:Int = False )
		Return bmx_wxsheet_deselectcell(wxObjectPtr, row, col, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeselectBlock:Int( block:wxSheetBlock, sendEvt:Int = False )
		Return bmx_wxsheet_deselectblock(wxObjectPtr, block.wxObjectPtr, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearSelection:Int(sendEvt:Int = False)
		Return bmx_wxsheet_clearselection(wxObjectPtr, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToggleCellSelection:Int( row:Int, col:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_togglecellselection(wxObjectPtr, row, col, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToggleRowSelection:Int( row:Int, addToSelected:Int = False, sendEvt:Int = False )
		Return bmx_wxsheet_togglerowselection(wxObjectPtr, row, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ToggleColSelection:Int( col:Int, addToSelected:Int = False, sendEvt:Int = False)
		Return bmx_wxsheet_togglecolselection(wxObjectPtr, col, addToSelected, sendEvt)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCursorCellHighlightPen:wxPen()
		Return wxPen._create(bmx_wxsheet_getcursorcellhighlightpen(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCursorCellHighlightROPen:wxPen()
		Return wxPen._create(bmx_wxsheet_getcursorcellhighlightropen(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCursorCellHighlightPen(pen:wxPen)
		bmx_wxsheet_setcursorcellhighlightpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCursorCellHighlightROPen(pen:wxPen)
		bmx_wxsheet_setcursorcellhighlightreopen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLabelOutlineColour:wxColour()
		Return wxColour._create(bmx_wxsheet_getlabeloutlinecolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLabelOutlineColour(colour:wxColour)
		bmx_wxsheet_setlabeloutlinecolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
		
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionBackground:wxColour()
		Return wxColour._create(bmx_wxsheet_getselectionbackground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSelectionForeground:wxColour()
		Return wxColour._create(bmx_wxsheet_getselectionforeground(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionBackground(colour:wxColour)
		bmx_wxsheet_setselectionbackground(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSelectionForeground(colour:wxColour)
		bmx_wxsheet_setselectionforeground(wxObjectPtr, colour.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method HasFocus:Int()
		Return bmx_wxsheet_hasfocus(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CopyCurrentSelectionToClipboard:Int(copyCursor:Int = True, colSep:String = "~t")
		Return bmx_wxsheet_copycurrentselectiontoclipboard(wxObjectPtr, copyCursor, colSep)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CopyCurrentSelectionToInternalSelection:Int(copyCursor:Int = True)
		Return bmx_wxsheet_copycurrentselectiontointernalselection(wxObjectPtr, copyCursor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CopyInternalSelectionToClipboard:Int(colSep:String = "~t")
		Return bmx_wxsheet_copyinternalselectiontoclipboard(wxObjectPtr, colSep)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CopyInternalSelectionToString:String(colSep:String = "~t")
		Return bmx_wxsheet_copyinternalselectiontostring(wxObjectPtr, colSep)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CopyStringToInternalSelection:Int(value:String, colSep:String = "~t")
		Return bmx_wxsheet_copystringtointernalselection(wxObjectPtr, value, colSep)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PasteFromClipboard:Int(row:Int = wxNullSheetRow, col:Int = wxNullSheetCol, colSep:String = "~t")
		Return bmx_wxsheet_pastefromclipboard(wxObjectPtr, row, col, colSep)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PasteInternalCopiedSelection:Int(row:Int = wxNullSheetRow, col:Int = wxNullSheetCol)
		Return bmx_wxsheet_pasteinternalcopiedselection(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CurrentlyPasting:Int()
		Return bmx_wxsheet_currentlypasting(wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetDefaultEditorForType:wxSheetCellEditor(typeName:String)
		Return wxSheetCellEditor._create(bmx_wxsheet_getdefaulteditorfortype(wxObjectPtr, typeName))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRendererForType:wxSheetCellRenderer(typeName:String) 
		Return wxSheetCellRenderer._create(bmx_wxsheet_getdefaultrendererfortype(wxObjectPtr, typeName))
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
		wxObjectPtr = bmx_wxsheetcellstringrendererrefdata_create(Self)
		Return Self
	End Method

	Method Draw(sheet:wxSheet, attr:wxSheetCellAttr, dc:wxDC, rectCell:wxRect, row:Int, col:Int, isSelected:Int)
		bmx_wxsheetcellstringrendererrefdata_draw(wxObjectPtr, sheet.wxObjectPtr, attr.wxObjectPtr, dc.wxObjectPtr, ..
			rectCell.wxObjectPtr, row, col, isSelected);
	End Method
	
	Function _Draw(obj:wxObject, sheet:Byte Ptr, attr:Byte Ptr, dc:Byte Ptr, rectCell:Byte Ptr, row:Int, col:Int, isSelected:Int)
		wxSheetCellStringRendererRefData(obj).Draw(wxSheet._find(sheet), wxSheetCellAttr._create(attr), ..
				wxDC._create(dc), wxRect._create(rectCell), row, col, isSelected)
	End Function
	
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

	Method CreateData:wxSheetCellBitmapRendererRefData(bitmap:wxBitmap = Null, align:Int = 0)
		If bitmap Then
			wxObjectPtr = bmx_wxsheetcellbitmaprendererrefdata_create(bitmap.wxObjectPtr, align)
		Else
			wxObjectPtr = bmx_wxsheetcellbitmaprendererrefdata_create(wxNullBitmap.wxObjectPtr, align)
		End If
		Return Self
	End Method
	
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

	Rem
	bbdoc: 
	End Rem
	Function CreateSheeCellAttr:wxSheetCellAttr(createData:Int = True)
		Return New wxSheetCellAttr.Create(createData)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetCellAttr(createData:Int = True)
		wxObjectPtr = bmx_wxsheetcellattr_create(createData)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetForegroundColour(colour:wxColour)
		bmx_wxsheetcellattr_setforegroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBackgroundColour(colour:wxColour)
		bmx_wxsheetcellattr_setbackgroundcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(font:wxFont)
		bmx_wxsheetcellattr_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAlignment(align:Int)
		bmx_wxsheetcellattr_setalignment(wxObjectPtr, align)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAlignmentHV(horzAlign:Int, vertAlign:Int)
		bmx_wxsheetcellattr_setalignmenthv(wxObjectPtr, horzAlign, vertAlign)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOrientation(orientation:Int)
		bmx_wxsheetcellattr_setorientation(wxObjectPtr, orientation)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLevel(level:Int)
		bmx_wxsheetcellattr_setlevel(wxObjectPtr, level)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOverflow(allow:Int)
		bmx_wxsheetcellattr_setoverflow(wxObjectPtr, allow)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetOverflowMarker(drawMarker:Int)
		bmx_wxsheetcellattr_setoverflowmarker(wxObjectPtr, drawMarker)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetShowEditor(showEditor:Int)
		bmx_wxsheetcellattr_setshoweditor(wxObjectPtr, showEditor)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetReadOnly(isReadOnly:Int)
		bmx_wxsheetcellattr_setreadonly(wxObjectPtr, isReadOnly)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetRenderer(renderer:wxSheetCellRenderer)
		bmx_wxsheetcellattr_setrenderer(wxObjectPtr, renderer.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEditor(editor:wxSheetCellEditor)
		bmx_wxsheetcellattr_seteditor(wxObjectPtr, editor.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetKind(kind:Int)
		bmx_wxsheetcellattr_setkind(wxObjectPtr, kind)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasForegroundColour:Int()
		Return bmx_wxsheetcellattr_hasforegroundcolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasBackgroundColour:Int()
		Return bmx_wxsheetcellattr_hasbackgroundcolour(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasFont:Int()
		Return bmx_wxsheetcellattr_hasfont(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasAlignment:Int()
		Return bmx_wxsheetcellattr_hasalignment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasOrientation:Int()
		Return bmx_wxsheetcellattr_hasorientation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasLevel:Int()
		Return bmx_wxsheetcellattr_haslevel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasOverflowMode:Int()
		Return bmx_wxsheetcellattr_hasoverflowmode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasOverflowMarkerMode:Int()
		Return bmx_wxsheetcellattr_hasoverflowmarkermode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasShowEditorMode:Int()
		Return bmx_wxsheetcellattr_hasshoweditormode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasReadWriteMode:Int()
		Return bmx_wxsheetcellattr_hasreadwritemode(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasRenderer:Int()
		Return bmx_wxsheetcellattr_hasrenderer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasEditor:Int()
		Return bmx_wxsheetcellattr_haseditor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasDefaultAttr:Int()
		Return bmx_wxsheetcellattr_hasdefaultattr(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsComplete:Int()
		Return bmx_wxsheetcellattr_iscomplete(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetForegroundColour:wxColour()
		Return wxColour._create(bmx_wxsheetcellattr_getforegroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBackgroundColour:wxColour()
		Return wxColour._create(bmx_wxsheetcellattr_getbackgroundcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_wxsheetcellattr_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAlignment:Int()
		Return bmx_wxsheetcellattr_getalignment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOrientation:Int()
		Return bmx_wxsheetcellattr_getorientation(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLevel:Int()
		Return bmx_wxsheetcellattr_getlevel(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOverflow:Int()
		Return bmx_wxsheetcellattr_getoverflow(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOverflowMarker:Int()
		Return bmx_wxsheetcellattr_getoverflowmarker(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetShowEditor:Int()
		Return bmx_wxsheetcellattr_getshoweditor(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetReadOnly:Int()
		Return bmx_wxsheetcellattr_getreadonly(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRenderer:wxSheetCellRenderer(sheet:wxSheet, row:Int, col:Int)
		Return wxSheetCellRenderer._create(bmx_wxsheetcellattr_getrenderer(wxObjectPtr, sheet.wxObjectPtr, row, col))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEditor:wxSheetCellEditor(sheet:wxSheet, row:Int, col:Int)
		Return wxSheetCellEditor._create(bmx_wxsheetcellattr_geteditor(wxObjectPtr, sheet.wxObjectPtr, row, col))
	End Method
	
	Rem
	bbdoc: 
	End Rem
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

	Rem
	bbdoc: 
	End Rem
	Function CreateSheetSplitter:wxSheetSplitter(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, ..
			h:Int = -1, style:Int = wxSP_3D|wxSP_3DBORDER)
		Return New wxSheetSplitter.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetSplitter(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSP_3D|wxSP_3DBORDER)
		wxObjectPtr = bmx_wxsheetsplitter_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		Return Self
	End Method

	' soft linking
	Function _create:wxSheetSplitter(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetSplitter = New wxSheetSplitter
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxSheetSplitter(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local splitter:wxSheetSplitter = wxSheetSplitter(wxfind(wxObjectPtr))
			If Not splitter Then
				Return wxSheetSplitter._create(wxObjectPtr)
			End If
			Return splitter
		End If
	End Function
	
	Rem
	bbdoc: Override this to return a derived wxSheet of your own making.
	about: The default implementation returns :
	<pre>New wxSheet.Create(Self, id)</pre>
	End Rem
	Method CreateSheet:wxSheet(id:Int)
		Return New wxSheet.Create(Self, id)
	End Method
	
	Function _createsheet:Byte Ptr(splitter:wxSheetSplitter, id:Int)
		Return splitter.CreateSheet(id).wxObjectPtr
	End Function

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



Rem
bbdoc: 
End Rem
Type wxSheetSelection Extends wxObject

	Function _create:wxSheetSelection(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetSelection = New wxSheetSelection
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method GetNumberRows:Int()
		Return bmx_wxsheetselection_getnumberrows(wxObjectPtr)
	End Method
	
	Method GetNumberCols:Int()
		Return bmx_wxsheetselection_getnumbercols(wxObjectPtr)
	End Method
	
	Method GetOptions:Int()
		Return bmx_wxsheetselection_getoptions(wxObjectPtr)
	End Method
	
	Method SetOptions(options:Int)
		bmx_wxsheetselection_setoptions(wxObjectPtr, options)
	End Method
	
	Method HasSelection:Int()
		Return bmx_wxsheetselection_hasselection(wxObjectPtr)
	End Method
	
	Method GetCount:Int()
		Return bmx_wxsheetselection_getcount(wxObjectPtr)
	End Method
	
	Method IsMinimized:Int()
		Return bmx_wxsheetselection_isminimized(wxObjectPtr)
	End Method
	
	Method Clear:Int()
		Return bmx_wxsheetselection_clear(wxObjectPtr)
	End Method
	
	Method Empty:Int()
		Return bmx_wxsheetselection_empty(wxObjectPtr)
	End Method

	Method GetBlock:wxSheetBlock(index:Int)
		Return wxSheetBlock._create(bmx_wxsheetselection_getblock(wxObjectPtr, index))
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxsheetselection_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type


Rem
bbdoc: 
End Rem
Type wxSheetBlock
	
	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxSheetBlock(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSheetBlock = New wxSheetBlock
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Function CreateSheetBlock:wxSheetBlock(row:Int, col:Int, height:Int, width:Int)
		Return New wxSheetBlock.Create(row, col, height, width)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSheetBlock(row:Int, col:Int, height:Int, width:Int)
		wxObjectPtr = bmx_wxsheetblock_create(row, col, height, width)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLeft:Int()
		Return bmx_wxsheetblock_getleft(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetRight:Int()
		Return bmx_wxsheetblock_getright(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetTop:Int()
		Return bmx_wxsheetblock_gettop(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBottom:Int()
		Return bmx_wxsheetblock_getbottom(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetWidth:Int()
		Return bmx_wxsheetblock_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetHeight:Int()
		Return bmx_wxsheetblock_getheight(wxObjectPtr)
	End Method	
	
	Method GetLeftTop(row:Int Var, col:Int Var)
	End Method
	
	Method GetLeftBottom(row:Int Var, col:Int Var)
	End Method
	
	Method GetRightTop(row:Int Var, col:Int Var)
	End Method
	
	Method GetRightBottom(row:Int Var, col:Int Var)
	End Method

	Method GetSize(row:Int Var, col:Int Var)
	End Method
	
	Method SetLeft( left_:Int)
	End Method
	
	Method SetTop( top_:Int )
	End Method
	
	Method SetRight( right_:Int )
	End Method
	
	Method SetBottom( bottom_:Int )
	End Method
	
	Method SetWidth( width_:Int )
	End Method
	
	Method SetHeight( height_:Int )
	End Method
	
	Method SetLeftTop(row:Int, col:Int)
	End Method
	
	Method SetLeftBottom(row:Int, col:Int)
	End Method
	
	Method SetRightTop(row:Int, col:Int)
	End Method
	
	Method SetRightBottom(row:Int, col:Int)
	End Method
	
	Method SetLeftCoord( left_ :Int)
	End Method
	
	Method SetTopCoord( top_:Int )
	End Method
	
	Method SetRightCoord( right_:Int )
	End Method
	
	Method SetBottomCoord( bottom_:Int )
	End Method
	
	Method SetLeftTopCoords(row:Int, col:Int)
	End Method
	
	Method SetLeftBottomCoords(row:Int, col:Int)
	End Method
	
	Method SetRightTopCoords(row:Int, col:Int)
	End Method
	
	Method SetRightBottomCoords(row:Int, col:Int)
	End Method
	
	Method Set( row:Int, col:Int, height:Int, width:Int ) 
	End Method
	
	Method SetCoords( top_:Int, left_:Int, bottom_:Int, right_:Int )
	End Method
	
	Method SetSize(height:Int, width:Int)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxsheetblock_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSheetEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSheetEvent = New wxSheetEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetRow:Int()
		Return bmx_wxsheetevent_getrow(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCol:Int()
		Return bmx_wxsheetevent_getcol(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCoords(row:Int Var, col:Int Var)
		bmx_wxsheetevent_getcoords(wxEventPtr, Varptr row, Varptr col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Selecting:Int()
		Return bmx_wxsheetevent_selecting(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ControlDown:Int()
		Return bmx_wxsheetevent_controldown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShiftDown:Int()
		Return bmx_wxsheetevent_shiftdown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AltDown:Int()
		Return bmx_wxsheetevent_altdown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MetaDown:Int()
		Return bmx_wxsheetevent_metadown(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxsheetevent_getposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScrolledPosition(x:Int Var, y:Int Var)
		bmx_wxsheetevent_getscrolledposition(wxEventPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEventWindow:wxWindow()
		Return wxWindow._find(bmx_wxsheetevent_geteventwindow(wxEventPtr))
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSheetCellSizeEvent Extends wxSheetEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSheetCellSizeEvent = New wxSheetCellSizeEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetSize:Int()
		Return bmx_wxsheetcellsizeevent_getsize(wxEventPtr)
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSheetRangeSelectEvent Extends wxSheetEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSheetRangeSelectEvent = New wxSheetRangeSelectEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetBlock:wxSheetBlock()
		Return wxSheetBlock._create(bmx_wxsheetrangeselectevent_getblock(wxEventPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetAddToSelection:Int()
		Return bmx_wxsheetrangeselectevent_getaddtoselection(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBlock( block:wxSheetBlock )
		bmx_wxsheetrangeselectevent_setblock(wxEventPtr, block.wxObjectPtr)
	End Method


End Type

Rem
bbdoc: 
End Rem
Type wxSheetEditorCreatedEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSheetEditorCreatedEvent = New wxSheetEditorCreatedEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetCoords(row:Int Var, col:Int Var)
		bmx_wxsheeteditorcreatedevent_getcoords(wxEventPtr, Varptr row, Varptr col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetControl:wxWindow()
		Return wxWindow._find(bmx_wxsheeteditorcreatedevent_getcontrol(wxEventPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCoords(row:Int, col:Int)
		bmx_wxsheeteditorcreatedevent_setcoords(wxEventPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetControl(control:wxWindow)
		bmx_wxsheeteditorcreatedevent_setcontrol(wxEventPtr, control.wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSheetSplitterEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxSheetSplitterEvent = New wxSheetSplitterEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetSashPosition:Int()
		Return bmx_wxsheetsplitterevent_getsashposition(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSashPosition(pos:Int)
		bmx_wxsheetsplitterevent_setsashposition(wxEventPtr, pos)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSplitMode:Int()
		Return bmx_wxsheetsplitterevent_getsplitmode(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsVerticalSplit:Int()
		Return bmx_wxsheetsplitterevent_isverticalsplit(wxEventPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSheet:wxSheet()
		Return wxSheet._find(bmx_wxsheetsplitterevent_getsheet(wxEventPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSheetSplitter:wxSheetSplitter()
		Return wxSheetSplitter._find(bmx_wxsheetsplitterevent_getsheetsplitter(wxEventPtr))
	End Method

End Type

Type TSheetEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_SHEET_VIEW_CHANGED, ..
					wxEVT_SHEET_SELECTING_CELL, ..
					wxEVT_SHEET_SELECTED_CELL, ..
					wxEVT_SHEET_CELL_LEFT_DOWN, ..
					wxEVT_SHEET_CELL_RIGHT_DOWN, ..
					wxEVT_SHEET_CELL_LEFT_UP, ..
					wxEVT_SHEET_CELL_RIGHT_UP, ..
					wxEVT_SHEET_CELL_LEFT_DCLICK, ..
					wxEVT_SHEET_CELL_RIGHT_DCLICK, ..
					wxEVT_SHEET_LABEL_LEFT_DOWN, ..
					wxEVT_SHEET_LABEL_RIGHT_DOWN, ..
					wxEVT_SHEET_LABEL_LEFT_UP, ..
					wxEVT_SHEET_LABEL_RIGHT_UP, ..
					wxEVT_SHEET_LABEL_LEFT_DCLICK, ..
					wxEVT_SHEET_LABEL_RIGHT_DCLICK, ..
					wxEVT_SHEET_CELL_VALUE_CHANGING, ..
					wxEVT_SHEET_CELL_VALUE_CHANGED, ..
					wxEVT_SHEET_EDITOR_ENABLED, ..
					wxEVT_SHEET_EDITOR_DISABLED
				Return wxSheetEvent.Create(wxEventPtr, evt)
			Case wxEVT_SHEET_ROW_SIZE, ..
					wxEVT_SHEET_ROW_SIZING, ..
					wxEVT_SHEET_ROW_SIZED, ..
					wxEVT_SHEET_COL_SIZE, ..
					wxEVT_SHEET_COL_SIZING, ..
					wxEVT_SHEET_COL_SIZED
				Return wxSheetCellSizeEvent.Create(wxEventPtr, evt)
			Case wxEVT_SHEET_RANGE_SELECTING, ..
					wxEVT_SHEET_RANGE_SELECTED
				Return wxSheetRangeSelectEvent.Create(wxEventPtr, evt)
			Case wxEVT_SHEET_EDITOR_CREATED
				Return wxSheetEditorCreatedEvent.Create(wxEventPtr, evt)
			Case wxEVT_SHEET_SPLIT_BEGIN, ..
					wxEVT_SHEET_SPLIT_CHANGING, ..
					wxEVT_SHEET_SPLIT_CHANGED, ..
					wxEVT_SHEET_SPLIT_DOUBLECLICKED, ..
					wxEVT_SHEET_SPLIT_UNSPLIT, ..
					wxEVT_SHEET_SPLIT_CREATE_SHEET
				Return wxSheetSplitterEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_SHEET_VIEW_CHANGED, ..
					wxEVT_SHEET_SELECTING_CELL, ..
					wxEVT_SHEET_SELECTED_CELL, ..
					wxEVT_SHEET_CELL_LEFT_DOWN, ..
					wxEVT_SHEET_CELL_RIGHT_DOWN, ..
					wxEVT_SHEET_CELL_LEFT_UP, ..
					wxEVT_SHEET_CELL_RIGHT_UP, ..
					wxEVT_SHEET_CELL_LEFT_DCLICK, ..
					wxEVT_SHEET_CELL_RIGHT_DCLICK, ..
					wxEVT_SHEET_LABEL_LEFT_DOWN, ..
					wxEVT_SHEET_LABEL_RIGHT_DOWN, ..
					wxEVT_SHEET_LABEL_LEFT_UP, ..
					wxEVT_SHEET_LABEL_RIGHT_UP, ..
					wxEVT_SHEET_LABEL_LEFT_DCLICK, ..
					wxEVT_SHEET_LABEL_RIGHT_DCLICK, ..
					wxEVT_SHEET_CELL_VALUE_CHANGING, ..
					wxEVT_SHEET_CELL_VALUE_CHANGED, ..
					wxEVT_SHEET_EDITOR_ENABLED, ..
					wxEVT_SHEET_EDITOR_DISABLED, ..
					wxEVT_SHEET_ROW_SIZE, ..
					wxEVT_SHEET_ROW_SIZING, ..
					wxEVT_SHEET_ROW_SIZED, ..
					wxEVT_SHEET_COL_SIZE, ..
					wxEVT_SHEET_COL_SIZING, ..
					wxEVT_SHEET_COL_SIZED, ..
					wxEVT_SHEET_RANGE_SELECTING, ..
					wxEVT_SHEET_RANGE_SELECTED, ..
					wxEVT_SHEET_EDITOR_CREATED, ..
					wxEVT_SHEET_SPLIT_BEGIN, ..
					wxEVT_SHEET_SPLIT_CHANGING, ..
					wxEVT_SHEET_SPLIT_CHANGED, ..
					wxEVT_SHEET_SPLIT_DOUBLECLICKED, ..
					wxEVT_SHEET_SPLIT_UNSPLIT, ..
					wxEVT_SHEET_SPLIT_CREATE_SHEET
				Return bmx_wxsheet_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TSheetEventFactory

'?
