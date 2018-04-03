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

#include "wxglue.h"
#include "gpPanel.h"
#include "gpMultiplotLayer.h"
#include "gpLineLayer.h"
#include "mpFXYVector.h"
#include "mpFX2Y.h"
#include "mpFXY.h"

#include "../wxbrush.mod/glue.h"
#include "../wxpen.mod/glue.h"

class MaxgpPanel;
class MaxmpFX2Y;
class MaxmpFXY;
class MaxmpLayer;

extern "C" {

#include <blitz.h>

	void CB_PREF(wx_wxgppanel_mpFX2Y__Rewind)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpFX2Y__GetNextX2Y)(BBObject * maxHandle, double & x, double & y1, double & y2);

	void CB_PREF(wx_wxgppanel_mpFXY__Rewind)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpFXY__GetNextXY)(BBObject * maxHandle, double & x, double & y);
	
	int CB_PREF(wx_wxgppanel_mpLayer__HasBBox)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsInfo)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsInfoLegendLayer)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsMovableLayer)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsScaleXLayer)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsScaleYLayer)(BBObject * maxHandle);
	int CB_PREF(wx_wxgppanel_mpLayer__IsPointLayer)(BBObject * maxHandle);
	double CB_PREF(wx_wxgppanel_mpLayer__GetMinX)(BBObject * maxHandle);
	double CB_PREF(wx_wxgppanel_mpLayer__GetMaxX)(BBObject * maxHandle);
	double CB_PREF(wx_wxgppanel_mpLayer__GetMinY)(BBObject * maxHandle);
	double CB_PREF(wx_wxgppanel_mpLayer__GetMaxY)(BBObject * maxHandle);

	MaxgpPanel * bmx_wxgppanel_create(BBObject * maxHandle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h);
	int bmx_wxgppanel_addlayer(gpPanel * panel, gpLayer * layer, int menuMask);
	void bmx_wxgppanel_fit(gpPanel * panel, gpLayer * layer);
	int bmx_wxgppanel_addlayerhoriz(gpPanel * panel, int id, gpLayer * layer, int menuMask, int proportion);
	void bmx_wxgppanel_realizelayers(gpPanel * panel);
	void bmx_wxgppanel_dellayer(gpPanel * panel, gpLayer * layer);
	void bmx_wxgppanel_delalllayers(gpPanel * panel);
	void bmx_wxgppanel_fitall(gpPanel * panel);
	void bmx_wxgppanel_fitparams(gpPanel * panel, gpLayer * layer, double xMin, double xMax, double yMin, double yMax, int * printSizeX, int * printSizeY);
	void bmx_wxgppanel_lockall(gpPanel * panel, int lock);
	void bmx_wxgppanel_lockxaxis(gpPanel * panel, gpLayer * layer, int lock);
	void bmx_wxgppanel_lockyaxis(gpPanel * panel, gpLayer * layer, int lock);
	int bmx_wxgppanel_setlayervisible(gpPanel * panel, gpLayer * layer, int viewable);
	int bmx_wxgppanel_setlayervisiblename(gpPanel * panel, BBString * layer, int viewable);
	int bmx_wxgppanel_setlayervisibleid(gpPanel * panel, int id, int viewable);
	int bmx_wxgppanel_islayervisible(gpPanel * panel, gpLayer * layer);
	int bmx_wxgppanel_islayervisiblename(gpPanel * panel, BBString * name);
	int bmx_wxgppanel_islayervisibleid(gpPanel * panel, int id);
	void bmx_wxgppanel_refresh(gpPanel * panel);
	void bmx_wxgppanel_refreshlayer(gpPanel * panel, gpLayer * layer);

	gpMultiPlotLayer * bmx_gpmultiplotlayer_create(BBString * label, BBString * xLabel, BBString * yLabel, int plotType);
	gpSeries * bmx_gpmultiplotlayer_addserieslayer(gpMultiPlotLayer * layer, BBString * label);
	void bmx_gpmultiplotlayer_settype(gpMultiPlotLayer * layer, int value);
	void bmx_gpmultiplotlayer_refreshchart(gpMultiPlotLayer * layer);

	int bmx_gpseries_islabel(gpSeries * series, BBString * compareLabel);
	void bmx_gpseries_datapush(gpSeries * series, double x, double y);
	void bmx_gpseries_refreshchart(gpSeries * series, int chartKind, double sampleRate, int fftLength, BBString * customXFormula, BBString * customYFormula, BBString * customYXFormula, int xAxisType, int yAxisType);
	void bmx_gpseries_setcontinuity(gpSeries * series, int value);
	void bmx_gpseries_setvisible(gpSeries * series, int value);
	void bmx_gpseries_showname(gpSeries * series, int value);
	void bmx_gpseries_setpen(gpSeries * series, MaxPen * pen);
	void bmx_gpseries_setbrush(gpSeries * series, MaxBrush * brush);
	void bmx_gpseries_dataclear(gpSeries * series);
	void bmx_gpseries_invert(gpSeries * series, int value);

	BBString * bmx_gplayer_getname(gpLayer * layer);
	void bmx_gplayer_setname(gpLayer * layer, BBString * name);
	int bmx_gplayer_type(gpLayer * layer);
	void bmx_gplayer_lockchartx(gpLayer * layer, int value);
	void bmx_gplayer_lockcharty(gpLayer * layer, int value);
	int bmx_gplayer_getlockx(gpLayer * layer);
	int bmx_gplayer_getlocky(gpLayer * layer);
	void bmx_gplayer_setchartboundsenabled(gpLayer * layer, int value);
	void bmx_gplayer_setchartbounds(gpLayer * layer, double xmin, double xmax, double ymin, double ymax);
	void bmx_gplayer_setboundlocks(gpLayer * layer, int xmin, int xmax, int ymin, int ymax);
	void bmx_gplayer_getboundlocks(gpLayer * layer, int * xmin, int * xmax, int * ymin, int * ymax);
	double bmx_gplayer_getzoomincrementfactory(gpLayer * layer);
	int bmx_gplayer_iswindowscrollbarsenabled(gpLayer * layer);
	void bmx_gplayer_datapush(gpLayer * layer, double x, double y, double z);
	void bmx_gplayer_dataclear(gpLayer * layer);
	void bmx_gplayer_refreshtooltip(gpLayer * layer);
	void bmx_gplayer_refreshlabels(gpLayer * layer);
	void bmx_gplayer_setxaxistype(gpLayer * layer, int kind);
	void bmx_gplayer_setsamplerate(gpLayer * layer, double d);
	void bmx_gplayer_setfftlength(gpLayer * layer, int i);
	int bmx_gplayer_refreshneeded(gpLayer * layer);
	void bmx_gplayer_refresh(gpLayer * layer);
	int bmx_gplayer_getvisibility(gpLayer * layer);
	void bmx_gplayer_setvisibility(gpLayer * layer, int value);
	int bmx_gplayer_getenable(gpLayer * layer);
	void bmx_gplayer_setenable(gpLayer * layer, int value);
	void bmx_gplayer_setyxformula(gpLayer * layer, BBString * formula);
	void bmx_gplayer_setxformula(gpLayer * layer, BBString * formula);
	void bmx_gplayer_setyformula(gpLayer * layer, BBString * formula);
	int bmx_gplayer_isyxformula(gpLayer * layer);
	int bmx_gplayer_isxformula(gpLayer * layer);
	int bmx_gplayer_isyformula(gpLayer * layer);
	BBString * bmx_gplayer_getyxformula(gpLayer * layer);
	BBString * bmx_gplayer_getxformula(gpLayer * layer);
	BBString * bmx_gplayer_getyformula(gpLayer * layer);
	void bmx_gplayer_showgrid(gpLayer * layer, int visibility, int mode);
	void bmx_gplayer_showcornermarkers(gpLayer * layer, int visibility);
	void bmx_gplayer_setcontinuousline(gpLayer * layer, int continuous);
	void bmx_gplayer_showinfolayer(gpLayer * layer, int visibility);
	void bmx_gplayer_addlayer(gpLayer * layer, mpLayer * mpl);
	void bmx_gplayer_dellayer(gpLayer * layer, mpLayer * mpl);
	void bmx_gplayer_delalllayers(gpLayer * layer);

	wxMenuItem * bmx_gpmenu_getmenuitembyid(gpMenu * menu, int id, wxMenu * m);
	int bmx_gpmenu_addmenuitem(gpMenu * menu, BBString * label, BBString * help, int kind, int checked, int toGroup);
	int bmx_gpmenu_addsubmenuitem(gpMenu * menu, BBString * label, BBString * help, int kind, int checked, int toGroup);
	void bmx_gpmenu_newsubmenu(gpMenu * menu, BBString * label);
	int bmx_gpmenu_appendsubmenu(gpMenu * menu, BBString * label, BBString * help);
	int bmx_gpmenu_addid(gpMenu * menu, int id);
	int bmx_gpmenu_addnewid(gpMenu * menu, int primary);
	int bmx_gpmenu_getprimaryid(gpMenu * menu);
	void bmx_gpmenu_settoolbargroup(gpMenu * menu, wxToolBar * toolbar, int group);
	void bmx_gpmenu_addtoolbaridtogroup(gpMenu * menu, int group, int id);
	void bmx_gpmenu_checkmenuitem(gpMenu * menu, int id, int checked);
	void bmx_gpmenu_checkmenugroup(gpMenu * menu, int group, int checked);
	int bmx_gpmenu_menuidbelongs(gpMenu * menu, int id);

	gpLineLayer * bmx_gplinelayer_create(BBString * label, BBString * xLabel, BBString * yLabel);

	mpFXYVector * bmx_mpfxyvector_create(BBString * name, int flags);
	void bmx_mpfxyvector_setdata(mpFXYVector * mpv, BBArray * xs, BBArray * ys);
	void bmx_mpfxyvector_clear(mpFXYVector * mpv);

	MaxmpFX2Y * bmx_mpfx2y_create(BBObject * maxHandle, BBString * name, int flags);

	MaxmpFXY * bmx_mpfxy_create(BBObject * maxHandle, BBString * name, int flags);

	MaxmpLayer * bmx_mplayer_create(BBObject * maxHandle);

	BBString * bmx_mplayer_getname(mpLayer * layer);
	MaxFont * bmx_mplayer_getfont(mpLayer * layer);
	MaxPen * bmx_mplayer_getpen(mpLayer * layer);
	void bmx_mplayer_setcontinuity(mpLayer * layer, int value);
	int bmx_mplayer_getcontinuity(mpLayer * layer);
	void bmx_mplayer_showname(mpLayer * layer, int value);
	void bmx_mplayer_setname(mpLayer * layer, BBString * name);
	void bmx_mplayer_setfont(mpLayer * layer, MaxFont * font);
	void bmx_mplayer_setpen(mpLayer * layer, MaxPen * pen);
	void bmx_mplayer_setdrawoutsidemargins(mpLayer * layer, int value);
	int bmx_mplayer_getdrawoutsidemargins(mpLayer * layer);
	MaxBitmap * bmx_mplayer_getcoloursquare(mpLayer * layer, int side);
	int bmx_mplayer_getlayertype(mpLayer * layer);
	int bmx_mplayer_getpointtype(mpLayer * layer);
	void bmx_mplayer_setpointtype(mpLayer * layer, int pointType);
	int bmx_mplayer_isvisible(mpLayer * layer);
	void bmx_mplayer_setvisible(mpLayer * layer, int value);
	MaxBrush * bmx_mplayer_getbrush(mpLayer * layer);
	void bmx_mplayer_setbrush(mpLayer * layer, MaxBrush * brush);
	void bmx_mplayer_invert(mpLayer * layer, int value);
	int bmx_mplayer_getinvert(mpLayer * layer);

	int bmx_mplayer_hasbbox(MaxmpLayer * layer);
	int bmx_mplayer_isinfo(MaxmpLayer * layer);
	int bmx_mplayer_isinfolegendlayer(MaxmpLayer * layer);
	int bmx_mplayer_ismovablelayer(MaxmpLayer * layer);
	int bmx_mplayer_isscalexlayer(MaxmpLayer * layer);
	int bmx_mplayer_isscaleylayer(MaxmpLayer * layer);
	int bmx_mplayer_ispointlayer(MaxmpLayer * layer);
	double bmx_mplayer_getminx(MaxmpLayer * layer);
	double bmx_mplayer_getmaxx(MaxmpLayer * layer);
	double bmx_mplayer_getminy(MaxmpLayer * layer);
	double bmx_mplayer_getmaxy(MaxmpLayer * layer);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxgpPanel : public gpPanel
{
public:
	MaxgpPanel(BBObject * handle, wxWindow* parent, wxWindowID id, int x, int y, int w, int h);
	~MaxgpPanel();
			
private:
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxmpFX2Y : public mpFX2Y
{
public:
	MaxmpFX2Y(BBObject * handle, wxString name, int flags);
	~MaxmpFX2Y();

	virtual void Rewind();
	virtual bool GetNextX2Y(double & x, double & y1, double & y2);

private:
	BBObject * maxHandle;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxmpFXY : public mpFXY
{
public:
	MaxmpFXY(BBObject * handle, wxString name, int flags);
	~MaxmpFXY();

	virtual void Rewind();
	virtual bool GetNextXY(double & x, double & y);
	
private:
	BBObject * maxHandle;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxmpLayer : public mpLayer
{
public:
	MaxmpLayer(BBObject * handle);
	~MaxmpLayer();
	
	virtual void Plot(wxDC & dc, mpWindow & w);

	virtual bool HasBBox();
	virtual bool IsInfo();
	virtual bool IsInfoLegendLayer();
	virtual bool IsMovableLayer();
	virtual bool IsScaleXLayer();
	virtual bool IsScaleYLayer();
	virtual bool IsPointLayer();
	virtual void UpdateMouseCoord(mpWindow& w, wxEvent& event);
	virtual double GetMinX();
	virtual double GetMaxX();
	virtual double GetMinY();
	virtual double GetMaxY();
	virtual bool GetNearestCoord(mpWindow & w, double & x, double & y);

	bool defaultHasBBox() { return mpLayer::HasBBox(); }
	bool defaultIsInfo() { return mpLayer::IsInfo(); }
	bool defaultIsInfoLegendLayer() { return mpLayer::IsInfoLegendLayer(); }
	bool defaultIsMovableLayer() { return mpLayer::IsMovableLayer(); }
	bool defaultIsScaleXLayer() { return mpLayer::IsScaleXLayer(); }
	bool defaultIsScaleYLayer() { return mpLayer::IsScaleYLayer(); }
	bool defaultIsPointLayer() { return mpLayer::IsPointLayer(); }
	void defaultUpdateMouseCoord(mpWindow& w, wxEvent& event) { mpLayer::UpdateMouseCoord(w, event); }
	double defaultGetMinX() { return mpLayer::GetMinX(); }
	double defaultGetMaxX() { return mpLayer::GetMaxX(); }
	double defaultGetMinY() { return mpLayer::GetMinY(); }
	double defaultGetMaxY() { return mpLayer::GetMaxY(); }
	bool defaultGetNearestCoord(mpWindow & w, double & x, double & y) { return mpLayer::GetNearestCoord(w, x, y); }

private:
	BBObject * maxHandle;
};
