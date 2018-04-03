#ifndef _MP_MPINFOLAYER_H_
#define _MP_MPINFOLAYER_H_

#include "mpLayer.h"

/** @class mpInfoLayer
@brief Base class to create small rectangular info boxes
mpInfoLayer is the base class to create a small rectangular info box in transparent overlay over plot layers. It is used to implement objects like legends.
*/
class WXDLLIMPEXP_MATHPLOT mpInfoLayer : public mpLayer
{
public:
	/** Default constructor. */
	mpInfoLayer();

	/** Complete constructor.
	@param rect Sets the initial size rectangle of the layer.
	@param brush pointer to a fill brush. Default is transparent */
	mpInfoLayer(wxRect rect, const wxBrush* brush = wxTRANSPARENT_BRUSH);

	/** Destructor */
	virtual ~mpInfoLayer();

	/** Updates the content of the info box. Should be overidden by derived classes.
	Update may behave in different ways according to the type of event which called it.
	@param w parent mpWindow from which to obtain information
	@param event The event which called the update. */
	virtual void UpdateInfo(mpWindow& w, wxEvent& event);

	/** mpInfoLayer has not bounding box. @sa mpLayer::HasBBox
	@return always \a FALSE */
	virtual bool HasBBox() { return false; };

	/** Plot method. Can be overidden by derived classes.
	@param dc the device content where to plot
	@param w the window to plot
	@sa mpLayer::Plot */
	virtual void   Plot(wxDC & dc, mpWindow & w);

	/** Specifies that this is an Info box layer.
	@return always \a TRUE
	@sa mpLayer::IsInfo */
	virtual bool IsInfo() { return true; };

	/** Checks whether a point is inside the info box rectangle.
	@param point The point to be checked
	@return \a true if the point is inside the bounding box */
	virtual bool Inside(wxPoint& point);

	/** Moves the layer rectangle of given pixel deltas.
	@param delta The wxPoint container for delta coordinates along x and y. Units are in pixels. */
	virtual void Move(wxPoint delta);

	/** Updates the rectangle reference point. Used by internal methods of mpWindow to correctly move mpInfoLayers. */
	virtual void UpdateReference();

	/** Returns the position of the upper left corner of the box (in pixels)
	@return The rectangle position */
	wxPoint GetPosition();

	/** Returns the size of the box (in pixels)
	@return The rectangle size */
	wxSize GetSize();
	/** Returns the current rectangle coordinates.
	@return The info layer rectangle */
	const wxRect& GetRectangle() { return m_dim; };

protected:
	wxRect m_dim;           //!< The bounding rectangle of the box. It may be resized dynamically by the Plot method.
	wxPoint m_reference;    //!< Holds the reference point for movements
	wxBrush m_brush;        //!< The brush to be used for the background
	int m_winX, m_winY;     //!< Holds the mpWindow size. Used to rescale position when window is resized.

	DECLARE_DYNAMIC_CLASS(mpInfoLayer)
};

#endif