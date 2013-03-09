/*
  Copyright (c) 2007-2013 Bruce A Henderson
 
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
#include "wx/wxsf/wxShapeFramework.h"

class MaxSFShapeCanvas;
class MaxSFDiagramManager;

extern "C" {

#include <blitz.h>

	BBObject * _wx_wxshapeframework_wxSFLineShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFCurveShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFRectShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFBitmapShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFControlShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFEllipseShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFFlexGridShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFGridShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFMultiSelRect__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFDiamondShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFPolygonShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFRoundRectShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFCircleShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFSquareShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFEditTextShape__find(wxSFShapeBase * shape);
	BBObject * _wx_wxshapeframework_wxSFTextShape__find(wxSFShapeBase * shape);

	void bmx_xsserializable_bind(xsSerializable * handle, BBObject * obj);

	wxSFShapeCanvas * bmx_wxsfshapecanvas_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	void bmx_wxsfshapecanvas_addstyle(wxSFShapeCanvas * canvas, wxSFShapeCanvas::STYLE style);
	void bmx_wxsfshapecanvas_setdiagrammanager(wxSFShapeCanvas * canvas, wxSFDiagramManager * 	manager	);
	void bmx_wxsfshapecanvas_selectall(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_deselectall(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_hideallhandles(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_copy(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_cut(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_paste(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_undo(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_redo(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_cancopy(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_cancut(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_canpaste(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_canundo(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_canredo(wxSFShapeCanvas * canvas);
	int bmx_wxsfshapecanvas_canalignselected(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_savecanvasstate(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_clearcanvashistory(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_printpreview(wxSFShapeCanvas * canvas);
	void bmx_wxsfshapecanvas_pagesetup(wxSFShapeCanvas * canvas);


	wxSFDiagramManager * bmx_wxsfdiagrammanager_create(BBObject * handle);
	BBObject * bmx_wxsfdiagrammanager_addshape(wxSFDiagramManager * manager, BBString * shapeInfo, int xPos, int yPos, int saveState);
	void bmx_wxsfdiagrammanager_acceptshape(wxSFDiagramManager * manager, BBString * shapeType);

	void bmx_wxsfcontrolshape_setcontrol(wxSFControlShape * shape, wxWindow * ctrl, int fit);
	wxWindow * bmx_wxsfcontrolshape_getcontrol(wxSFControlShape * shape);
	void bmx_wxsfcontrolshape_seteventprocessing(wxSFControlShape * shape, int mask);
	int bmx_wxsfcontrolshape_geteventprocessing(wxSFControlShape * shape);
	void bmx_wxsfcontrolshape_setcontroloffset(wxSFControlShape * shape, int offset);
	int bmx_wxsfcontrolshape_getcontroloffset(wxSFControlShape * shape);

	void bmx_wxsfshapebase_clearacceptedchilds(wxSFShapeBase * base);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSFShapeCanvas: public wxSFShapeCanvas
{
public:
	MaxSFShapeCanvas(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y,
		int w, int h, long style);
	MaxSFShapeCanvas();
	~ MaxSFShapeCanvas();

private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
	
};

class MaxSFDiagramManager: public wxSFDiagramManager
{
public:
	MaxSFDiagramManager(BBObject * handle);
	~MaxSFDiagramManager();
};

