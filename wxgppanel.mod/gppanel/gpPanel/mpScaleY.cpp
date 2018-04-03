#include "mpScaleY.h"
#include "mpWindow.h"


// Minimum axis label separation
#define mpMIN_Y_AXIS_LABEL_SEPARATION 32

IMPLEMENT_DYNAMIC_CLASS(mpScaleY, mpLayer)

mpScaleY::mpScaleY(wxString name, int flags, bool ticks)
{
	SetName(name);
	SetFont((wxFont&)*wxSMALL_FONT);
	SetPen((wxPen&)*wxGREY_PEN);
	m_pTicksLabelColour = wxColour(*wxBLACK);
	m_flags = flags;
	m_ticks = ticks;
	m_type = mpLAYER_AXIS;
	m_labelFormat = wxT("");
}
bool mpScaleY::Inside(const wxPoint& point)
{
	return m_labelRect.Contains(point);
}
void mpScaleY::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);
		dc.SetFont(m_font);
		dc.SetTextForeground(m_pTicksLabelColour);
		int orgx = 0;
		const int extend = w.GetScrY(); // /2;
		if (m_flags == mpALIGN_CENTER)
			orgx = w.x2p(0); //(int)(w.GetPosX() * w.GetScaleX());
		if (m_flags == mpALIGN_LEFT) {
			if (m_drawOutsideMargins)
				orgx = Y_BORDER_SEPARATION;
			else
				orgx = w.GetMarginLeft();
		}
		if (m_flags == mpALIGN_RIGHT) {
			if (m_drawOutsideMargins)
				orgx = w.GetScrX() - Y_BORDER_SEPARATION;
			else
				orgx = w.GetScrX() - w.GetMarginRight();
		}
		if (m_flags == mpALIGN_BORDER_RIGHT)
			orgx = w.GetScrX() - 1; //dc.LogicalToDeviceX(0) - 1;
		if (m_flags == mpALIGN_BORDER_LEFT)
			orgx = 1; //-dc.LogicalToDeviceX(0);


					  // Draw line
		dc.DrawLine(orgx, 0, orgx, extend);

		// To cut the axis line when draw outside margin is false, use this code
		/* if (m_drawOutsideMargins == true)
		dc.DrawLine( orgx, 0, orgx, extend);
		else
		dc.DrawLine( orgx, w.GetMarginTop(), orgx, w.GetScrY() - w.GetMarginBottom()); */

		const double dig = floor(log(128.0 / w.GetScaleY()) / mpLN10);
		const double step = exp(mpLN10 * dig);
		const double end = w.GetPosY() + (double)extend / w.GetScaleY();

		wxCoord tx, ty;
		wxString s;
		wxString fmt;
		int tmp = (int)dig;
		double maxScaleAbs = fabs(w.GetDesiredYmax());
		double minScaleAbs = fabs(w.GetDesiredYmin());
		double endscale = (maxScaleAbs > minScaleAbs) ? maxScaleAbs : minScaleAbs;

		if (m_labelFormat.IsEmpty()) {
			if ((endscale < 1e4) && (endscale > 1e-3))
				fmt = wxT("%.2f");
			else if ((endscale < 1e7) && (endscale > 1e-6))
				fmt = wxT("%.0f");
			else
				fmt = wxT("%.1e");
		}
		else {
			fmt = m_labelFormat;
		}

		/*
		if ((endscale < 1e4) && (endscale > 1e-3))
		fmt = wxT("%.2f");
		else
		fmt = wxT("%.1e");
		*/
		/*    if (tmp>=1)
		{*/
		//    fmt = wxT("%7.5g");
		//     }
		//     else
		//     {
		//         tmp=8-tmp;
		//         fmt.Printf(wxT("%%.%dg"), (tmp >= -1) ? 2 : -tmp);
		//     }

		double n = floor((w.GetPosY() - (double)(extend - w.GetMarginTop() - w.GetMarginBottom()) / w.GetScaleY()) / step) * step;

		/* wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft(); */
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		tmp = 65536;
		int labelW = 0;
		// Before staring cycle, calculate label height
		int labelHeigth = 0;
		s.Printf(fmt, n);
		dc.GetTextExtent(s, &tx, &labelHeigth);
		for (; n < end; n += step) {
			const int p = (int)((w.GetPosY() - n) * w.GetScaleY());
			if ((p >= minYpx) && (p <= maxYpx)) {
				if (m_ticks) { // Draw axis ticks
					if (m_flags == mpALIGN_BORDER_LEFT) {
						dc.DrawLine(orgx, p, orgx + 4, p);
					}
					else {
						dc.DrawLine(orgx - 4, p, orgx, p); //( orgx, p, orgx+4, p);
					}
				}
				else {
					m_pen.SetStyle(wxPENSTYLE_DOT);
					dc.SetPen(m_pen);
					if ((m_flags == mpALIGN_LEFT) && !m_drawOutsideMargins) {
						dc.DrawLine(orgx - 4, p, endPx, p);
					}
					else {
						if ((m_flags == mpALIGN_RIGHT) && !m_drawOutsideMargins) {
							dc.DrawLine(minYpx, p, orgx + 4, p);
						}
						else {
							dc.DrawLine(0/*-w.GetScrX()*/, p, w.GetScrX(), p);
						}
					}
					m_pen.SetStyle(wxPENSTYLE_SOLID);
					dc.SetPen(m_pen);
				}
				//Print ticks labels
				if (!m_invert)
				{
					s.Printf(fmt, std::fabs(n));
				}
				else
				{
					s.Printf(fmt, std::fabs(n - maxScaleAbs));
				}
				dc.GetTextExtent(s, &tx, &ty);
#ifdef MATHPLOT_DO_LOGGING
				if (ty != labelHeigth) wxLogMessage(wxT("mpScaleY::Plot: ty(%f) and labelHeigth(%f) differ!"), ty, labelHeigth);
#endif
				labelW = (labelW <= tx) ? tx : labelW;
				if ((tmp - p + labelHeigth / 2) > mpMIN_Y_AXIS_LABEL_SEPARATION) {
					if ((m_flags == mpALIGN_BORDER_LEFT) || (m_flags == mpALIGN_RIGHT))
						dc.DrawText(s, orgx + 4, p - ty / 2);
					else
						dc.DrawText(s, orgx - 4 - tx, p - ty / 2); //( s, orgx+4, p-ty/2);
					tmp = p - labelHeigth / 2;
				}
			}
		}
		// Draw axis name
		dc.GetTextExtent(m_name, &tx, &ty);
		m_labelRect.width = tx;
		m_labelRect.height = ty;

		switch (m_flags)
		{
		case mpALIGN_BORDER_LEFT:
			dc.DrawText(m_name, m_labelRect.x = (labelW + 8), m_labelRect.y = 4);
			break;
		case mpALIGN_LEFT: {
			if ((!m_drawOutsideMargins) && (w.GetMarginLeft() > (ty + labelW + 8))) {
				dc.DrawRotatedText(m_name, m_labelRect.x = (orgx - 15 - labelW - ty), m_labelRect.y = ((maxYpx - minYpx + tx) >> 1), 90);
				m_labelRect.width = ty;
				m_labelRect.height = tx;
				m_labelRect.y -= tx;

			}
			else {
				dc.DrawText(m_name, m_labelRect.x = (orgx + 4), m_labelRect.y = 4);
			}
		}   break;
		case mpALIGN_CENTER:
			dc.DrawText(m_name, orgx + 4, 4);
			break;
		case mpALIGN_RIGHT: {
			if ((!m_drawOutsideMargins) && (w.GetMarginRight() > (ty + labelW + 8))) {
				dc.DrawRotatedText(m_name, m_labelRect.x = (orgx + 6 + labelW), m_labelRect.y = ((maxYpx - minYpx + tx) >> 1), 90);
				m_labelRect.width = ty;
				m_labelRect.height = tx;
				m_labelRect.y -= tx;
			}
			else {
				dc.DrawText(m_name, m_labelRect.x = (orgx - tx - 4), m_labelRect.y = 4);
			}
		} break;
		case mpALIGN_BORDER_RIGHT:
			dc.DrawText(m_name, m_labelRect.x = (orgx - 6 - tx - labelW), m_labelRect.y = 4);
			break;
		default:
			break;
		}
	}

	/*    if (m_flags != mpALIGN_RIGHT) {
	dc.GetTextExtent(m_name, &tx, &ty);
	if (m_flags == mpALIGN_BORDER_LEFT) {
	dc.DrawText( m_name, orgx-tx-4, -extend + ty + 4);
	} else {
	if (m_flags == mpALIGN_BORDER_RIGHT )
	dc.DrawText( m_name, orgx-(tx*2)-4, -extend + ty + 4);
	else
	dc.DrawText( m_name, orgx + 4, -extend + 4);
	}
	}; */
}