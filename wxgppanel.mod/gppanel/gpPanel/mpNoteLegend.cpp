#include "mpNoteLegend.h"
#include "mpWindow.h"

/**
*   mpNoteLegend by Jussi Vatjus-Anttila    21.9.2009
*/
mpNoteLegend::mpNoteLegend() : mpInfoLayer()
{}

mpNoteLegend::mpNoteLegend(wxRect rect, const wxBrush* brush) : mpInfoLayer(rect, brush)
{}

mpNoteLegend::~mpNoteLegend()
{}

void mpNoteLegend::UpdateInfo(mpWindow& w, wxEvent& event)
{}

void mpNoteLegend::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		// Adjust relative position inside the window
		int scrx = w.GetScrX();
		int scry = w.GetScrY();
		if ((m_winX != scrx) || (m_winY != scry)) {
#ifdef MATHPLOT_DO_LOGGING
			// wxLogMessage(_("mpInfoLayer::Plot() screen size has changed from %d x %d to %d x %d"), m_winX, m_winY, scrx, scry);
#endif
			if (m_winX != 1) m_dim.x = (int)floor((double)(m_dim.x*scrx / m_winX));
			if (m_winY != 1) {
				m_dim.y = (int)floor((double)(m_dim.y*scry / m_winY));
				UpdateReference();
			}
			// Finally update window size
			m_winX = scrx;
			m_winY = scry;
		}
		// Finally update window size
		m_winX = scrx;
		m_winY = scry;

		wxPen lpen;
		wxString label;

		dc.SetBrush(m_brush);
		dc.SetFont(m_font);
		dc.SetPen(m_pen);
		label = GetName();

		const int baseWidth = (mpLEGEND_MARGIN/**2*/ + mpLEGEND_LINEWIDTH);
		int textX = baseWidth, textY = mpLEGEND_MARGIN;
		int tmpX = 0, tmpY = 0;

		//dc.GetTextExtent(label, &tmpX, &tmpY);
		dc.GetMultiLineTextExtent(label, &tmpX, &tmpY);
		textX = (textX > (tmpX + baseWidth)) ? textX : (tmpX + baseWidth + mpLEGEND_MARGIN / 2);
		textY += (tmpY);

		m_dim.width = textX;

		textY += mpLEGEND_MARGIN;
		m_dim.height = textY;
		dc.DrawRectangle(m_dim.x, m_dim.y, m_dim.width, m_dim.height);

		wxRect tmp(m_dim.x + baseWidth - mpLEGEND_MARGIN, m_dim.y + mpLEGEND_MARGIN, m_dim.width, m_dim.height);
		dc.DrawLabel(label, tmp);
	}
}