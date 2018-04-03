#include "mpFXYBar.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpFXYBar implementation - by Jussi Vatjus-Anttila 2009
//-----------------------------------------------------------------------------
IMPLEMENT_ABSTRACT_CLASS(mpFXYBar, mpLayer)

mpFXYBar::mpFXYBar(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
	m_pen.SetStyle(wxPENSTYLE_SOLID);
	m_gradienBackground = true;
	m_showLabel = true;
	m_useCustomLabel = false;
}

void mpFXYBar::Plot(wxDC & dc, mpWindow & w)
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

		wxCoord xPx = 0, yPx = 0,
			widthPx, heightPx,
			y0Px = w.y2p(0),
			x0Px = w.x2p(0);

		Rewind();
		while (GetNextXY(x, y, label))
		{

			xPx = w.x2p(x);
			yPx = w.y2p(y);

			if (GetLSB(lsb))
			{
				widthPx = w.x2p(x + lsb) - xPx;
			}
			else widthPx = 1;
			xPx -= (w.x2p(lsb / 2) - x0Px);


			heightPx = y0Px - yPx;

			//this avoid balk to disapear when rolling up
			if (yPx < minYpx && (yPx + heightPx)>minYpx)
			{
				heightPx -= minYpx - yPx;
				yPx = minYpx;
			}
			if ((yPx + heightPx)>maxYpx)
			{
				heightPx = maxYpx - yPx;
			}
			if (yPx > maxYpx) {
				heightPx += (yPx - maxYpx);
				yPx = maxYpx;
			}

			if (xPx < startPx && (xPx + widthPx) > startPx)
			{
				widthPx -= startPx - xPx;
				xPx = startPx;
			}

			//show allways something, at least one pixel
			if (widthPx <= 1) widthPx = 1;
			if (heightPx < 1 && heightPx > -1) heightPx = 1;


			if (m_drawOutsideMargins || ((xPx >= startPx) && (xPx <= endPx) && (yPx >= minYpx) && (yPx <= maxYpx)))
			{
				if (!m_gradienBackground || widthPx == 1 || heightPx == 1)
				{
					//Precisa fazer checagem se o gráfico é invertido ou não
					if (!m_invert)
					{
						dc.DrawRectangle(xPx, yPx, widthPx, heightPx);
					}
					else
					{
						dc.DrawRectangle(xPx, w.y2p(w.getChartAxisMaxY()), widthPx, heightPx);
					}
				}
				else {
					dc.GradientFillLinear(wxRect(xPx, yPx, widthPx / 2, heightPx),
						wxColour(100, 100, 150),
						wxColour(150, 150, 255),
						wxDirection(wxRIGHT));
					dc.GradientFillLinear(wxRect(xPx + widthPx / 2, yPx, widthPx / 2, heightPx),
						wxColour(100, 100, 150),
						wxColour(150, 150, 255),
						wxDirection(wxLEFT));
				}

				if (m_showLabel)
				{
					if (!m_useCustomLabel)
					{
						if (y == floor(y)) {
							label = wxString::Format(_("%.0f"), y);
						}
						else {
							label = wxString::Format(_("%.2f"), y + 0.005); //rounding..
						}
					}
					wxCoord dx, dy;
					dc.GetTextExtent(label, &dx, &dy);
					dy = (yPx>y0Px) ? (yPx + 5) : (yPx - 10 - dy);

					if (!label.IsEmpty() && dx < widthPx)
					{

						if (dy >= minYpx && dy < maxYpx) {
							//  dc.DrawText( label, xPx+widthPx/2-dx/2, dy);
							dc.DrawText(label, xPx + widthPx / 2 - dx / 2, heightPx);
						}
						label = _("");
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