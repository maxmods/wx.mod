/////////////////////////////////////////////////////////////////////////////
// Name:            mathplot.cpp
// Purpose:         Framework for plotting in wxWindows
// Original Author: David Schalig
// Maintainer:      Davide Rondini
// Contributors:    Jose Luis Blanco, Val Greene
// Created:         21/07/2003
// Last edit:       22/02/2009
// Copyright:       (c) David Schalig, Davide Rondini
// Licence:         wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef _MP_MATHPLOT_H_
#define _MP_MATHPLOT_H_

/** @file mathplot.h */
/** @mainpage wxMathPlot
    wxMathPlot is a framework for mathematical graph plotting in wxWindows.

    The framework is designed for convenience and ease of use.

    @section screenshots Screenshots
    <a href="http://wxmathplot.sourceforge.net/screenshot.shtml">Go to the screenshots page.</a>

    @section overview Overview
    The heart of wxMathPlot is mpWindow, which is a 2D canvas for plot layers.
    mpWindow can be embedded as subwindow in a wxPane, a wxFrame, or any other wxWindow.
    mpWindow provides a zoomable and moveable view of the layers. The current view can
    be controlled with the mouse, the scrollbars, and a context menu.

    Plot layers are implementations of the abstract base class mpLayer. Those can
    be function plots, scale rulers, or any other vector data visualisation. wxMathPlot provides two mpLayer implementations for plotting horizontal and vertical rulers: mpScaleX and mpScaleY.
    For convenient function plotting a series of classes derived from mpLayer are provided, like mpFX, mpProfile, mpLegend and so on. These base classes already come with plot code, user's own functions can be implemented by overriding just one member for retrieving a function value.

    mpWindow has built-in support for mouse-based pan and zoom through intuitive combinations of buttons and the mouse wheel. It also incorporates an optional double buffering mechanism to avoid flicker. Plots can be easily sent to printer evices or exported in bitmap formats like PNG, BMP or JPEG.

    @section coding Coding conventions
    wxMathPlot sticks to wxWindow's coding conventions. All entities defined by wxMathPlot have the prefix <i>mp</i>.

    @section author Author and license
    wxMathPlot is published under the terms of the wxWindow license.<br>
    The original author is David Schalig <mrhill@users.sourceforge.net>.<br>
    From June 2007 the project is maintained by Davide Rondini <cdron77@users.sourceforge.net>.<br>
    Authors can be contacted via the wxMathPlot's homepage at
    https://sourceforge.net/projects/wxmathplot<br>
    Contributors:<br>
    Jose Luis Blanco, Val Greene.<br>
*/

//this definition uses windows dll to export function.
//WXDLLIMPEXP_MATHPLOT definition definition changed to WXDLLIMPEXP_MATHPLOT
//mathplot_EXPORTS will be defined by cmake
#ifdef mathplot_EXPORTS
 #define WXDLLIMPEXP_MATHPLOT WXEXPORT
 #define WXDLLIMPEXP_DATA_MATHPLOT(type) WXEXPORT type
#else // not making DLL
 #define WXDLLIMPEXP_MATHPLOT
 #define WXDLLIMPEXP_DATA_MATHPLOT(type) type
#endif

#if defined(__GNUG__) && !defined(__APPLE__)
#pragma interface "mathplot.h"
#endif

#include <vector>

// #include <wx/wx.h>
#include <wx/defs.h>
#include <wx/menu.h>
#include <wx/scrolwin.h>
#include <wx/event.h>
#include <wx/dynarray.h>
#include <wx/pen.h>
#include <wx/dcmemory.h>
#include <wx/string.h>
#include <wx/print.h>
#include <wx/image.h>

#include <wx/tipwin.h>
#include <wx/gdicmn.h>

#include <deque>
#include <map>

#include "mpLayer.h"

//WX_DECLARE_LIST(wxPoint, PointList);
//#include <wx/listimpl.cpp>


// For memory leak debug
#ifdef _WINDOWS
#ifdef _DEBUG
#include <crtdbg.h>
#define DEBUG_NEW new(_NORMAL_BLOCK ,__FILE__, __LINE__)
#else
#define DEBUG_NEW new
#endif // _DEBUG
#endif // _WINDOWS

// Separation for axes when set close to border
#define X_BORDER_SEPARATION 40
#define Y_BORDER_SEPARATION 60

//-----------------------------------------------------------------------------
// classes
//-----------------------------------------------------------------------------

class WXDLLIMPEXP_MATHPLOT mpLayer;
class WXDLLIMPEXP_MATHPLOT mpFX;
class WXDLLIMPEXP_MATHPLOT mpFY;
class WXDLLIMPEXP_MATHPLOT mpFXY;
class WXDLLIMPEXP_MATHPLOT mpFXYBar;
class WXDLLIMPEXP_MATHPLOT mpFYXBar;
class WXDLLIMPEXP_MATHPLOT mpFXYCandleStick;
class WXDLLIMPEXP_MATHPLOT mpFXYVector;
class WXDLLIMPEXP_MATHPLOT mpScaleX;
class WXDLLIMPEXP_MATHPLOT mpScaleY;
class WXDLLIMPEXP_MATHPLOT mpWindow;
class WXDLLIMPEXP_MATHPLOT mpText;
class WXDLLIMPEXP_MATHPLOT mpPrintout;
class WXDLLIMPEXP_MATHPLOT mpPointLayer;
class WXDLLIMPEXP_MATHPLOT mpXYArea;

/** Command IDs used by mpWindow */
enum
{
    mpID_FIT = 2000,    //!< Fit view to match bounding box of all layers
    mpID_ZOOM_IN,       //!< Zoom into view at clickposition / window center
    mpID_ZOOM_OUT,      //!< Zoom out
    mpID_CENTER,        //!< Center view on click position
    mpID_LOCKASPECT,    //!< Lock x/y scaling aspect
    mpID_GRID,
    mpID_HELP_MOUSE     //!< Shows information about the mouse commands
};
typedef enum __mp_Mouse_Zoom_Type {
     mpZOOM_XY          //!< zoom 2 dimensialy
    ,mpZOOM_X
    ,mpZOOM_Y
} mpMouseZoomType;
//-----------------------------------------------------------------------------
// mpLayer
//-----------------------------------------------------------------------------

struct mpXY
{
    double x, y;
    mpXY(double _x, double _y){x=_x;y=_y;}
    mpXY(const mpXY& copy){x=copy.x;y=copy.y;}
};




//-----------------------------------------------------------------------------
// mpInfoLayer
//-----------------------------------------------------------------------------





//-----------------------------------------------------------------------------
// mpLayer implementations - functions
//-----------------------------------------------------------------------------

/** @name Label alignment constants
@{*/

/** @internal */
#define mpALIGNMASK    0x03
/** Aligns label to the right. For use with mpFX. */
#define mpALIGN_RIGHT  0x00
/** Aligns label to the center. For use with mpFX and mpFY. */
#define mpALIGN_CENTER 0x01
/** Aligns label to the left. For use with mpFX. */
#define mpALIGN_LEFT   0x02
/** Aligns label to the top. For use with mpFY. */
#define mpALIGN_TOP    mpALIGN_RIGHT
/** Aligns label to the bottom. For use with mpFY. */
#define mpALIGN_BOTTOM mpALIGN_LEFT
/** Aligns X axis to bottom border. For mpScaleX */
#define mpALIGN_BORDER_BOTTOM  0x04
/** Aligns X axis to top border. For mpScaleX */
#define mpALIGN_BORDER_TOP  0x05
/** Set label for X axis in normal mode */
#define mpX_NORMAL  0x00
/** Set label for X axis in time mode: the value is represented as minutes:seconds.milliseconds if time is less than 2 minutes, hours:minutes:seconds otherwise*/
#define mpX_TIME  0x01
/** Set label for X axis in hours mode: the value is always represented as hours:minutes:seconds*/
#define mpX_HOURS 0x02
/** Set label for X axis in date mode: the value is always represented as yyyy-mm-dd. */
#define mpX_DATE 0x03
/** Set label for X axis in datetime mode: the value is always represented as yyyy-mm-ddThh:mm:ss. */
#define mpX_DATETIME 0x04
/*LOGtest* Set label for X axis in logarithmic mode */
#define mpX_LOGARITHMIC 0x05									//################################LOGtest##########################
/** Aligns Y axis to left border. For mpScaleY */
#define mpALIGN_BORDER_LEFT mpALIGN_BORDER_BOTTOM
/** Aligns Y axis to right border. For mpScaleY */
#define mpALIGN_BORDER_RIGHT mpALIGN_BORDER_TOP
/** Aligns label to north-east. For use with mpFXY. */
#define mpALIGN_NE     0x00
/** Aligns label to north-west. For use with mpFXY. */
#define mpALIGN_NW     0x01
/** Aligns label to south-west. For use with mpFXY. */
#define mpALIGN_SW     0x02
/** Aligns label to south-east. For use with mpFXY. */
#define mpALIGN_SE     0x03

/*@}*/

/** @name mpLayer implementations - functions
@{*/













/*@}*/

//-----------------------------------------------------------------------------
// mpLayer implementations - furniture (scales, ...)
//-----------------------------------------------------------------------------

/** @name mpLayer implementations - furniture (scales, ...)
 @{ */















//-----------------------------------------------------------------------------
// mpMovableObject  - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// mpPointLayer  - provided by Jussi Vatjus-Anttila
//-----------------------------------------------------------------------------
/** This virtual class represents objects that consist one changeable point (currently only circle).
  *	Circle is placed to another mpLayer spesific place (currently only mpFXY is implemented[implementation can be better..] )
  */


enum mpTaggLine
{
     mpVERTICAL_LINE=1
    ,mpHORIZONTAL_LINE=2
    ,mpCROSS_LINES=4
};
class polygon
{
	private:
		wxPointList m_polygon;

	public:
		polygon(wxPointList poly)                 { m_polygon = poly; }
		~polygon()                              { }
		polygon(const polygon& poly)            { m_polygon = poly.GetPolygon(); } //copy constructor
		void SetPolygon(const wxPointList& poly)  { m_polygon = poly; }
		wxPointList GetPolygon() const            { return m_polygon; }
		wxPointList get(double angle=0, double scale=1)
		{
			wxPointList out;
			wxPointList::iterator it;
			for(it=m_polygon.begin();it!=m_polygon.end();++it)
			{
				out.Append( rotate(**it, angle, scale) );
			}
			return out;
		}

	private:
		/**
		*             _          _
		*            |  m11  m12  |
		*       [x y]|  m21  m22  | = [m11*x + m21*y, m12*x + m22*y]
		*            |_ 0    0   _|
		*
		*       Rotation Clockwise by Ø, scaling isotropic by s
		*             _                    _
		*            | s * cos Ø    sin Ø   |
		*       [x y]|  -sin Ø    s * cos Ø |=[sx*(cos Ø)*x-(sin Ø)*y,
		*            |_    0          0    _|  (sin Ø)*x+sy*(cos Ø)*y]
		*/
		wxPoint* rotate(wxPoint pt, double angle, double scale, bool angleInRadians=false)
		{
			 wxPoint *point = new wxPoint();
			 double theta = angleInRadians?angle:2*M_PI/360*angle;
			 point->x = (int)(scale * (cos(theta) * pt.x - sin(theta) * pt.y) + 0.5);
			 point->y = (int)(scale * (sin(theta) * pt.x +  cos(theta) * pt.y) +0.5);
			 return point;
		}
};
class mpPointDeriveClass {
    public:
        mpPointDeriveClass(){}
        /** This virtual function must implement to final object */
        virtual void customPlot(wxDC & dc, mpWindow & w, double x0, double y0, double x1, double y1, wxPoint p0, wxPoint p1, int maxYpx) {}
};

/*@}*/

#endif // _MP_MATHPLOT_H_
