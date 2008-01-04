/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "wxglue.h"
#include "wx/sheet/sheet.h"
#include "wx/sheet/sheetspt.h"
#include "wx/sheet/sheetedt.h"
#include "wx/sheet/sheetren.h"
#include "../wxpen.mod/glue.h"

class MaxSheet;
class MaxSheetSplitter;
class MaxSheetCellEditor;
class MaxSheetCellRenderer;
class MaxSheetCellAttr;
class MaxSheetSelection;
class MaxSheetBlock;
class MaxSheetCellStringRendererRefData;

extern "C" {

#include <blitz.h>

	void _wx_wxsheet_wxSheetCellStringRendererRefData__Draw(BBObject * handle, wxSheet * sheet,
			MaxSheetCellAttr * attr, MaxDC * dc, MaxRect * rect, int row, int col, bool isSelected);

	MaxSheet * bmx_wxsheet_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	bool bmx_wxsheet_creategrid(wxSheet * sheet, int numRows, int numCols, int options);
	int bmx_wxsheet_getnumberrows(wxSheet * sheet);
	int bmx_wxsheet_getnumbercols(wxSheet * sheet);
	bool bmx_wxsheet_containscell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containsgridrow(wxSheet * sheet, int row);
	bool bmx_wxsheet_containsgridcol(wxSheet * sheet, int col);
	bool bmx_wxsheet_containsgridcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containsrowlabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_containscollabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_isgridcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_islabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_isrowlabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_iscollabelcell(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_iscornerlabelcell(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_clearvalues(wxSheet * sheet, int update);
	bool bmx_wxsheet_insertrows(wxSheet * sheet, int row, int numRows, int update);
	bool bmx_wxsheet_appendrows(wxSheet * sheet, int numRows, int update);
	bool bmx_wxsheet_deleterows(wxSheet * sheet, int row, int numRows, int update);
	bool bmx_wxsheet_insertcols(wxSheet * sheet, int col, int numCols, int update);
	bool bmx_wxsheet_appendcols(wxSheet * sheet, int numCols, int update);
	bool bmx_wxsheet_deletecols(wxSheet * sheet, int col, int numCols, int update);
	void bmx_wxsheet_setrowheight(wxSheet * sheet, int row, int height, bool ignoreMinSize);
	void bmx_wxsheet_setcolwidth(wxSheet * sheet, int col, int width, bool ignoreMinSize);
	int bmx_wxsheet_getrowheight(wxSheet * sheet, int row);
	int bmx_wxsheet_getrowtop(wxSheet * sheet, int row);
	int bmx_wxsheet_getrowbottom(wxSheet * sheet, int row);
	int bmx_wxsheet_getcolwidth(wxSheet * sheet, int col);
	int bmx_wxsheet_getcolleft(wxSheet * sheet, int col);
	int bmx_wxsheet_getcolright(wxSheet * sheet, int col);
	BBString * bmx_wxsheet_getcellvalue(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_setcellvalue(wxSheet * sheet, int row, int col, BBString * value);
	int bmx_wxsheet_hascellvalue(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_setattrrenderer(wxSheet * sheet, int row, int col, MaxSheetCellRenderer * renderer, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattreditor(wxSheet * sheet, int row, int col, MaxSheetCellEditor * editor, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrreadonly(wxSheet * sheet, int row, int col, bool isReadOnly, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrorientation(wxSheet * sheet, int row, int col, int orientation, wxSheetAttr_Type attrType);

	void bmx_wxsheet_setattrbackgroundcolour(wxSheet * sheet, int row, int col, MaxColour * colour, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrforegroundcolour(wxSheet * sheet, int row, int col, MaxColour * colour, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrfont(wxSheet * sheet, int row, int col, MaxFont * font, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattralignment(wxSheet * sheet, int row, int col, int align, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrlevel(wxSheet * sheet, int row, int col, int level, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattroverflow(wxSheet * sheet, int row, int col, bool allow, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattroverflowmarker(wxSheet * sheet, int row, int col, bool drawMarker, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattrshoweditor(wxSheet * sheet, int row, int col, bool showEditor, wxSheetAttr_Type attrType);
	MaxColour * bmx_wxsheet_getattrbackgroundcolour(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxColour * bmx_wxsheet_getattrforegroundcolour(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxFont * bmx_wxsheet_getattrfont(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattralignment(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattrorientation(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	int bmx_wxsheet_getattrlevel(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattroverflow(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattroverflowmarker(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattrshoweditor(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	bool bmx_wxsheet_getattrreadonly(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellRenderer * bmx_wxsheet_getattrrenderer(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellEditor * bmx_wxsheet_getattreditor(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setcolformatbool(wxSheet * sheet, int col);
	void bmx_wxsheet_setcolformatnumber(wxSheet * sheet, int col);
	void bmx_wxsheet_setcolformatfloat(wxSheet * sheet, int col, int width, int precision);
	void bmx_wxsheet_setcolformatcustom(wxSheet * sheet, int col, BBString * typeName);
	bool bmx_wxsheet_iscellvisible(wxSheet * sheet, int row, int col, bool wholeCellVisible);
	bool bmx_wxsheet_isrowvisible(wxSheet * sheet, int row, bool wholeRowVisible);
	bool bmx_wxsheet_iscolvisible(wxSheet * sheet, int col, bool wholeColVisible);
	void bmx_wxsheet_makecellvisible(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_getgridcursorcell(wxSheet * sheet, int * row, int * col);
	int bmx_wxsheet_getgridcursorrow(wxSheet * sheet);
	int bmx_wxsheet_getgridcursorcol(wxSheet * sheet);
	void bmx_wxsheet_setgridcursorcell(wxSheet * sheet, int row, int col);

	MaxSheetCellAttr * bmx_wxsheet_getrowlabelattr(wxSheet * sheet, int row);
	MaxSheetCellAttr * bmx_wxsheet_getcollabelattr(wxSheet * sheet, int col);
	MaxSheetCellAttr * bmx_wxsheet_getcornerlabelattr(wxSheet * sheet);
	MaxSheetCellAttr * bmx_wxsheet_getrowlabelcellattr(wxSheet * sheet, int row);
	MaxSheetCellAttr * bmx_wxsheet_getcollabelcellattr(wxSheet * sheet, int col);
	void bmx_wxsheet_setrowlabelcellattr(wxSheet * sheet, int row, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setcollabelcellattr(wxSheet * sheet, int col, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setcornerlabelattr(wxSheet * sheet, MaxSheetCellAttr * attr);
	MaxSheetCellAttr * bmx_wxsheet_getdefaultattr(wxSheet * sheet, int row, int col);
	MaxSheetCellAttr * bmx_wxsheet_getdefaultgridcellattr(wxSheet * sheet);
	MaxSheetCellAttr * bmx_wxsheet_getdefaultrowlabelattr(wxSheet * sheet);
	MaxSheetCellAttr * bmx_wxsheet_getdefaultcollabelattr(wxSheet * sheet);
	void bmx_wxsheet_setdefaultattr(wxSheet * sheet, int row, int col, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setdefaultgridcellattr(wxSheet * sheet, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setdefaultrowlabelattr(wxSheet * sheet, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setdefaultcollabelattr(wxSheet * sheet, MaxSheetCellAttr * attr);
	void bmx_wxsheet_getcellsize(wxSheet * sheet, int row, int col, int * w, int * h);
	bool bmx_wxsheet_iscellshown(wxSheet * sheet, int row, int col);
	void bmx_wxsheet_setmargins(wxSheet * sheet, int width, int height);
	int bmx_wxsheet_getrowbestheight(wxSheet * sheet, int row);
	int bmx_wxsheet_getcolbestwidth(wxSheet * sheet, int col);
	int bmx_wxsheet_getrowlabelwidth(wxSheet * sheet, bool zeroNotShown);
	int bmx_wxsheet_getcollabelheight(wxSheet * sheet, bool zeroNotShown);
	void bmx_wxsheet_setrowlabelwidth(wxSheet * sheet, int width);
	void bmx_wxsheet_setcollabelheight(wxSheet * sheet, int height);
	int bmx_wxsheet_autosizerow(wxSheet * sheet, int row, bool setAsMin);
	int bmx_wxsheet_autosizecol(wxSheet * sheet, int col, bool setAsMin);
	void bmx_wxsheet_autosizerows(wxSheet * sheet, bool setAsMin);
	void bmx_wxsheet_autosizecols(wxSheet * sheet, bool setAsMin);
	void bmx_wxsheet_autosize(wxSheet * sheet, bool setAsMin);
	void bmx_wxsheet_autosizerowlabelheight(wxSheet * sheet, int row);
	void bmx_wxsheet_autosizecollabelwidth(wxSheet * sheet, int col);
	void bmx_wxsheet_setequalcolwidths(wxSheet * sheet, int minWidth);
	BBString * bmx_wxsheet_getrowlabelvalue(wxSheet * sheet, int row);
	BBString * bmx_wxsheet_getcollabelvalue(wxSheet * sheet, int col);
	void bmx_wxsheet_setrowlabelvalue(wxSheet * sheet, int row, BBString * value);
	void bmx_wxsheet_setcollabelvalue(wxSheet * sheet, int col, BBString * value);
	BBString * bmx_wxsheet_getcornerlabelvalue(wxSheet * sheet);
	void bmx_wxsheet_setcornerlabelvalue(wxSheet * sheet, BBString * value);

	MaxSheetCellAttr * bmx_wxsheet_getorcreateattr(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	MaxSheetCellAttr * bmx_wxsheet_getattr(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	void bmx_wxsheet_setattr(wxSheet * sheet, int row, int col, MaxSheetCellAttr * attr, wxSheetAttr_Type attrType);
	MaxSheetCellAttr * bmx_wxsheet_getgridattr(wxSheet * sheet, int row, int col);
	MaxSheetCellAttr * bmx_wxsheet_getgridcellattr(wxSheet * sheet, int row, int col);
	MaxSheetCellAttr * bmx_wxsheet_getgridrowattr(wxSheet * sheet, int row);
	MaxSheetCellAttr * bmx_wxsheet_getgridcolattr(wxSheet * sheet, int col);
	void bmx_wxsheet_setgridcellattr(wxSheet * sheet, int row, int col, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setgridrowattr(wxSheet * sheet, int row, MaxSheetCellAttr * attr);
	void bmx_wxsheet_setgridcolattr(wxSheet * sheet, int col, MaxSheetCellAttr * attr);

	bool bmx_wxsheet_hasspannedcells(wxSheet * sheet);
	void bmx_wxsheet_getcellowner(wxSheet * sheet, int row, int col, int * ownerRow, int * ownerCol);
	void bmx_wxsheet_getcellblock(wxSheet * sheet, int row, int col, int * oRow, int * oCol, int * oWidth, int * oHeight);
	void bmx_wxsheet_getcellspan(wxSheet * sheet, int row, int col, int * rowSpan, int * colSpan);
	void bmx_wxsheet_setcellspan(wxSheet * sheet, int row, int col, int rows, int cols);

	int bmx_wxsheet_isareaeditable(wxSheet * sheet, int cellType);
	int bmx_wxsheet_getareaeditable(wxSheet * sheet);
	void bmx_wxsheet_setareaeditable(wxSheet * sheet, int cellType);
	void bmx_wxsheet_enabledragrowsize(wxSheet * sheet, bool enable);
	void bmx_wxsheet_enabledragcolsize(wxSheet * sheet, bool enable);
	void bmx_wxsheet_enabledraggridsize(wxSheet * sheet, bool enable);
	void bmx_wxsheet_disabledragrowsize(wxSheet * sheet);
	void bmx_wxsheet_disabledragcolsize(wxSheet * sheet);
	void bmx_wxsheet_disabledraggridsize(wxSheet * sheet);
	bool bmx_wxsheet_candragrowsize(wxSheet * sheet);
	bool bmx_wxsheet_candragcolsize(wxSheet * sheet);
	bool bmx_wxsheet_candraggridsize(wxSheet * sheet);
	void bmx_wxsheet_enablegridlines(wxSheet * sheet, int dir);
	int bmx_wxsheet_gridlinesenabled(wxSheet * sheet);
	MaxColour * bmx_wxsheet_getgridlinecolour(wxSheet * sheet);
	void bmx_wxsheet_setgridlinecolour(wxSheet * sheet, MaxColour * colour);
	MaxSheetSelection * bmx_wxsheet_getselection(wxSheet * sheet);

	void bmx_wxsheet_adjustscrollbars(wxSheet * sheet, bool calcWinSizes);
	int bmx_wxsheet_getscrollbarmode(wxSheet * sheet);
	void bmx_wxsheet_setscrollbarmode(wxSheet * sheet, int mode);
	void bmx_wxsheet_sethorizontalscrollbarmode(wxSheet * sheet, int mode);
	void bmx_wxsheet_setverticalscrollbarmode(wxSheet * sheet, int mode);
	int bmx_wxsheet_needsverticalscrollbar(wxSheet * sheet);
	int bmx_wxsheet_needshorizontalscrollbar(wxSheet * sheet);

	void bmx_wxsheet_refreshcell(wxSheet * sheet, int row, int col, bool singleCell);
	void bmx_wxsheet_refreshblock(wxSheet * sheet, MaxSheetBlock * block);
	void bmx_wxsheet_refreshrow(wxSheet * sheet, int row);
	void bmx_wxsheet_refreshcol(wxSheet * sheet, int col);
	void bmx_wxsheet_refreshgridcellblock(wxSheet * sheet, MaxSheetBlock * block);
	void bmx_wxsheet_refreshattrchange(wxSheet * sheet, int row, int col, wxSheetAttr_Type attrType);
	void bmx_wxsheet_refreshsheet(wxSheet * sheet, bool eraseb, MaxRect * rect);

	bool bmx_wxsheet_hasselection(wxSheet * sheet, bool selecting);
	bool bmx_wxsheet_iscellselected(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_isrowselected(wxSheet * sheet, int row);
	bool bmx_wxsheet_iscolselected(wxSheet * sheet, int col);
	bool bmx_wxsheet_isblockselected(wxSheet * sheet, MaxSheetBlock * block);
	bool bmx_wxsheet_isselecting(wxSheet * sheet);
	void bmx_wxsheet_setselectionmode(wxSheet * sheet, wxSheetSelectionMode_Type selmode);
	int bmx_wxsheet_getselectionmode(wxSheet * sheet);
	bool bmx_wxsheet_hasselectionmode(wxSheet * sheet, int mode);
	void bmx_wxsheet_beginbatch(wxSheet * sheet);
	void bmx_wxsheet_endbatch(wxSheet * sheet, bool refresh);
	int bmx_wxsheet_getbatchcount(wxSheet * sheet);
	void bmx_wxsheet_forcerefresh(wxSheet * sheet);

	MaxSheetBlock * bmx_wxsheet_fixselectionblock(wxSheet * sheet, MaxSheetBlock * block, int selMode);
	bool bmx_wxsheet_selectrow(wxSheet * sheet, int row, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectrows(wxSheet * sheet, int rowTop, int rowBottom, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectCol(wxSheet * sheet, int col, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectcols(wxSheet * sheet, int colLeft, int colRight, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectcell(wxSheet * sheet, int row, int col, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectblock(wxSheet * sheet, MaxSheetBlock * block, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_selectall(wxSheet * sheet, bool sendEvt);
	bool bmx_wxsheet_deselectrow(wxSheet * sheet, int row, bool sendEvt);
	bool bmx_wxsheet_deselectrows(wxSheet * sheet, int rowTop, int rowBottom, bool sendEvt);
	bool bmx_wxsheet_deselectcol(wxSheet * sheet, int col, bool sendEvt);
	bool bmx_wxsheet_deselectcols(wxSheet * sheet, int colLeft, int colRight, bool sendEvt);
	bool bmx_wxsheet_deselectcell(wxSheet * sheet, int row, int col, bool sendEvt);
	bool bmx_wxsheet_deselectblock(wxSheet * sheet, MaxSheetBlock * block, bool sendEvt);
	bool bmx_wxsheet_clearselection(wxSheet * sheet, bool sendEvt);
	bool bmx_wxsheet_togglecellselection(wxSheet * sheet, int row, int col, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_togglerowselection(wxSheet * sheet, int row, bool addToSelected, bool sendEvt);
	bool bmx_wxsheet_togglecolselection(wxSheet * sheet, int col, bool addToSelected, bool sendEvt);

	MaxPen * bmx_wxsheet_getcursorcellhighlightpen(wxSheet * sheet);
	MaxPen * bmx_wxsheet_getcursorcellhighlightropen(wxSheet * sheet);
	void bmx_wxsheet_setcursorcellhighlightpen(wxSheet * sheet, MaxPen * pen);
	void bmx_wxsheet_setcursorcellhighlightreopen(wxSheet * sheet, MaxPen * pen);
	MaxColour * bmx_wxsheet_getlabeloutlinecolour(wxSheet * sheet);
	void bmx_wxsheet_setlabeloutlinecolour(wxSheet * sheet, MaxColour * colour);
	MaxColour * bmx_wxsheet_getselectionbackground(wxSheet * sheet);
	MaxColour * bmx_wxsheet_getselectionforeground(wxSheet * sheet);
	void bmx_wxsheet_setselectionbackground(wxSheet * sheet, MaxColour * colour);
	void bmx_wxsheet_setselectionforeground(wxSheet * sheet, MaxColour * colour);

	bool bmx_wxsheet_hasfocus(wxSheet * sheet);
	bool bmx_wxsheet_copycurrentselectiontoclipboard(wxSheet * sheet, bool copyCursor, BBString * colSep);
	bool bmx_wxsheet_copycurrentselectiontointernalselection(wxSheet * sheet, bool copyCursor);
	bool bmx_wxsheet_copyinternalselectiontoclipboard(wxSheet * sheet, BBString * colSep);
	BBString * bmx_wxsheet_copyinternalselectiontostring(wxSheet * sheet, BBString * colSep);
	bool bmx_wxsheet_copystringtointernalselection(wxSheet * sheet, BBString * value, BBString * colSep);
	bool bmx_wxsheet_pastefromclipboard(wxSheet * sheet, int row, int col, BBString * colSep);
	bool bmx_wxsheet_pasteinternalcopiedselection(wxSheet * sheet, int row, int col);
	bool bmx_wxsheet_currentlypasting(wxSheet * sheet);

	MaxSheetCellEditor * bmx_wxsheet_getdefaulteditorfortype(wxSheet * sheet, BBString * typeName);
	MaxSheetCellRenderer * bmx_wxsheet_getdefaultrendererfortype(wxSheet * sheet, BBString * typeName);

	bool bmx_wxsheet_setnumberrows(wxSheet * sheet, int rows, bool update);
	bool bmx_wxsheet_setnumbercols(wxSheet * sheet, int cols, bool update);
	bool bmx_wxsheet_setnumbercells(wxSheet * sheet, int rows, int cols, bool update);
	int bmx_wxsheet_getdefaultrowheight(wxSheet * sheet);
	int bmx_wxsheet_getdefaultcolwidth(wxSheet * sheet);
	void bmx_wxsheet_setdefaultrowheight(wxSheet * sheet, int height, bool resizeExistingRows);
	void bmx_wxsheet_setdefaultcolwidth(wxSheet * sheet, int width, bool resizeExistingCols);
	int bmx_wxsheet_getminimalacceptablerowheight(wxSheet * sheet);
	int bmx_wxsheet_getminimalacceptablecolwidth(wxSheet * sheet);
	void bmx_wxsheet_setminimalacceptablerowheight(wxSheet * sheet, int height);
	void bmx_wxsheet_setminimalacceptablecolwidth(wxSheet * sheet, int width);
	int bmx_wxsheet_getminimalrowheight(wxSheet * sheet, int row);
	int bmx_wxsheet_getminimalcolwidth(wxSheet * sheet, int col);
	void bmx_wxsheet_setminimalrowheight(wxSheet * sheet, int row, int height);
	void bmx_wxsheet_setminimalcolwidth(wxSheet * sheet, int col, int width);

	int bmx_wxsheetselection_getnumberrows(MaxSheetSelection * selection);
	int bmx_wxsheetselection_getnumbercols(MaxSheetSelection * selection);
	int bmx_wxsheetselection_getoptions(MaxSheetSelection * selection);
	void bmx_wxsheetselection_setoptions(MaxSheetSelection * selection, int options);
	bool bmx_wxsheetselection_hasselection(MaxSheetSelection * selection);
	int bmx_wxsheetselection_getcount(MaxSheetSelection * selection);
	bool bmx_wxsheetselection_isminimized(MaxSheetSelection * selection);
	int bmx_wxsheetselection_clear(MaxSheetSelection * selection);
	int bmx_wxsheetselection_empty(MaxSheetSelection * selection);
	MaxSheetBlock * bmx_wxsheetselection_getblock(MaxSheetSelection * selection, int index);
	void bmx_wxsheetselection_delete(MaxSheetSelection * selection);

	void bmx_wxsheetblock_delete(MaxSheetBlock * block);
	MaxSheetBlock * bmx_wxsheetblock_create(int row, int col, int height, int width);
	int bmx_wxsheetblock_getleft(MaxSheetBlock * block);
	int bmx_wxsheetblock_getright(MaxSheetBlock * block);
	int bmx_wxsheetblock_gettop(MaxSheetBlock * block);
	int bmx_wxsheetblock_getbottom(MaxSheetBlock * block);
	int bmx_wxsheetblock_getwidth(MaxSheetBlock * block);
	int bmx_wxsheetblock_getheight(MaxSheetBlock * block);

	MaxSheetSplitter * bmx_wxsheetsplitter_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	void bmx_wxsheetsplitter_initialize(wxSheetSplitter * splitter, wxSheet * sheet);


	void bmx_wxsheettable_setview(wxSheetTable * table, wxSheet * sheet);
	int bmx_wxsheettable_getnumberrows(wxSheetTable * table);
	int bmx_wxsheettable_getnumbercols(wxSheetTable * table);
	bool bmx_wxsheettable_containsgridrow(wxSheetTable * table, int row);
	bool bmx_wxsheettable_containsgridcol(wxSheetTable * table, int col);
	bool bmx_wxsheettable_containsgridcell(wxSheetTable * table, int row, int col);
	BBString * bmx_wxsheettable_getvalue(wxSheetTable * table, int row, int col);
	void bmx_wxsheettable_setvalue(wxSheetTable * table, int row, int col, BBString * value);
	bool bmx_wxsheettable_hasvalue(wxSheetTable * table, int row, int col);
	int bmx_wxsheettable_getfirstnonemptycoltoleft(wxSheetTable * table, int row, int col);
	void bmx_wxsheettable_clearvalues(wxSheetTable * table, int update);
	BBString * bmx_wxsheettable_getdefaultrowlabelvalue(wxSheetTable * table, int row);
	BBString * bmx_wxsheettable_getdefaultcollabelvalue(wxSheetTable * table, int col);
	long bmx_wxsheettable_getvalueasint(wxSheetTable * table, int row, int col);
	double bmx_wxsheettable_getvalueasdouble(wxSheetTable * table, int row, int col);
	bool bmx_wxsheettable_getvalueasbool(wxSheetTable * table, int row, int col);


	MaxSheetCellEditor * bmx_wxsheetcelleditor_create(wxSheetCellEditorRefData * data);
	void bmx_wxsheetcelleditor_delete(MaxSheetCellEditor * editor);

	wxSheetCellAutoWrapStringEditorRefData * bmx_wxsheetcellautowrapstringeditorrefdata_create();

	MaxSheetCellRenderer * bmx_wxsheetcellrenderer_create(wxSheetCellRendererRefData * data);
	void bmx_wxsheetcellrenderer_delete(MaxSheetCellRenderer * renderer);
	
	wxSheetCellAutoWrapStringRendererRefData * bmx_wxsheetcellautowrapstringrendererrefdata_create();
	wxSheetCellTextEditorRefData * bmx_wxsheetcelltexteditorrefdata_create();
	wxSheetCellNumberEditorRefData * bmx_wxsheetcellnumbereditorrefdata_create(int minimum, int maximum);
	wxSheetCellFloatEditorRefData * bmx_wxsheetcellfloateditorrefdata_create(int width, int precision);
	wxSheetCellChoiceEditorRefData * bmx_wxsheetcellchoiceeditorrefdata_create(BBArray * choices, bool allowOthers);
	wxSheetCellBoolEditorRefData * bmx_wxsheetcellbooleditorrefdata_create();
	wxSheetCellEnumEditorRefData * bmx_wxsheetcellenumeditorrefdata_create(BBString * choices);
	MaxSheetCellStringRendererRefData * bmx_wxsheetcellstringrendererrefdata_create(BBObject * handle);
	wxSheetCellNumberRendererRefData * bmx_wxsheetcellnumberrendererrefdata_create();
	wxSheetCellFloatRendererRefData * bmx_wxsheetcellfloatrendererrefdata_create(int width, int precision);
	wxSheetCellBoolRendererRefData * bmx_wxsheetcellboolrendererrefdata_create();
	wxSheetCellEnumRendererRefData * bmx_wxsheetcellenumrendererrefdata_create(BBString * choices);
	wxSheetCellBitmapRendererRefData * bmx_wxsheetcellbitmaprendererrefdata_create(MaxBitmap * bitmap, int align);


	void bmx_wxsheetcellstringrendererrefdata_draw(MaxSheetCellStringRendererRefData * data,
		wxSheet * sheet, MaxSheetCellAttr * attr, MaxDC * dc, MaxRect * rect, int row, int col, bool isSelected);

	MaxSheetCellAttr * bmx_wxsheetcellattr_create(bool createData);
	void bmx_wxsheetcellattr_setforegroundcolour(MaxSheetCellAttr * attr, MaxColour * colour);
	void bmx_wxsheetcellattr_setbackgroundcolour(MaxSheetCellAttr * attr, MaxColour * colour);
	void bmx_wxsheetcellattr_setfont(MaxSheetCellAttr * attr, MaxFont * font);
	void bmx_wxsheetcellattr_setalignment(MaxSheetCellAttr * attr, int align);
	void bmx_wxsheetcellattr_setalignmenthv(MaxSheetCellAttr * attr, int horzAlign, int vertAlign);
	void bmx_wxsheetcellattr_setorientation(MaxSheetCellAttr * attr, int orientation);
	void bmx_wxsheetcellattr_setlevel(MaxSheetCellAttr * attr, wxSheetAttrLevel_Type level);
	void bmx_wxsheetcellattr_setoverflow(MaxSheetCellAttr * attr, bool allow);
	void bmx_wxsheetcellattr_setoverflowmarker(MaxSheetCellAttr * attr, bool drawMarker);
	void bmx_wxsheetcellattr_setshoweditor(MaxSheetCellAttr * attr, bool showEditor);
	void bmx_wxsheetcellattr_setreadonly(MaxSheetCellAttr * attr, bool isReadOnly);
	void bmx_wxsheetcellattr_setrenderer(MaxSheetCellAttr * attr, MaxSheetCellRenderer * renderer);
	void bmx_wxsheetcellattr_seteditor(MaxSheetCellAttr * attr, MaxSheetCellEditor * editor);
	void bmx_wxsheetcellattr_setkind(MaxSheetCellAttr * attr, wxSheetAttr_Type kind);
	bool bmx_wxsheetcellattr_hasforegroundcolour(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasbackgroundcolour(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasfont(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasalignment(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasorientation(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_haslevel(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasoverflowmode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasoverflowmarkermode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasshoweditormode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasreadwritemode(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasrenderer(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_haseditor(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_hasdefaultattr(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_iscomplete(MaxSheetCellAttr * attr);
	MaxColour * bmx_wxsheetcellattr_getforegroundcolour(MaxSheetCellAttr * attr);
	MaxColour * bmx_wxsheetcellattr_getbackgroundcolour(MaxSheetCellAttr * attr);
	MaxFont * bmx_wxsheetcellattr_getfont(MaxSheetCellAttr * attr);
	int bmx_wxsheetcellattr_getalignment(MaxSheetCellAttr * attr);
	wxOrientation bmx_wxsheetcellattr_getorientation(MaxSheetCellAttr * attr);
	wxSheetAttrLevel_Type bmx_wxsheetcellattr_getlevel(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getoverflow(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getoverflowmarker(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getshoweditor(MaxSheetCellAttr * attr);
	bool bmx_wxsheetcellattr_getreadonly(MaxSheetCellAttr * attr);
	MaxSheetCellRenderer * bmx_wxsheetcellattr_getrenderer(MaxSheetCellAttr * attr, wxSheet * sheet, int row, int col);
	MaxSheetCellEditor * bmx_wxsheetcellattr_geteditor(MaxSheetCellAttr * attr, wxSheet * sheet, int row, int col);
	wxSheetAttr_Type bmx_wxsheetcellattr_getkind(MaxSheetCellAttr * attr);
	void bmx_wxsheetcellattr_delete(MaxSheetCellAttr * attr);

	int bmx_wxsheetevent_getrow(wxSheetEvent & event);
	int bmx_wxsheetevent_getcol(wxSheetEvent & event);
	void bmx_wxsheetevent_getcoords(wxSheetEvent & event, int * row, int * col);
	bool bmx_wxsheetevent_selecting(wxSheetEvent & event);
	bool bmx_wxsheetevent_controldown(wxSheetEvent & event);
	bool bmx_wxsheetevent_shiftdown(wxSheetEvent & event);
	bool bmx_wxsheetevent_altdown(wxSheetEvent & event);
	bool bmx_wxsheetevent_metadown(wxSheetEvent & event);
	void bmx_wxsheetevent_getposition(wxSheetEvent & event, int * x, int * y);
	void bmx_wxsheetevent_getscrolledposition(wxSheetEvent & event, int * x, int * y);
	wxWindow * bmx_wxsheetevent_geteventwindow(wxSheetEvent & event);

	int bmx_wxsheetsplitterevent_getsashposition(wxSheetSplitterEvent & event);
	void bmx_wxsheetsplitterevent_setsashposition(wxSheetSplitterEvent & event, int pos);
	int bmx_wxsheetsplitterevent_getsplitmode(wxSheetSplitterEvent & event);
	bool bmx_wxsheetsplitterevent_isverticalsplit(wxSheetSplitterEvent & event);
	wxSheet * bmx_wxsheetsplitterevent_getsheet(wxSheetSplitterEvent & event);
	wxSheetSplitter * bmx_wxsheetsplitterevent_getsheetsplitter(wxSheetSplitterEvent & event);

	void bmx_wxsheeteditorcreatedevent_getcoords(wxSheetEditorCreatedEvent & event, int * row, int * col);
	wxWindow * bmx_wxsheeteditorcreatedevent_getcontrol(wxSheetEditorCreatedEvent & event);
	void bmx_wxsheeteditorcreatedevent_setcoords(wxSheetEditorCreatedEvent & event, int row, int col);
	void bmx_wxsheeteditorcreatedevent_setcontrol(wxSheetEditorCreatedEvent & event, wxWindow * control);
	
	MaxSheetBlock * bmx_wxsheetrangeselectevent_getblock(wxSheetRangeSelectEvent & event);
	bool bmx_wxsheetrangeselectevent_getaddtoselection(wxSheetRangeSelectEvent & event);
	void bmx_wxsheetrangeselectevent_setblock(wxSheetRangeSelectEvent & event, MaxSheetBlock * block);

	int bmx_wxsheetcellsizeevent_getsize(wxSheetCellSizeEvent & event);

	int bmx_wxsheet_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSheet : public wxSheet
{
public:
	MaxSheet(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSheet();
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

class MaxSheetSplitter : public wxSheetSplitter
{
public:
	MaxSheetSplitter(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxSheetSplitter();
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};


class MaxSheetCellEditor
{
public:
	MaxSheetCellEditor(const wxSheetCellEditor & e);
	wxSheetCellEditor & Editor();

private:
	wxSheetCellEditor editor;

};

class MaxSheetCellRenderer
{
public:
	MaxSheetCellRenderer(const wxSheetCellRenderer & r);
	wxSheetCellRenderer & Renderer();

private:
	wxSheetCellRenderer renderer;

};

class MaxSheetCellAttr
{
public:
	MaxSheetCellAttr(const wxSheetCellAttr & a);
	wxSheetCellAttr & Attr();

private:
	wxSheetCellAttr attr;

};

class MaxSheetSelection
{
public:
	MaxSheetSelection(const wxSheetSelection & s);
	wxSheetSelection & Selection();

private:
	wxSheetSelection selection;

};

class MaxSheetBlock
{
public:
	MaxSheetBlock(const wxSheetBlock & b);
	wxSheetBlock & Block();

private:
	wxSheetBlock block;

};

class MaxSheetCellStringRendererRefData : public wxSheetCellStringRendererRefData
{
public:
	MaxSheetCellStringRendererRefData() { }
	
	MaxSheetCellStringRendererRefData(BBObject * handle);
	~MaxSheetCellStringRendererRefData();
	
	// call this to call the super-class Draw() method
	void MaxDraw(wxSheet * sheet, MaxSheetCellAttr * attr, MaxDC * dc, MaxRect * rect,
		int row, int col, bool isSelected);
		
	virtual void Draw(wxSheet& sheet, const wxSheetCellAttr& attr, wxDC& dc, const wxRect& rect,
		const wxSheetCoords& coords, bool isSelected);

	bool Copy(const MaxSheetCellStringRendererRefData& other) {
		maxHandle = other.maxHandle;
		return wxSheetCellStringRendererRefData::Copy(other);
	}
	DECLARE_SHEETOBJREFDATA_COPY_CLASS(MaxSheetCellStringRendererRefData, wxSheetCellRendererRefData)
	
	BBObject * maxHandle;
};
