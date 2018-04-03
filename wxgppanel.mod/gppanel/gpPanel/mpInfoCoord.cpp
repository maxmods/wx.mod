#include "mpInfoCoord.h"
#include "mpWindow.h"

mpInfoCoords::mpInfoCoords(unsigned int x_labelType) : mpInfoLayer()		//LOGtest "unsigned int x_labelType" added
{
	m_labelType = x_labelType;
}

mpInfoCoords::mpInfoCoords(wxRect rect, const wxBrush* brush) : mpInfoLayer(rect, brush)
{
	/* It seems that Windows port of wxWidgets don't support multi-line test to be drawn in a wxDC.
	wxGTK instead works perfectly with it.
	Info on wxForum: http://wxforum.shadonet.com/viewtopic.php?t=3451&highlight=drawtext+eol */
	/*#ifdef _WINDOWS
	m_format = wxT("x = %f y = %f");
	#else*/
	//If use DrawLabel instead of DrawText, multiline works windows port too.
	m_format = wxT("x = %f\ny = %f");
	//#endif
}

mpInfoCoords::~mpInfoCoords()
{

}
void mpInfoCoords::UpdateInfo(mpWindow& w, wxEvent& event)
//void mpInfoLegend::UpdateInfo(mpWindow& WXUNUSED(w), wxEvent& WXUNUSED(event))
{
	if (event.GetEventType() == wxEVT_MOTION) {
		int mouseX = ((wxMouseEvent&)event).GetX();
		int mouseY = ((wxMouseEvent&)event).GetY();

		m_content.Printf(m_format, w.p2x(mouseX), w.p2y(mouseY));

	}
}

void mpInfoCoords::Plot(wxDC & dc, mpWindow & w)
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
			if (m_winY != 1 && m_winY != 0) {
				m_dim.y = (int)floor((double)(m_dim.y*scry / m_winY));
				UpdateReference();
			}
			// Finally update window size
			m_winX = scrx;
			m_winY = scry;
		}
		dc.SetPen(m_pen);
		//     wxImage image0(wxT("pixel.png"), wxBITMAP_TYPE_PNG);
		//     wxBitmap image1(image0);
		//     wxBrush semiWhite(image1);
		dc.SetBrush(m_brush);
		dc.SetFont(m_font);
		int textX, textY;
		dc.GetMultiLineTextExtent(m_content, &textX, &textY);
		if (m_dim.width < textX + 10) m_dim.width = textX + 10;
		if (m_dim.height < textY + 10) m_dim.height = textY + 10;
		dc.DrawRectangle(m_dim.x, m_dim.y, m_dim.width, m_dim.height);
		wxRect tmp = m_dim;
		tmp.x += 5; tmp.y += 5;
		tmp.width -= 10; tmp.height -= 10;
		dc.DrawLabel(m_content, tmp);
	}
}