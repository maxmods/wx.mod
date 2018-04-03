#include "mpText.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpText - provided by Val Greene
//-----------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(mpText, mpLayer)


/** @param name text to be displayed
@param offsetx x position in percentage (0-100)
@param offsetx y position in percentage (0-100)
*/
mpText::mpText(wxString name, int offsetx, int offsety)
{
	SetName(name);

	if (offsetx >= 0 && offsetx <= 100)
		m_offsetx = offsetx;
	else
		m_offsetx = 5;

	if (offsety >= 0 && offsety <= 100)
		m_offsety = offsety;
	else
		m_offsetx = 50;
	m_type = mpLAYER_INFO;
}

/** mpText Layer plot handler.
This implementation will plot the text adjusted to the visible area.
*/

void mpText::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);
		dc.SetFont(m_font);

		wxCoord tw = 0, th = 0;
		dc.GetTextExtent(GetName(), &tw, &th);

		//     int left = -dc.LogicalToDeviceX(0);
		//     int width = dc.LogicalToDeviceX(0) - left;
		//     int bottom = dc.LogicalToDeviceY(0);
		//     int height = bottom - -dc.LogicalToDeviceY(0);

		/*    dc.DrawText( GetName(),
		(int)((((float)width/100.0) * m_offsety) + left - (tw/2)),
		(int)((((float)height/100.0) * m_offsetx) - bottom) );*/
		int px = m_offsetx*(w.GetScrX() - w.GetMarginLeft() - w.GetMarginRight()) / 100;
		int py = m_offsety*(w.GetScrY() - w.GetMarginTop() - w.GetMarginBottom()) / 100;
		dc.DrawText(GetName(), px, py);
	}
}