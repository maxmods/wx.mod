#include "mpFX.h"
#include "mpWindow.h"

IMPLEMENT_ABSTRACT_CLASS(mpFX, mpLayer)

mpFX::mpFX(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
	m_markCorners = false;
	m_drawOutsideMargins = false;
	m_cornerMarkSize = 3;
}

void mpFX::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);

		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		wxCoord iy = 0;
		if (m_pen.GetWidth() <= 1)
		{
			for (wxCoord i = startPx; i < endPx; ++i)
			{
				iy = w.y2p(GetY(w.p2x(i)));
				// Draw the point only if you can draw outside margins or if the point is inside margins
				if (m_drawOutsideMargins || ((iy >= minYpx) && (iy <= maxYpx)))
				{
					dc.DrawPoint(i, iy);// (wxCoord) ((w.GetPosY() - GetY( (double)i / w.GetScaleX() + w.GetPosX()) ) * w.GetScaleY()));
										//dc.DrawLine( i, iy, i, iy);
					if (m_markCorners)
					{
						dc.DrawCircle(i, iy, m_cornerMarkSize);
					}
				}

			}
		}
		else
		{
			for (wxCoord i = startPx; i < endPx; ++i)
			{
				iy = w.y2p(GetY(w.p2x(i)));
				// Draw the point only if you can draw outside margins or if the point is inside margins
				if (m_drawOutsideMargins || ((iy >= minYpx) && (iy <= maxYpx)))
				{
					dc.DrawPoint(i, iy);
					//dc.DrawLine( i, iy, i, iy);
					if (m_markCorners)
					{
						dc.DrawCircle(i, iy, m_cornerMarkSize);
					}
				}

				//             wxCoord c = w.y2p( GetY(w.p2x(i)) ); //(wxCoord) ((w.GetPosY() - GetY( (double)i / w.GetScaleX() + w.GetPosX()) ) * w.GetScaleY());

			}
		}

		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			/*if ((m_flags & mpALIGNMASK) == mpALIGN_RIGHT)
			tx = (w.GetScrX()>>1) - tx - 8;
			else if ((m_flags & mpALIGNMASK) == mpALIGN_CENTER)
			tx = -tx/2;
			else
			tx = -(w.GetScrX()>>1) + 8;
			*/
			if ((m_flags & mpALIGNMASK) == mpALIGN_RIGHT)
				tx = (w.GetScrX() - tx) - w.GetMarginRight() - 8;
			else if ((m_flags & mpALIGNMASK) == mpALIGN_CENTER)
				tx = ((w.GetScrX() - w.GetMarginRight() - w.GetMarginLeft() - tx) / 2) + w.GetMarginLeft();
			else
				tx = w.GetMarginLeft() + 8;
			dc.DrawText(m_name, tx, w.y2p(GetY(w.p2x(tx)))); // (wxCoord) ((w.GetPosY() - GetY( (double)tx / w.GetScaleX() + w.GetPosX())) * w.GetScaleY()) );
		}
	}
}
void mpFX::MarkCorners(bool t) { m_markCorners = t; }