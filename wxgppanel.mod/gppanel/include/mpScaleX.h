#ifndef _MP_SCALEX_H_
#define _MP_SCALEX_H_
#include "mpLayer.h"

/** Plot layer implementing a x-scale ruler.
The ruler is fixed at Y=0 in the coordinate system. A label is plotted at
the bottom-right hand of the ruler. The scale numbering automatically
adjusts to view and zoom factor.
*/
class WXDLLIMPEXP_MATHPLOT mpScaleX : public mpLayer
{
public:
	/** Full constructor.
	@param name Label to plot by the ruler
	@param flags Set the position of the scale with respect to the window.
	@param ticks Select ticks or grid. Give TRUE (default) for drawing axis ticks, FALSE for drawing the grid.
	@param type mpX_NORMAL for normal labels, mpX_TIME for time axis in hours, minutes, seconds. */
	mpScaleX(wxString name = wxT("X"), int flags = mpALIGN_CENTER, bool ticks = true, unsigned int type = mpX_NORMAL);

	/** Layer plot handler.
	This implementation will plot the ruler adjusted to the visible area.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

	/** Check whether this layer has a bounding box.
	This implementation returns \a FALSE thus making the ruler invisible
	to the plot layer bounding box calculation by mpWindow.
	*/
	virtual bool HasBBox();
	/** Virtual function for @return true because this is xscaler*/
	virtual bool IsScaleXLayer();

	/** Set X axis alignment.
	@param align alignment (choose between mpALIGN_BORDER_BOTTOM, mpALIGN_BOTTOM, mpALIGN_CENTER, mpALIGN_TOP, mpALIGN_BORDER_TOP */
	void SetAlign(int align);

	/** Set X axis ticks or grid
	@param ticks TRUE to plot axis ticks, FALSE to plot grid. */
	void SetTicks(bool ticks);

	/** Get X axis ticks or grid
	@return TRUE if plot is drawing axis ticks, FALSE if the grid is active. */
	bool GetTicks();

	/** Get X axis label colour of the text.
	@return the current wxColour of the ticks labels */
	const wxColour& GetTicksColour() const { return m_pTicksLabelColour; }

	/** Get X axis label colour of the text.
	@param c set the new colour of the ticks labels */
	void SetTicksColour(const wxColour &c) { m_pTicksLabelColour = c; }

	/** Get X axis label view mode.
	@return mpX_NORMAL for normal labels, mpX_TIME for time axis in hours, minutes, seconds. */
	unsigned int GetLabelMode() { return m_labelType; };

	/** Set X axis label view mode.
	@param mode mpX_NORMAL for normal labels, mpX_TIME for time axis in hours, minutes, seconds. */
	void SetLabelMode(unsigned int mode) { m_labelType = mode; };

	/** Set X axis Label format (used for mpX_NORMAL draw mode).
	@param format The format string */
	void SetLabelFormat(const wxString& format) { m_labelFormat = format; };

	/** Get X axis Label format (used for mpX_NORMAL draw mode).
	@return The format string */
	const wxString& GetLabelFormat() { return m_labelFormat; };


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
	int m_flags; //!< Flag for axis alignment
	bool m_ticks; //!< Flag to toggle between ticks or grid
	unsigned int m_labelType; //!< Select labels mode: mpX_NORMAL for normal labels, mpX_TIME for time axis in hours, minutes, seconds
	wxString m_labelFormat; //!< Format string used to print labels

	wxColour m_pTicksLabelColour; //!< The colour of the ticks at the axis. It can be get/set by Get/SetTicksColour member function.
	wxRect  m_labelRect;
	wxMenu  m_popmenu;  //!< user handled popupmenu when clicked the point shape

	DECLARE_DYNAMIC_CLASS(mpScaleX)
};

#endif