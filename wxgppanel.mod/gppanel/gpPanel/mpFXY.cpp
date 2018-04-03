#include "mpFXY.h"
#include "mpWindow.h"

IMPLEMENT_ABSTRACT_CLASS(mpFXY, mpLayer)

mpFXY::mpFXY(wxString name, int flags)
{
	SetName(name);
	m_flags = flags;
	m_type = mpLAYER_PLOT;
	m_markCorners = false;
	m_drawOutsideMargins = false;
	m_cornerMarkSize = 3;
}
void mpFXY::UpdateViewBoundary(wxCoord xnew, wxCoord ynew)
{
	// Keep track of how many points have been drawn and the bouding box
	maxDrawX = (xnew > maxDrawX) ? xnew : maxDrawX;
	minDrawX = (xnew < minDrawX) ? xnew : minDrawX;
	maxDrawY = (maxDrawY > ynew) ? maxDrawY : ynew;
	minDrawY = (minDrawY < ynew) ? minDrawY : ynew;
	//drawnPoints++;
}
bool mpFXY::GetNearestCoord(mpWindow & w, double & x, double & y)
{
	double x_ = 0, y_ = 0, x__ = 0, y__ = 0;
	bool oldInside = false;
	int ix, iy;
	wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
	wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
	wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
	wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

	Rewind();
	while (GetNextXY(x_, y_))
	{
		ix = w.x2p(x);
		iy = w.y2p(y);
		if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
		{
			//value must be inside
			if (x_ >= x)
			{
				if (x_ - x <= x - x__)
				{
					x = x_;
					y = y_;
					return true;
				}
				else if (oldInside)
				{
					x = x__;
					y = y__;
					return true;
				}

			}
			oldInside = true;
		}
		else oldInside = false;
		x__ = x_;
		y__ = y_;

	}
	return false;
}
void mpFXY::MarkCorners(bool t)
{
	m_markCorners = t;
}

void mpFXY::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);
		dc.SetBrush(m_brush);

		double x, y;
		// Do this to reset the counters to evaluate bounding box for label positioning
		//Rewind(); GetNextXY(x, y);

		///@bug  Why insert double values to wxCoord..?
		//maxDrawX = (wxCoord)x; minDrawX = (wxCoord)x; maxDrawY = (wxCoord)y; minDrawY = (wxCoord)y;
		//drawnPoints = 0;


		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		wxCoord ix = 0, iy = 0;

		Rewind();
		CurrentBounds(w.p2x(startPx), w.p2x(endPx));

		if (!m_continuous)
		{
			// for some reason DrawPoint does not use the current pen,
			// so we use DrawLine for fat pens
			if (m_pen.GetWidth() <= 1)
			{
				while (GetNextXY(x, y))
				{
					ix = w.x2p(x);
					iy = w.y2p(y);

					if (m_invert)
					{
						iy = w.y2p(w.getChartAxisMinY()) - iy;
					}

					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
					{
						switch (m_pointType)
						{	//
						case mpCIRCLE:
							dc.DrawCircle(ix, iy, 4);
							break;
						case mpRECT:
							dc.DrawRectangle(ix, iy, m_RectSize.x, m_RectSize.y);
							break;
						case mpPOINT:
							dc.DrawPoint(ix, iy);
							break;
						default: break;
						}
						UpdateViewBoundary(ix, iy);
						if (m_markCorners)
						{
							dc.DrawCircle(ix, iy, m_cornerMarkSize);
						}
					}
				}
			}
			else
			{
				while (GetNextXY(x, y))
				{
					ix = w.x2p(x);
					iy = w.y2p(y);
					if (m_drawOutsideMargins || ((ix >= startPx) && (ix <= endPx) && (iy >= minYpx) && (iy <= maxYpx)))
					{
						switch (m_pointType)
						{	//
						case mpCIRCLE:
						{
							dc.DrawCircle(ix, iy, 2);
							break;
						}
						case mpRECT:
						{
							dc.DrawRectangle(ix, iy, m_RectSize.x, m_RectSize.y);
							break;
						}
						case mpPOINT:
						{
							dc.DrawLine(ix, iy, ix, iy);
							break;
						}
						default: break;
						}

						if (m_markCorners)
						{
							dc.DrawCircle(ix, iy, m_cornerMarkSize);
						}
					}
				}
			}
		}
		else
		{
			// Old code
			wxCoord x0 = 0, c0 = 0,
				*nextX0 = 0,
				*nextY0 = 0;
			bool    first = TRUE;
			while (GetNextXY(x, y))
			{
				wxCoord x1 = w.x2p(x); // (wxCoord) ((x - w.GetPosX()) * w.GetScaleX());
				wxCoord c1 = w.y2p(y); // (wxCoord) ((w.GetPosY() - y) * w.GetScaleY());
				if (first)
				{
					first = FALSE;
					x0 = x1; c0 = c1;
				}
				bool outUp, outDown;
				if ((x1 >= startPx) && (x0 <= endPx)) {
					outDown = (c0 > maxYpx) && (c1 > maxYpx);   // check that at least one of point is inside borders
					outUp = (c0 < minYpx) && (c1 < minYpx);
					if (!outUp && !outDown) {


						// this could comment in more detail..
						/// @bug There is some bugs!
						if (c1 != c0) {
							if (c0 < minYpx) { //y0 < minY
								x0 = (int)(((double)(minYpx - c0)) / ((double)(c1 - c0))*(x1 - x0)) + x0;
								c0 = minYpx;
							}
							if (c0 > maxYpx) { //y0 > maxY
								x0 = (int)(((double)(maxYpx - c0)) / ((double)(c1 - c0))*(double)(x1 - x0)) + x0;
								//wxLogDebug(wxT("old x0 = %d, new x0 = %d"), x0, newX0);
								c0 = maxYpx;
							}
							if (c1 < minYpx) {  //y1 > minY
								nextX0 = new wxCoord(x1);   //Save x1 value because it needed for next loop!
								nextY0 = new wxCoord(c1);   //Save y1 value because it needed for next loop!
								x1 = (int)(((double)(minYpx - c0)) / ((double)(c1 - c0))*(x1 - x0)) + x0;
								c1 = minYpx;
							}
							if (c1 > maxYpx) { //y1 > maxY
								nextX0 = new wxCoord(x1);   //Save x1 value because it needed for next loop!
								nextY0 = new wxCoord(c1);   //Save y1 value because it needed for next loop!

								x1 = (int)(((double)(maxYpx - c0)) / ((double)(c1 - c0))*(x1 - x0)) + x0;
								c1 = maxYpx;
							}

						}

						//fix left and right boundary in x axis
						if (x1 != x0) {
							if (x0 < startPx) {
								c0 = (int)(((double)(startPx - x0)) / ((double)(x1 - x0))*(c1 - c0)) + c0;
								x0 = startPx;
							}
							if (x1 > endPx) {
								c1 = (int)(((double)(endPx - x0)) / ((double)(x1 - x0))*(c1 - c0)) + c0;
								x1 = endPx;
							}
						}
						if (!m_invert)
						{
							dc.DrawLine(x0, c0, x1, c1);
						}
						else
						{
							dc.DrawLine(x0, w.y2p(w.getChartAxisMinY()) - c0, x1, w.y2p(w.getChartAxisMinY()) - c1);
						}
						UpdateViewBoundary(x1, c1);

						if (m_markCorners)
						{
							dc.DrawCircle(x1, c1, m_cornerMarkSize);
						}
					}
				}
				x0 = x1; c0 = c1;
				if (nextX0) { x0 = *nextX0; wxDELETE(nextX0); }
				if (nextY0) { c0 = *nextY0; wxDELETE(nextY0); }
			}
		}

		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			// xxx implement else ... if (!HasBBox())
			{
				// const int sx = w.GetScrX();
				// const int sy = w.GetScrY();

				if ((m_flags & mpALIGNMASK) == mpALIGN_NW)
				{
					tx = minDrawX + 8;
					ty = maxDrawY + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_NE)
				{
					tx = maxDrawX - tx - 8;
					ty = maxDrawY + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_SE)
				{
					tx = maxDrawX - tx - 8;
					ty = minDrawY - ty - 8;
				}
				else
				{ // mpALIGN_SW
					tx = minDrawX + 8;
					ty = minDrawY - ty - 8;
				}
			}

			dc.DrawText(m_name, tx, ty);
		}
	}
}