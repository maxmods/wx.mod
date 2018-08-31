/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
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

MaxMpWindow::MaxMpWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long flags)
	: mpWindow(parent, id, wxPoint(x, y), wxSize(w, h), flags)
{
	wxbind(this, handle);
}

MaxMpWindow::~MaxMpWindow() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpFX::MaxMpFX(BBObject * handle, wxString name, int flags)
	: mpFX(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpFX::~MaxMpFX() {
	wxunbind(this);
}

double MaxMpFX::GetY(double x) {
	return CB_PREF(wx_wxmathplot_mpFX__GetY)(maxHandle, x);
}

double MaxMpFX::GetMinY() {
	return CB_PREF(wx_wxmathplot_mpFX__GetMinY)(maxHandle);
}

double MaxMpFX::GetMaxY() {
	return CB_PREF(wx_wxmathplot_mpFX__GetMaxY)(maxHandle);
}

// ---------------------------------------------------------------------------------------

MaxMpFY::MaxMpFY(BBObject * handle, wxString name, int flags)
	: mpFY(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpFY::~MaxMpFY() {
	wxunbind(this);
}

double MaxMpFY::GetX(double x) {
	return CB_PREF(wx_wxmathplot_mpFY__GetX)(maxHandle, x);
}

double MaxMpFY::GetMinX() {
	return CB_PREF(wx_wxmathplot_mpFY__GetMinX)(maxHandle);
}

double MaxMpFY::GetMaxX() {
	return CB_PREF(wx_wxmathplot_mpFY__GetMaxX)(maxHandle);
}

// ---------------------------------------------------------------------------------------

MaxMpFXY::MaxMpFXY(BBObject * handle, wxString name, int flags)
	: mpFXY(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpFXY::~MaxMpFXY() {
	wxunbind(this);
}

void MaxMpFXY::Rewind() {
	CB_PREF(wx_wxmathplot_mpFXY__Rewind)(maxHandle);
}

bool MaxMpFXY::GetNextXY(double &x, double &y) {
	return static_cast<bool>(CB_PREF(wx_wxmathplot_mpFXY__GetNextXY)(maxHandle, &x, &y));
}

double MaxMpFXY::GetMinX() {
	return CB_PREF(wx_wxmathplot_mpFXY__GetMinX)(maxHandle);
}

double MaxMpFXY::GetMaxX() {
	return CB_PREF(wx_wxmathplot_mpFXY__GetMaxX)(maxHandle);
}

double MaxMpFXY::GetMinY() {
	return CB_PREF(wx_wxmathplot_mpFXY__GetMinY)(maxHandle);
}

double MaxMpFXY::GetMaxY() {
	return CB_PREF(wx_wxmathplot_mpFXY__GetMaxY)(maxHandle);
}


// ---------------------------------------------------------------------------------------

MaxScaleX::MaxScaleX(BBObject * handle, wxString name, int flags, bool ticks, int type)
	: mpScaleX(name, flags, ticks, type), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxScaleX::~MaxScaleX() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxScaleY::MaxScaleY(BBObject * handle, wxString name, int flags, bool ticks)
	: mpScaleY(name, flags, ticks), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxScaleY::~MaxScaleY() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpPolygon::MaxMpPolygon(BBObject * handle, wxString name)
	: mpPolygon(name), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpPolygon::~MaxMpPolygon() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpCovarianceEllipse::MaxMpCovarianceEllipse(BBObject * handle, double cov00, double cov11, double cov01, double quantiles, int segments, wxString layerName)
	: mpCovarianceEllipse(cov00, cov11, cov01, quantiles, segments, layerName), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpCovarianceEllipse::~MaxMpCovarianceEllipse() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpBitmapLayer::MaxMpBitmapLayer(BBObject * handle)
	: mpBitmapLayer(), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpBitmapLayer::~MaxMpBitmapLayer() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpFXYVector::MaxMpFXYVector(BBObject * handle, wxString name, int flags)
	: mpFXYVector(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpFXYVector::~MaxMpFXYVector() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpText::MaxMpText(BBObject * handle, wxString name, int offsetx, int offsety)
	: mpText(name, offsetx, offsety), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpText::~MaxMpText() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpProfile::MaxMpProfile(BBObject * handle, wxString name, int flags)
	: mpProfile(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpProfile::~MaxMpProfile() {
	wxunbind(this);
}

double MaxMpProfile::GetY(double x) {
	return CB_PREF(wx_wxmathplot_mpProfile__GetY)(maxHandle, x);
}

// ---------------------------------------------------------------------------------------

MaxMpPrintout::MaxMpPrintout(BBObject * handle, mpWindow * window, wxString title)
	: mpPrintout(window, title), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpPrintout::~MaxMpPrintout() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpInfoCoords::MaxMpInfoCoords(BBObject * handle, int x, int y, int w, int h, const wxBrush * brush)
	: mpInfoCoords(wxRect(x, y, w, h), brush), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpInfoCoords::~MaxMpInfoCoords() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxMpInfoLegend::MaxMpInfoLegend(BBObject * handle, int x, int y, int w, int h, const wxBrush * brush)
	: mpInfoLegend(wxRect(x, y, w, h), brush), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxMpInfoLegend::~MaxMpInfoLegend() {
	wxunbind(this);
}

// *********************************************

BEGIN_EVENT_TABLE(MaxMpWindow, mpWindow)
END_EVENT_TABLE()

MaxMpWindow * bmx_mpwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int flags) {
	return new MaxMpWindow(maxHandle, parent, id, x, y, w, h, flags);
}

void bmx_mpwindow_fit(mpWindow * window) {
	window->Fit();
}

int bmx_mpwindow_addlayer(mpWindow * window, mpLayer * layer, int refreshDisplay) {
	return window->AddLayer(layer, refreshDisplay);
}

int bmx_mpwindow_dellayer(mpWindow * window, mpLayer * layer, int alsoDeleteObject, int refreshDisplay) {
	return static_cast<int>(window->DelLayer(layer, static_cast<bool>(alsoDeleteObject), static_cast<bool>(refreshDisplay)));
}

void bmx_mpwindow_delalllayers(mpWindow * window, int alsoDeleteObject, int refreshDisplay) {
	window->DelAllLayers(static_cast<bool>(alsoDeleteObject), static_cast<bool>(refreshDisplay));
}

mpLayer * bmx_mpwindow_getlayer(mpWindow * window, int position) {
	return window->GetLayer(position);
}

mpLayer * bmx_mpwindow_getlayerbyname(mpWindow * window, BBString * name) {
	return window->GetLayerByName(wxStringFromBBString(name));
}

void bmx_mpwindow_updateall(mpWindow * window) {
	window->UpdateAll();
}

double bmx_mpwindow_getscalex(mpWindow * window) {
	return window->GetScaleX();
}

double bmx_mpwindow_getscaley(mpWindow * window) {
	return window->GetScaleY();
}

double bmx_mpwindow_getposx(mpWindow * window) {
	return window->GetPosX();
}

double bmx_mpwindow_getposy(mpWindow * window) {
	return window->GetPosY();
}

int bmx_mpwindow_getxscreen(mpWindow * window) {
	return window->GetXScreen();
}

int bmx_mpwindow_getyscreen(mpWindow * window) {
	return window->GetYScreen();
}

void bmx_mpwindow_setscalex(mpWindow * window, double scale) {
	window->SetScaleX(scale);
}

void bmx_mpwindow_setscaley(mpWindow * window, double scale) {
	window->SetScaleY(scale);
}

void bmx_mpwindow_setposx(mpWindow * window, double pos) {
	window->SetPosX(pos);
}

void bmx_mpwindow_setposy(mpWindow * window, double pos) {
	window->SetPosY(pos);
}

void bmx_mpwindow_setpos(mpWindow * window, double x, double y) {
	window->SetPos(x, y);
}

void bmx_mpwindow_setscreen(mpWindow * window, int x, int y) {
	window->SetScr(x, y);
}

void bmx_mpwindow_enablemousepanzoom(mpWindow * window, int enabled) {
	window->EnableMousePanZoom(static_cast<bool>(enabled));
}

void bmx_mpwindow_lockaspect(mpWindow * window, int enable) {
	window->LockAspect(static_cast<bool>(enable));
}

int bmx_mpwindow_isaspectlocked(mpWindow * window) {
	return window->IsAspectLocked();
}

void bmx_mpwindow_fitbounds(mpWindow * window, double xMin, double xMax, double yMin, double yMax, int printSizeX, int printSizeY) {
	if (printSizeX < 0 || printSizeY < 0) {
		window->Fit(xMin, xMax, yMin, yMax, NULL, NULL);
	} else {
		wxCoord px(printSizeX);
		wxCoord py(printSizeY);
		window->Fit(xMin, xMax, yMin, yMax, &px, &py);
	}
}

void bmx_mpwindow_zoomin(mpWindow * window, int centerPointX, int centerPointY) {
	if (centerPointX < 0 || centerPointY < 0) {
		window->ZoomIn();
	} else {
		wxPoint p(centerPointX, centerPointY);
		window->ZoomIn(p);
	}
}

void bmx_mpwindow_zoomout(mpWindow * window, int centerPointX, int centerPointY) {
	if (centerPointX < 0 || centerPointY < 0) {
		window->ZoomOut();
	} else {
		wxPoint p(centerPointX, centerPointY);
		window->ZoomOut(p);
	}
}

void bmx_mpwindow_zoominx(mpWindow * window) {
	window->ZoomInX();
}

void bmx_mpwindow_zoomoutx(mpWindow * window) {
	window->ZoomOutX();
}

void bmx_mpwindow_zoominy(mpWindow * window) {
	window->ZoomInY();
}

void bmx_mpwindow_zoomouty(mpWindow * window) {
	window->ZoomOutY();
}

void bmx_mpwindow_zoomrect(mpWindow * window, int x0, int y0, int x1, int y1) {
	wxPoint p0(x0, y0);
	wxPoint p1(x1, y1);
	window->ZoomRect(p0, p1);
}

int bmx_mpwindow_countlayers(mpWindow * window) {
	return window->CountLayers();
}

int bmx_mpwindow_countalllayers(mpWindow * window) {
	return window->CountAllLayers();
}

double bmx_mpwindow_getdesiredxmin(mpWindow * window) {
	return window->GetDesiredXmin();
}

double bmx_mpwindow_getdesiredxmax(mpWindow * window) {
	return window->GetDesiredXmax();
}

double bmx_mpwindow_getdesiredymin(mpWindow * window) {
	return window->GetDesiredYmin();
}

double bmx_mpwindow_getdesiredymax(mpWindow * window) {
	return window->GetDesiredYmax();
}

void bmx_mpwindow_getboundingbox(mpWindow * window, double * bbox) {
	window->GetBoundingBox(bbox);
}

void bmx_mpwindow_setmpscrollbars(mpWindow * window, int status) {
	window->SetMPScrollbars(static_cast<bool>(status));
}

int bmx_mpwindow_getmpscrollbars(mpWindow * window) {
	return static_cast<int>(window->GetMPScrollbars());
}

void bmx_mpwindow_setmargins(mpWindow * window, int top, int right, int bottom, int left) {
	window->SetMargins(top, right, bottom, left);
}

void bmx_mpwindow_setmargintop(mpWindow * window, int value) {
	window->SetMarginTop(value);
}

void bmx_mpwindow_setmarginright(mpWindow * window, int value) {
	window->SetMarginRight(value);
}

void bmx_mpwindow_setmarginbottom(mpWindow * window, int value) {
	window->SetMarginBottom(value);
}

void bmx_mpwindow_setmarginleft(mpWindow * window, int value) {
	window->SetMarginLeft(value);
}

int bmx_mpwindow_getmargintop(mpWindow * window) {
	return window->GetMarginTop();
}

int bmx_mpwindow_getmarginright(mpWindow * window) {
	return window->GetMarginRight();
}

int bmx_mpwindow_getmarginbottom(mpWindow * window) {
	return window->GetMarginBottom();
}

int bmx_mpwindow_getmarginleft(mpWindow * window) {
	return window->GetMarginLeft();
}

mpInfoLayer * bmx_mpwindow_isinsideinfolayer(mpWindow * window, int x, int y) {
	wxPoint p(x, y);
	return window->IsInsideInfoLayer(p);
}

void bmx_mpwindow_setlayervisible(mpWindow * window, BBString * name, int viewable) {
	window->SetLayerVisible(wxStringFromBBString(name), static_cast<bool>(viewable));
}

int bmx_mpwindow_islayervisible(mpWindow * window, BBString * name) {
	return static_cast<int>(window->IsLayerVisible(wxStringFromBBString(name)));
}

void bmx_mpwindow_setlayervisiblepos(mpWindow * window, int position, int viewable) {
	window->SetLayerVisible(position, static_cast<bool>(viewable));
}

int bmx_mpwindow_islayervisiblepos(mpWindow * window, int position) {
	return static_cast<int>(window->IsLayerVisible(position));
}

void bmx_mpwindow_setcolourtheme(mpWindow * window, MaxColour * bgColour, MaxColour * drawColour, MaxColour * axesColour) {
	window->SetColourTheme(bgColour->Colour(), drawColour->Colour(), axesColour->Colour());
}

MaxColour * bmx_mpwindow_getaxescolour(mpWindow * window) {
	wxColour c(window->GetAxesColour());
	return new MaxColour(c);
}

// *********************************************

MaxMpFX * bmx_mpfx_create(BBObject * maxHandle, BBString * name, int flags) {
	return new MaxMpFX(maxHandle, wxStringFromBBString(name), flags);
}

// *********************************************

MaxScaleX * bmx_mpscalex_create(BBObject * maxHandle, BBString * name, int flags, int ticks, int type) {
	return new MaxScaleX(maxHandle, wxStringFromBBString(name), flags, ticks, type);
}

void bmx_mpscalex_setalign(mpScaleX * layer, int align) {
	layer->SetAlign(align);
}

void bmx_mpscalex_setticks(mpScaleX * layer, int ticks) {
	layer->SetTicks(ticks);
}

int bmx_mpscalex_getticks(mpScaleX * layer) {
	return layer->GetTicks();
}

int bmx_mpscalex_getlabelmode(mpScaleX * layer) {
	return layer->GetLabelMode();
}

void bmx_mpscalex_setlabelmode(mpScaleX * layer, int labelMode) {
	layer->SetLabelMode(labelMode);
}

void bmx_mpscalex_setlabelformat(mpScaleX * layer, BBString * format) {
	layer->SetLabelFormat(wxStringFromBBString(format));
}

BBString * bmx_mpscalex_getlabelformat(mpScaleX * layer) {
	return bbStringFromWxString(layer->SetLabelFormat());
}

// *********************************************

MaxScaleY * bmx_mpscaley_create(BBObject * maxHandle, BBString * name, int flags, int ticks) {
	return new MaxScaleY(maxHandle, wxStringFromBBString(name), flags, ticks);
}

void bmx_mpscaley_setalign(mpScaleY * layer, int align) {
	layer->SetAlign(align);
}

void bmx_mpscaley_setticks(mpScaleY * layer, int ticks) {
	layer->SetTicks(ticks);
}

int bmx_mpscaley_getticks(mpScaleY * layer) {
	return layer->GetTicks();
}

void bmx_mpscaley_setlabelformat(mpScaleY * layer, BBString * format) {
	layer->SetLabelFormat(wxStringFromBBString(format));
}

BBString * bmx_mpscaley_getlabelformat(mpScaleY * layer) {
	return bbStringFromWxString(layer->SetLabelFormat());
}

// *********************************************

MaxMpFY * bmx_mpfy_create(BBObject * maxHandle, BBString * name, int flags) {
	return new MaxMpFY(maxHandle, wxStringFromBBString(name), flags);
}

// *********************************************

MaxMpFXY * bmx_mpfxy_create(BBObject * maxHandle, BBString * name, int flags) {
	return new MaxMpFXY(maxHandle, wxStringFromBBString(name), flags);
}

// *********************************************

void bmx_mplayer_setname(mpLayer * layer, BBString * name) {
	layer->SetName(wxStringFromBBString(name));
}

void bmx_mplayer_setfont(mpLayer * layer, MaxFont * font) {
	layer->SetFont(font->Font());
}

void bmx_mplayer_setpen(mpLayer * layer, MaxPen * pen) {
	layer->SetPen(pen->Pen());
}

int bmx_mplayer_hasbbox(mpLayer * layer) {
	return static_cast<int>(layer->HasBBox());
}

int bmx_mplayer_isinfo(mpLayer * layer) {
	return static_cast<int>(layer->IsInfo());
}

double bmx_mplayer_getminx(mpLayer * layer) {
	return layer->GetMinX();
}

double bmx_mplayer_getmaxx(mpLayer * layer) {
	return layer->GetMaxX();
}

double bmx_mplayer_getminy(mpLayer * layer) {
	return layer->GetMinY();
}

double bmx_mplayer_getmaxy(mpLayer * layer) {
	return layer->GetMaxY();
}

BBString * bmx_mplayer_getname(mpLayer * layer) {
	return bbStringFromWxString(layer->GetName());
}

MaxFont *bmx_mplayer_getfont(mpLayer * layer) {
	wxFont f(layer->GetFont());
	return new MaxFont(f);
}

MaxPen * bmx_mplayer_getpen(mpLayer * layer) {
	wxPen p(layer->GetPen());
	return new MaxPen(p);
}

void bmx_mplayer_setdrawoutsidemargins(mpLayer * layer, int drawModeOutside) {
	layer->SetDrawOutsideMargins(static_cast<bool>(drawModeOutside));
}

int bmx_mplayer_getdrawoutsidemargins(mpLayer * layer) {
	return static_cast<int>(layer->GetDrawOutsideMargins());
}

MaxBitmap * bmx_mplayer_getcoloursquare(mpLayer * layer, int side) {
	return new MaxBitmap(layer->GetColourSquare(side));
}

int bmx_mplayer_getlayertype(mpLayer * layer) {
	return layer->GetLayerType();
}

int bmx_mplayer_isvisible(mpLayer * layer) {
	return static_cast<int>(layer->IsVisible());
}

void bmx_mplayer_setvisible(mpLayer * layer, int show) {
	layer->SetVisible(static_cast<bool>(show));
}

MaxBrush * bmx_mplayer_getbrush(mpLayer * layer) {
	wxBrush b(layer->GetBrush());
	return new MaxBrush(b);
}

void bmx_mplayer_setbrush(mpLayer * layer, MaxBrush * brush) {
	layer->SetBrush(brush->Brush());
}

void bmx_mplayer_setcontinuity(mpLayer * layer, int continuity) {
	layer->SetContinuity(static_cast<bool>(continuity));
}

int bmx_mplayer_getcontinuity(mpLayer * layer) {
	return static_cast<int>(layer->GetContinuity());
}

void bmx_mplayer_showname(mpLayer * layer, int show) {
	layer->ShowName(static_cast<bool>(show));
}

// *********************************************

MaxMpPolygon * bmx_mppolygon_create(BBObject * handle, BBString * name) {
	return new MaxMpPolygon(handle, wxStringFromBBString(name));
}

void bmx_mppolygon_setpoints(MaxMpPolygon * poly, BBArray * pointsXs, BBArray * pointsYs, int closedShape) {
	int n1 = pointsXs->scales[0];
	int n2 = pointsYs->scales[0];
	
	double * d1 = (double*)BBARRAYDATA( pointsXs, pointsXs->dims );
	double * d2 = (double*)BBARRAYDATA( pointsYs, pointsYs->dims );

	int n = n1;
	if (n > n2) {
		n = n2;
	}

	std::vector<double> v1(d1, d1 + n);
	std::vector<double> v2(d2, d2 + n);
	
	poly->setPoints(v1, v2, static_cast<bool>(closedShape));
}

// *********************************************

MaxMpCovarianceEllipse * bmx_mpcovarianceelipse_create(BBObject * handle, double cov00, double cov11, double cov01, double quantiles, int segments, BBString * layerName) {
	return new MaxMpCovarianceEllipse(handle, cov00, cov11, cov01, quantiles, segments, wxStringFromBBString(layerName));
}

double bmx_mpcovarianceelipse_getquantiles(mpCovarianceEllipse * ellipse) {
	return ellipse->GetQuantiles();
}

void bmx_mpcovarianceelipse_setquantiles(mpCovarianceEllipse * ellipse, double q) {
	ellipse->SetQuantiles(q);
}

void bmx_mpcovarianceelipse_setsegments(mpCovarianceEllipse * ellipse, int segments) {
	ellipse->SetSegments(segments);
}

int bmx_mpcovarianceelipse_getsegments(mpCovarianceEllipse * ellipse) {
	return ellipse->GetSegments();
}

void bmx_mpcovarianceelipse_setcovariancematrix(mpCovarianceEllipse * ellipse, double cov00, double cov01, double cov11) {
	ellipse->SetCovarianceMatrix(cov00, cov01, cov11);
}

// *********************************************

MaxMpBitmapLayer * bmx_mpbitmaplayer_create(BBObject * handle) {
	return new MaxMpBitmapLayer(handle);
}

MaxImage * bmx_mpbitmaplayer_getbitmapcopy(mpBitmapLayer * layer) {
	wxImage image;
	layer->GetBitmapCopy(image);
	return new MaxImage(image);
}

void bmx_mpbitmaplayer_setbitmap(mpBitmapLayer * layer, MaxImage * image, double x, double y, double w, double h) {
	layer->SetBitmap(image->Image(), x, y, w, h);
}

void bmx_mpbitmaplayer_setalign(mpBitmapLayer * layer, int align) {
	layer->SetAlign(align);
}

// *********************************************

void bmx_mpmovableobject_getcoordinatebase(mpMovableObject * layer, double * x, double * y, double * phi) {
	double tx, ty, tphi;
	layer->GetCoordinateBase(tx, ty, tphi);
	*x = tx;
	*y = ty;
	*phi = tphi;
}

void bmx_mpmovableobject_setcoordinatebase(mpMovableObject * layer, double x, double y, double phi) {
	layer->SetCoordinateBase(x, y, phi);
}

void bmx_mpmovableobject_setalign(mpMovableObject * layer, int align) {
	layer->SetAlign(align);
}

// *********************************************

MaxMpFXYVector * bmx_mpfxyvector_create(BBObject * handle, BBString * name, int flags) {
	return new MaxMpFXYVector(handle, wxStringFromBBString(name), flags);
}

void bmx_mpfxyvector_setdata(mpFXYVector * layer, BBArray * xs, BBArray * ys) {
	int n1 = xs->scales[0];
	int n2 = ys->scales[0];
	
	double * d1 = (double*)BBARRAYDATA( xs, xs->dims );
	double * d2 = (double*)BBARRAYDATA( ys, ys->dims );

	int n = n1;
	if (n > n2) {
		n = n2;
	}

	std::vector<double> v1(d1, d1 + n);
	std::vector<double> v2(d2, d2 + n);
	
	layer->SetData(v1, v2);
}

void bmx_mpfxyvector_setdataraw(mpFXYVector * layer, double * xs, double * ys, int length) {
	std::vector<double> v1(xs, xs + length);
	std::vector<double> v2(ys, ys + length);
	
	layer->SetData(v1, v2);
}

void bmx_mpfxyvector_clear(mpFXYVector * layer) {
	layer->Clear();
}

// *********************************************

MaxMpText * bmx_mptext_create(BBObject * handle, BBString * name, int offsetx, int offsety) {
	return new MaxMpText(handle, wxStringFromBBString(name), offsetx, offsety);
}

// *********************************************

MaxMpProfile * bmx_mpprofile_create(BBObject * handle, BBString * name, int flags) {
	return new MaxMpProfile(handle, wxStringFromBBString(name), flags);
}

// *********************************************

MaxMpPrintout * bmx_mpprintout_create(BBObject * handle, mpWindow * drawWindow, BBString * title) {
	return new MaxMpPrintout(handle, drawWindow, wxStringFromBBString(title));
}

// *********************************************

void bmx_mpinfolayer_getposition(mpInfoLayer * layer, int * x, int * y) {
	wxPoint p(layer->GetPosition());
	*x = p.x;
	*y = p.y;
}

void bmx_mpinfolayer_getsize(mpInfoLayer * layer, int * w, int * h) {
	wxSize s(layer->GetSize());
	*w = s.GetWidth();
	*h = s.GetHeight();
}

// *********************************************

MaxMpInfoCoords * bmx_mpinfocoords_create(BBObject * handle, int x, int y, int w, int h, MaxBrush * brush) {
	return new MaxMpInfoCoords(handle, x, y, w, h, brush != NULL ? &brush->Brush() : wxTRANSPARENT_BRUSH);
}

// *********************************************

MaxMpInfoLegend * bmx_mpinfolegend_create(BBObject * handle, int x, int y, int w, int h, MaxBrush * brush) {
	return new MaxMpInfoLegend(handle, x, y, w, h, brush != NULL ? &brush->Brush() : wxTRANSPARENT_BRUSH);
}
