#ifndef _MP_MPLAYER_H_
#define _MP_MPLAYER_H_

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
#include "mathplot.h"


class mpWindow;

typedef enum __mp_Layer_Type {
	mpLAYER_UNDEF      //!< Layer type undefined
	, mpLAYER_AXIS       //!< Axis type layer
	, mpLAYER_PLOT       //!< Plot type layer
	, mpLAYER_INFO       //!< Info box type layer
	, mpLAYER_BITMAP     //!< Bitmap type layer
	, mpLayer_POINT      //!< Point layer
} mpLayerType;

enum mpShape
{
	mpCIRCLE
	, mpRECT
	, mpPOINT
	, mpDIAMOND
	, mpSQUARE
	, mpELLIPSE
	, mpARROW_UP
	, mpARROW_DOWN
	, mpARROW_UPDOWN
};


/** Plot layer, abstract base class.
Any number of mpLayer implementations can be attached to mpWindow.
Examples for mpLayer implementations are function graphs, or scale rulers.

For convenience mpLayer defines a name, a font (wxFont), a pen (wxPen),
and a continuity property (bool) as class members.
The default values at constructor are the default font, a black pen, and
continuity set to false (draw separate points).
These may or may not be used by implementations.
*/
class WXDLLIMPEXP_MATHPLOT mpLayer : public wxObject
{
public:
	mpLayer();

	virtual ~mpLayer() {};

	/** Check whether this layer has a bounding box.
	The default implementation returns \a TRUE. Override and return
	FALSE if your mpLayer implementation should be ignored by the calculation
	of the global bounding box for all layers in a mpWindow.
	@retval TRUE Has bounding box
	@retval FALSE Has not bounding box
	*/
	virtual bool   HasBBox() { return TRUE; }

	/** Check whether the layer is an info box.
	The default implementation returns \a FALSE. It is overrided to \a TRUE for mpInfoLayer
	class and its derivative. It is necessary to define mouse actions behaviour over
	info boxes.
	@return whether the layer is an info boxes
	@sa mpInfoLayer::IsInfo */
	virtual bool IsInfo() { return false; }
	virtual bool IsInfoLegendLayer() { return false; }
	virtual bool IsMovableLayer() { return false; }
	virtual bool IsScaleXLayer() { return false; }
	virtual bool IsScaleYLayer() { return false; }

	/** Check whether the layer is an point.
	The default implementation returns \a FALSE. It is overrided to \a TRUE for mpInfoLayer
	class and its derivative. It is necessary to define mouse actions behaviour over
	point layer.
	@return whether the layer is an point layer
	@sa mpPointLayer::IsPointEnabled */
	virtual bool IsPointLayer() { return false; }
	virtual void UpdateMouseCoord(mpWindow& w, wxEvent& event) {}
	/** Get inclusive left border of bounding box.
	@return Value
	*/
	virtual double GetMinX() { return -1.0; }

	/** Get inclusive right border of bounding box.
	@return Value
	*/
	virtual double GetMaxX() { return  1.0; }

	/** Get inclusive bottom border of bounding box.
	@return Value
	*/
	virtual double GetMinY() { return -1.0; }

	/** Get inclusive top border of bounding box.
	@return Value
	*/
	virtual double GetMaxY() { return  1.0; }
	/**
	*  Search for the closest coordinate of the curve  @Jussi Vatjus-Anttila 9.-09
	*  So far, only implemented on mpFXY layer.
	*  Used by mpPointLayer
	*  @param w    mpWindow
	*  @param x [in+out]  search x coordinate near and set curve coordinate if found
	*  @param y [in+out]  search y coordinate near and set curve coordinate if found
	*  @return true if found curve coordinate
	*/
	virtual bool GetNearestCoord(mpWindow & w, double & x, double & y) { return false; }

	/** Plot given view of layer to the given device context.
	An implementation of this function has to transform layer coordinates to
	wxDC coordinates based on the view parameters retrievable from the mpWindow
	passed in \a w.
	Note that the public methods of mpWindow: x2p,y2p and p2x,p2y are already provided
	which transform layer coordinates to DC pixel coordinates, and <b>user code should rely
	on them</b> for portability and future changes to be applied transparently, instead of
	implementing the following formulas manually.

	The passed device context \a dc has its coordinate origin set to the top-left corner
	of the visible area (the default). The coordinate orientation is as show in the
	following picture:
	<pre>
	(wxDC origin 0,0)
	x-------------> ascending X ----------------+
	|                                           |
	|                                           |
	V ascending Y                               |
	|                                           |
	|                                           |
	|                                           |
	+-------------------------------------------+  <-- right-bottom corner of the mpWindow visible area.
	</pre>
	Note that Y ascends in downward direction, whereas the usual vertical orientation
	for mathematical plots is vice versa. Thus Y-orientation will be swapped usually,
	when transforming between wxDC and mpLayer coordinates. This change of coordinates
	is taken into account in the methods p2x,p2y,x2p,y2p.

	<b> Rules for transformation between mpLayer and wxDC coordinates </b>
	@code
	dc_X = (layer_X - mpWindow::GetPosX()) * mpWindow::GetScaleX()
	dc_Y = (mpWindow::GetPosY() - layer_Y) * mpWindow::GetScaleY() // swapping Y-orientation

	layer_X = (dc_X / mpWindow::GetScaleX()) + mpWindow::GetPosX() // scale guaranteed to be not 0
	layer_Y = mpWindow::GetPosY() - (dc_Y / mpWindow::GetScaleY()) // swapping Y-orientation
	@endcode

	@param dc Device context to plot to.
	@param w  View to plot. The visible area can be retrieved from this object.
	@sa mpWindow::p2x,mpWindow::p2y,mpWindow::x2p,mpWindow::y2p
	*/
	virtual void   Plot(wxDC & dc, mpWindow & w) = 0;

	/** Get layer name.
	@return Name
	*/
	wxString       GetName() const { return m_name; }

	/** Get font set for this layer.
	@return Font
	*/
	const wxFont&  GetFont() const { return m_font; }

	/** Get pen set for this layer.
	@return Pen
	*/
	const wxPen&   GetPen()  const { return m_pen; }

	/** Set the 'continuity' property of the layer (true:draws a continuous line, false:draws separate points).
	* @sa GetContinuity
	*/
	void SetContinuity(bool continuity) { m_continuous = continuity; }

	/** Gets the 'continuity' property of the layer.
	* @sa SetContinuity
	*/
	bool GetContinuity() const { return m_continuous; }

	/** Shows or hides the text label with the name of the layer (default is visible).
	*/
	void ShowName(bool show) { m_showName = show; };

	/** Set layer name
	@param name Name, will be copied to internal class member
	*/
	void SetName(wxString name) { m_name = name; }

	/** Set layer font
	@param font Font, will be copied to internal class member
	*/
	void SetFont(wxFont& font) { m_font = font; }

	/** Set layer pen
	@param pen Pen, will be copied to internal class member
	*/
	void SetPen(wxPen pen) { m_pen = pen; }

	/** Set Draw mode: inside or outside margins. Default is outside, which allows the layer to draw up to the mpWindow border.
	@param drawModeOutside The draw mode to be set */
	void SetDrawOutsideMargins(bool drawModeOutside) { m_drawOutsideMargins = drawModeOutside; };

	/** Get Draw mode: inside or outside margins.
	@return The draw mode */
	bool GetDrawOutsideMargins() { return m_drawOutsideMargins; };

	/** Get a small square bitmap filled with the colour of the pen used in the layer. Useful to create legends or similar reference to the layers.
	@param side side length in pixels
	@return a wxBitmap filled with layer's colour */
	wxBitmap GetColourSquare(int side = 16);

	/** Get layer type: a Layer can be of different types: plot lines, axis, info boxes, etc, this method returns the right value.
	@return An integer indicating layer type */
	mpLayerType GetLayerType() const { return m_type; }

	/** Get point type: each layer can be drawn with a specific point type e.g. mpPOINT, mpCIRCLE, mpRECT
	@return <-- the current point type*/
	mpShape GetPointType() const { return m_pointType; }

	/** Set point type: each layer can be drawn with a specific point type e.g. mpPOINT, mpCIRCLE, mpRECT
	@param pt --> set the current point type*/
	void SetPointType(const mpShape& pt) { m_pointType = pt; }

	/** Checks whether the layer is visible or not.
	@return \a true if visible */
	bool IsVisible() { return m_visible; };

	/** Sets layer visibility.
	@param show visibility bool. */
	void SetVisible(bool show) { m_visible = show; }

	/** Get brush set for this layer.
	@return brush. */
	const wxBrush&   GetBrush() const { return m_brush; };

	/** Set layer brush
	@param brush brush, will be copied to internal class member	*/
	void SetBrush(wxBrush brush) { m_brush = brush; };

	void invert(bool value) { m_invert = value; }
	bool getInvert() { return m_invert; }

	/** Set Layer drawing order
	n = {0..10}
	@param n  when layer drawn. 0= first, 10=last
	*/
	//void SetDrawingOrder(int n){ m_drawingOrder = n; }

protected:
	wxFont   m_font;        //!< Layer's font
	wxPen    m_pen;         //!< Layer's pen
	wxBrush  m_brush;       //!< Layer's brush
	wxString m_name;        //!< Layer's name
	bool     m_continuous;  //!< Specify if the layer will be plotted as a continuous line or a set of points.
	bool     m_showName;    //!< States whether the name of the layer must be shown (default is true).
	bool     m_drawOutsideMargins; //!< select if the layer should draw only inside margins or over all DC
	mpLayerType m_type;     //!< Define layer type, which is assigned by constructor
	bool 	m_visible;	    //!< Toggles layer visibility
	bool	m_invert;		//< Invert the chart

	mpShape m_pointType; //!< Define a point type, the default is a simple point
	wxSize  m_RectSize; //!< The size of rectangles, when plotstyle mpRECT is used
						//int     m_drawingOrder; //!< Drawing order
	DECLARE_DYNAMIC_CLASS(mpLayer)
};

#endif