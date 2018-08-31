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

#include "wxglue.h"
#include "mathplot.h"
#include "../wxpen.mod/glue.h"
#include "../wxbrush.mod/glue.h"

class MaxMpWindow;
class MaxMpFX;
class MaxScaleX;
class MaxScaleY;
class MaxMpFY;
class MaxMpFXY;
class MaxMpPolygon;
class MaxMpCovarianceEllipse;
class MaxMpBitmapLayer;
class MaxMpFXYVector;
class MaxMpText;
class MaxMpProfile;
class MaxMpPrintout;
class MaxMpInfoCoords;
class MaxMpInfoLegend;

extern "C" {

#include <blitz.h>

	double CB_PREF(wx_wxmathplot_mpFX__GetY)(BBObject *, double);
	double CB_PREF(wx_wxmathplot_mpFX__GetMinY)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFX__GetMaxY)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFY__GetX)(BBObject *, double);
	double CB_PREF(wx_wxmathplot_mpFY__GetMinX)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFY__GetMaxX)(BBObject *);
	void CB_PREF(wx_wxmathplot_mpFXY__Rewind)(BBObject *);
	int CB_PREF(wx_wxmathplot_mpFXY__GetNextXY)(BBObject *, double * x, double * y);
	double CB_PREF(wx_wxmathplot_mpFXY__GetMinX)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFXY__GetMaxX)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFXY__GetMinY)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpFXY__GetMaxY)(BBObject *);
	double CB_PREF(wx_wxmathplot_mpProfile__GetY)(BBObject *, double);

	MaxMpWindow * bmx_mpwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int flags);
	void bmx_mpwindow_fit(mpWindow * window);
	int bmx_mpwindow_addlayer(mpWindow * window, mpLayer * layer, int refreshDisplay);
	int bmx_mpwindow_dellayer(mpWindow * window, mpLayer * layer, int alsoDeleteObject, int refreshDisplay);
	void bmx_mpwindow_delalllayers(mpWindow * window, int alsoDeleteObject, int refreshDisplay);
	mpLayer * bmx_mpwindow_getlayer(mpWindow * window, int position);
	mpLayer * bmx_mpwindow_getlayerbyname(mpWindow * window, BBString * name);
	void bmx_mpwindow_updateall(mpWindow * window);
	double bmx_mpwindow_getscalex(mpWindow * window);
	double bmx_mpwindow_getscaley(mpWindow * window);
	double bmx_mpwindow_getposx(mpWindow * window);
	double bmx_mpwindow_getposy(mpWindow * window);
	int bmx_mpwindow_getxscreen(mpWindow * window);
	int bmx_mpwindow_getyscreen(mpWindow * window);
	void bmx_mpwindow_setscalex(mpWindow * window, double scale);
	void bmx_mpwindow_setscaley(mpWindow * window, double scale);
	void bmx_mpwindow_setposx(mpWindow * window, double pos);
	void bmx_mpwindow_setposy(mpWindow * window, double pos);
	void bmx_mpwindow_setpos(mpWindow * window, double x, double y);
	void bmx_mpwindow_setscreen(mpWindow * window, int x, int y);
	void bmx_mpwindow_enablemousepanzoom(mpWindow * window, int enabled);
	void bmx_mpwindow_lockaspect(mpWindow * window, int enable);
	int bmx_mpwindow_isaspectlocked(mpWindow * window);
	void bmx_mpwindow_fitbounds(mpWindow * window, double xMin, double xMax, double yMin, double yMax, int printSizeX, int printSizeY);
	void bmx_mpwindow_zoomin(mpWindow * window, int centerPointX, int centerPointY);
	void bmx_mpwindow_zoomout(mpWindow * window, int centerPointX, int centerPointY);
	void bmx_mpwindow_zoominx(mpWindow * window);
	void bmx_mpwindow_zoomoutx(mpWindow * window);
	void bmx_mpwindow_zoominy(mpWindow * window);
	void bmx_mpwindow_zoomouty(mpWindow * window);
	void bmx_mpwindow_zoomrect(mpWindow * window, int x0, int y0, int x1, int y1);
	int bmx_mpwindow_countlayers(mpWindow * window);
	int bmx_mpwindow_countalllayers(mpWindow * window);
	double bmx_mpwindow_getdesiredxmin(mpWindow * window);
	double bmx_mpwindow_getdesiredxmax(mpWindow * window);
	double bmx_mpwindow_getdesiredymin(mpWindow * window);
	double bmx_mpwindow_getdesiredymax(mpWindow * window);
	void bmx_mpwindow_getboundingbox(mpWindow * window, double * bbox);
	void bmx_mpwindow_setmpscrollbars(mpWindow * window, int status);
	int bmx_mpwindow_getmpscrollbars(mpWindow * window);
	void bmx_mpwindow_setmargins(mpWindow * window, int top, int right, int bottom, int left);
	void bmx_mpwindow_setmargintop(mpWindow * window, int value);
	void bmx_mpwindow_setmarginright(mpWindow * window, int value);
	void bmx_mpwindow_setmarginbottom(mpWindow * window, int value);
	void bmx_mpwindow_setmarginleft(mpWindow * window, int value);
	int bmx_mpwindow_getmargintop(mpWindow * window);
	int bmx_mpwindow_getmarginright(mpWindow * window);
	int bmx_mpwindow_getmarginbottom(mpWindow * window);
	int bmx_mpwindow_getmarginleft(mpWindow * window);
	mpInfoLayer * bmx_mpwindow_isinsideinfolayer(mpWindow * window, int x, int y);
	void bmx_mpwindow_setlayervisible(mpWindow * window, BBString * name, int viewable);
	int bmx_mpwindow_islayervisible(mpWindow * window, BBString * name);
	void bmx_mpwindow_setlayervisiblepos(mpWindow * window, int position, int viewable);
	int bmx_mpwindow_islayervisiblepos(mpWindow * window, int position);
	void bmx_mpwindow_setcolourtheme(mpWindow * window, MaxColour * bgColour, MaxColour * drawColour, MaxColour * axesColour);
	MaxColour * bmx_mpwindow_getaxescolour(mpWindow * window);

	void bmx_mplayer_setname(mpLayer * layer, BBString * name);
	void bmx_mplayer_setfont(mpLayer * layer, MaxFont * font);
	void bmx_mplayer_setpen(mpLayer * layer, MaxPen * pen);
	int bmx_mplayer_hasbbox(mpLayer * layer);
	int bmx_mplayer_isinfo(mpLayer * layer);
	double bmx_mplayer_getminx(mpLayer * layer);
	double bmx_mplayer_getmaxx(mpLayer * layer);
	double bmx_mplayer_getminy(mpLayer * layer);
	double bmx_mplayer_getmaxy(mpLayer * layer);
	BBString * bmx_mplayer_getname(mpLayer * layer);
	MaxFont *bmx_mplayer_getfont(mpLayer * layer);
	MaxPen * bmx_mplayer_getpen(mpLayer * layer);
	void bmx_mplayer_setdrawoutsidemargins(mpLayer * layer, int drawModeOutside);
	int bmx_mplayer_getdrawoutsidemargins(mpLayer * layer);
	MaxBitmap * bmx_mplayer_getcoloursquare(mpLayer * layer, int side);
	int bmx_mplayer_getlayertype(mpLayer * layer);
	int bmx_mplayer_isvisible(mpLayer * layer);
	void bmx_mplayer_setvisible(mpLayer * layer, int show);
	MaxBrush * bmx_mplayer_getbrush(mpLayer * layer);
	void bmx_mplayer_setbrush(mpLayer * layer, MaxBrush * brush);
	void bmx_mplayer_setcontinuity(mpLayer * layer, int continuity);
	int bmx_mplayer_getcontinuity(mpLayer * layer);
	void bmx_mplayer_showname(mpLayer * layer, int show);

	MaxMpFX * bmx_mpfx_create(BBObject * maxHandle, BBString * name, int flags);

	MaxScaleX * bmx_mpscalex_create(BBObject * maxHandle, BBString * name, int flags, int ticks, int type);
	void bmx_mpscalex_setalign(mpScaleX * layer, int align);
	void bmx_mpscalex_setticks(mpScaleX * layer, int ticks);
	int bmx_mpscalex_getticks(mpScaleX * layer);
	int bmx_mpscalex_getlabelmode(mpScaleX * layer);
	void bmx_mpscalex_setlabelmode(mpScaleX * layer, int labelMode);
	void bmx_mpscalex_setlabelformat(mpScaleX * layer, BBString * format);
	BBString * bmx_mpscalex_getlabelformat(mpScaleX * layer);

	MaxScaleY * bmx_mpscaley_create(BBObject * maxHandle, BBString * name, int flags, int ticks);
	void bmx_mpscaley_setalign(mpScaleY * layer, int align);
	void bmx_mpscaley_setticks(mpScaleY * layer, int ticks);
	int bmx_mpscaley_getticks(mpScaleY * layer);
	void bmx_mpscaley_setlabelformat(mpScaleY * layer, BBString * format);
	BBString * bmx_mpscaley_getlabelformat(mpScaleY * layer);

	MaxMpFY * bmx_mpfy_create(BBObject * maxHandle, BBString * name, int flags);

	MaxMpFXY * bmx_mpfxy_create(BBObject * maxHandle, BBString * name, int flags);

	MaxMpPolygon * bmx_mppolygon_create(BBObject * handle, BBString * name);
	void bmx_mppolygon_setpoints(MaxMpPolygon * poly, BBArray * pointsXs, BBArray * pointsYs, int closedShape);

	MaxMpCovarianceEllipse * bmx_mpcovarianceelipse_create(BBObject * handle, double cov00, double cov11, double cov01, double quantiles, int segments, BBString * layerName);
	double bmx_mpcovarianceelipse_getquantiles(mpCovarianceEllipse * ellipse);
	void bmx_mpcovarianceelipse_setquantiles(mpCovarianceEllipse * ellipse, double q);
	void bmx_mpcovarianceelipse_setsegments(mpCovarianceEllipse * ellipse, int segments);
	int bmx_mpcovarianceelipse_getsegments(mpCovarianceEllipse * ellipse);
	void bmx_mpcovarianceelipse_setcovariancematrix(mpCovarianceEllipse * ellipse, double cov00, double cov01, double cov11);

	MaxMpBitmapLayer * bmx_mpbitmaplayer_create(BBObject * handle);
	MaxImage * bmx_mpbitmaplayer_getbitmapcopy(mpBitmapLayer * layer);
	void bmx_mpbitmaplayer_setbitmap(mpBitmapLayer * layer, MaxImage * image, double x, double y, double w, double h);
	void bmx_mpbitmaplayer_setalign(mpBitmapLayer * layer, int align);

	void bmx_mpmovableobject_getcoordinatebase(mpMovableObject * layer, double * x, double * y, double * phi);
	void bmx_mpmovableobject_setcoordinatebase(mpMovableObject * layer, double x, double y, double phi);
	void bmx_mpmovableobject_setalign(mpMovableObject * layer, int align);

	MaxMpFXYVector * bmx_mpfxyvector_create(BBObject * handle, BBString * name, int flags);
	void bmx_mpfxyvector_setdata(mpFXYVector * layer, BBArray * xs, BBArray * ys);
	void bmx_mpfxyvector_setdataraw(mpFXYVector * layer, double * xs, double * ys, int length);
	void bmx_mpfxyvector_clear(mpFXYVector * layer);

	MaxMpText * bmx_mptext_create(BBObject * handle, BBString * name, int offsetx, int offsety);

	MaxMpProfile * bmx_mpprofile_create(BBObject * handle, BBString * name, int flags);
	
	MaxMpPrintout * bmx_mpprintout_create(BBObject * handle, mpWindow * drawWindow, BBString * title);

	void bmx_mpinfolayer_getposition(mpInfoLayer * layer, int * x, int * y);
	void bmx_mpinfolayer_getsize(mpInfoLayer * layer, int * w, int * h);

	MaxMpInfoCoords * bmx_mpinfocoords_create(BBObject * handle, int x, int y, int w, int h, MaxBrush * brush);

	MaxMpInfoLegend * bmx_mpinfolegend_create(BBObject * handle, int x, int y, int w, int h, MaxBrush * brush);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMpWindow : public mpWindow
{
public:
	MaxMpWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long flags);
	~MaxMpWindow();

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// --------------------------------------------------------

class MaxMpFX : public mpFX
{
public:
	MaxMpFX(BBObject * handle, wxString name, int flags);
	~MaxMpFX();

	virtual double GetY(double x);
	virtual double GetMinY();
	virtual double GetMaxY();
private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxScaleX : public mpScaleX
{
public:
	MaxScaleX(BBObject * handle, wxString name, int flags, bool ticks, int type);
	~MaxScaleX();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxScaleY : public mpScaleY
{
public:
	MaxScaleY(BBObject * handle, wxString name, int flags, bool ticks);
	~MaxScaleY();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpFY : public mpFY
{
public:
	MaxMpFY(BBObject * handle, wxString name, int flags);
	~MaxMpFY();

	virtual double GetX(double x);
	virtual double GetMinX();
	virtual double GetMaxX();
private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpFXY : public mpFXY
{
public:
	MaxMpFXY(BBObject * handle, wxString name, int flags);
	~MaxMpFXY();

	virtual void Rewind();
	virtual bool GetNextXY(double &x, double &y);
	virtual double GetMinX();
	virtual double GetMaxX();
	virtual double GetMinY();
	virtual double GetMaxY();
private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpPolygon : public mpPolygon
{
public:
	MaxMpPolygon(BBObject * handle, wxString name);
	~MaxMpPolygon();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpCovarianceEllipse : public mpCovarianceEllipse 
{
public:
	MaxMpCovarianceEllipse (BBObject * handle, double cov_00, double cov_11, double cov_01, double quantiles, int segments, wxString layerName);
	~MaxMpCovarianceEllipse ();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpBitmapLayer : public mpBitmapLayer
{
public:
	MaxMpBitmapLayer(BBObject * handle);
	~MaxMpBitmapLayer();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpFXYVector : public mpFXYVector
{
public:
	MaxMpFXYVector(BBObject * handle, wxString name, int flags);
	~MaxMpFXYVector();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpText : public mpText
{
public:
	MaxMpText(BBObject * handle, wxString name, int offsetx, int offsety);
	~MaxMpText();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpProfile : public mpProfile
{
public:
	MaxMpProfile(BBObject * handle, wxString name, int flags);
	~MaxMpProfile();

	virtual double GetY(double x);

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpPrintout : public mpPrintout
{
public:
	MaxMpPrintout(BBObject * handle, mpWindow * window, wxString name);
	~MaxMpPrintout();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpInfoCoords : public mpInfoCoords
{
public:
	MaxMpInfoCoords(BBObject * handle, int x, int y, int w, int h, const wxBrush * brush);
	~MaxMpInfoCoords();

private:
	BBObject * maxHandle;
};

// --------------------------------------------------------

class MaxMpInfoLegend : public mpInfoLegend
{
public:
	MaxMpInfoLegend(BBObject * handle, int x, int y, int w, int h, const wxBrush * brush);
	~MaxMpInfoLegend();

private:
	BBObject * maxHandle;
};
