#include "mpFX2Y.h"
#include "mpWindow.h"

IMPLEMENT_ABSTRACT_CLASS(mpFX2Y, mpLayer)

mpFX2Y::mpFX2Y(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
}
void mpFX2Y::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);

		double x, y1, y2;
		Rewind();

		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		wxCoord ix = 0, iy = 0, iy1 = 0, iy2 = 0;

		if (!m_continuous)
		{
			// for some reason DrawPoint does not use the current pen,
			// so we use DrawLine for fat pens
			if (m_pen.GetWidth() <= 1)
			{
				while (GetNextX2Y(x, y1, y2))
				{
					ix = w.x2p(x);
					iy1 = w.y2p(y1);
					iy2 = w.y2p(y2);
					if (iy1 >= iy2)  iy = iy2 + (iy1 - iy2) / 2;
					else            iy = iy1 + (iy2 - iy1) / 2;

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
						dc.DrawPoint(ix, iy);

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy1 >= minYpx) && (iy1 <= maxYpx)))
						dc.DrawPoint(ix, iy1);

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy2 >= minYpx) && (iy2 <= maxYpx)))
						dc.DrawPoint(ix, iy2);
				}
			}
			else
			{
				while (GetNextX2Y(x, y1, y2))
				{
					ix = w.x2p(x);
					iy1 = w.y2p(y1);
					iy2 = w.y2p(y2);
					if (iy1 >= iy2)  iy = iy2 + (iy1 - iy2) / 2;
					else            iy = iy1 + (iy2 - iy1) / 2;

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
						dc.DrawLine(ix, iy, ix, iy);

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy1 >= minYpx) && (iy1 <= maxYpx)))
						dc.DrawLine(ix, iy1, ix, iy1);

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy2 >= minYpx) && (iy2 <= maxYpx)))
						dc.DrawLine(ix, iy2, ix, iy2);
				}
			}
		}
		else
		{
			wxCoord cx0 = 0, cya0 = 0, cyb0 = 0, cy0 = 0;
			wxCoord cx = 0, cy1 = 0, cy2 = 0, cy = 0;
			bool    first = TRUE;
			while (GetNextX2Y(x, y1, y2))
			{
				cx = w.x2p(x); // (wxCoord) ((x - w.GetPosX()) * w.GetScaleX());
				cy1 = w.y2p(y1); // (wxCoord) ((w.GetPosY() - y) * w.GetScaleY());
				cy2 = w.y2p(y2); // (wxCoord) ((w.GetPosY() - y) * w.GetScaleY());

				if (cy1 >= cy2)  cy = cy2 + (cy1 - cy2) / 2;
				else            cy = cy1 + (cy2 - cy1) / 2;


				if (first)
				{
					cx0 = cx;
					cy0 = cy;
					cya0 = cy1;
					cyb0 = cy2;

					first = FALSE;
				}
				dc.DrawLine(cx0, cya0, cx, cy1);
				dc.DrawLine(cx0, cyb0, cx, cy2);
				dc.DrawLine(cx0, cy0, cx, cy);

				cx0 = cx;
				cy0 = cy;
				cya0 = cy1;
				cyb0 = cy2;
			}
		}

		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			// xxx implement else ... if (!HasBBox())
			{
				const int sx = w.GetScrX() >> 1;
				const int sy = w.GetScrY() >> 1;

				if ((m_flags & mpALIGNMASK) == mpALIGN_NE)
				{
					tx = sx - tx - 8;
					ty = -sy + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_NW)
				{
					tx = -sx + 8;
					ty = -sy + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_SW)
				{
					tx = -sx + 8;
					ty = sy - 8 - ty;
				}
				else
				{
					tx = sx - tx - 8;
					ty = sy - 8 - ty;
				}
			}

			dc.DrawText(m_name, tx, ty);
		}
	}
}