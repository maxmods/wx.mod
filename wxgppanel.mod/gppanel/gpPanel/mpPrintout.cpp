#include "mpPrintout.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpPrintout - provided by Davide Rondini
//-----------------------------------------------------------------------------

mpPrintout::mpPrintout(mpWindow *drawWindow, const wxChar *title) : wxPrintout(title)
{
	drawn = false;
	plotWindow = drawWindow;
}

bool mpPrintout::OnPrintPage(int page)
{

	wxDC *trgDc = GetDC();
	if ((trgDc) && (page == 1)) {
		wxCoord m_prnX, m_prnY;
		int marginX = 50;
		int marginY = 50;
		trgDc->GetSize(&m_prnX, &m_prnY);

		m_prnX -= (2 * marginX);
		m_prnY -= (2 * marginY);
		trgDc->SetDeviceOrigin(marginX, marginY);

#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(wxT("Print Size: %d x %d\n"), m_prnX, m_prnY);
		wxLogMessage(wxT("Screen Size: %d x %d\n"), plotWindow->GetScrX(), plotWindow->GetScrY());
#endif

		// Set the scale according to the page:
		plotWindow->Fit(
			plotWindow->GetDesiredXmin(),
			plotWindow->GetDesiredXmax(),
			plotWindow->GetDesiredYmin(),
			plotWindow->GetDesiredYmax(),
			&m_prnX,
			&m_prnY);


		// Get the colours of the plotWindow to restore them ath the end
		wxColour oldBgColour = plotWindow->GetBackgroundColour();
		wxColour oldFgColour = plotWindow->GetForegroundColour();
		wxColour oldAxColour = plotWindow->GetAxesColour();

		// Draw background, ensuring to use white background for printing.
		trgDc->SetPen(*wxTRANSPARENT_PEN);
		// wxBrush brush( plotWindow->GetBackgroundColour() );
		wxBrush brush = *wxWHITE_BRUSH;
		trgDc->SetBrush(brush);
		trgDc->DrawRectangle(0, 0, m_prnX, m_prnY);

		// Draw all the layers:
		//trgDc->SetDeviceOrigin( m_prnX>>1, m_prnY>>1);  // Origin at the center
		mpLayer *layer;
		for (unsigned int li = 0; li < plotWindow->CountAllLayers(); li++) {
			layer = plotWindow->GetLayer(li);
			layer->Plot(*trgDc, *plotWindow);
		};
		// Restore device origin
		// trgDc->SetDeviceOrigin(0, 0);
		// Restore colours
		plotWindow->SetColourTheme(oldBgColour, oldFgColour, oldAxColour);
		// Restore drawing
		plotWindow->Fit(plotWindow->GetDesiredXmin(), plotWindow->GetDesiredXmax(), plotWindow->GetDesiredYmin(), plotWindow->GetDesiredYmax(), NULL, NULL);
		plotWindow->UpdateAll();
	}
	return true;
}

bool mpPrintout::HasPage(int page)
{
	return (page == 1);
}