#include "mpFYXBar.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpFYXBar implementation - by Jussi Vatjus-Anttila 2009
//-----------------------------------------------------------------------------
IMPLEMENT_ABSTRACT_CLASS(mpFYXBar, mpLayer)

mpFYXBar::mpFYXBar(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
	m_pen.SetStyle(wxPENSTYLE_SOLID);
	m_brush = *wxTRANSPARENT_BRUSH;
	m_gradienBackground = false;
	m_showLabel = true;
	m_useCustomLabel = false;
}

void mpFYXBar::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);
		dc.SetBrush(m_brush);
		dc.SetFont(m_font);

		double x, y, lsb;
		wxString label;


		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		wxCoord xPx = 0, yPx = 0, widthPx, heightPx,
			x0Px = w.x2p(0),
			y0Px = w.y2p(0);
		//int lsbPx = w.y2p(0)-w.y2p(lsb);


		Rewind();
		while (GetNextXY(x, y, label))
		{
			dc.SetBrush(m_brush);
			xPx = w.x2p(x);
			yPx = w.y2p(y);

			if (GetLSB(lsb))
			{
				heightPx = yPx - w.y2p(y + lsb);
			}
			else heightPx = 1;

			yPx -= (y0Px - w.y2p(lsb / 2));

			widthPx = x0Px - xPx;



			//this avoid balk to disapear when rolling up/down
			if (yPx < minYpx && (yPx + heightPx)>minYpx)
			{
				heightPx -= minYpx - yPx;
				yPx = minYpx;
			}
			if ((yPx + heightPx)>maxYpx && yPx <= maxYpx)
			{
				heightPx -= (yPx + heightPx - maxYpx);
			}

			//this avoid balk to disapear when rolling left/right

			//X < 0 + rolling left
			if (xPx < startPx && xPx + widthPx > startPx)
			{
				widthPx -= startPx - xPx;
				xPx = startPx;
			}
			//X > 0 + rolling left
			if (xPx > startPx && xPx + widthPx < startPx)
			{
				widthPx -= (xPx + widthPx) - startPx;
			}
			//rolling right
			if (xPx + widthPx < endPx && xPx > endPx)
			{
				widthPx += xPx - endPx;
				xPx = endPx;
			}


			//show allways something, at least one pixel
			if (widthPx < 1 && widthPx > -1) widthPx = 1;
			if (heightPx < 1) heightPx = 1;


			if (m_drawOutsideMargins || ((xPx >= startPx) && (xPx <= endPx) && (yPx >= minYpx) && (yPx <= maxYpx)))
			{
				if (!m_gradienBackground || widthPx == 1 || heightPx == 1)
				{
					dc.DrawRectangle(xPx, yPx, widthPx, heightPx);
				}
				else {
					dc.GradientFillLinear(wxRect(xPx, yPx, widthPx, heightPx / 2),
						wxColour(100, 100, 150),
						wxColour(150, 150, 255),
						wxDirection(wxUP));
					dc.GradientFillLinear(wxRect(xPx, yPx + heightPx / 2, widthPx, heightPx / 2),
						wxColour(100, 100, 150),
						wxColour(150, 150, 255),
						wxDirection(wxDOWN));
				}



				if (m_showLabel)
				{

					if (!m_useCustomLabel)
					{
						label = wxString::Format(_("%.2f"), y);
					}

					wxCoord dx, dy;
					dc.GetTextExtent(label, &dx, &dy);
					dx = (xPx<x0Px) ? (xPx - 10 - dx) : (xPx + 10);

					if (!label.IsEmpty() && dy <= heightPx)
					{

						if (dx >= startPx && dx < endPx) {
							dc.DrawText(label, dx, yPx + heightPx / 2 - dy / 2);
						}
						label.clear();
					}
				}

			}

			/*
			else if(((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
			{
			if(ix < startPx && (ix+width) > startPx)
			dc.DrawRectangle(w.x2p(0)+width, iy, width, height);
			}
			*/


		}



		if (!m_name.IsEmpty() && m_showName)
		{

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