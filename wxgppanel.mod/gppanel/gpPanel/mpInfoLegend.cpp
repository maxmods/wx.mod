#include "mpInfoLegend.h"
#include "mpWindow.h"

mpInfoLegend::mpInfoLegend() : mpInfoLayer()
{}

mpInfoLegend::mpInfoLegend(wxRect rect, const wxBrush* brush) : mpInfoLayer(rect, brush)
{}

mpInfoLegend::~mpInfoLegend()
{}

void mpInfoLegend::UpdateInfo(mpWindow& w, wxEvent& event)
{}

void mpInfoLegend::Plot(wxDC & dc, mpWindow & w)
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
		//     wxImage image0(wxT("pixel.png"), wxBITMAP_TYPE_PNG);
		//     wxBitmap image1(image0);
		//     wxBrush semiWhite(image1);
		dc.SetBrush(m_brush);
		dc.SetFont(m_font);
		const int baseWidth = (mpLEGEND_MARGIN * 2 + mpLEGEND_LINEWIDTH);
		int textX = baseWidth, textY = mpLEGEND_MARGIN;
		int plotCount = 0;
		int posY = 0;
		int tmpX = 0, tmpY = 0;
		mpLayer* ly = NULL;
		wxPen lpen;
		wxString label;
		for (unsigned int p = 0; p < w.CountAllLayers(); p++) {
			ly = w.GetLayer(p);
			if ((ly->GetLayerType() == mpLAYER_PLOT) && (ly->IsVisible())) {
				label = ly->GetName();
				dc.GetTextExtent(label, &tmpX, &tmpY);
				textX = (textX >(tmpX + baseWidth)) ? textX : (tmpX + baseWidth + mpLEGEND_MARGIN);
				textY += (tmpY);
#ifdef MATHPLOT_DO_LOGGING
				// wxLogMessage(_("mpInfoLegend::Plot() Adding layer %d: %s"), p, label.c_str());
#endif
			}
		}
		dc.SetPen(m_pen);
		dc.SetBrush(m_brush);
		m_dim.width = textX;
		if (textY != mpLEGEND_MARGIN) { // Don't draw any thing if there are no visible layers
			textY += mpLEGEND_MARGIN;
			m_dim.height = textY;
			dc.DrawRectangle(m_dim.x, m_dim.y, m_dim.width, m_dim.height);
			for (unsigned int p2 = 0; p2 < w.CountAllLayers(); p2++) {
				ly = w.GetLayer(p2);
				if ((ly->GetLayerType() == mpLAYER_PLOT) && (ly->IsVisible())) {
					label = ly->GetName();
					lpen = ly->GetPen();
					dc.GetTextExtent(label, &tmpX, &tmpY);
					dc.SetPen(lpen);
					//textX = (textX > (tmpX + baseWidth)) ? textX : (tmpX + baseWidth);
					//textY += (tmpY + mpLEGEND_MARGIN);
					posY = m_dim.y + mpLEGEND_MARGIN + plotCount*tmpY + (tmpY >> 1);
					dc.DrawLine(m_dim.x + mpLEGEND_MARGIN,   // X start coord
						posY,                        // Y start coord
						m_dim.x + mpLEGEND_LINEWIDTH + mpLEGEND_MARGIN, // X end coord
						posY);
					//dc.DrawRectangle(m_dim.x + 5, m_dim.y + 5 + plotCount*tmpY, 5, 5);
					dc.DrawText(label, m_dim.x + baseWidth, m_dim.y + mpLEGEND_MARGIN + plotCount*tmpY);
					plotCount++;
				}
			}
		}
	}
}