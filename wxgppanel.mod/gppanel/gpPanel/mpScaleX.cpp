#include "mpScaleX.h"
#include "mpWindow.h"


#define mpMIN_X_AXIS_LABEL_SEPARATION 64

IMPLEMENT_DYNAMIC_CLASS(mpScaleX, mpLayer)

mpScaleX::mpScaleX(wxString name, int flags, bool ticks, unsigned int type)
{
	SetName(name);
	SetFont((wxFont&)*wxSMALL_FONT);
	SetPen((wxPen&)*wxGREY_PEN);
	m_pTicksLabelColour = wxColour(*wxBLACK);
	m_flags = flags;
	m_ticks = ticks;
	m_labelType = type;
	m_type = mpLAYER_AXIS;
	m_labelFormat = wxT("");
}
bool mpScaleX::Inside(const wxPoint& point)
{
	return m_labelRect.Contains(point);
}
void mpScaleX::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);
		dc.SetFont(m_font);
		dc.SetTextForeground(m_pTicksLabelColour);
		int orgy = 0;

		const int extend = w.GetScrX(); //  /2;
		if (m_flags == mpALIGN_CENTER)
			orgy = w.y2p(0); //(int)(w.GetPosY() * w.GetScaleY());
		if (m_flags == mpALIGN_TOP) {
			if (m_drawOutsideMargins)
				orgy = X_BORDER_SEPARATION;
			else
				orgy = w.GetMarginTop();
		}
		if (m_flags == mpALIGN_BOTTOM) {
			if (m_drawOutsideMargins)
				orgy = X_BORDER_SEPARATION;
			else
				orgy = w.GetScrY() - w.GetMarginBottom();
		}
		if (m_flags == mpALIGN_BORDER_BOTTOM)
			orgy = w.GetScrY() - 1;//dc.LogicalToDeviceY(0) - 1;
		if (m_flags == mpALIGN_BORDER_TOP)
			orgy = 1;//-dc.LogicalToDeviceY(0);

		dc.DrawLine(0, orgy, w.GetScrX(), orgy);

		// To cut the axis line when draw outside margin is false, use this code
		/*if (m_drawOutsideMargins == true)
		dc.DrawLine( 0, orgy, w.GetScrX(), orgy);
		else
		dc.DrawLine( w.GetMarginLeft(), orgy, w.GetScrX() - w.GetMarginRight(), orgy); */

		const double dig = floor(log(128.0 / w.GetScaleX()) / mpLN10);
		//const double step = exp( mpLN10 * dig);
		double step = exp(mpLN10 * dig);	//LOGtest
											//const double end  = w.GetPosX() + (double)extend / w.GetScaleX();
		double end = w.GetPosX() + (double)extend / w.GetScaleX();	//LOGtest

		if (m_labelType == mpX_LOGARITHMIC) {		//LOGtest
			step = 1;
			end = 10 * (w.GetPosX() + (double)extend / w.GetScaleX());
		}

		wxCoord tx, ty;
		wxString s;
		wxString fmt;
		int tmp = (int)dig;
		if (m_labelType == mpX_NORMAL) {
			if (!m_labelFormat.IsEmpty()) {
				fmt = m_labelFormat;
			}
			else {
				if (tmp >= 1) {
					fmt = wxT("%.f");
				}
				else {
					tmp = 8 - tmp;
					fmt.Printf(wxT("%%.%df"), tmp >= -1 ? 2 : -tmp);
				}
			}
		}
		//##########LOGtest######################
		else if (m_labelType == mpX_LOGARITHMIC) {
			if (!m_labelFormat.IsEmpty()) {
				fmt = m_labelFormat;
			}
			else {
				fmt = wxT("10^%.f");
			}
		}
		//#######################################
		else if (m_labelType == mpX_DATETIME || m_labelType == mpX_DATE || m_labelType == mpX_TIME) {		//Added: " if( m_labelType == mpX_DATETIME || mpX_DATE || mpX_TIME )"
																											// Date and/or time axis representation
			if (m_labelType == mpX_DATETIME) {
				fmt = (wxT("%04.0f-%02.0f-%02.0fT%02.0f:%02.0f:%02.0f"));
			}
			else if (m_labelType == mpX_DATE) {
				fmt = (wxT("%04.0f-%02.0f-%02.0f"));
			}
			else if ((m_labelType == mpX_TIME) && (end / 60 < 2)) {
				fmt = (wxT("%02.0f:%02.3f"));
			}
			else {
				fmt = (wxT("%02.0f:%02.0f:%02.0f"));
			}
		}

		//double n = floor( (w.GetPosX() - (double)extend / w.GetScaleX()) / step ) * step ;
		double n0 = floor((w.GetPosX() /* - (double)(extend - w.GetMarginLeft() - w.GetMarginRight())/ w.GetScaleX() */) / step) * step;
		double n = 0;
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(wxT("mpScaleX::Plot: dig: %f , step: %f, end: %f, n: %f"), dig, step, end, n0);
#endif
		wxCoord startPx = m_drawOutsideMargins ? 0 : w.GetMarginLeft();
		wxCoord endPx = m_drawOutsideMargins ? w.GetScrX() : w.GetScrX() - w.GetMarginRight();
		wxCoord minYpx = m_drawOutsideMargins ? 0 : w.GetMarginTop();
		wxCoord maxYpx = m_drawOutsideMargins ? w.GetScrY() : w.GetScrY() - w.GetMarginBottom();

		tmp = -65535;
		int labelH = 0; // Control labels heigth to decide where to put axis name (below labels or on top of axis)
		int maxExtent = 0;
		double nx = 1;	//LOGtest
		int dek = 0, p, px;	//LOGtest
		for (n = n0; n < end; n += step) {													//step size between axis ticks
																							//for( n=n0; n<=end; n+=step) {		//LOGtest
																							//const int p = (int)((n - w.GetPosX()) * w.GetScaleX());
			if (m_labelType == mpX_LOGARITHMIC)	//LOGtest
			{
				if (dek == 0) p = (int)((log10(nx) - w.GetPosX()) * w.GetScaleX());	//LOGtest //w.GetPosX() defines  PlotStartpoint
				else p = px + (int)((log10(nx)/* - w.GetPosX()*/) * w.GetScaleX());		//LOGtest
				if (nx == 10)
				{
					nx = 1;
					dek++;
					px = p;
				}			//LOGtest
				nx += 1;	//LOGtest
			}
			else p = (int)((n - w.GetPosX()) * w.GetScaleX());	//LOGtest

#ifdef MATHPLOT_DO_LOGGING
			wxLogMessage(wxT("mpScaleX::Plot: n: %f -> p = %d"), n, p);
#endif
			if ((p >= startPx) && (p <= endPx)) {
				if (m_ticks) { // draw axis ticks
					if (m_flags == mpALIGN_BORDER_BOTTOM)
						dc.DrawLine(p, orgy, p, orgy - 4);
					else
						dc.DrawLine(p, orgy, p, orgy + 4);
				}
				else { // draw grid dotted lines
					m_pen.SetStyle(wxPENSTYLE_DOT);
					dc.SetPen(m_pen);
					if ((m_flags == mpALIGN_BOTTOM) && !m_drawOutsideMargins) {
						dc.DrawLine(p, orgy + 4, p, minYpx);
					}
					else {
						if ((m_flags == mpALIGN_TOP) && !m_drawOutsideMargins) {
							dc.DrawLine(p, orgy - 4, p, maxYpx);
						}
						else {
							dc.DrawLine(p, 0/*-w.GetScrY()*/, p, w.GetScrY());
						}
					}
					m_pen.SetStyle(wxPENSTYLE_SOLID);
					dc.SetPen(m_pen);
				}
				// Write ticks labels in s string
				if (m_labelType == mpX_NORMAL)
					s.Printf(fmt, n);
				//##############LOGtest####################
				else if (m_labelType == mpX_LOGARITHMIC)
					s.Printf(fmt, n);
				//#########################################
				else if (m_labelType == mpX_DATETIME) {
					time_t when = (time_t)n;
					struct tm tm = *localtime(&when);
					s.Printf(fmt, (double)tm.tm_year + 1900, (double)tm.tm_mon + 1, (double)tm.tm_mday, (double)tm.tm_hour, (double)tm.tm_min, (double)tm.tm_sec);
				}
				else if (m_labelType == mpX_DATE) {
					time_t when = (time_t)n;
					struct tm tm = *localtime(&when);
					s.Printf(fmt, (double)tm.tm_year + 1900, (double)tm.tm_mon + 1, (double)tm.tm_mday);
				}
				else if ((m_labelType == mpX_TIME) || (m_labelType == mpX_HOURS)) {
					double modulus = fabs(n);
					double sign = n / modulus;
					double hh = floor(modulus / 3600);
					double mm = floor((modulus - hh * 3600) / 60);
					double ss = modulus - hh * 3600 - mm * 60;
#ifdef MATHPLOT_DO_LOGGING
					wxLogMessage(wxT("%02.0f Hours, %02.0f minutes, %02.0f seconds"), sign*hh, mm, ss);
#endif // MATHPLOT_DO_LOGGING
					if (fmt.Len() == 20) // Format with hours has 11 chars
						s.Printf(fmt, sign*hh, mm, floor(ss));
					else
						s.Printf(fmt, sign*mm, ss);
				}
				dc.GetTextExtent(s, &tx, &ty);
				labelH = (labelH <= ty) ? ty : labelH;
				/*				if ((p-tx/2-tmp) > 64) { // Problem about non-regular axis labels
				if ((m_flags == mpALIGN_BORDER_BOTTOM) || (m_flags == mpALIGN_TOP)) {
				dc.DrawText( s, p-tx/2, orgy-4-ty);
				} else {
				dc.DrawText( s, p-tx/2, orgy+4);
				}
				tmp=p+tx/2;
				}
				*/
				maxExtent = (tx > maxExtent) ? tx : maxExtent; // Keep in mind max label width
			}
		}
		// Actually draw labels, taking care of not overlapping them, and distributing them regularly
		double labelStep = ceil((maxExtent + mpMIN_X_AXIS_LABEL_SEPARATION) / (w.GetScaleX()*step))*step;
		for (n = n0; n < end; n += labelStep) {
			const int p = (int)((n - w.GetPosX()) * w.GetScaleX());
#ifdef MATHPLOT_DO_LOGGING
			wxLogMessage(wxT("mpScaleX::Plot: n_label = %f -> p_label = %d"), n, p);
#endif
			if ((p >= startPx) && (p <= endPx)) {
				// Write ticks labels in s string
				if (m_labelType == mpX_NORMAL)
					s.Printf(fmt, n);
				//##############LOGtest####################
				else if (m_labelType == mpX_LOGARITHMIC)
					s.Printf(fmt, n);
				//#########################################
				else if (m_labelType == mpX_DATETIME) {
					time_t when = (time_t)n;
					struct tm tm = *localtime(&when);
					s.Printf(fmt, (double)tm.tm_year + 1900, (double)tm.tm_mon + 1, (double)tm.tm_mday, (double)tm.tm_hour, (double)tm.tm_min, (double)tm.tm_sec);
				}
				else if (m_labelType == mpX_DATE) {
					time_t when = (time_t)n;
					struct tm tm = *localtime(&when);
					s.Printf(fmt, (double)tm.tm_year + 1900, (double)tm.tm_mon + 1, (double)tm.tm_mday);
				}
				else if ((m_labelType == mpX_TIME) || (m_labelType == mpX_HOURS)) {
					double modulus = fabs(n);
					double sign = n / modulus;
					double hh = floor(modulus / 3600);
					double mm = floor((modulus - hh * 3600) / 60);
					double ss = modulus - hh * 3600 - mm * 60;
#ifdef MATHPLOT_DO_LOGGING
					wxLogMessage(wxT("%02.0f Hours, %02.0f minutes, %02.0f seconds"), sign*hh, mm, ss);
#endif // MATHPLOT_DO_LOGGING
					if (fmt.Len() == 20) // Format with hours has 11 chars
						s.Printf(fmt, sign*hh, mm, floor(ss));
					else
						s.Printf(fmt, sign*mm, ss);
				}
				dc.GetTextExtent(s, &tx, &ty);
				if ((m_flags == mpALIGN_BORDER_BOTTOM) || (m_flags == mpALIGN_TOP)) {
					dc.DrawText(s, p - tx / 2, orgy - 4 - ty);
				}
				else {
					dc.DrawText(s, p - tx / 2, orgy + 4);
				}
			}
		}

		// Draw axis name
		dc.GetTextExtent(m_name, &tx, &ty);
		m_labelRect.width = tx;
		m_labelRect.height = ty;
		switch (m_flags) {
		case mpALIGN_BORDER_BOTTOM:
			dc.DrawText(m_name, m_labelRect.x = (extend - tx - 4), m_labelRect.y = (orgy - 8 - ty - labelH));
			break;
		case mpALIGN_BOTTOM: {
			if ((!m_drawOutsideMargins) && (w.GetMarginBottom() > (ty + labelH + 8))) {
				dc.DrawText(m_name, m_labelRect.x = ((endPx - startPx - tx) >> 1), m_labelRect.y = (orgy + 6 + labelH));
			}
			else {
				dc.DrawText(m_name, m_labelRect.x = (extend - tx - 4), m_labelRect.y = (orgy - 4 - ty));
			}
		} break;
		case mpALIGN_CENTER:
			dc.DrawText(m_name, m_labelRect.x = (extend - tx - 4), m_labelRect.y = (orgy - 4 - ty));
			break;
		case mpALIGN_TOP: {
			if ((!m_drawOutsideMargins) && (w.GetMarginTop() > (ty + labelH + 8))) {
				dc.DrawText(m_name, m_labelRect.x = ((endPx - startPx - tx) >> 1), m_labelRect.y = (orgy - 6 - ty - labelH));
			}
			else {
				dc.DrawText(m_name, m_labelRect.x = (extend - tx - 4), m_labelRect.y = (orgy + 4));
			}
		} break;
		case mpALIGN_BORDER_TOP:
			dc.DrawText(m_name, m_labelRect.x = (extend - tx - 4), m_labelRect.y = (orgy + 6 + labelH));
			break;
		default:
			break;
		}
	}
	/*    if (m_flags != mpALIGN_TOP) {

	if ((m_flags == mpALIGN_BORDER_BOTTOM) || (m_flags == mpALIGN_TOP)) {
	dc.DrawText( m_name, extend - tx - 4, orgy - 4 - (ty*2));
	} else {
	dc.DrawText( m_name, extend - tx - 4, orgy - 4 - ty); //orgy + 4 + ty);
	}
	}; */
}
bool mpScaleX::HasBBox() { return false; }
bool mpScaleX::IsScaleXLayer() { return true; }
void mpScaleX::SetAlign(int align) { m_flags = align; }
void mpScaleX::SetTicks(bool ticks) { m_ticks = ticks; }
bool mpScaleX::GetTicks() { return m_ticks; }