#include "mpInfoLayer.h"
#include "mpWindow.h"


IMPLEMENT_DYNAMIC_CLASS(mpInfoLayer, mpLayer)

mpInfoLayer::mpInfoLayer()
{
	m_dim = wxRect(0, 0, 1, 1);
	m_brush = *wxTRANSPARENT_BRUSH;
	m_reference.x = 0; m_reference.y = 0;
	m_winX = 1; //parent->GetScrX();
	m_winY = 1; //parent->GetScrY();
	m_type = mpLAYER_INFO;
}

mpInfoLayer::mpInfoLayer(wxRect rect, const wxBrush* brush) : m_dim(rect)
{
	SetBrush(*brush);
	m_reference.x = rect.x;
	m_reference.y = rect.y;
	m_winX = 1; //parent->GetScrX();
	m_winY = 1; //parent->GetScrY();
	m_type = mpLAYER_INFO;
}

mpInfoLayer::~mpInfoLayer()
{

}

//void mpInfoLayer::UpdateInfo(mpWindow& w, wxEvent& event)
void mpInfoLayer::UpdateInfo(mpWindow& WXUNUSED(w), wxEvent& WXUNUSED(event))
{

}

bool mpInfoLayer::Inside(wxPoint& point)
{
	return m_dim.Contains(point);
}

void mpInfoLayer::Move(wxPoint delta)
{
	m_dim.SetX(m_reference.x + delta.x);
	m_dim.SetY(m_reference.y + delta.y);
}

void mpInfoLayer::UpdateReference()
{
	m_reference.x = m_dim.x;
	m_reference.y = m_dim.y;
}

void mpInfoLayer::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		// Adjust relative position inside the window
		int scrx = w.GetScrX();
		int scry = w.GetScrY();

		// Avoid dividing by 0
		if (scrx == 0) scrx = 1;
		if (scry == 0) scry = 1;

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
		dc.SetPen(m_pen);
		//     wxImage image0(wxT("pixel.png"), wxBITMAP_TYPE_PNG);
		//     wxBitmap image1(image0);
		//     wxBrush semiWhite(image1);
		dc.SetBrush(m_brush);
		dc.DrawRectangle(m_dim.x, m_dim.y, m_dim.width, m_dim.height);
	}
}

wxPoint mpInfoLayer::GetPosition()
{
	return m_dim.GetPosition();
}

wxSize mpInfoLayer::GetSize()
{
	return m_dim.GetSize();
}