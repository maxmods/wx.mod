/*
  Copyright (c) 2018 Bruce A Henderson
 
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

BEGIN_EVENT_TABLE(MaxgpPanel, gpPanel)
END_EVENT_TABLE()

MaxgpPanel::MaxgpPanel(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h)
       : gpPanel(parent, id, wxPoint(x, y), wxSize(w,h))
{
	wxbind(this, handle);
}

MaxgpPanel::~MaxgpPanel() {
	wxunbind(this);
}

// ---------------------------------------------------------------------------------------

MaxmpFX2Y::MaxmpFX2Y(BBObject * handle, wxString name, int flags)
		: mpFX2Y(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxmpFX2Y::~MaxmpFX2Y() {
	wxunbind(this);
}

void MaxmpFX2Y::Rewind() {
	CB_PREF(wx_wxgppanel_mpFX2Y__Rewind)(maxHandle);
}

bool MaxmpFX2Y::GetNextX2Y(double & x, double & y1, double & y2) {
	return CB_PREF(wx_wxgppanel_mpFX2Y__GetNextX2Y)(maxHandle, x, y1, y2);
}

// ---------------------------------------------------------------------------------------

MaxmpFXY::MaxmpFXY(BBObject * handle, wxString name, int flags)
		: mpFXY(name, flags), maxHandle(handle)
{
	wxbind(this, handle);
}

MaxmpFXY::~MaxmpFXY() {
	wxunbind(this);
}

void MaxmpFXY::Rewind() {
	CB_PREF(wx_wxgppanel_mpFXY__Rewind)(maxHandle);
}

bool MaxmpFXY::GetNextXY(double & x, double & y) {
	return CB_PREF(wx_wxgppanel_mpFXY__GetNextXY)(maxHandle, x, y);
}

// ---------------------------------------------------------------------------------------

MaxmpLayer::MaxmpLayer(BBObject * handle)
	: maxHandle(handle)
{
}

MaxmpLayer::~MaxmpLayer() {
}

void MaxmpLayer::Plot(wxDC & dc, mpWindow & w) {
	// TODO
}

bool MaxmpLayer::HasBBox() {
	return CB_PREF(wx_wxgppanel_mpLayer__HasBBox)(maxHandle);
}

bool MaxmpLayer::IsInfo() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsInfo)(maxHandle);
}

bool MaxmpLayer::IsInfoLegendLayer() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsInfoLegendLayer)(maxHandle);
}

bool MaxmpLayer::IsMovableLayer() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsMovableLayer)(maxHandle);
}

bool MaxmpLayer::IsScaleXLayer() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsScaleXLayer)(maxHandle);
}

bool MaxmpLayer::IsScaleYLayer() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsScaleYLayer)(maxHandle);
}

bool MaxmpLayer::IsPointLayer() {
	return CB_PREF(wx_wxgppanel_mpLayer__IsPointLayer)(maxHandle);
}

void MaxmpLayer::UpdateMouseCoord(mpWindow& w, wxEvent& event) {
 // TODO
}

double MaxmpLayer::GetMinX() {
	return CB_PREF(wx_wxgppanel_mpLayer__GetMinX)(maxHandle);
}

double MaxmpLayer::GetMaxX() {
	return CB_PREF(wx_wxgppanel_mpLayer__GetMaxX)(maxHandle);
}

double MaxmpLayer::GetMinY() {
	return CB_PREF(wx_wxgppanel_mpLayer__GetMinY)(maxHandle);
}

double MaxmpLayer::GetMaxY() {
	return CB_PREF(wx_wxgppanel_mpLayer__GetMaxY)(maxHandle);
}

bool MaxmpLayer::GetNearestCoord(mpWindow & w, double & x, double & y) {
	// TODO
	return 0;
}



// *********************************************

MaxgpPanel * bmx_wxgppanel_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h) {
	return new MaxgpPanel(maxHandle, parent, id, x, y, w, h);
}

int bmx_wxgppanel_addlayer(gpPanel * panel, gpLayer * layer, int menuMask) {
	return panel->AddLayer(layer, menuMask);
}

void bmx_wxgppanel_fit(gpPanel * panel, gpLayer * layer) {
	panel->Fit(layer);
}

int bmx_wxgppanel_addlayerhoriz(gpPanel * panel, int id, gpLayer * layer, int menuMask, int proportion) {
	return panel->AddLayer(id, layer, menuMask, proportion);
}

void bmx_wxgppanel_realizelayers(gpPanel * panel) {
	panel->RealizeLayers();
}

void bmx_wxgppanel_dellayer(gpPanel * panel, gpLayer * layer) {
	panel->DelLayer(layer, false);
}

void bmx_wxgppanel_delalllayers(gpPanel * panel) {
	panel->DelAllLayers(false);
}

void bmx_wxgppanel_fitall(gpPanel * panel) {
	panel->FitAll();
}

void bmx_wxgppanel_fitparams(gpPanel * panel, gpLayer * layer, double xMin, double xMax, double yMin, double yMax, int * printSizeX, int * printSizeY) {
	panel->Fit(layer, xMin, xMax, yMin, yMax, printSizeX, printSizeY);
}

void bmx_wxgppanel_lockall(gpPanel * panel, int lock) {
	panel->LockAll(lock);
}

void bmx_wxgppanel_lockxaxis(gpPanel * panel, gpLayer * layer, int lock) {
	panel->LockXAxis(layer, lock);
}

void bmx_wxgppanel_lockyaxis(gpPanel * panel, gpLayer * layer, int lock) {
	panel->LockYAxis(layer, lock);
}

int bmx_wxgppanel_setlayervisible(gpPanel * panel, gpLayer * layer, int viewable) {
	return panel->SetLayerVisible(layer, viewable);
}

int bmx_wxgppanel_setlayervisiblename(gpPanel * panel, BBString * layer, int viewable) {
	return panel->SetLayerVisible(wxStringFromBBString(layer), viewable);
}

int bmx_wxgppanel_setlayervisibleid(gpPanel * panel, int id, int viewable) {
	return panel->SetLayerVisible(id, viewable);
}

int bmx_wxgppanel_islayervisible(gpPanel * panel, gpLayer * layer) {
	return panel->IsLayerVisible(layer);
}

int bmx_wxgppanel_islayervisiblename(gpPanel * panel, BBString * name) {
	return panel->IsLayerVisible(wxStringFromBBString(name));
}

int bmx_wxgppanel_islayervisibleid(gpPanel * panel, int id) {
	return panel->IsLayerVisible(id);
}

void bmx_wxgppanel_refresh(gpPanel * panel) {
	panel->Refresh();
}

void bmx_wxgppanel_refreshlayer(gpPanel * panel, gpLayer * layer) {
	panel->Refresh(layer);
}

// *********************************************

gpMultiPlotLayer * bmx_gpmultiplotlayer_create(BBString * label, BBString * xLabel, BBString * yLabel, int plotType) {
	return new gpMultiPlotLayer(wxStringFromBBString(label), wxStringFromBBString(xLabel), wxStringFromBBString(yLabel), static_cast<gpMultiPlotLayer::Type>(plotType));
}

gpSeries * bmx_gpmultiplotlayer_addserieslayer(gpMultiPlotLayer * layer, BBString * label) {
	return layer->AddSeriesLayer(wxStringFromBBString(label));
}

void bmx_gpmultiplotlayer_settype(gpMultiPlotLayer * layer, int value) {
	layer->type(static_cast<gpMultiPlotLayer::Type>(value));
}

void bmx_gpmultiplotlayer_refreshchart(gpMultiPlotLayer * layer) {
	layer->RefreshChart();
}

void bmx_gpmultiplotlayer_invertyscale(gpMultiPlotLayer * layer, int value) {
	layer->invertYScale(static_cast<bool>(value));
}

void bmx_gpmultiplotlayer_mydatapush(gpMultiPlotLayer * layer, double x, double y, BBString * seriesLabel) {
	layer->myDataPush(x, y, wxStringFromBBString(seriesLabel));
}

void bmx_gpmultiplotlayer_dataclearlabel(gpMultiPlotLayer * layer, BBString * seriesLabel) {
	layer->DataClear(wxStringFromBBString(seriesLabel));
}

void bmx_gpmultiplotlayer_setpen(gpMultiPlotLayer * layer, MaxPen * pen, BBString * seriesLabel) {
	layer->SetPen(pen->Pen(), wxStringFromBBString(seriesLabel));
}

void bmx_gpmultiplotlayer_deleteseries(gpMultiPlotLayer * layer, BBString * seriesLabel) {
	layer->DeleteSeries(wxStringFromBBString(seriesLabel));
}

void bmx_gpmultiplotlayer_addlegendinfo(gpMultiPlotLayer * layer, int x, int y) {
	layer->AddLegendInfo(x, y);
}

void bmx_gpmultiplotlayer_addcoordinfo(gpMultiPlotLayer * layer, int x, int y) {
	layer->AddCoordInfo(x, y);
}

double bmx_gpmultiplotlayer_getminy(gpMultiPlotLayer * layer) {
	return layer->getMinY();
}

int bmx_gpmultiplotlayer_getchartkind(gpMultiPlotLayer * layer) {
	return static_cast<int>(layer->GetChartKind());
}


// *********************************************

int bmx_gpseries_islabel(gpSeries * series, BBString * compareLabel) {
	return series->IsLabel(wxStringFromBBString(compareLabel));
}

void bmx_gpseries_datapush(gpSeries * series, double x, double y) {
	series->DataPush(x, y);
}

void bmx_gpseries_refreshchart(gpSeries * series, int chartKind, double sampleRate, int fftLength, BBString * customXFormula, BBString * customYFormula,
		BBString * customYXFormula, int xAxisType, int yAxisType) {
	series->RefreshChart(static_cast<gpCHART_KIND>(chartKind), sampleRate, fftLength, wxStringFromBBString(customXFormula),
		wxStringFromBBString(customYFormula), wxStringFromBBString(customYXFormula), static_cast<gpAXIS_SCALE>(xAxisType),
		static_cast<gpAXIS_SCALE>(yAxisType));
}

void bmx_gpseries_setcontinuity(gpSeries * series, int value) {
	series->SetContinuity(value);
}

void bmx_gpseries_setvisible(gpSeries * series, int value) {
	series->SetVisible(value);
}

void bmx_gpseries_showname(gpSeries * series, int value) {
	series->ShowName(value);
}

void bmx_gpseries_setpen(gpSeries * series, MaxPen * pen) {
	series->SetPen(pen->Pen());
}

void bmx_gpseries_setbrush(gpSeries * series, MaxBrush * brush) {
	series->SetBrush(brush->Brush());
}

void bmx_gpseries_dataclear(gpSeries * series) {
	series->DataClear();
}

void bmx_gpseries_invert(gpSeries * series, int value) {
	series->invert(value);
}

// *********************************************

BBString * bmx_gplayer_getname(gpLayer * layer) {
	bbStringFromWxString(layer->GetName());
}

void bmx_gplayer_setname(gpLayer * layer, BBString * name) {
	layer->SetName(wxStringFromBBString(name));
}

int bmx_gplayer_type(gpLayer * layer) {
	return layer->gpType();
}

void bmx_gplayer_lockchartx(gpLayer * layer, int value) {
	layer->LockChartX(value);
}

void bmx_gplayer_lockcharty(gpLayer * layer, int value) {
	layer->LockChartY(value);
}

int bmx_gplayer_getlockx(gpLayer * layer) {
	return layer->GetLockX();
}

int bmx_gplayer_getlocky(gpLayer * layer) {
	return layer->GetLockY();
}

void bmx_gplayer_setchartboundsenabled(gpLayer * layer, int value) {
	layer->SetChartBounds(value);
}

void bmx_gplayer_setchartbounds(gpLayer * layer, double xmin, double xmax, double ymin, double ymax) {
	layer->SetChartBounds(xmin, xmax, ymin, ymax);
}

void bmx_gplayer_setboundlocks(gpLayer * layer, int xmin, int xmax, int ymin, int ymax) {
	layer->SetBoundLocks(xmin, xmax, ymin, ymax);
}

void bmx_gplayer_getboundlocks(gpLayer * layer, int * xmin, int * xmax, int * ymin, int * ymax) {
	bool x0, x1, y0, y1;
	layer->GetBoundLocks(x0, x1, y0, y1);
	*xmin = x0;
	*xmax = x1;
	*ymin = y0;
	*ymax = y1;
}

double bmx_gplayer_getzoomincrementfactory(gpLayer * layer) {
	return layer->GetZoomIncrementFactory();
}

int bmx_gplayer_iswindowscrollbarsenabled(gpLayer * layer) {
	return layer->IsWindowScrollbarsEnabled();
}

void bmx_gplayer_datapush(gpLayer * layer, double x, double y, double z) {
	layer->DataPush(x, y, z);
}

void bmx_gplayer_dataclear(gpLayer * layer) {
	layer->DataClear();
}

void bmx_gplayer_refreshtooltip(gpLayer * layer) {
	layer->RefreshToolTip();
}

void bmx_gplayer_refreshlabels(gpLayer * layer) {
	layer->RefreshLabels();
}

void bmx_gplayer_setxaxistype(gpLayer * layer, int kind) {
	layer->SetXAxisType(kind);
}

void bmx_gplayer_setsamplerate(gpLayer * layer, double d) {
	layer->SetSamplerate(d);
}

void bmx_gplayer_setfftlength(gpLayer * layer, int i) {
	layer->SetFftLength(i);
}

int bmx_gplayer_refreshneeded(gpLayer * layer) {
	return layer->RefreshNeeded();
}

void bmx_gplayer_refresh(gpLayer * layer) {
	layer->Refresh();
}

int bmx_gplayer_getvisibility(gpLayer * layer) {
	return layer->GetVisibility();
}

void bmx_gplayer_setvisibility(gpLayer * layer, int value) {
	layer->SetVisibility(value);
}

int bmx_gplayer_getenable(gpLayer * layer) {
	return layer->GetEnable();
}

void bmx_gplayer_setenable(gpLayer * layer, int value) {
	layer->SetEnable(value);
}

void bmx_gplayer_setyxformula(gpLayer * layer, BBString * formula) {
	layer->SetYXFormula(wxStringFromBBString(formula));
}

void bmx_gplayer_setxformula(gpLayer * layer, BBString * formula) {
	layer->SetXFormula(wxStringFromBBString(formula));
}

void bmx_gplayer_setyformula(gpLayer * layer, BBString * formula) {
	layer->SetYFormula(wxStringFromBBString(formula));
}

int bmx_gplayer_isyxformula(gpLayer * layer) {
	return layer->IsYXFormula();
}

int bmx_gplayer_isxformula(gpLayer * layer) {
	return layer->IsXFormula();
}

int bmx_gplayer_isyformula(gpLayer * layer) {
	return layer->IsYFormula();
}

BBString * bmx_gplayer_getyxformula(gpLayer * layer) {
	return bbStringFromWxString(layer->GetYXFormula());
}

BBString * bmx_gplayer_getxformula(gpLayer * layer) {
	return bbStringFromWxString(layer->GetXFormula());
}

BBString * bmx_gplayer_getyformula(gpLayer * layer) {
	return bbStringFromWxString(layer->GetYFormula());
}

void bmx_gplayer_showgrid(gpLayer * layer, int visibility, int mode) {
	layer->ShowGrid(visibility, mode);
}

void bmx_gplayer_showcornermarkers(gpLayer * layer, int visibility) {
	layer->ShowCornerMarkers(visibility);
}

void bmx_gplayer_setcontinuousline(gpLayer * layer, int continuous) {
	layer->SetContinousLine(continuous);
}

void bmx_gplayer_showinfolayer(gpLayer * layer, int visibility) {
	layer->ShowInfoLayer(visibility);
}

void bmx_gplayer_addlayer(gpLayer * layer, mpLayer * mpl) {
	layer->AddLayer(mpl);
}

void bmx_gplayer_dellayer(gpLayer * layer, mpLayer * mpl) {
	layer->DelLayer(mpl, false);
}

void bmx_gplayer_delalllayers(gpLayer * layer) {
	layer->DelAllLayers(false);
}

int bmx_gplayer_selectxaxisscale(gpLayer * layer, int kind) {
	return static_cast<int>(layer->SelectXAxisScale(static_cast<gpAXIS_SCALE>(kind)));
}

int bmx_gplayer_selectyaxisscale(gpLayer * layer, int kind) {
	return static_cast<int>(layer->SelectYAxisScale(static_cast<gpAXIS_SCALE>(kind)));
}

int bmx_gplayer_setchartkind(gpLayer * layer, int kind) {
	return static_cast<int>(layer->SetChartKind(static_cast<gpCHART_KIND>(kind)));
}

// *********************************************

gpLineLayer * bmx_gplinelayer_create(BBString * label, BBString * xLabel, BBString * yLabel) {
	return new gpLineLayer(wxStringFromBBString(label), wxStringFromBBString(xLabel), wxStringFromBBString(yLabel));
}

// *********************************************

mpFXYVector * bmx_mpfxyvector_create(BBString * name, int flags) {
	return new mpFXYVector(wxStringFromBBString(name), flags);
}

void bmx_mpfxyvector_setdata(mpFXYVector * mpv, BBArray * xs, BBArray * ys) {
	double * xd = (double*)BBARRAYDATA(xs, xs->dims);
	double * yd = (double*)BBARRAYDATA(ys, ys->dims);

	std::vector<double> x(xd, xd + xs->scales[0]);
	std::vector<double> y(yd, yd + ys->scales[0]);

	mpv->SetData(x, y);
}

void bmx_mpfxyvector_clear(mpFXYVector * mpv) {
	mpv->Clear();
}

// *********************************************

MaxmpFX2Y * bmx_mpfx2y_create(BBObject * maxHandle, BBString * name, int flags) {
	return new MaxmpFX2Y(maxHandle, wxStringFromBBString(name), flags);
}

// *********************************************

MaxmpFXY * bmx_mpfxy_create(BBObject * maxHandle, BBString * name, int flags) {
	return new MaxmpFXY(maxHandle, wxStringFromBBString(name), flags);
}

// *********************************************

wxMenuItem * bmx_gpmenu_getmenuitembyid(gpMenu * menu, int id, wxMenu * m) {
	return menu->GetMenuItemById(id, m);
}

int bmx_gpmenu_addmenuitem(gpMenu * menu, BBString * label, BBString * help, int kind, int checked, int toGroup) {
	return menu->addMenuItem(wxStringFromBBString(label), wxStringFromBBString(help), static_cast<wxItemKind>(kind), checked, toGroup);
}

int bmx_gpmenu_addsubmenuitem(gpMenu * menu, BBString * label, BBString * help, int kind, int checked, int toGroup) {
	return menu->addSubMenuItem(wxStringFromBBString(label), wxStringFromBBString(help), static_cast<wxItemKind>(kind), checked, toGroup);
}

void bmx_gpmenu_newsubmenu(gpMenu * menu, BBString * label) {
	menu->newSubMenu(wxStringFromBBString(label));
}

int bmx_gpmenu_appendsubmenu(gpMenu * menu, BBString * label, BBString * help) {
	return menu->AppendSubMenu(wxStringFromBBString(label), wxStringFromBBString(help));
}

int bmx_gpmenu_addid(gpMenu * menu, int id) {
	return menu->AddId(id);
}

int bmx_gpmenu_addnewid(gpMenu * menu, int primary) {
	return menu->AddNewId(primary);
}

int bmx_gpmenu_getprimaryid(gpMenu * menu) {
	return menu->GetPrimaryId();
}

void bmx_gpmenu_settoolbargroup(gpMenu * menu, wxToolBar * toolbar, int group) {
	menu->SetToolbarGroup(toolbar, group);
}

void bmx_gpmenu_addtoolbaridtogroup(gpMenu * menu, int group, int id) {
	menu->AddToolBarIdToGroup(group, id);
}

void bmx_gpmenu_checkmenuitem(gpMenu * menu, int id, int checked) {
	menu->CheckMenuItem(id, checked);
}

void bmx_gpmenu_checkmenugroup(gpMenu * menu, int group, int checked) {
	menu->CheckMenuGroup(group, checked);
}

int bmx_gpmenu_menuidbelongs(gpMenu * menu, int id) {
	return menu->MenuIdBelongs(id);
}

// *********************************************

MaxmpLayer * bmx_mplayer_create(BBObject * maxHandle) {
	return new MaxmpLayer(maxHandle);
}

BBString * bmx_mplayer_getname(mpLayer * layer) {
	return bbStringFromWxString(layer->GetName());
}

MaxFont * bmx_mplayer_getfont(mpLayer * layer) {
	return new MaxFont(layer->GetFont());
}

MaxPen * bmx_mplayer_getpen(mpLayer * layer) {
	wxPen pen(layer->GetPen());
	return new MaxPen(pen);
}

void bmx_mplayer_setcontinuity(mpLayer * layer, int value) {
	layer->SetContinuity(value);
}

int bmx_mplayer_getcontinuity(mpLayer * layer) {
	return layer->GetContinuity();
}

void bmx_mplayer_showname(mpLayer * layer, int value) {
	layer->ShowName(value);
}

void bmx_mplayer_setname(mpLayer * layer, BBString * name) {
	layer->SetName(wxStringFromBBString(name));
}

void bmx_mplayer_setfont(mpLayer * layer, MaxFont * font) {
	layer->SetFont(font->Font());
}

void bmx_mplayer_setpen(mpLayer * layer, MaxPen * pen) {
	layer->SetPen(pen->Pen());
}

void bmx_mplayer_setdrawoutsidemargins(mpLayer * layer, int value) {
	layer->SetDrawOutsideMargins(value);
}

int bmx_mplayer_getdrawoutsidemargins(mpLayer * layer) {
	return layer->GetDrawOutsideMargins();
}

MaxBitmap * bmx_mplayer_getcoloursquare(mpLayer * layer, int side) {
	return new MaxBitmap(layer->GetColourSquare(side));
}

int bmx_mplayer_getlayertype(mpLayer * layer) {
	return layer->GetLayerType();
}

int bmx_mplayer_getpointtype(mpLayer * layer) {
	return layer->GetPointType();
}

void bmx_mplayer_setpointtype(mpLayer * layer, int pointType) {
	layer->SetPointType(static_cast<mpShape>(pointType));
}

int bmx_mplayer_isvisible(mpLayer * layer) {
	return layer->IsVisible();
}

void bmx_mplayer_setvisible(mpLayer * layer, int value) {
	layer->SetVisible(value);
}

MaxBrush * bmx_mplayer_getbrush(mpLayer * layer) {
	wxBrush brush(layer->GetBrush());
	return new MaxBrush(brush);
}

void bmx_mplayer_setbrush(mpLayer * layer, MaxBrush * brush) {
	layer->SetBrush(brush->Brush());
}

void bmx_mplayer_invert(mpLayer * layer, int value) {
	layer->invert(value);
}

int bmx_mplayer_getinvert(mpLayer * layer) {
	return layer->getInvert();
}

int bmx_mplayer_hasbbox(MaxmpLayer * layer) {
	return layer->defaultHasBBox();
}

int bmx_mplayer_isinfo(MaxmpLayer * layer) {
	return layer->defaultIsInfo();
}

int bmx_mplayer_isinfolegendlayer(MaxmpLayer * layer) {
	return layer->defaultIsInfoLegendLayer();
}

int bmx_mplayer_ismovablelayer(MaxmpLayer * layer) {
	return layer->defaultIsMovableLayer();
}

int bmx_mplayer_isscalexlayer(MaxmpLayer * layer) {
	return layer->defaultIsScaleXLayer();
}

int bmx_mplayer_isscaleylayer(MaxmpLayer * layer) {
	return layer->defaultIsScaleYLayer();
}

int bmx_mplayer_ispointlayer(MaxmpLayer * layer) {
	return layer->defaultIsPointLayer();
}

double bmx_mplayer_getminx(MaxmpLayer * layer) {
	return layer->defaultGetMinX();
}

double bmx_mplayer_getmaxx(MaxmpLayer * layer) {
	return layer->defaultGetMaxX();
}

double bmx_mplayer_getminy(MaxmpLayer * layer) {
	return layer->defaultGetMinY();
}

double bmx_mplayer_getmaxy(MaxmpLayer * layer) {
	return layer->defaultGetMaxY();
}

