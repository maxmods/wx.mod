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

Import wx.wx
Import wx.wxWindow
Import wx.wxSplitterWindow
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "src/include/*.h"

Import "glue.cpp"

Import "src/sheet.cpp"
Import "src/sheetatr.cpp"
Import "src/sheetedg.cpp"
Import "src/sheetedt.cpp"
Import "src/sheetren.cpp"
Import "src/sheetsel.cpp"
Import "src/sheetspt.cpp"
Import "src/sheettbl.cpp"
Import "src/sheetval.cpp"

Extern

	Function bmx_wxsheet_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxsheet_creategrid:Int(handle:Byte Ptr, numRows:Int, numCols:Int, options:Int)
	Function bmx_wxsheet_getnumberrows:Int(handle:Byte Ptr)
	Function bmx_wxsheet_getnumbercols:Int(handle:Byte Ptr)
	Function bmx_wxsheet_containscell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_containsgridrow:Int(handle:Byte Ptr, row:Int)
	Function bmx_wxsheet_containsgridcol:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_containsgridcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_containsrowlabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_containscollabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_isgridcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_islabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_isrowlabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_iscollabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_iscornerlabelcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_clearvalues(handle:Byte Ptr, update:Int)
	Function bmx_wxsheet_insertrows:Int(handle:Byte Ptr, row:Int, numRows:Int, update:Int)
	Function bmx_wxsheet_appendrows:Int(handle:Byte Ptr, numRows:Int, update:Int)
	Function bmx_wxsheet_deleterows:Int(handle:Byte Ptr, row:Int, numRows:Int, update:Int)
	Function bmx_wxsheet_insertcols:Int(handle:Byte Ptr, col:Int, numCols:Int, update:Int)
	Function bmx_wxsheet_appendcols:Int(handle:Byte Ptr, numCols:Int, update:Int)
	Function bmx_wxsheet_deletecols:Int(handle:Byte Ptr, col:Int, numCols:Int, update:Int)
	Function bmx_wxsheet_setrowheight(handle:Byte Ptr, row:Int, height:Int, ignoreMinSize:Int)
	Function bmx_wxsheet_setcolwidth(handle:Byte Ptr, col:Int, width:Int, ignoreMinSize:Int)
	Function bmx_wxsheet_getrowheight:Int(handle:Byte Ptr, row:Int)
	Function bmx_wxsheet_getrowtop:Int(handle:Byte Ptr, row:Int)
	Function bmx_wxsheet_getrowbottom:Int(handle:Byte Ptr, row:Int)
	Function bmx_wxsheet_getcolwidth:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_getcolleft:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_getcolright:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_getcellvalue:String(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_setcellvalue(handle:Byte Ptr, row:Int, col:Int, value:String)
	Function bmx_wxsheet_hascellvalue:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_setattrrenderer(handle:Byte Ptr, row:Int, col:Int, renderer:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_setattreditor(handle:Byte Ptr, row:Int, col:Int, editor:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_setattrreadonly(handle:Byte Ptr, row:Int, col:Int, isReadOnly:Int, attrType:Int)
	Function bmx_wxsheet_setattrorientation(handle:Byte Ptr, row:Int, col:Int, orientation:Int, attrType:Int)
	
	Function bmx_wxsheet_setattrbackgroundcolour(handle:Byte Ptr, row:Int, col:Int, colour:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_setattrforegroundcolour(handle:Byte Ptr, row:Int, col:Int, colour:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_setattrfont(handle:Byte Ptr, row:Int, col:Int, font:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_setattralignment(handle:Byte Ptr, row:Int, col:Int, align:Int, attrType:Int)
	Function bmx_wxsheet_setattrlevel(handle:Byte Ptr, row:Int, col:Int, level:Int, attrType:Int)
	Function bmx_wxsheet_setattroverflow(handle:Byte Ptr, row:Int, col:Int, allow:Int, attrType:Int)
	Function bmx_wxsheet_setattroverflowmarker(handle:Byte Ptr, row:Int, col:Int, drawMarker:Int, attrType:Int)
	Function bmx_wxsheet_setattrshoweditor(handle:Byte Ptr, row:Int, col:Int, showEditor:Int, attrType:Int)
	Function bmx_wxsheet_getattrbackgroundcolour:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrforegroundcolour:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrfont:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattralignment:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrorientation:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrlevel:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattroverflow:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattroverflowmarker:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrshoweditor:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrreadonly:Int(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattrrenderer:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattreditor:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_setcolformatbool(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_setcolformatnumber(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_setcolformatfloat(handle:Byte Ptr, col:Int, width:Int, precision:Int)
	Function bmx_wxsheet_setcolformatcustom(handle:Byte Ptr, col:Int, typeName:String)
	Function bmx_wxsheet_iscellvisible:Int(handle:Byte Ptr, row:Int, col:Int, wholeCellVisible:Int)
	Function bmx_wxsheet_isrowvisible:Int(handle:Byte Ptr, row:Int, wholeRowVisible:Int)
	Function bmx_wxsheet_iscolvisible:Int(handle:Byte Ptr, col:Int, wholeColVisible:Int)
	Function bmx_wxsheet_makecellvisible(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_getgridcursorcell(handle:Byte Ptr, row:Int Ptr, col:Int Ptr)
	Function bmx_wxsheet_getgridcursorrow:Int(handle:Byte Ptr)
	Function bmx_wxsheet_getgridcursorcol:Int(handle:Byte Ptr)
	Function bmx_wxsheet_setgridcursorcell(handle:Byte Ptr, row:Int, col:Int)

	Function bmx_wxsheet_getorcreateattr:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_getattr:Byte Ptr(handle:Byte Ptr, row:Int, col:Int, attrType:Int)
	Function bmx_wxsheet_setattr(handle:Byte Ptr, row:Int, col:Int, attr:Byte Ptr, attrType:Int)
	Function bmx_wxsheet_getgridattr:Byte Ptr(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_getgridcellattr:Byte Ptr(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheet_getgridrowattr:Byte Ptr(handle:Byte Ptr, row:Int)
	Function bmx_wxsheet_getgridcolattr:Byte Ptr(handle:Byte Ptr, col:Int)
	Function bmx_wxsheet_setgridcellattr(handle:Byte Ptr, row:Int, col:Int, attr:Byte Ptr)
	Function bmx_wxsheet_setgridrowattr(handle:Byte Ptr, row:Int, attr:Byte Ptr)
	Function bmx_wxsheet_setgridcolattr(handle:Byte Ptr, col:Int, attr:Byte Ptr)

	Function bmx_wxsheet_hasspannedcells:Int(handle:Byte Ptr)
	Function bmx_wxsheet_getcellowner(handle:Byte Ptr, row:Int, col:Int, ownerRow:Int Ptr, ownerCol:Int Ptr)
	Function bmx_wxsheet_getcellblock(handle:Byte Ptr, row:Int, col:Int, oRow:Int Ptr, oCol:Int Ptr, oWidth:Int Ptr, oHeight:Int Ptr)
	Function bmx_wxsheet_getcellspan(handle:Byte Ptr, row:Int, col:Int, rowSpan:Int Ptr, colSpan:Int Ptr)
	Function bmx_wxsheet_setcellspan(handle:Byte Ptr, row:Int, col:Int, rows:Int, cols:Int)

	Function bmx_wxsheetsplitter_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxsheetsplitter_initialize(handle:Byte Ptr, sheet:Byte Ptr)


	Function bmx_wxsheettable_setview(handle:Byte Ptr, sheet:Byte Ptr)
	Function bmx_wxsheettable_getnumberrows:Int(handle:Byte Ptr)
	Function bmx_wxsheettable_getnumbercols:Int(handle:Byte Ptr)
	Function bmx_wxsheettable_containsgridrow:Int(handle:Byte Ptr, row:Int)
	Function bmx_wxsheettable_containsgridcol:Int(handle:Byte Ptr, col:Int)
	Function bmx_wxsheettable_containsgridcell:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_getvalue:String(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_setvalue(handle:Byte Ptr, row:Int, col:Int, value:String)
	Function bmx_wxsheettable_hasvalue:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_getfirstnonemptycoltoleft:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_clearvalues(handle:Byte Ptr, update:Int)
	Function bmx_wxsheettable_getdefaultrowlabelvalue:String(handle:Byte Ptr, row:Int)
	Function bmx_wxsheettable_getdefaultcollabelvalue:String(handle:Byte Ptr, col:Int)
	Function bmx_wxsheettable_getvalueasint:Int(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_getvalueasdouble:Double(handle:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheettable_getvalueasbool:Int(handle:Byte Ptr, row:Int, col:Int)


	Function bmx_wxsheetcelleditor_create:Byte Ptr(editor:Byte Ptr)
	Function bmx_wxsheetcelleditor_delete(handle:Byte Ptr)

	Function bmx_wxsheetcellautowrapstringeditorrefdata_create:Byte Ptr()

	Function bmx_wxsheetcellrenderer_create:Byte Ptr(renderer:Byte Ptr)
	Function bmx_wxsheetcellrenderer_delete(handle:Byte Ptr)
	
	Function bmx_wxsheetcellautowrapstringrendererrefdata_create:Byte Ptr()
	Function bmx_wxsheetcelltexteditorrefdata_create:Byte Ptr()
	Function bmx_wxsheetcellnumbereditorrefdata_create:Byte Ptr(minimum:Int, maximum:Int)
	Function bmx_wxsheetcellfloateditorrefdata_create:Byte Ptr(width:Int, precision:Int)
	Function bmx_wxsheetcellchoiceeditorrefdata_create:Byte Ptr(choices:String[], allowOthers:Int)
	Function bmx_wxsheetcellbooleditorrefdata_create:Byte Ptr()
	Function bmx_wxsheetcellenumeditorrefdata_create:Byte Ptr(choices:String)
	Function bmx_wxsheetcellstringrendererrefdata_create:Byte Ptr()
	Function bmx_wxsheetcellnumberrendererrefdata_create:Byte Ptr()
	Function bmx_wxsheetcellfloatrendererrefdata_create:Byte Ptr(width:Int, precision:Int)
	Function bmx_wxsheetcellboolrendererrefdata_create:Byte Ptr()
	Function bmx_wxsheetcellenumrendererrefdata_create:Byte Ptr(choices:String)


	Function bmx_wxsheetcellattr_create:Byte Ptr(createData:Int)
	Function bmx_wxsheetcellattr_setforegroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxsheetcellattr_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxsheetcellattr_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxsheetcellattr_setalignment(handle:Byte Ptr, align:Int)
	Function bmx_wxsheetcellattr_setalignmenthv(handle:Byte Ptr, horzAlign:Int, vertAlign:Int)
	Function bmx_wxsheetcellattr_setorientation(handle:Byte Ptr, orientation:Int)
	Function bmx_wxsheetcellattr_setlevel(handle:Byte Ptr, level:Int)
	Function bmx_wxsheetcellattr_setoverflow(handle:Byte Ptr, allow:Int)
	Function bmx_wxsheetcellattr_setoverflowmarker(handle:Byte Ptr, drawMarker:Int)
	Function bmx_wxsheetcellattr_setshoweditor(handle:Byte Ptr, showEditor:Int)
	Function bmx_wxsheetcellattr_setreadonly(handle:Byte Ptr, isReadOnly:Int)
	Function bmx_wxsheetcellattr_setrenderer(handle:Byte Ptr, renderer:Byte Ptr)
	Function bmx_wxsheetcellattr_seteditor(handle:Byte Ptr, editor:Byte Ptr)
	Function bmx_wxsheetcellattr_setkind(handle:Byte Ptr, kind:Int)
	Function bmx_wxsheetcellattr_hasforegroundcolour:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasbackgroundcolour:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasfont:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasalignment:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasorientation:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_haslevel:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasoverflowmode:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasoverflowmarkermode:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasshoweditormode:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasreadwritemode:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasrenderer:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_haseditor:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_hasdefaultattr:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_iscomplete:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getforegroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getalignment:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getorientation:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getlevel:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getoverflow:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getoverflowmarker:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getshoweditor:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getreadonly:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_getrenderer:Byte Ptr(handle:Byte Ptr, sheet:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheetcellattr_geteditor:Byte Ptr(handle:Byte Ptr, sheet:Byte Ptr, row:Int, col:Int)
	Function bmx_wxsheetcellattr_getkind:Int(handle:Byte Ptr)
	Function bmx_wxsheetcellattr_delete(handle:Byte Ptr)


End Extern


Const wxSHEET_VALUE_STRING:String = "string"
Const wxSHEET_VALUE_BOOL:String = "bool"
Const wxSHEET_VALUE_NUMBER:String = "long"
Const wxSHEET_VALUE_FLOAT:String = "double"
Const wxSHEET_VALUE_CHOICE:String = "choice"
Const wxSHEET_VALUE_CHOICEINT:String = "choiceint"
Const wxSHEET_VALUE_DATETIME:String = "datetime"
Const wxSHEET_VALUE_LABEL:String = "label"


Const wxSHEET_CELL_UNKNOWN:Int = $00 ' An invalid cell coords
Const wxSHEET_CELL_GRID:Int = $01 ' A grid cell      row >= 0  && col >= 0
Const wxSHEET_CELL_ROWLABEL:Int = $02 ' A row label cell row >= 0  && col == -1
Const wxSHEET_CELL_COLLABEL:Int = $04 ' A col label cell row == -1 && col >= 0
Const wxSHEET_CELL_CORNERLABEL:Int = $08 ' The corner label row == -1 && col == -1
Const wxSHEET_CELL_NONE:Int = $00 ' An invalid cell coords
Const wxSHEET_CELL_ANY:Int = $0F  ' Any cell

Const wxSHEET_SelectNone:Int = $0001  ' don't allow selections by mouse or keyboard
                                   ' direct calls To the selections work however
Const wxSHEET_SelectCells:Int = $0002  ' single cells, blocks, rows, And cols
Const wxSHEET_SelectRows:Int = $0004  ' only rows can be selected
Const wxSHEET_SelectCols:Int = $0008  ' only cols can be selected
Const wxSHEET_SelectSingle:Int = $0010  ' only single cell can be selected

Const wxSHEET_DragLabelRowHeight:Int = $0010  ' Mouse can resize row heights on label
Const wxSHEET_DragLabelColWidth:Int = $0020  ' Mouse can resize col widths on label
Const wxSHEET_DragLabelCellSize:Int = wxSHEET_DragLabelRowHeight|wxSHEET_DragLabelColWidth
 
Const wxSHEET_DragLabelRowWidth:Int = $0040  ' Mouse can resize row label width
Const wxSHEET_DragLabelColHeight:Int = $0080  ' Mouse can resize col label height
Const wxSHEET_DragLabelSize:Int = wxSHEET_DragLabelRowWidth|wxSHEET_DragLabelColHeight

Const wxSHEET_DragGridRowHeight:Int = $0100  ' Mouse can resize row heights on grid
Const wxSHEET_DragGridColWidth:Int = $0200  ' Mouse can resize col widths on grid
Const wxSHEET_DragGridCellSize:Int = wxSHEET_DragGridRowHeight|wxSHEET_DragGridColWidth

Const wxSHEET_DragCellSize:Int = wxSHEET_DragLabelCellSize|wxSHEET_DragGridCellSize
Const wxSHEET_DragSize:Int = wxSHEET_DragCellSize|wxSHEET_DragLabelSize

Const wxSHEET_UpdateNone:Int = $0000  ' update nothing

Const wxSHEET_UpdateGridCellValues:Int = $0001  ' update the grid cell data container
Const wxSHEET_UpdateRowLabelValues:Int = $0002  ' update the row label data container
Const wxSHEET_UpdateColLabelValues:Int = $0004  ' update the col label data container
Const wxSHEET_UpdateLabelValues:Int = wxSHEET_UpdateRowLabelValues|wxSHEET_UpdateColLabelValues  ' update the label containers
Const wxSHEET_UpdateValues:Int = wxSHEET_UpdateGridCellValues|wxSHEET_UpdateLabelValues

Const wxSHEET_UpdateSpanned:Int = $0008  ' update the spanned cells

Const wxSHEET_UpdateGridCellAttrs:Int = $0010  ' update grid cell attributes
Const wxSHEET_UpdateRowLabelAttrs:Int = $0020  ' update row label attributes
Const wxSHEET_UpdateColLabelAttrs:Int = $0040  ' update col label attributes
Const wxSHEET_UpdateLabelAttrs:Int = wxSHEET_UpdateRowLabelAttrs|wxSHEET_UpdateColLabelAttrs
Const wxSHEET_UpdateAttributes:Int = wxSHEET_UpdateGridCellAttrs|wxSHEET_UpdateLabelAttrs  ' update the attr container

Const wxSHEET_UpdateSelection:Int = $0100  ' update the selection

Const wxSHEET_UpdateAll:Int = wxSHEET_UpdateValues|wxSHEET_UpdateSpanned|wxSHEET_UpdateAttributes|wxSHEET_UpdateSelection
Const wxSHEET_UpdateType_Mask:Int = wxSHEET_UpdateAll


' A Default attr, used when no particular one is set, all areas have def attr
Const wxSHEET_AttrDefault:Int = $00010
' The attr For a single cell coords, applies To all areas
Const wxSHEET_AttrCell:Int = $00020
' The attr For a row of cells, only applies To the grid cells
'  Not label attrs, they only have Default Or single cell
Const wxSHEET_AttrRow:Int = $00040
' The attr For a col of cells, only applies To the grid cells
'  Not label attrs, they only have Default Or single cell
Const wxSHEET_AttrCol:Int = $00080
' Only For getting attrs, get an attr that May be merged from cell/row/col
'  attrs, If none of those Then resort To Default attr For area
'  this is the best choice For getting an attr since it's guaranteed to work
Const wxSHEET_AttrAny:Int = wxSHEET_AttrDefault|wxSHEET_AttrCell|wxSHEET_AttrRow|wxSHEET_AttrCol

Const wxSHEET_AttrType_Mask:Int = wxSHEET_AttrAny

Const wxSHEET_AttrOrientUnset:Int = 0
Const wxSHEET_AttrOrientHoriz:Int = wxHORIZONTAL ' 0x0004 Horizontally orientated
Const wxSHEET_AttrOrientVert:Int = wxVERTICAL   ' 0x0008 Vertically orientated
Const wxSHEET_AttrOrientType_Mask:Int = wxSHEET_AttrOrientHoriz | wxSHEET_AttrOrientVert

Const wxSHEET_AttrAlignHorizUnset:Int = $01000
Const wxSHEET_AttrAlignVertUnset:Int = $02000
Const wxSHEET_AttrAlignUnset:Int = wxSHEET_AttrAlignHorizUnset|wxSHEET_AttrAlignVertUnset

Const wxSHEET_AttrAlignCenterHoriz:Int = wxALIGN_CENTER_HORIZONTAL ' = 0x0100,
Const wxSHEET_AttrAlignLeft:Int = wxALIGN_LEFT              ' = wxALIGN_NOT,
Const wxSHEET_AttrAlignTop:Int = wxALIGN_TOP               ' = wxALIGN_NOT,
Const wxSHEET_AttrAlignRight:Int = wxALIGN_RIGHT             ' = 0x0200,
Const wxSHEET_AttrAlignBottom:Int = wxALIGN_BOTTOM            ' = 0x0400,
Const wxSHEET_AttrAlignCenterVert:Int = wxALIGN_CENTER_VERTICAL   ' = 0x0800,
Const wxSHEET_AttrAlignCenter:Int = wxALIGN_CENTER            ' = (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL),
Const wxSHEET_AttrAlignType_Mask:Int = wxALIGN_MASK|wxSHEET_AttrAlignUnset ' = 0x0f00

Const wxSHEET_AttrAlignHoriz_Mask:Int = wxALIGN_LEFT|wxALIGN_RIGHT|wxALIGN_CENTER_HORIZONTAL|wxSHEET_AttrAlignHorizUnset
Const wxSHEET_AttrAlignVert_Mask:Int = wxALIGN_TOP|wxALIGN_BOTTOM|wxALIGN_CENTER_VERTICAL|wxSHEET_AttrAlignVertUnset


Const wxEVT_SHEET_VIEW_CHANGED:Int = 15920
Const wxEVT_SHEET_SELECTING_CELL:Int = 15921
Const wxEVT_SHEET_SELECTED_CELL:Int = 15922
Const wxEVT_SHEET_CELL_LEFT_DOWN:Int = 15800
Const wxEVT_SHEET_CELL_RIGHT_DOWN:Int = 15810
Const wxEVT_SHEET_CELL_LEFT_UP:Int = 15801
Const wxEVT_SHEET_CELL_RIGHT_UP:Int = 15811
Const wxEVT_SHEET_CELL_LEFT_DCLICK:Int = 15820
Const wxEVT_SHEET_CELL_RIGHT_DCLICK:Int = 15830
Const wxEVT_SHEET_LABEL_LEFT_DOWN:Int = 15840
Const wxEVT_SHEET_LABEL_RIGHT_DOWN:Int = 15850
Const wxEVT_SHEET_LABEL_LEFT_UP:Int = 15841
Const wxEVT_SHEET_LABEL_RIGHT_UP:Int = 15851
Const wxEVT_SHEET_LABEL_LEFT_DCLICK:Int = 15860
Const wxEVT_SHEET_LABEL_RIGHT_DCLICK:Int = 15870
Const wxEVT_SHEET_ROW_SIZE:Int = 15880
Const wxEVT_SHEET_ROW_SIZING:Int = 15881
Const wxEVT_SHEET_ROW_SIZED:Int = 15882
Const wxEVT_SHEET_COL_SIZE:Int = 15890
Const wxEVT_SHEET_COL_SIZING:Int = 15891
Const wxEVT_SHEET_COL_SIZED:Int = 15892
Const wxEVT_SHEET_RANGE_SELECTING:Int = 15900
Const wxEVT_SHEET_RANGE_SELECTED:Int = 15901
Const wxEVT_SHEET_CELL_VALUE_CHANGING:Int = 15910
Const wxEVT_SHEET_CELL_VALUE_CHANGED:Int = 15911
Const wxEVT_SHEET_EDITOR_ENABLED:Int = 15930
Const wxEVT_SHEET_EDITOR_DISABLED:Int = 15940
Const wxEVT_SHEET_EDITOR_CREATED:Int = 15950
