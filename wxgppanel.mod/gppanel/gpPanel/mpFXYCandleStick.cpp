#include "mpFXYCandleStick.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpFXCandleStick implementation - by Jussi Vatjus-Anttila 2009
//-----------------------------------------------------------------------------
IMPLEMENT_ABSTRACT_CLASS(mpFXYCandleStick, mpLayer)

mpFXYCandleStick::mpFXYCandleStick(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
	m_pen.SetStyle(wxPENSTYLE_SOLID);
	m_gradienBackground = true;
	m_candleBrush = *wxBLACK_BRUSH;
	m_candleBrush2 = *wxWHITE_BRUSH;
	m_candlePen = *wxBLACK_PEN;
	m_stickPen = *wxBLACK_PEN;
}
void mpFXYCandleStick::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);

		double x, yCandleMin, yCandleMax, yStickMin, yStickMax, lsb;
		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		wxCoord xPx = 0, yCandleMinPx, yCandleMaxPx, yStickMinPx, yStickMaxPx, widthPx, heightPx,
			stickXpx;

		Rewind();
		while (GetNext(x, yCandleMin, yCandleMax, yStickMin, yStickMax))
		{
			dc.SetBrush(m_brush);
			xPx = w.x2p(x);
			yCandleMinPx = w.y2p(yCandleMax);
			yCandleMaxPx = w.y2p(yCandleMin);
			yStickMinPx = w.y2p(yStickMax);
			yStickMaxPx = w.y2p(yStickMin);

			//calculate bar width
			if (GetLSB(lsb))
			{
				widthPx = w.x2p(x + lsb) - xPx;
			}
			else widthPx = 1;
			stickXpx = xPx + widthPx / 2;

			heightPx = yCandleMaxPx - yCandleMinPx;


			//this avoid balk to disapear when rolling left/rigth up/down

			//stick corrections
			if (yStickMaxPx > maxYpx && yStickMinPx < maxYpx)yStickMaxPx = maxYpx;
			if (yStickMinPx < minYpx && yStickMaxPx > minYpx)yStickMinPx = minYpx;

			//rolling down
			if (yCandleMinPx > maxYpx && yCandleMaxPx > maxYpx);
			else if (yCandleMinPx > maxYpx)
			{
				yCandleMinPx = maxYpx;
				heightPx = yCandleMaxPx - yCandleMinPx;
			}
			else if (yCandleMaxPx > maxYpx)
			{
				yCandleMaxPx = maxYpx;
				heightPx = yCandleMaxPx - yCandleMinPx;
			}

			//rolling up
			if (yCandleMinPx < minYpx && yCandleMaxPx < minYpx);
			else if (yCandleMinPx < minYpx)
			{
				yCandleMinPx = minYpx;
				heightPx = yCandleMaxPx - yCandleMinPx;
			}
			else if (yCandleMaxPx < minYpx)
			{
				yCandleMaxPx = minYpx;
				heightPx = yCandleMaxPx - yCandleMinPx;
			}



			//show allways something, at least one pixel
			if (widthPx <= 0)
			{
				widthPx = 1;
				if (m_gradienBackground)widthPx++;
			}
			if (heightPx == 0)heightPx = 1;

			if (xPx < startPx) {
				if (xPx + widthPx > startPx)
				{
					widthPx -= (startPx - xPx);
					xPx = startPx;
				}
			}

			if (m_drawOutsideMargins || ((xPx >= startPx) && (xPx <= endPx) && (yStickMinPx >= minYpx) && (yStickMaxPx <= maxYpx)))
			{
				if (stickXpx > startPx && stickXpx < endPx)
				{
					dc.SetPen(m_stickPen);
					dc.DrawLine(stickXpx, yStickMinPx, stickXpx, yStickMaxPx);
				}

				if ((yCandleMinPx >= minYpx) && (yCandleMaxPx <= maxYpx) && xPx >= startPx)
				{
					if (!m_gradienBackground)
					{
						if (yCandleMinPx < yCandleMaxPx)
							dc.SetBrush(m_candleBrush);
						else dc.SetBrush(m_candleBrush2);

						dc.SetPen(m_candlePen);
						dc.DrawRectangle(xPx, yCandleMinPx, widthPx, heightPx);
					}
					else {
						dc.GradientFillLinear(wxRect(xPx, yCandleMinPx, widthPx / 2, heightPx),
							wxColour(100, 100, 150),
							wxColour(150, 150, 255),
							wxDirection(wxRIGHT));
						dc.GradientFillLinear(wxRect(xPx + widthPx / 2, yCandleMinPx, widthPx / 2, heightPx),
							wxColour(100, 100, 150),
							wxColour(150, 150, 255),
							wxDirection(wxLEFT));
					}
				}
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