#ifndef _MP_INFOLEGEND_H_
#define _MP_INFOLEGEND_H_

#include "mpInfoLayer.h"

/** @class mpInfoLegend
@brief Implements the legend to be added to the plot
This layer allows to add a legend to describe the plots in the window. The legend uses the layer name as a label, and displays only layers of type mpLAYER_PLOT. */
class WXDLLIMPEXP_MATHPLOT mpInfoLegend : public mpInfoLayer
{
public:
	/** Default constructor */
	mpInfoLegend();

	/** Complete constructor, setting initial rectangle and background brush.
	@param rect The initial bounding rectangle.
	@param brush The wxBrush to be used for box background: default is transparent
	@sa mpInfoLayer::mpInfoLayer */
	mpInfoLegend(wxRect rect, const wxBrush* brush = wxTRANSPARENT_BRUSH);

	/**  Default destructor */
	virtual ~mpInfoLegend();

	virtual bool IsInfoLegendLayer() { return true; }

	/** Updates the content of the info box. Unused in this class.
	@param w parent mpWindow from which to obtain information
	@param event The event which called the update. */
	virtual void UpdateInfo(mpWindow& w, wxEvent& event);

	/** Plot method.
	@param dc the device content where to plot
	@param w the window to plot
	@sa mpLayer::Plot */
	virtual void   Plot(wxDC & dc, mpWindow & w);

	wxMenu* GetPopupMenu() { return &m_popmenu; }
	void popup(wxWindow& win, wxMouseEvent& event)
	{
		win.PopupMenu(&m_popmenu, event.GetX(), event.GetY());
	}

protected:
private:
	wxMenu m_popmenu;

};

#endif