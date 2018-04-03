#include "mpProfile.h"
#include "mpWindow.h"


//-----------------------------------------------------------------------------
// mpProfile implementation
//-----------------------------------------------------------------------------

IMPLEMENT_ABSTRACT_CLASS(mpProfile, mpLayer)

mpProfile::mpProfile(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
}

void mpProfile::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);

		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		// Plot profile linking subsequent point of the profile, instead of mpFY, which plots simple points.
		for (wxCoord i = startPx; i < endPx; ++i)
		{
			wxCoord c0 = w.y2p(GetY(w.p2x(i))); // (wxCoord) ((w.GetYpos() - GetY( (double)i / w.GetXscl() + w.GetXpos()) ) * w.GetYscl());
			wxCoord c1 = w.y2p(GetY(w.p2x(i + 1)));//(wxCoord) ((w.GetYpos() - GetY( (double)(i+1) / w.GetXscl() + (w.GetXpos() ) ) ) * w.GetYscl());
												   // c0 = (c0 <= maxYpx) ? ((c0 >= minYpx) ? c0 : minYpx) : maxYpx;
												   // c1 = (c1 <= maxYpx) ? ((c1 >= minYpx) ? c1 : minYpx) : maxYpx;
			if (!m_drawOutsideMargins) {
				c0 = (c0 <= maxYpx) ? ((c0 >= minYpx) ? c0 : minYpx) : maxYpx;
				c1 = (c1 <= maxYpx) ? ((c1 >= minYpx) ? c1 : minYpx) : maxYpx;
			}
			dc.DrawLine(i, c0, i + 1, c1);
		};
		if (!m_name.IsEmpty())
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			if ((m_flags & mpALIGNMASK) == mpALIGN_RIGHT)
				tx = (w.GetScrX() - tx) - w.GetMarginRight() - 8;
			else if ((m_flags & mpALIGNMASK) == mpALIGN_CENTER)
				tx = ((w.GetScrX() - w.GetMarginRight() - w.GetMarginLeft() - tx) / 2) + w.GetMarginLeft();
			else
				tx = w.GetMarginLeft() + 8;

			dc.DrawText(m_name, tx, w.y2p(GetY(w.p2x(tx))));//(wxCoord) ((w.GetPosY() - GetY( (double)tx / w.GetScaleX() + w.GetPosX())) * w.GetScaleY()) );
		}
	}
}