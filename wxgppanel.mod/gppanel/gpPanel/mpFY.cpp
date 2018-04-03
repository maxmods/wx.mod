#include "mpFY.h"
#include "mpWindow.h"

IMPLEMENT_ABSTRACT_CLASS(mpFY, mpLayer)

mpFY::mpFY(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
}

void mpFY::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);

		wxCoord i, ix;

		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		if (m_pen.GetWidth() <= 1)
		{
			for (i = minYpx; i < maxYpx; ++i)
			{
				ix = w.x2p(GetX(w.p2y(i)));
				if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx)))
				{
					dc.DrawPoint(ix, i);
				}

			}
		}
		else
		{
			for (i = 0; i< w.GetScrY(); ++i)
			{
				ix = w.x2p(GetX(w.p2y(i)));
				if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx)))
				{
					//dc.DrawLine(ix, i, ix, i);
					dc.DrawPoint(ix, i);
				}
				//             wxCoord c =  w.x2p(GetX(w.p2y(i))); //(wxCoord) ((GetX( (double)i / w.GetScaleY() + w.GetPosY()) - w.GetPosX()) * w.GetScaleX());
				//             dc.DrawLine(c, i, c, i);
			}
		}

		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			if ((m_flags & mpALIGNMASK) == mpALIGN_TOP)
				ty = w.GetMarginTop() + 8;
			else if ((m_flags & mpALIGNMASK) == mpALIGN_CENTER)
				ty = ((w.GetScrY() - w.GetMarginTop() - w.GetMarginBottom() - ty) / 2) + w.GetMarginTop();
			else
				ty = w.GetScrY() - 8 - ty - w.GetMarginBottom();

			dc.DrawText(m_name, w.x2p(GetX(w.p2y(ty))), ty); // (wxCoord) ((GetX( (double)i / w.GetScaleY() + w.GetPosY()) - w.GetPosX()) * w.GetScaleX()), -ty);
		}
	}
}
