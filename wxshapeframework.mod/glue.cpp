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

#include "glue.h"

// ---------------------------------------------------------------------------------------

MaxSFShapeCanvas::MaxSFShapeCanvas(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
{
	Create(parent, id, wxPoint(x, y), wxSize(w, h), style);
	wxbind(this, handle);
}

MaxSFShapeCanvas::MaxSFShapeCanvas()
{}

MaxSFShapeCanvas::~MaxSFShapeCanvas() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxSFDiagramManager::MaxSFDiagramManager(BBObject * handle)
{
	wxbind(this, handle);
}

MaxSFDiagramManager::~MaxSFDiagramManager() {
	wxunbind(this);
}


// *********************************************

void bmx_xsserializable_bind(xsSerializable * handle, BBObject * obj) {
	wxbind(handle, obj);
}

// *********************************************

// NOTE : make sure that these are ordered by SUBCLASS -> SUPERCLASS, or the wrong ones will be picked up first.
BBObject * newObjectForShape(wxSFShapeBase * shape) {

	if (!shape) {
		return &bbNullObject;
	}

	if (wxIsKindOf(shape, wxSFCurveShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFCurveShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFLineShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFLineShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFBitmapShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFBitmapShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFControlShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFControlShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFEllipseShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFEllipseShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFFlexGridShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFFlexGridShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFGridShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFGridShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFMultiSelRect)) {
		return CB_PREF(wx_wxshapeframework_wxSFMultiSelRect__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFDiamondShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFDiamondShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFPolygonShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFPolygonShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFRoundRectShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFRoundRectShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFCircleShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFCircleShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFSquareShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFSquareShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFEditTextShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFEditTextShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFTextShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFTextShape__find)(shape);
	}

	if (wxIsKindOf(shape, wxSFRectShape)) {
		return CB_PREF(wx_wxshapeframework_wxSFRectShape__find)(shape);
	}

}

// *********************************************


BEGIN_EVENT_TABLE(MaxSFShapeCanvas, wxSFShapeCanvas)
END_EVENT_TABLE()

wxSFShapeCanvas * bmx_wxsfshapecanvas_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style) {
	return new MaxSFShapeCanvas(maxHandle, parent, id, x, y, w, h, style);
}

void bmx_wxsfshapecanvas_addstyle(wxSFShapeCanvas * canvas, wxSFShapeCanvas::STYLE style) {
	canvas->AddStyle(style);
}

void bmx_wxsfshapecanvas_setdiagrammanager(wxSFShapeCanvas * canvas, wxSFDiagramManager * 	manager	) {
	canvas->SetDiagramManager(manager);
}

void bmx_wxsfshapecanvas_selectall(wxSFShapeCanvas * canvas) {
	canvas->SelectAll();
}

void bmx_wxsfshapecanvas_deselectall(wxSFShapeCanvas * canvas) {
	canvas->DeselectAll();
}

void bmx_wxsfshapecanvas_hideallhandles(wxSFShapeCanvas * canvas) {
	canvas->HideAllHandles();
}

void bmx_wxsfshapecanvas_copy(wxSFShapeCanvas * canvas) {
	canvas->Copy();
}

void bmx_wxsfshapecanvas_cut(wxSFShapeCanvas * canvas) {
	canvas->Cut();
}

void bmx_wxsfshapecanvas_paste(wxSFShapeCanvas * canvas) {
	canvas->Paste();
}

void bmx_wxsfshapecanvas_undo(wxSFShapeCanvas * canvas) {
	canvas->Undo();
}

void bmx_wxsfshapecanvas_redo(wxSFShapeCanvas * canvas) {
	canvas->Redo();
}

int bmx_wxsfshapecanvas_cancopy(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanCopy());
}

int bmx_wxsfshapecanvas_cancut(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanCut());
}

int bmx_wxsfshapecanvas_canpaste(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanPaste());
}

int bmx_wxsfshapecanvas_canundo(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanUndo());
}

int bmx_wxsfshapecanvas_canredo(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanRedo());
}

int bmx_wxsfshapecanvas_canalignselected(wxSFShapeCanvas * canvas) {
	return static_cast<int>(canvas->CanAlignSelected());
}

void bmx_wxsfshapecanvas_savecanvasstate(wxSFShapeCanvas * canvas) {
	canvas->SaveCanvasState();
}

void bmx_wxsfshapecanvas_clearcanvashistory(wxSFShapeCanvas * canvas) {
	canvas->ClearCanvasHistory();
}

void bmx_wxsfshapecanvas_printpreview(wxSFShapeCanvas * canvas) {
	canvas->PrintPreview();
}

void bmx_wxsfshapecanvas_pagesetup(wxSFShapeCanvas * canvas) {
	canvas->PageSetup();
}


// *********************************************

wxSFDiagramManager * bmx_wxsfdiagrammanager_create(BBObject * handle) {
	return new MaxSFDiagramManager(handle);
}

BBObject * bmx_wxsfdiagrammanager_addshape(wxSFDiagramManager * manager, BBString * shapeInfo, int xPos, int yPos, int saveState) {
	if (xPos >= 0 || yPos >= 0) {
		return newObjectForShape(manager->AddShape(wxClassInfo::FindClass(wxStringFromBBString(shapeInfo).c_str()), wxPoint(xPos, yPos), static_cast<bool>(saveState)));
	} else {
		return newObjectForShape(manager->AddShape(wxClassInfo::FindClass(wxStringFromBBString(shapeInfo).c_str()), static_cast<bool>(saveState)));
	}
}


void bmx_wxsfdiagrammanager_acceptshape(wxSFDiagramManager * manager, BBString * shapeType) {
	manager->AcceptShape(wxStringFromBBString(shapeType));
}

// *********************************************

void bmx_wxsfcontrolshape_setcontrol(wxSFControlShape * shape, wxWindow * ctrl, int fit) {
	shape->SetControl(ctrl, static_cast<bool>(fit));
}

wxWindow * bmx_wxsfcontrolshape_getcontrol(wxSFControlShape * shape) {
	return shape->GetControl();
}

void bmx_wxsfcontrolshape_seteventprocessing(wxSFControlShape * shape, int mask) {
	shape->SetEventProcessing(mask);
}

int bmx_wxsfcontrolshape_geteventprocessing(wxSFControlShape * shape) {
	return shape->GetEventProcessing();
}

void bmx_wxsfcontrolshape_setcontroloffset(wxSFControlShape * shape, int offset) {
	shape->SetControlOffset(offset);
}

int bmx_wxsfcontrolshape_getcontroloffset(wxSFControlShape * shape) {
	return shape->GetControlOffset();
}

// *********************************************

void bmx_wxsfshapebase_clearacceptedchilds(wxSFShapeBase * base) {
	base->ClearAcceptedChilds();
}

