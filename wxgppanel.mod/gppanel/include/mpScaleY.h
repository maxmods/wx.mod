#ifndef _MP_SCALEY_H_
#define _MP_SCALEY_H_
#include "mpLayer.h"

/** Plot layer implementing a y-scale ruler.
If align is set to mpALIGN_CENTER, the ruler is fixed at X=0 in the coordinate system. If the align is set to mpALIGN_TOP or mpALIGN_BOTTOM, the axis is always drawn respectively at top or bottom of the window. A label is plotted at
the top-right hand of the ruler. The scale numbering automatically
adjusts to view and zoom factor.
*/
class WXDLLIMPEXP_MATHPLOT mpScaleY : public mpLayer
{
public:
	/** @param name Label to plot by the ruler
	@param flags Set position of the scale respect to the window.
	@param ticks Select ticks or grid. Give TRUE (default) for drawing axis ticks, FALSE for drawing the grid */
	mpScaleY(wxString name = wxT("Y"), int flags = mpALIGN_CENTER, bool ticks = true);

	/** Layer plot handler.
	This implementation will plot the ruler adjusted to the visible area.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

	/** Check whether this layer has a bounding box.
	This implementation returns \a FALSE thus making the ruler invisible
	to the plot layer bounding box calculation by mpWindow.
	*/
	virtual bool HasBBox() { return FALSE; }

	virtual bool IsScaleYLayer() { return true; }

	/** Set Y axis alignment.
	@param align alignment (choose between mpALIGN_BORDER_LEFT, mpALIGN_LEFT, mpALIGN_CENTER, mpALIGN_RIGHT, mpALIGN_BORDER_RIGHT) */
	void SetAlign(int align) { m_flags = align; };

	/** Set Y axis ticks or grid
	@param ticks TRUE to plot axis ticks, FALSE to plot grid. */
	void SetTicks(bool ticks) { m_ticks = ticks; };

	/** Get Y axis ticks or grid
	@return TRUE if plot is drawing axis ticks, FALSE if the grid is active. */
	bool GetTicks() { return m_ticks; };


	/** Set Y axis Label format.
	@param format The format string */
	void SetLabelFormat(const wxString& format) { m_labelFormat = format; };

	/** Get Y axis Label format.
	@return The format string */
	const wxString& SetLabelFormat() { return m_labelFormat; };

	/** Get X axis label colour of the text.
	@return the current wxColour of the ticks labels */
	const wxColour& GetTicksColour() const { return m_pTicksLabelColour; }

	/** Get X axis label colour of the text.
	@param c set the new colour of the ticks labels */
	void SetTicksColour(const wxColour &c) { m_pTicksLabelColour = c; }

	/** Get reference to context menu of the plot canvas.
	@return Pointer to menu. The menu can be modified.
	*/
	wxMenu* GetPopupMenu() { return &m_popmenu; }
	virtual bool Inside(const wxPoint& point);
	void popup(wxWindow& win, wxMouseEvent& event)
	{
		win.PopupMenu(&m_popmenu, event.GetX(), event.GetY());
	}

protected:
	int m_flags;        //!< Flag for axis alignment
	bool m_ticks;       //!< Flag to toggle between ticks or grid
	wxString m_labelFormat; //!< Format string used to print labels

	wxColour m_pTicksLabelColour; //!< The colour of the ticks at the axis. It can be get/set by Get/SetTicksColour member function.

	wxRect  m_labelRect;
	wxMenu  m_popmenu;  //!< user handled popupmenu when clicked the point shape

	DECLARE_DYNAMIC_CLASS(mpScaleY)
};

#endif