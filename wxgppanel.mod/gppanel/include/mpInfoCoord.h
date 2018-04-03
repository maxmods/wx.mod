#ifndef _MP_MPINFOCOORDS_H_
#define _MP_MPINFOCOORDS_H_

#include "mpInfoLayer.h"
/** @class mpInfoCoords
@brief Implements an overlay box which shows the mouse coordinates in plot units.
When an mpInfoCoords layer is activated, when mouse is moved over the mpWindow, its coordinates (in mpWindow units, not pixels) are continuously reported inside the layer box. */
class WXDLLIMPEXP_MATHPLOT mpInfoCoords : public mpInfoLayer
{
public:
	/** Default constructor */
	mpInfoCoords(unsigned int x_labelType);														//LOGtest "unsigned int x_labelType" added
	/** Complete constructor, setting initial rectangle and background brush.
	@param rect The initial bounding rectangle.
	@param brush The wxBrush to be used for box background: default is transparent */
	mpInfoCoords(wxRect rect, const wxBrush* brush = wxTRANSPARENT_BRUSH);

	/** Default destructor */
	virtual ~mpInfoCoords();

	/** Set format of coordinate string */
	void SetFormat(wxString form) { m_format = form; }

	/** Updates the content of the info box. It is used to update coordinates.
	@param w parent mpWindow from which to obtain information
	@param event The event which called the update. */
	virtual void UpdateInfo(mpWindow& w, wxEvent& event);

	/** Plot method.
	@param dc the device content where to plot
	@param w the window to plot
	@sa mpLayer::Plot */
	virtual void   Plot(wxDC & dc, mpWindow & w);

protected:
	wxString m_content; //!< string holding the coordinates to be drawn.
	wxString m_format;  //!< Format of coordinate string. default: "x = %f y = %f"
	unsigned int m_labelType;		//Added for LOGtest
};

#endif