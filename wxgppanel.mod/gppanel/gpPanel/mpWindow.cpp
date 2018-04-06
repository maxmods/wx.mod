#include "mpWindow.h"
#include "lineChartLayer.h"

/////////////////////////////////////////////////////////////////////////////
// Name:            mathplot.cpp
// Purpose:         Framework for plotting in wxWindows
// Original Author: David Schalig
// Maintainer:      Davide Rondini
// Contributors:    Jose Luis Blanco, Val Greene
// Created:         21/07/2003
// Last edit:       09/09/2007
// Copyright:       (c) David Schalig, Davide Rondini
// Licence:         wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifdef __GNUG__
#pragma implementation "mathplot.h"
#endif

// For compilers that support precompilation, includes "wx.h".
#include <wx/window.h>
//#include <wx/wxprec.h>
#include <wx/dcclient.h>

// Comment out for release operation:
// (Added by J.L.Blanco, Aug 2007)
// #define MATHPLOT_DO_LOGGING

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
#include <wx/object.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/sizer.h>
#include <wx/log.h>
#include <wx/intl.h>
#include <wx/dcclient.h>
#include <wx/cursor.h>
#endif

#include "mathplot.h"
#include <wx/bmpbuttn.h>
#include <wx/module.h>
#include <wx/msgdlg.h>
#include <wx/image.h>
#include <wx/tipwin.h>

#include <cmath>
#include <cstdio> // used only for debug
#include <ctime> // used for representation of x axes involving date

#include "baseXYData.h"
#include "mpPointLayer.h"
#include "mpScaleX.h"
#include "mpScaleY.h"
#include "mpInfoLegend.h"

// #include "pixel.xpm"

// Memory leak debugging
#ifdef _DEBUG
#define new DEBUG_NEW
#endif





// Number of pixels to scroll when scrolling by a line
#define mpSCROLL_NUM_PIXELS_PER_LINE  10

//WX_DEFINE_LIST(PointList);



#define MP_POP_LANGUAGE_EN


#ifdef MP_POP_LANGUAGE_EN
#define MP_POPMENU_CENTER               _("Center")
#define MP_POPMENU_CENTER_INFO          _("Center plot view to this position")
#define MP_POPMENU_FIT                  _("Fit")
#define MP_POPMENU_FIT_INFO             _("Set plot view to show all items")
#define MP_POPMENU_ZOOM_IN              _("Zoom in")
#define MP_POPMENU_ZOOM_IN_INFO         _("Zoom in plot view.")
#define MP_POPMENU_ZOOM_OUT             _("Zoom out")
#define MP_POPMENU_ZOOM_OUT_INFO        _("Zoom out plot view.")
#define MP_POPMENU_LOCK_ASPECT          _("Lock aspect")
#define MP_POPMENU_LOCK_ASPECT_INFO     _("Lock horizontal and vertical zoom aspect.")
#define MP_POPMENU_HELP                 _("Show mouse commands...")
#define MP_POPMENU_HELP_INFO            _("Show help about the mouse commands.")
#endif

#ifdef MP_POP_LANGUAGE_FI
#define MP_POPMENU_CENTER               _("Keskitä")
#define MP_POPMENU_CENTER_INFO          _("Keskitä ikkuna tähän pisteeseen")
#define MP_POPMENU_FIT                  _("Sovita")
#define MP_POPMENU_FIT_INFO             _("Sovita ikkunaan")
#define MP_POPMENU_ZOOM_IN              _("Zoomaus sisään")
#define MP_POPMENU_ZOOM_IN_INFO         _("Zoomaus sisään")
#define MP_POPMENU_ZOOM_OUT             _("Zoomaus ulos")
#define MP_POPMENU_ZOOM_OUT_INFO        _("Zoomaus ulos")
#define MP_POPMENU_LOCK_ASPECT          _("Lukitse suhde")
#define MP_POPMENU_LOCK_ASPECT_INFO     _("Lukitse suhde")
#define MP_POPMENU_HELP                 _("Tietoa hiirilekomennoista")
#define MP_POPMENU_HELP_INFO            _("Tietoa hiirilekomennoista")
#endif

//-----------------------------------------------------------------------------
// mpWindow
//-----------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(mpWindow, wxWindow)

BEGIN_EVENT_TABLE(mpWindow, wxWindow)
EVT_PAINT(mpWindow::OnPaint)
EVT_SIZE(mpWindow::OnSize)
EVT_SCROLLWIN_THUMBTRACK(mpWindow::OnScrollThumbTrack)
EVT_SCROLLWIN_PAGEUP(mpWindow::OnScrollPageUp)
EVT_SCROLLWIN_PAGEDOWN(mpWindow::OnScrollPageDown)
EVT_SCROLLWIN_LINEUP(mpWindow::OnScrollLineUp)
EVT_SCROLLWIN_LINEDOWN(mpWindow::OnScrollLineDown)
EVT_SCROLLWIN_TOP(mpWindow::OnScrollTop)
EVT_SCROLLWIN_BOTTOM(mpWindow::OnScrollBottom)

EVT_MIDDLE_DOWN(mpWindow::OnMouseMiddleDown)
EVT_MIDDLE_UP(mpWindow::OnMouseMiddleRelease)
EVT_RIGHT_DOWN(mpWindow::OnMouseRightDown) // JLB
EVT_RIGHT_UP(mpWindow::OnMouseRightRelease)
EVT_MOUSEWHEEL(mpWindow::OnMouseWheel)   // JLB
EVT_MOTION(mpWindow::OnMouseMove)   // JLB
EVT_LEFT_DOWN(mpWindow::OnMouseLeftDown)
EVT_LEFT_UP(mpWindow::OnMouseLeftRelease)
EVT_LEAVE_WINDOW(mpWindow::OnMouseLeaveWindow)

EVT_MENU(mpID_CENTER, mpWindow::OnCenter)
EVT_MENU(mpID_FIT, mpWindow::OnFit)
EVT_MENU(mpID_ZOOM_IN, mpWindow::OnZoomIn)
EVT_MENU(mpID_ZOOM_OUT, mpWindow::OnZoomOut)
EVT_MENU(mpID_LOCKASPECT, mpWindow::OnLockAspect)
EVT_MENU(mpID_HELP_MOUSE, mpWindow::OnMouseHelp)

END_EVENT_TABLE()

mpWindow::mpWindow() {}
mpWindow::mpWindow(wxWindow *parent, wxWindowID id, const wxPoint &pos, const wxSize &size, long flag, const wxString& name)
	: wxWindow(parent, id, pos, size, flag, name)
{
	m_scaleX = m_scaleY = 1.0;
	m_posX = m_posY = 0;
	m_desiredXmin = m_desiredYmin = 0;
	m_desiredXmax = m_desiredYmax = 1;
	m_scrX = m_scrY = 64; // Fixed from m_scrX = m_scrX = 64;
	m_minX = m_minY = 0;
	m_maxX = m_maxY = 0;
	m_last_lx = m_last_ly = 0;
	m_buff_bmp = NULL;
	m_enableDoubleBuffer = FALSE;
	m_enableMouseNavigation = TRUE;
	m_enableMousePopup = TRUE;
	m_mouseMovedAfterRightClick = FALSE;
	m_mouseMovedAfterMiddleClickWithCtrl = FALSE;

	// See doxygen comments.
	zoomIncrementalFactor = 1.5;

	m_movingInfoLayer = NULL;
	m_movingPointLayer = NULL;
	// Set margins to 0
	m_marginTop = 0; m_marginRight = 0; m_marginBottom = 0; m_marginLeft = 0;
	//SetMaximumXZoomLevel(1);

	m_lockBoundMinY = false;
	m_lockBoundMaxY = false;
	m_lockBoundMinX = false;
	m_lockBoundMaxX = false;

	/*m_scaleXmin = 0.25;
	m_scaleXmax = 2;
	m_scaleYmin = 0.25;
	m_scaleYmax = 2;
	m_scaleBoundsEnable = true;*/

	OnMouseHelpString = _("Supported Mouse commands:\n \
        - Left button down + Mark area: Rectangular zoom\n \
        - Middle button down + Mark are: Horizontal zoom\n \
        - Right button down + Move: Pan (Move)\n \
        - Wheel: Vertical scroll\n \
        - Wheel + SHIFT: Horizontal scroll\n \
        - Wheel + CTRL: Zoom in/out");
	OnMouseHelpStringTitle = _("Mouse Help");

	m_zoomingRect = NULL;
	m_zoomingHorizontally = true;


	m_lockaspect = FALSE;

	InitPopupMenu();

	m_layers.clear();
	SetBackgroundColour(*wxWHITE);
	m_bgColour = *wxWHITE;
	m_fgColour = *wxBLACK;


	//defaultly gradien background is disabled but colours defined.
	m_gradienBackColour = false;
	m_gradienInitialColour = wxColour(150, 150, 200);
	m_gradienDestColour = wxColour(255, 255, 255);
	m_gradienDirect = wxDirection(wxUP);


	m_mouseZoomMode = mpZOOM_XY;

	m_enableScrollBars = false;
	SetSizeHints(128, 128);

	// J.L.Blanco: Eliminates the "flick" with the double buffer.
	SetBackgroundStyle(wxBG_STYLE_CUSTOM);

	UpdateAll();
}

mpWindow::~mpWindow()
{
	// Free all the layers:
	DelAllLayers(true, false);

	wxDELETE(m_buff_bmp);
}

void mpWindow::InitPopupMenu()
{
	m_popmenu.Append(mpID_CENTER, MP_POPMENU_CENTER, MP_POPMENU_CENTER_INFO);
	m_popmenu.Append(mpID_FIT, MP_POPMENU_FIT, MP_POPMENU_FIT_INFO);
	m_popmenu.Append(mpID_ZOOM_IN, MP_POPMENU_ZOOM_IN, MP_POPMENU_ZOOM_IN_INFO);
	m_popmenu.Append(mpID_ZOOM_OUT, MP_POPMENU_ZOOM_OUT, MP_POPMENU_ZOOM_OUT_INFO);
	m_popmenu.AppendCheckItem(mpID_LOCKASPECT, MP_POPMENU_LOCK_ASPECT, MP_POPMENU_LOCK_ASPECT_INFO);
	m_popmenu.Append(mpID_HELP_MOUSE, MP_POPMENU_HELP, MP_POPMENU_HELP_INFO);

}

// Mouse handler, for detecting when the user drag with the right button or just "clicks" for the menu
// JLB
void mpWindow::OnMouseRightDown(wxMouseEvent     &event)
{
	m_mouseMovedAfterRightClick = FALSE;
	m_mouseRClick_X = event.GetX();
	m_mouseRClick_Y = event.GetY();
	wxPoint position = event.GetPosition();

	if (m_zoomingRect)wxDELETE(m_zoomingRect);

#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::OnMouseRightDown() X = %d , Y = %d"), event.GetX(), event.GetY());
#endif


	if (!m_enableMouseNavigation) return;

	//SetCursor( *wxCROSS_CURSOR );

}

// Process mouse wheel events
// JLB
void mpWindow::OnMouseWheel(wxMouseEvent &event)
{
	if (m_zoomingRect)wxDELETE(m_zoomingRect);

	if (!m_enableMouseNavigation)
	{
		event.Skip();
		return;
	}

	//GetClientSize( &m_scrX,&m_scrY);

	if (event.m_controlDown)
	{
		wxPoint clickPt(event.GetX(), event.GetY());
		// CTRL key hold: Zoom in/out:
		if (event.GetWheelRotation()>0) {
			ZoomIn(clickPt);
		}
		else {
			ZoomOut(clickPt);
		}
	}
	else
	{
		// Scroll vertically or horizontally (this is SHIFT is hold down).
		int change = -event.GetWheelRotation(); // Opposite direction (More intuitive)!
		double changeUnitsX = change / m_scaleX;
		double changeUnitsY = change / m_scaleY;

		if (event.m_shiftDown)
		{
			m_posX += changeUnitsX;
			m_desiredXmax += changeUnitsX;
			m_desiredXmin += changeUnitsX;

			if (m_lockBoundMaxX && m_desiredXmax > m_maxX) {
				m_posX -= changeUnitsX;
				m_desiredXmax -= changeUnitsX;
				m_desiredXmin -= changeUnitsX;
			}
			else if (m_lockBoundMinX && m_desiredXmin < m_minX) {
				m_posX -= changeUnitsX;
				m_desiredXmax -= changeUnitsX;
				m_desiredXmin -= changeUnitsX;
			}
		}
		else
		{

			m_posY -= changeUnitsY;

			m_desiredYmax -= changeUnitsY;
			m_desiredYmin -= changeUnitsY;

			if (m_lockBoundMaxY && m_desiredYmax > m_maxY) {
				m_posY += changeUnitsY;
				m_desiredYmax += changeUnitsY;
				m_desiredYmin += changeUnitsY;
			}
			else if (m_lockBoundMinY && m_desiredYmin < m_minY) {
				m_posY += changeUnitsY;
				m_desiredYmax += changeUnitsY;
				m_desiredYmin += changeUnitsY;
			}
		}

		UpdateAll();
	}
}

// If the user "drags" with the right buttom pressed, do "pan"
// JLB
void mpWindow::OnMouseMove(wxMouseEvent     &event)
{
	wxLayerList::iterator li;
	//int mouseX = m_mousePosition_X
	//    = event.GetX();
	//int mouseY = m_mousePosition_Y
	//    = event.GetY();

	//allways update point layer coordinates..
	wxCursor mouseCursor(wxCURSOR_ARROW);

	wxPoint pos = event.GetPosition();
	for (li = m_layers.begin(); li != m_layers.end(); li++) {
		if ((*li)->IsPointLayer())
		{
			mpPointLayer *ly = (mpPointLayer*)(*li);
			ly->UpdateMouseCoord(*this, event);

			if (ly->Inside(pos))
			{
				mouseCursor = wxCURSOR_CROSS; break;
			}

		}
		if ((*li)->IsScaleXLayer())
		{
			mpScaleX *ly = dynamic_cast<mpScaleX*>(*li);
			if (ly->Inside(pos))
			{
				mouseCursor = wxCURSOR_RIGHT_ARROW;  break;
			}
		}
		if ((*li)->IsScaleYLayer())
		{
			mpScaleY *ly = dynamic_cast<mpScaleY*>(*li);
			if (ly->Inside(pos))
			{
				mouseCursor = wxCURSOR_RIGHT_ARROW;  break;
			}
		}
		if ((*li)->IsInfo())
		{
			mpInfoLayer *ly = dynamic_cast<mpInfoLayer*>(*li);
			if (ly->Inside(pos))
			{
				mouseCursor = wxCURSOR_CROSS;  break;
			}
		}
	}
	SetCursor(mouseCursor);


	//If point layer is selected, move it while mouse moves
	if (m_movingPointLayer != NULL && event.m_leftDown)
	{
		m_movingPointLayer->UpdatePoint(*this, event);
		UpdateAll();
		return;
	}

	/*if (!m_enableMouseNavigation)
	{
	event.Skip();
	return;
	}*/

	if (event.m_rightDown && m_enableMouseNavigation)
	{
		m_mouseMovedAfterRightClick = TRUE;  // Hides the popup menu after releasing the button!

											 // The change:
		int  Ax = m_mouseRClick_X - event.GetX();
		int  Ay = m_mouseRClick_Y - event.GetY();

		// For the next event, use relative to this coordinates.
		m_mouseRClick_X = event.GetX();
		m_mouseRClick_Y = event.GetY();

		double   Ax_units = Ax / m_scaleX;
		double   Ay_units = -Ay / m_scaleY;

		m_posX += Ax_units;
		m_posY += Ay_units;

		m_desiredXmax += Ax_units;
		m_desiredXmin += Ax_units;

		m_desiredYmax += Ay_units;
		m_desiredYmin += Ay_units;

		if (m_lockBoundMaxX && m_desiredXmax > m_maxX) {
			m_posX -= Ax_units;
			m_desiredXmax -= Ax_units;
			m_desiredXmin -= Ax_units;
		}
		else if (m_lockBoundMinX && m_desiredXmin < m_minX) {
			m_posX -= Ax_units;
			m_desiredXmax -= Ax_units;
			m_desiredXmin -= Ax_units;
		}
		if (m_lockBoundMaxY && m_desiredYmax > m_maxY) {
			m_posY -= Ay_units;
			m_desiredYmax -= Ay_units;
			m_desiredYmin -= Ay_units;
		}
		else if (m_lockBoundMinY && m_desiredYmin < m_minY) {
			m_posY -= Ay_units;
			m_desiredYmax -= Ay_units;
			m_desiredYmin -= Ay_units;
		}


		UpdateAll();

#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("[mpWindow::OnMouseMove] Ax:%i Ay:%i m_posX:%f m_posY:%f"), Ax, Ay, m_posX, m_posY);
#endif

	}
	else if (event.m_leftDown)
	{
		if (m_movingInfoLayer == NULL && m_enableMouseNavigation && m_mouseDownHasHappened)
		{
			//zooming:
			if (m_zoomingRect == NULL) m_zoomingRect = new wxRect();


			if (m_mouseZoomMode == mpZOOM_XY)
				*m_zoomingRect = wxRect(m_mouseLClick_X, m_mouseLClick_Y, event.GetX() - m_mouseLClick_X, event.GetY() - m_mouseLClick_Y);

			else if (m_mouseZoomMode == mpZOOM_X)
			{
				*m_zoomingRect = wxRect(m_mouseLClick_X,
					GetMarginTop(),
					event.GetX() - m_mouseLClick_X,
					GetScrY() - GetMarginBottom());
			}
		}
		else if (m_movingInfoLayer)
		{
			wxPoint moveVector(event.GetX() - m_mouseLClick_X, event.GetY() - m_mouseLClick_Y);
			if (m_movingInfoLayer)
				m_movingInfoLayer->Move(moveVector);
		}
		UpdateAll();
		//RefreshRect(*m_zoomingRect);
	}
	else if (event.m_middleDown && m_enableMouseNavigation) {

		if (event.m_controlDown) {
			//tape measurement
			m_mouseMovedAfterMiddleClickWithCtrl = TRUE;
			UpdateAll();
			//Refresh( FALSE );
		}
		else if (m_mouseMovedAfterMiddleClickWithCtrl) {
			m_mouseMovedAfterMiddleClickWithCtrl = FALSE;
			UpdateAll();
			//Refresh( FALSE );
		}
		else if (!m_mouseMovedAfterMiddleClickWithCtrl) {
			//zooming:
			if (m_zoomingRect == NULL) m_zoomingRect = new wxRect();

			if (abs(event.GetX() - m_mouseMClick_X) > abs(event.GetY() - m_mouseMClick_Y))
				m_zoomingHorizontally = true;
			else m_zoomingHorizontally = false;

			if (m_zoomingHorizontally) {
				*m_zoomingRect = wxRect(m_mouseMClick_X,
					GetMarginTop(),
					event.GetX() - m_mouseMClick_X,
					GetScrY() - GetMarginBottom());
			}
			else {
				*m_zoomingRect = wxRect(GetMarginLeft(),
					m_mouseMClick_Y,
					GetScrX() - GetMarginRight(),
					event.GetY() - m_mouseMClick_Y);
			}

			//RefreshRect(*m_zoomingRect);
			UpdateAll();
			//Refresh( FALSE );
		}
	}
	else {
		if (m_zoomingRect)wxDELETE(m_zoomingRect);
		//update all info layers
		for (li = m_layers.begin(); li != m_layers.end(); li++) {
			if ((*li)->IsInfo() && (*li)->IsVisible()) {
				mpInfoLayer* tmpLyr = (mpInfoLayer*)(*li);
				tmpLyr->UpdateInfo(*this, event);
				UpdateAll();
				//RefreshRect(tmpLyr->GetRectangle());
			}
		}
		/*
		// if (m_coordTooltip) {
		wxString toolTipContent;
		toolTipContent.Printf(_("X = %f\nY = %f"), p2x(event.GetX()), p2y(event.GetY()));
		wxTipWindow** ptr = NULL;
		wxRect rectBounds(event.GetX(), event.GetY(), 5, 5);
		wxTipWindow* tip = new wxTipWindow(this, toolTipContent, 100, ptr, &rectBounds);

		//} */
	}

	event.Skip();
}

bool mpWindow::checkPoint(int mouseX, int mouseY, int centerX, int centerY, int r)
{
	int distance = std::sqrt(std::pow(mouseX - centerX, 2) +
		std::pow(mouseY - centerY, 2));
	if (distance <= r)  return true;
	return false;
}

void mpWindow::OnMouseLeftDown(wxMouseEvent &event)
{
	m_mouseDownHasHappened = true;
	m_mouseLClick_X = event.GetX();
	m_mouseLClick_Y = event.GetY();
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::OnMouseLeftDown() X = %d , Y = %d"), event.GetX(), event.GetY());/*m_mouseLClick_X, m_mouseLClick_Y);*/
#endif
	wxPoint pointClicked = event.GetPosition();
	m_movingInfoLayer = IsInsideInfoLayer(pointClicked);
	if (m_movingInfoLayer != NULL) {
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("mpWindow::OnMouseLeftDown() started moving layer %lx"), (long int)m_movingInfoLayer);/*m_mouseLClick_X, m_mouseLClick_Y);*/
#endif
		event.Skip(); return;
	}
	m_movingPointLayer = IsInsidePointLayer(pointClicked);
	if (m_movingPointLayer != NULL) {
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("mpWindow::OnMouseRightDown() started moving layer %lx"), (long int)m_movingPointLayer);/*m_mouseLClick_X, m_mouseLClick_Y);*/
#endif
		this->SetCursor(wxCURSOR_CROSS);
		m_movingPointLayer->UpdatePoint(*this, event);
		event.Skip(); return;
	}

	for (auto layer : m_layers)
	{
		lineChartLayer *pLayer = dynamic_cast<lineChartLayer*>(layer);
		if (pLayer != nullptr && pLayer->GetContinuity() == false)
		{
			double x, y;
			pLayer->Rewind();
			while (pLayer->GetNextXY(x, y))
			{
				if (checkPoint(pointClicked.x, pointClicked.y, x2p(x), y2p(y), 4))
				{
					wxMessageBox("Clicou no ponto (" + wxString::FromDouble(x) + "," + wxString::FromDouble(y) + ")");
					break;
				}
			}
		}
	}
	event.Skip();
}

void mpWindow::OnMouseLeftRelease(wxMouseEvent &event)
{
	wxPoint release(event.GetX(), event.GetY());
	wxPoint press(m_mouseLClick_X, m_mouseLClick_Y);

	if (m_zoomingRect)wxDELETE(m_zoomingRect);

	if (m_movingInfoLayer != NULL) {
		m_movingInfoLayer->UpdateReference();
		m_movingInfoLayer = NULL;
	}
	else if (m_movingPointLayer != NULL) {
		//if point layer is enabled, and relase left mouse button, update point
		m_movingPointLayer->UpdatePoint(*this, event);
		UpdateAll();
		m_movingPointLayer = NULL;
		this->SetCursor(wxCURSOR_ARROW);
	}
	else {

		if (release != press && m_enableMouseNavigation &&
			!event.m_rightDown  //this allows to cancel the zooming
			)
		{
			//only when mouseNavigation is enabled

			if (m_mouseDownHasHappened)
			{
				// only when there has previously been a mouse down event.

				//if mpZOOM_X is selected, Y axis not zooming!
				if (m_mouseZoomMode == mpZOOM_X) {
					press.y = GetMarginTop();
					release.y = GetScrY() - GetMarginBottom();
				}
				if (m_mouseZoomMode == mpZOOM_Y)
				{
					/// @todo not tested
					press.x = GetMarginLeft();
					release.x = GetScrX() - GetMarginRight();
				}

				//pressed to avoid injury
				//must be more than 8 pixel different
				if (press.x >> 4 != release.x >> 4 &&
					press.y >> 4 != release.y >> 4)
					ZoomRect(press, release);
			}
			else
			{

			}

		} /*else {
		  if (m_coordTooltip) {
		  wxString toolTipContent;
		  toolTipContent.Printf(_("X = %f\nY = %f"), p2x(event.GetX()), p2y(event.GetY()));
		  SetToolTip(toolTipContent);
		  }
		  }*/
	}
	m_mouseDownHasHappened = false;
	event.Skip();
}

void mpWindow::Fit()
{
	if (UpdateBBox())
		Fit(m_minX, m_maxX, m_minY, m_maxY);
}


// JL
void mpWindow::Fit(double xMin, double xMax, double yMin, double yMax, wxCoord *printSizeX, wxCoord *printSizeY)
{
	// Save desired borders:
	m_desiredXmin = xMin; m_desiredXmax = xMax;
	m_desiredYmin = yMin; m_desiredYmax = yMax;

	if (printSizeX != NULL && printSizeY != NULL)
	{
		// Printer:
		m_scrX = *printSizeX;
		m_scrY = *printSizeY;
	}
	else
	{
		// Normal case (screen):
		GetClientSize(&m_scrX, &m_scrY);
	}

	double Ax, Ay;

	Ax = xMax - xMin;
	Ay = yMax - yMin;

	m_scaleX = (Ax != 0) ? (m_scrX - m_marginLeft - m_marginRight) / Ax : 1; //m_scaleX = (Ax!=0) ? m_scrX/Ax : 1;
	m_scaleY = (Ay != 0) ? (m_scrY - m_marginTop - m_marginBottom) / Ay : 1; //m_scaleY = (Ay!=0) ? m_scrY/Ay : 1;

	if (m_lockaspect)
	{
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("mpWindow::Fit()(lock) m_scaleX=%f,m_scaleY=%f"), m_scaleX, m_scaleY);
#endif
		// Keep the lowest "scale" to fit the whole range required by that axis (to actually "fit"!):
		double s = m_scaleX < m_scaleY ? m_scaleX : m_scaleY;
		m_scaleX = s;
		m_scaleY = s;
	}

	// Adjusts corner coordinates: This should be simply:
	//   m_posX = m_minX;
	//   m_posY = m_maxY;
	// But account for centering if we have lock aspect:
	m_posX = (xMin + xMax) / 2 - ((m_scrX - m_marginLeft - m_marginRight) / 2 + m_marginLeft) / m_scaleX; // m_posX = (xMin+xMax)/2 - (m_scrX/2)/m_scaleX;
																										  //	m_posY = (yMin+yMax)/2 + ((m_scrY - m_marginTop - m_marginBottom)/2 - m_marginTop)/m_scaleY;  // m_posY = (yMin+yMax)/2 + (m_scrY/2)/m_scaleY;
	m_posY = (yMin + yMax) / 2 + ((m_scrY - m_marginTop - m_marginBottom) / 2 + m_marginTop) / m_scaleY;  // m_posY = (yMin+yMax)/2 + (m_scrY/2)/m_scaleY;

#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::Fit() m_desiredXmin=%f m_desiredXmax=%f  m_desiredYmin=%f m_desiredYmax=%f"), xMin, xMax, yMin, yMax);
	wxLogMessage(_("mpWindow::Fit() m_scaleX = %f , m_scrX = %d,m_scrY=%d, Ax=%f, Ay=%f, m_posX=%f, m_posY=%f"), m_scaleX, m_scrX, m_scrY, Ax, Ay, m_posX, m_posY);
#endif

	// It is VERY IMPORTANT to DO NOT call Refresh if we are drawing to the printer!!
	// Otherwise, the DC dimensions will be those of the window instead of the printer device
	if (printSizeX == NULL || printSizeY == NULL)
		UpdateAll();
}

// Patch ngpaton
void mpWindow::DoZoomInXCalc(const int staticXpixel)
{
	// Preserve the position of the clicked point:
	double staticX = p2x(staticXpixel);
	// Zoom in:
	m_scaleX = m_scaleX * zoomIncrementalFactor;
	// Adjust the new m_posx
	m_posX = staticX - (staticXpixel / m_scaleX);
	// Adjust desired
	m_desiredXmin = m_posX;
	m_desiredXmax = m_posX + (m_scrX - (m_marginLeft + m_marginRight)) / m_scaleX;
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::DoZoomInXCalc() prior X coord: (%f), new X coord: (%f) SHOULD BE EQUAL!!"), staticX, p2x(staticXpixel));
#endif
}

void mpWindow::DoZoomInYCalc(const int staticYpixel)
{
	// Preserve the position of the clicked point:
	double staticY = p2y(staticYpixel);
	// Zoom in:
	m_scaleY = m_scaleY * zoomIncrementalFactor;
	// Adjust the new m_posy:
	m_posY = staticY + (staticYpixel / m_scaleY);
	// Adjust desired
	m_desiredYmax = m_posY;
	m_desiredYmin = m_posY - (m_scrY - (m_marginTop + m_marginBottom)) / m_scaleY;
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::DoZoomInYCalc() prior Y coord: (%f), new Y coord: (%f) SHOULD BE EQUAL!!"), staticY, p2y(staticYpixel));
#endif
}

void mpWindow::DoZoomOutXCalc(const int staticXpixel)
{
	// Preserve the position of the clicked point:
	double staticX = p2x(staticXpixel);
	// Zoom out:
	m_scaleX = m_scaleX / zoomIncrementalFactor;
	// Adjust the new m_posx/y:
	m_posX = staticX - (staticXpixel / m_scaleX);
	// Adjust desired
	m_desiredXmin = m_posX;
	m_desiredXmax = m_posX + (m_scrX - (m_marginLeft + m_marginRight)) / m_scaleX;
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::DoZoomOutXCalc() prior X coord: (%f), new X coord: (%f) SHOULD BE EQUAL!!"), staticX, p2x(staticXpixel));
#endif
}

void mpWindow::DoZoomOutYCalc(const int staticYpixel)
{
	// Preserve the position of the clicked point:
	double staticY = p2y(staticYpixel);
	// Zoom out:
	m_scaleY = m_scaleY / zoomIncrementalFactor;
	// Adjust the new m_posx/y:
	m_posY = staticY + (staticYpixel / m_scaleY);
	// Adjust desired
	m_desiredYmax = m_posY;
	m_desiredYmin = m_posY - (m_scrY - (m_marginTop + m_marginBottom)) / m_scaleY;
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::DoZoomOutYCalc() prior Y coord: (%f), new Y coord: (%f) SHOULD BE EQUAL!!"), staticY, p2y(staticYpixel));
#endif
}


void mpWindow::ZoomIn(const wxPoint& centerPoint)
{
	wxPoint	c(centerPoint);
	if (c == wxDefaultPosition)
	{
		GetClientSize(&m_scrX, &m_scrY);
		c.x = (m_scrX - m_marginLeft - m_marginRight) / 2 + m_marginLeft; // c.x = m_scrX/2;
		c.y = (m_scrY - m_marginTop - m_marginBottom) / 2 - m_marginTop; // c.y = m_scrY/2;
	}

	// Preserve the position of the clicked point:
	double prior_layer_x = p2x(c.x);
	double prior_layer_y = p2y(c.y);

	// Zoom in:
	m_scaleX *= zoomIncrementalFactor;
	m_scaleY *= (m_mouseZoomMode == mpZOOM_XY ? zoomIncrementalFactor : 1);

	// Adjust the new m_posx/y:
	m_posX = prior_layer_x - c.x / m_scaleX;
	m_posY = prior_layer_y + c.y / m_scaleY;

	m_desiredXmin = m_posX;
	m_desiredXmax = m_posX + (m_scrX - m_marginLeft - m_marginRight) / m_scaleX; // m_desiredXmax = m_posX + m_scrX / m_scaleX;
	m_desiredYmax = m_posY;
	m_desiredYmin = m_posY - (m_scrY - m_marginTop - m_marginBottom) / m_scaleY; // m_desiredYmin = m_posY - m_scrY / m_scaleY;


#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::ZoomIn() prior coords: (%f,%f), new coords: (%f,%f) SHOULD BE EQUAL!!"), prior_layer_x, prior_layer_y, p2x(c.x), p2y(c.y));
#endif

	UpdateAll();
}

void mpWindow::ZoomOut(const wxPoint& centerPoint)
{
	wxPoint	c(centerPoint);
	if (c == wxDefaultPosition)
	{
		GetClientSize(&m_scrX, &m_scrY);
		c.x = (m_scrX - m_marginLeft - m_marginRight) / 2 + m_marginLeft; // c.x = m_scrX/2;
		c.y = (m_scrY - m_marginTop - m_marginBottom) / 2 - m_marginTop; // c.y = m_scrY/2;
	}

	// Preserve the position of the clicked point:
	double prior_layer_x = p2x(c.x);
	double prior_layer_y = p2y(c.y);
	/*double  tmpPosX = m_posX,
	tmpPosY = m_posY,
	tmpDesXmin = m_desiredXmin,
	tmpDesXmax = m_desiredXmax,
	tmpDesYmin = m_desiredYmin,
	tmpDesYmax = m_desiredYmax,
	tmpScaleX = m_scaleX,
	tmpScaleY = m_scaleY;*/

	// Zoom out:

	/*if(m_scaleBoundsEnable)
	{
	if(m_scaleXmax > (m_scaleX / zoomIncrementalFactor) );
	m_scaleX /= zoomIncrementalFactor;

	if( m_scaleYmax > ( m_scaleY / (m_mouseZoomMode==mpZOOM_XY ? zoomIncrementalFactor : 1)  ) )
	m_scaleY /= (m_mouseZoomMode==mpZOOM_XY ? zoomIncrementalFactor : 1);

	}
	else*/
	{
		m_scaleX /= zoomIncrementalFactor;
		m_scaleY /= (m_mouseZoomMode == mpZOOM_XY ? zoomIncrementalFactor : 1);
	}

	// Adjust the new m_posx/y:
	m_posX = prior_layer_x - c.x / m_scaleX;

	if (m_mouseZoomMode == mpZOOM_XY)
		m_posY = prior_layer_y + c.y / m_scaleY;

	m_desiredXmin = m_posX;
	m_desiredXmax = m_posX + (m_scrX - m_marginLeft - m_marginRight) / m_scaleX; // m_desiredXmax = m_posX + m_scrX / m_scaleX;
	m_desiredYmax = m_posY;
	m_desiredYmin = m_posY - (m_scrY - m_marginTop - m_marginBottom) / m_scaleY; // m_desiredYmin = m_posY - m_scrY / m_scaleY;

																				 /*if(m_lockBoundMaxX && m_desiredXmax > m_maxX){
																				 m_posX = tmpPosX;
																				 m_scaleX = tmpScaleX;
																				 m_desiredXmax = tmpDesXmax;
																				 }
																				 if(m_lockBoundMinX && m_desiredXmin < m_minX){
																				 m_posX = tmpPosX;
																				 m_scaleX = tmpScaleX;
																				 m_desiredXmin = tmpDesXmin;
																				 }
																				 if(m_lockBoundMaxY && m_desiredYmax > m_maxY){
																				 m_posX = tmpPosY;
																				 m_scaleY = tmpScaleY;
																				 m_desiredYmax = tmpDesYmax;
																				 }
																				 if(m_lockBoundMinY && m_desiredYmin < m_minY){
																				 m_posY = tmpPosY;
																				 m_scaleY = tmpScaleY;
																				 m_desiredYmin = tmpDesYmin;
																				 }*/

#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::ZoomOut() prior coords: (%f,%f), new coords: (%f,%f) SHOULD BE EQUAL!!"), prior_layer_x, prior_layer_y, p2x(c.x), p2y(c.y));
#endif
	UpdateAll();
}

void mpWindow::ZoomInX()
{
	m_scaleX = m_scaleX * zoomIncrementalFactor;
	UpdateAll();
}

void mpWindow::ZoomOutX()
{
	m_scaleX = m_scaleX / zoomIncrementalFactor;
	UpdateAll();
}

void mpWindow::ZoomInY()
{
	m_scaleY = m_scaleY * zoomIncrementalFactor;
	UpdateAll();
}

void mpWindow::ZoomOutY()
{
	m_scaleY = m_scaleY / zoomIncrementalFactor;
	UpdateAll();
}

void mpWindow::ZoomRect(wxPoint p0, wxPoint p1)
{
	// Compute the 2 corners in graph coordinates:
	double p0x = p2x(p0.x);
	double p0y = p2y(p0.y);
	double p1x = p2x(p1.x);
	double p1y = p2y(p1.y);

	// Order them:
	double zoom_x_min = p0x<p1x ? p0x : p1x;
	double zoom_x_max = p0x>p1x ? p0x : p1x;
	double zoom_y_min = p0y<p1y ? p0y : p1y;
	double zoom_y_max = p0y>p1y ? p0y : p1y;

#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("Zoom: (%f,%f)-(%f,%f)"), zoom_x_min, zoom_y_min, zoom_x_max, zoom_y_max);
#endif

	Fit(zoom_x_min, zoom_x_max, zoom_y_min, zoom_y_max);
}

void mpWindow::LockAspect(bool enable)
{
	m_lockaspect = enable;
	m_popmenu.Check(mpID_LOCKASPECT, enable);

	// Try to fit again with the new config:
	Fit(m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax);
}

void mpWindow::OnShowPopupMenu(wxMouseEvent &event)
{

}

void mpWindow::OnMouseLeaveWindow(wxMouseEvent &event)
{
	if (m_zoomingRect)wxDELETE(m_zoomingRect);
	m_mouseDownHasHappened = false;
}

void mpWindow::OnMouseMiddleDown(wxMouseEvent     &event)
{
	m_mouseMovedAfterMiddleClickWithCtrl = FALSE;
	m_mouseMClick_X = event.GetX();
	m_mouseMClick_Y = event.GetY();
	wxPoint pointClicked = event.GetPosition();
}
void mpWindow::OnMouseMiddleRelease(wxMouseEvent  &event)
{
	wxPoint release(event.GetX(), event.GetY());
	wxPoint press(m_mouseMClick_X, m_mouseMClick_Y);

	if (m_zoomingRect)wxDELETE(m_zoomingRect);
	if (m_mouseMovedAfterMiddleClickWithCtrl)
	{
		m_mouseMovedAfterMiddleClickWithCtrl = FALSE;
		return;
	}

	if (release != press && m_enableMouseNavigation &&
		!event.m_rightDown  //this allows to cancel the zooming
		)
	{
		//only when mouseNavigation is enabled



		//must be more than 8 pixel different
		//pressed to avoid injury
		if (press.x >> 4 != release.x >> 4)
		{

			if (m_zoomingHorizontally) {
				press.y = GetMarginTop();
				release.y = GetScrY() - GetMarginBottom();
			}
			else { /// @bug there might be some bug
				press.x = GetMarginLeft();
				release.x = GetScrX() - GetMarginRight();
			}
			ZoomRect(press, release);
		}
	}

	event.Skip();
}
void mpWindow::OnMouseRightRelease(wxMouseEvent &event)
{
	// Only display menu if the user has not "dragged" the figure


	SetCursor(*wxSTANDARD_CURSOR);
	wxPoint pos = event.GetPosition();

	//Check if there is point layer point in this position
	for (wxLayerList::iterator li = m_layers.begin(); li != m_layers.end(); li++) {
		if ((*li)->IsPointLayer())
		{
			mpPointLayer *ly = dynamic_cast<mpPointLayer*>(*li);
			if (ly->Inside(pos))
			{
				ly->popup(*this, event);
				return; //nothing more.
			}
		}
		if ((*li)->IsScaleXLayer())
		{
			mpScaleX *ly = dynamic_cast<mpScaleX*>(*li);
			if (ly->Inside(pos))
			{
				ly->popup(*this, event);
				return; //nothing more.
			}
		}
		if ((*li)->IsScaleYLayer())
		{
			mpScaleY *ly = dynamic_cast<mpScaleY*>(*li);
			if (ly->Inside(pos))
			{
				ly->popup(*this, event);
				return; //nothing more.
			}
		}
		if ((*li)->IsInfoLegendLayer())
		{
			mpInfoLegend *ly = dynamic_cast<mpInfoLegend*>(*li);
			if (ly->Inside(pos))
			{
				ly->popup(*this, event);
				return; //nothing more.
			}
		}
	}

	if (!m_enableMouseNavigation)
	{
		return;
	}


	if (!m_mouseMovedAfterRightClick && m_enableMousePopup)   // JLB
	{
		m_clickedX = event.GetX();
		m_clickedY = event.GetY();
		PopupMenu(&m_popmenu, event.GetX(), event.GetY());
	}
}

void mpWindow::OnLockAspect(wxCommandEvent& WXUNUSED(event))
{
	LockAspect(!m_lockaspect);
}
void mpWindow::OnMouseHelp(wxCommandEvent& WXUNUSED(event))
{
	wxMessageBox(OnMouseHelpString, OnMouseHelpStringTitle, wxOK, this);
}

void mpWindow::OnFit(wxCommandEvent& WXUNUSED(event))
{
	Fit();
}
void mpWindow::OnCenter(wxCommandEvent& WXUNUSED(event))
{
	GetClientSize(&m_scrX, &m_scrY);
	int centerX = (m_scrX - m_marginLeft - m_marginRight) / 2; // + m_marginLeft; // c.x = m_scrX/2;
	int centerY = (m_scrY - m_marginTop - m_marginBottom) / 2; // - m_marginTop; // c.y = m_scrY/2;
	SetPos(p2x(m_clickedX - centerX), p2y(m_clickedY - centerY));
	//SetPos( p2x(m_clickedX-m_scrX/2), p2y(m_clickedY-m_scrY/2) );  //SetPos( (double)(m_clickedX-m_scrX/2) / m_scaleX + m_posX, (double)(m_scrY/2-m_clickedY) / m_scaleY + m_posY);
}

void mpWindow::OnZoomIn(wxCommandEvent& WXUNUSED(event))
{
	ZoomIn(wxPoint(m_mouseRClick_X, m_mouseRClick_Y));
}

void mpWindow::OnZoomOut(wxCommandEvent& WXUNUSED(event))
{
	ZoomOut();
}

void mpWindow::OnSize(wxSizeEvent& WXUNUSED(event))
{
	// Try to fit again with the new window size:
	Fit(m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax);
#ifdef MATHPLOT_DO_LOGGING
	wxLogMessage(_("mpWindow::OnSize() m_scrX = %d, m_scrY = %d"), m_scrX, m_scrY);
#endif // MATHPLOT_DO_LOGGING
}


bool mpWindow::AddLayer(mpLayer* layer, bool refreshDisplay)
{
	if (layer != NULL) {
		m_layers.push_back(layer);

		if (layer->IsPointLayer()) SetLayerBottom(layer);

		if (refreshDisplay) UpdateAll();
		return true;
	};
	return false;
}

double mpWindow::getMinWLayersY()
{
	double min = std::numeric_limits<double>::max();
	for (auto layer : m_layers)
	{
		if (layer->GetMinY() < min)
		{
			min = layer->GetMinY();
		}
	}
	return min;
}

bool mpWindow::DelLayer(
	mpLayer*    layer,
	bool        alsoDeleteObject,
	bool        refreshDisplay)
{
	wxLayerList::iterator layIt;
	for (layIt = m_layers.begin(); layIt != m_layers.end(); layIt++)
	{
		if (*layIt == layer)
		{
			// Also delete the object?
			if (alsoDeleteObject)
				delete *layIt;
			m_layers.erase(layIt); // this deleted the reference only
			if (refreshDisplay)
				UpdateAll();
			return true;
		}
	}
	return false;
}

void mpWindow::DelAllLayers(bool alsoDeleteObject, bool refreshDisplay)
{
	while (m_layers.size()>0)
	{
		// Also delete the object?
		if (alsoDeleteObject) delete m_layers[0];
		m_layers.erase(m_layers.begin()); // this deleted the reference only
	}
	if (refreshDisplay)  UpdateAll();
}

// void mpWindow::DoPrepareDC(wxDC& dc)
// {
//     dc.SetDeviceOrigin(x2p(m_minX), y2p(m_maxY));
// }

void mpWindow::OnPaint(wxPaintEvent& WXUNUSED(event))
{
	wxPaintDC dc(this);
	dc.GetSize(&m_scrX, &m_scrY);   // This is the size of the visible area only!
									//     DoPrepareDC(dc);

#ifdef MATHPLOT_DO_LOGGING
	{
		int px, py;
		GetViewStart(&px, &py);
		wxLogMessage(_("[mpWindow::OnPaint] vis.area:%ix%i px=%i py=%i"), m_scrX, m_scrY, px, py);
	}
#endif

	// Selects direct or buffered draw:
	wxDC    *trgDc;

	// J.L.Blanco @ Aug 2007: Added double buffer support
	if (m_enableDoubleBuffer)
	{
		if (m_last_lx != m_scrX || m_last_ly != m_scrY)
		{
			wxDELETE(m_buff_bmp);
			m_buff_bmp = new wxBitmap(m_scrX, m_scrY);
			m_buff_dc.SelectObject(*m_buff_bmp);
			m_last_lx = m_scrX;
			m_last_ly = m_scrY;
		}
		trgDc = &m_buff_dc;
	}
	else
	{
		trgDc = &dc;
	}

	// Draw background:
	//trgDc->SetDeviceOrigin(0,0);


	trgDc->SetPen(*wxTRANSPARENT_PEN);
	wxBrush brush(GetBackgroundColour());
	trgDc->SetBrush(brush);
	trgDc->SetTextForeground(m_fgColour);

	if (m_gradienBackColour)
		trgDc->GradientFillLinear(wxRect(0, 0, m_scrX, m_scrY), m_gradienInitialColour, m_gradienDestColour, m_gradienDirect);
	else
		trgDc->DrawRectangle(0, 0, m_scrX, m_scrY);

	if (m_zoomingRect)
	{

		//wxToolTip* tip = GetToolTip();
		//if(tip)tip->Enable(false);

		wxPen pen(*wxBLACK, 1, wxDOT);
		trgDc->SetPen(pen);


		if (m_mouseZoomMode == mpZOOM_XY)
		{
			trgDc->SetBrush(*wxLIGHT_GREY_BRUSH);
			trgDc->DrawRectangle(*m_zoomingRect);
		}
		else if (m_mouseZoomMode == mpZOOM_X)
		{
			wxCoord  width, height;
			trgDc->GetSize(&width, &height);

			trgDc->DrawLine(m_zoomingRect->x, 0, m_zoomingRect->x, height);
			trgDc->DrawLine(m_zoomingRect->x + m_zoomingRect->width, 0, m_zoomingRect->x + m_zoomingRect->width, height);
			trgDc->SetBrush(*wxLIGHT_GREY_BRUSH);
			trgDc->DrawRectangle(*m_zoomingRect);

			trgDc->SetBrush(*wxTRANSPARENT_BRUSH);

		}
	}
	else {
		/*wxToolTip* tip = wxWindow::GetToolTip();
		if(tip)tip->Enable(true);*/
	}

	// Draw all the layers:
	//trgDc->SetDeviceOrigin( m_scrX>>1, m_scrY>>1);  // Origin at the center
	wxLayerList::iterator li;
	for (li = m_layers.begin(); li != m_layers.end(); li++)
	{
		mpLayer* ptLayer = (*li);
		ptLayer->Plot(*trgDc, *this);
	};


#ifndef ZEROZERO
	if (m_mouseMovedAfterMiddleClickWithCtrl)
	{
		// Measure tape.
		// show dx, dy and distance
		wxPoint pos0 = wxPoint(m_mouseMClick_X, m_mouseMClick_Y);
		wxPoint pos1 = wxPoint(m_mousePosition_X, m_mousePosition_Y);
		double  dx = p2x(pos0.x) - p2x(pos1.x),
			dy = p2y(pos0.y) - p2y(pos1.y),
			distance = sqrtf(dx*dx + dy*dy);
		wxString label = wxString::Format(_("dX: %.2f\ndY: %.2f\nDistance: %.2f"),
			dx, dy, distance);
		wxRect rect;
		rect.x = pos0.x + (pos1.x - pos0.x) / 2;
		rect.y = pos0.y + (pos1.y - pos0.y) / 2;

		trgDc->SetPen(*wxBLACK_PEN);
		trgDc->DrawLine(pos0, pos1);

		trgDc->GetMultiLineTextExtent(label, &rect.width, &rect.height);
		trgDc->SetBrush(*wxTRANSPARENT_BRUSH);
		trgDc->DrawRectangle(rect.x - 5, rect.y - 5, rect.width + 10, rect.height + 10);
		trgDc->DrawLabel(label, rect);
	}
#endif


	// If doublebuffer, draw now to the window:
	if (m_enableDoubleBuffer)
	{
		//trgDc->SetDeviceOrigin(0,0);
		//dc.SetDeviceOrigin(0,0);  // Origin at the center
		dc.Blit(0, 0, m_scrX, m_scrY, trgDc, 0, 0);
	}

	/*    if (m_coordTooltip) {
	wxString toolTipContent;
	wxPoint mousePoint =  wxGetMousePosition();
	toolTipContent.Printf(_("X = %f\nY = %f"), p2x(mousePoint.x), p2y(mousePoint.y));
	SetToolTip(toolTipContent);
	}*/
	// If scrollbars are enabled, refresh them
	if (m_enableScrollBars) {
		/*       m_scrollX = (int) floor((m_posX - m_minX)*m_scaleX);
		m_scrollY = (int) floor((m_maxY - m_posY )*m_scaleY);
		Scroll(m_scrollX, m_scrollY);*/
		// Scroll(x2p(m_posX), y2p(m_posY));
		//             SetVirtualSize((int) ((m_maxX - m_minX)*m_scaleX), (int) ((m_maxY - m_minY)*m_scaleY));
		//         int centerX = (m_scrX - m_marginLeft - m_marginRight)/2; // + m_marginLeft; // c.x = m_scrX/2;
		// 	int centerY = (m_scrY - m_marginTop - m_marginBottom)/2; // - m_marginTop; // c.y = m_scrY/2;
		/*SetScrollbars(1, 1, (int) ((m_maxX - m_minX)*m_scaleX), (int) ((m_maxY - m_minY)*m_scaleY));*/ //, x2p(m_posX + centerX/m_scaleX), y2p(m_posY - centerY/m_scaleY), true);
	}

}

// void mpWindow::OnScroll2(wxScrollWinEvent &event)
// {
// #ifdef MATHPLOT_DO_LOGGING
//     wxLogMessage(_("[mpWindow::OnScroll2] Init: m_posX=%f m_posY=%f, sc_pos = %d"),m_posX,m_posY, event.GetPosition());
// #endif
//     // If scrollbars are not enabled, Skip operation
//     if (!m_enableScrollBars) {
//         event.Skip();
//         return;
//     }
// //     m_scrollX = (int) floor((m_posX - m_minX)*m_scaleX);
// //     m_scrollY = (int) floor((m_maxY - m_posY /*- m_minY*/)*m_scaleY);
// //     Scroll(m_scrollX, m_scrollY);
//
// //     GetClientSize( &m_scrX, &m_scrY);
//     //Scroll(x2p(m_desiredXmin), y2p(m_desiredYmin));
//     int pixelStep = 1;
//     if (event.GetOrientation() == wxHORIZONTAL) {
//         //m_desiredXmin -= (m_scrollX - event.GetPosition())/m_scaleX;
//         //m_desiredXmax -= (m_scrollX - event.GetPosition())/m_scaleX;
//         m_posX -= (m_scrollX - event.GetPosition())/m_scaleX;
//         m_scrollX = event.GetPosition();
//     }
//     Fit(m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax);
// // /*    int pixelStep = 1;
// //     if (event.GetOrientation() == wxHORIZONTAL) {
// //         m_posX 		-= (px - event.GetPosition())/m_scaleX;//(pixelStep/m_scaleX);
// // 	m_desiredXmax 	-= (px - event.GetPosition())/m_scaleX;//(pixelStep/m_scaleX);
// // 	m_desiredXmin 	-= (px - event.GetPosition())/m_scaleX;//(pixelStep/m_scaleX);
// //         //SetPosX( (double)px / GetScaleX() + m_minX + (double)(width>>1)/GetScaleX());
// // //         m_posX = p2x(px); //m_minX + (double)(px /*+ (m_scrX)*/)/GetScaleX();
// //     } else {
// //         m_posY 		+= (py - event.GetPosition())/m_scaleY;//(pixelStep/m_scaleY);
// // 	m_desiredYmax	+= (py - event.GetPosition())/m_scaleY;//(pixelStep/m_scaleY);
// // 	m_desiredYmax	+= (py - event.GetPosition())/m_scaleY;//(pixelStep/m_scaleY);
// //         //SetPosY( m_maxY - (double)py / GetScaleY() - (double)(height>>1)/GetScaleY());
// //         //m_posY = m_maxY - (double)py / GetScaleY() - (double)(height>>1)/GetScaleY();
// // //         m_posY = p2y(py);//m_maxY - (double)(py /*+ (m_scrY)*/)/GetScaleY();
// //     }*/
// #ifdef MATHPLOT_DO_LOGGING
//     int px, py;
//     GetViewStart( &px, &py);
//     wxLogMessage(_("[mpWindow::OnScroll2] End:  m_posX = %f, m_posY = %f, px = %f, py = %f"),m_posX, m_posY, px, py);
// #endif
//
//     UpdateAll();
// //     event.Skip();
// }

void mpWindow::SetMPScrollbars(bool status)
{
	// Temporary behaviour: always disable scrollbars
	m_enableScrollBars = status; //false;
	if (status == false)
	{
		SetScrollbar(wxHORIZONTAL, 0, 0, 0);
		SetScrollbar(wxVERTICAL, 0, 0, 0);
	}
	// else the scroll bars will be updated in UpdateAll();
	UpdateAll();

	//     EnableScrolling(false, false);
	//     m_enableScrollBars = status;
	//     EnableScrolling(status, status);
	/*    m_scrollX = (int) floor((m_posX - m_minX)*m_scaleX);
	m_scrollY = (int) floor((m_posY - m_minY)*m_scaleY);*/
	//     int scrollWidth = (int) floor((m_maxX - m_minX)*m_scaleX) - m_scrX;
	//     int scrollHeight = (int) floor((m_minY - m_maxY)*m_scaleY) - m_scrY;

	// /*    m_scrollX = (int) floor((m_posX - m_minX)*m_scaleX);
	//     m_scrollY = (int) floor((m_maxY - m_posY /*- m_minY*/)*m_scaleY);
	//     int scrollWidth = (int) floor(((m_maxX - m_minX) - (m_desiredXmax - m_desiredXmin))*m_scaleX);
	//     int scrollHeight = (int) floor(((m_maxY - m_minY) - (m_desiredYmax - m_desiredYmin))*m_scaleY);
	// #ifdef MATHPLOT_DO_LOGGING
	//     wxLogMessage(_("mpWindow::SetMPScrollbars() scrollWidth = %d, scrollHeight = %d"), scrollWidth, scrollHeight);
	// #endif
	//     if(status) {
	//         SetScrollbars(1,
	//                       1,
	//                       scrollWidth,
	//                       scrollHeight,
	//                       m_scrollX,
	//                       m_scrollY);
	// //         SetVirtualSize((int) (m_maxX - m_minX), (int) (m_maxY - m_minY));
	//     }
	//     Refresh(false);*/
};

bool mpWindow::UpdateBBox()
{
	bool first = TRUE;

	for (wxLayerList::iterator li = m_layers.begin(); li != m_layers.end(); li++)
	{
		mpLayer* f = *li;

		if (f->HasBBox() && f->IsVisible()) //updated: If not visible, don't check bounding boxes! 10.11.-09 by Jussi V-A
		{
			if (first)
			{
				first = FALSE;
				m_minX = f->GetMinX(); m_maxX = f->GetMaxX();
				m_minY = f->GetMinY(); m_maxY = f->GetMaxY();
			}
			else
			{
				if (f->GetMinX()<m_minX) m_minX = f->GetMinX(); if (f->GetMaxX()>m_maxX) m_maxX = f->GetMaxX();
				if (f->GetMinY()<m_minY) m_minY = f->GetMinY(); if (f->GetMaxY()>m_maxY) m_maxY = f->GetMaxY();
			}
		}
		//node = node->GetNext();
	}
#ifdef MATHPLOT_DO_LOGGING
	wxLogDebug(wxT("[mpWindow::UpdateBBox] Bounding box: Xmin = %f, Xmax = %f, Ymin = %f, YMax = %f"), m_minX, m_maxX, m_minY, m_maxY);
#endif // MATHPLOT_DO_LOGGING
	return first == FALSE;
}

// void mpWindow::UpdateAll()
// {
// GetClientSize( &m_scrX,&m_scrY);
/*    if (m_enableScrollBars) {
// The "virtual size" of the scrolled window:
const int sx = (int)((m_maxX - m_minX) * GetScaleX());
const int sy = (int)((m_maxY - m_minY) * GetScaleY());
SetVirtualSize(sx, sy);
SetScrollRate(1, 1);*/
//         const int px = (int)((GetPosX() - m_minX) * GetScaleX());// - m_scrX); //(cx>>1));

// J.L.Blanco, Aug 2007: Formula fixed:
//         const int py = (int)((m_maxY - GetPosY()) * GetScaleY());// - m_scrY); //(cy>>1));
//         int px, py;
//         GetViewStart(&px0, &py0);
// 	px = (int)((m_posX - m_minX)*m_scaleX);
// 	py = (int)((m_maxY - m_posY)*m_scaleY);

//         SetScrollbars( 1, 1, sx - m_scrX, sy - m_scrY, px, py, TRUE);
//     }

// Working code
// 	UpdateBBox();
//    Refresh( FALSE );
// end working code

// Old version
/*   bool box = UpdateBBox();
if (box)
{
int cx, cy;
GetClientSize( &cx, &cy);

// The "virtual size" of the scrolled window:
const int sx = (int)((m_maxX - m_minX) * GetScaleX());
const int sy = (int)((m_maxY - m_minY) * GetScaleY());

const int px = (int)((GetPosX() - m_minX) * GetScaleX() - (cx>>1));

// J.L.Blanco, Aug 2007: Formula fixed:
const int py = (int)((m_maxY - GetPosY()) * GetScaleY() - (cy>>1));

SetScrollbars( 1, 1, sx, sy, px, py, TRUE);

#ifdef MATHPLOT_DO_LOGGING
wxLogMessage(_("[mpWindow::UpdateAll] Size:%ix%i ScrollBars:%i,%i"),sx,sy,px,py);
#endif
}

FitInside();
Refresh( FALSE );
*/
// }

void mpWindow::UpdateAll()
{
	if (UpdateBBox())
	{
		if (m_enableScrollBars)
		{
			int cx, cy;
			GetClientSize(&cx, &cy);
			// Do x scroll bar
			{
				// Convert margin sizes from pixels to coordinates
				double leftMargin = m_marginLeft / m_scaleX;
				// Calculate the range in coords that we want to scroll over
				double maxX = (m_desiredXmax > m_maxX) ? m_desiredXmax : m_maxX;
				double minX = (m_desiredXmin < m_minX) ? m_desiredXmin : m_minX;
				if ((m_posX + leftMargin) < minX)
					minX = m_posX + leftMargin;
				// Calculate scroll bar size and thumb position
				int sizeX = (int)((maxX - minX) * m_scaleX);
				int thumbX = (int)(((m_posX + leftMargin) - minX) * m_scaleX);
				SetScrollbar(wxHORIZONTAL, thumbX, cx - (m_marginRight + m_marginLeft), sizeX);
			}
			// Do y scroll bar
			{
				// Convert margin sizes from pixels to coordinates
				double topMargin = m_marginTop / m_scaleY;
				// Calculate the range in coords that we want to scroll over
				double maxY = (m_desiredYmax > m_maxY) ? m_desiredYmax : m_maxY;
				if ((m_posY - topMargin) > maxY)
					maxY = m_posY - topMargin;
				double minY = (m_desiredYmin < m_minY) ? m_desiredYmin : m_minY;
				// Calculate scroll bar size and thumb position
				int sizeY = (int)((maxY - minY) * m_scaleY);
				int thumbY = (int)((maxY - (m_posY - topMargin)) * m_scaleY);
				SetScrollbar(wxVERTICAL, thumbY, cy - (m_marginTop + m_marginBottom), sizeY);
			}
		}
	}

	Refresh(FALSE);
}

void mpWindow::DoScrollCalc(const int position, const int orientation)
{
	if (orientation == wxVERTICAL)
	{
		// Y axis
		// Get top margin in coord units
		double topMargin = m_marginTop / m_scaleY;
		// Calculate maximum Y coord to be shown in the graph
		double maxY = m_desiredYmax > m_maxY ? m_desiredYmax : m_maxY;
		// Set new position
		SetPosY((maxY - (position / m_scaleY)) + topMargin);
	}
	else
	{
		// X Axis
		// Get left margin in coord units
		double leftMargin = m_marginLeft / m_scaleX;
		// Calculate minimum X coord to be shown in the graph
		double minX = (m_desiredXmin < m_minX) ? m_desiredXmin : m_minX;
		// Set new position
		SetPosX((minX + (position / m_scaleX)) - leftMargin);
	}
}

void mpWindow::OnScrollThumbTrack(wxScrollWinEvent &event)
{
	DoScrollCalc(event.GetPosition(), event.GetOrientation());
}

void mpWindow::OnScrollPageUp(wxScrollWinEvent &event)
{
	int scrollOrientation = event.GetOrientation();
	// Get position before page up
	int position = GetScrollPos(scrollOrientation);
	// Get thumb size
	int thumbSize = GetScrollThumb(scrollOrientation);
	// Need to adjust position by a page
	position -= thumbSize;
	if (position < 0)
		position = 0;

	DoScrollCalc(position, scrollOrientation);
}
void mpWindow::OnScrollPageDown(wxScrollWinEvent &event)
{
	int scrollOrientation = event.GetOrientation();
	// Get position before page up
	int position = GetScrollPos(scrollOrientation);
	// Get thumb size
	int thumbSize = GetScrollThumb(scrollOrientation);
	// Get scroll range
	int scrollRange = GetScrollRange(scrollOrientation);
	// Need to adjust position by a page
	position += thumbSize;
	if (position > (scrollRange - thumbSize))
		position = scrollRange - thumbSize;

	DoScrollCalc(position, scrollOrientation);
}

void mpWindow::OnScrollLineUp(wxScrollWinEvent &event)
{
	int scrollOrientation = event.GetOrientation();
	// Get position before page up
	int position = GetScrollPos(scrollOrientation);
	// Need to adjust position by a line
	position -= mpSCROLL_NUM_PIXELS_PER_LINE;
	if (position < 0)
		position = 0;

	DoScrollCalc(position, scrollOrientation);
}

void mpWindow::OnScrollLineDown(wxScrollWinEvent &event)
{
	int scrollOrientation = event.GetOrientation();
	// Get position before page up
	int position = GetScrollPos(scrollOrientation);
	// Get thumb size
	int thumbSize = GetScrollThumb(scrollOrientation);
	// Get scroll range
	int scrollRange = GetScrollRange(scrollOrientation);
	// Need to adjust position by a page
	position += mpSCROLL_NUM_PIXELS_PER_LINE;
	if (position > (scrollRange - thumbSize))
		position = scrollRange - thumbSize;

	DoScrollCalc(position, scrollOrientation);
}

void mpWindow::OnScrollTop(wxScrollWinEvent &event)
{
	DoScrollCalc(0, event.GetOrientation());
}

void mpWindow::OnScrollBottom(wxScrollWinEvent &event)
{
	int scrollOrientation = event.GetOrientation();
	// Get thumb size
	int thumbSize = GetScrollThumb(scrollOrientation);
	// Get scroll range
	int scrollRange = GetScrollRange(scrollOrientation);

	DoScrollCalc(scrollRange - thumbSize, scrollOrientation);
}
// End patch ngpaton

void mpWindow::SetScaleX(double scaleX)
{
	if (scaleX != 0) m_scaleX = scaleX;
	UpdateAll();
}

// New methods implemented by Davide Rondini

unsigned int mpWindow::CountLayers()
{
	//wxNode *node = m_layers.GetFirst();
	unsigned int layerNo = 0;
	for (wxLayerList::iterator li = m_layers.begin(); li != m_layers.end(); li++)//while(node)
	{
		if ((*li)->HasBBox()) layerNo++;
		// node = node->GetNext();
	};
	return layerNo;
}

mpLayer* mpWindow::GetLayer(int position)
{
	if ((position >= (int)m_layers.size()) || position < 0) return NULL;
	return m_layers[position];
}

mpLayer* mpWindow::GetLayer(const wxString &name)
{
	for (wxLayerList::iterator it = m_layers.begin(); it != m_layers.end(); it++)
		if (!(*it)->GetName().Cmp(name))
			return *it;
	return NULL;    // Not found
}
void mpWindow::SetLayerPosition(mpLayer* layer, int position)
{
	wxLayerList::iterator it;
	wxLayerList old = m_layers;
	int old_position = 0;
	for (it = old.begin(); it != old.end(); it++, old_position++)
	{
		if (*it == layer) break;
	}
	if (it == old.end()) return; //not found
	if (position == old_position) return; //already in this position
	m_layers.clear();
	for (int i = 0; i<(int)old.size(); i++)
	{
		if (i == old_position)continue;
		if (i == position) m_layers.push_back(layer);
		m_layers.push_back(old[i]);
	}
}
void mpWindow::SetLayerBottom(mpLayer* layer)
{
	SetLayerPosition(layer, 0);
}
void mpWindow::SetLayerTop(mpLayer* layer)
{
	SetLayerPosition(layer, m_layers.size() - 1);
}

void mpWindow::GetBoundingBox(double* bbox)
{
	bbox[0] = m_minX;
	bbox[1] = m_maxX;
	bbox[2] = m_minY;
	bbox[3] = m_maxY;
}

bool mpWindow::SaveScreenshot(const wxString& filename, wxBitmapType type, wxSize imageSize, bool fit)
{
	int sizeX, sizeY;
	int bk_scrX, bk_scrY;
	if (imageSize == wxDefaultSize) {
		sizeX = m_scrX;
		sizeY = m_scrY;
	}
	else {
		sizeX = imageSize.x;
		sizeY = imageSize.y;
		bk_scrX = m_scrX;
		bk_scrY = m_scrY;
		SetScr(sizeX, sizeY);
	}

	wxBitmap screenBuffer(sizeX, sizeY);
	wxMemoryDC screenDC;
	screenDC.SelectObject(screenBuffer);
	screenDC.SetPen(*wxTRANSPARENT_PEN);
	wxBrush brush(GetBackgroundColour());
	screenDC.SetBrush(brush);
	screenDC.DrawRectangle(0, 0, sizeX, sizeY);

	if (fit) {
		Fit(m_minX, m_maxX, m_minY, m_maxY, &sizeX, &sizeY);
	}
	else {
		Fit(m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax, &sizeX, &sizeY);
	}
	// Draw all the layers:
	wxLayerList::iterator li;
	for (li = m_layers.begin(); li != m_layers.end(); li++)
		(*li)->Plot(screenDC, *this);

	if (imageSize != wxDefaultSize) {
		// Restore dimensions
		SetScr(bk_scrX, bk_scrY);
		Fit(m_desiredXmin, m_desiredXmax, m_desiredYmin, m_desiredYmax, &bk_scrX, &bk_scrY);
		UpdateAll();
	}
	// Once drawing is complete, actually save screen shot
	wxImage screenImage = screenBuffer.ConvertToImage();
	return screenImage.SaveFile(filename, type);
}

void mpWindow::SetMargins(int top, int right, int bottom, int left)
{
	m_marginTop = top;
	m_marginRight = right;
	m_marginBottom = bottom;
	m_marginLeft = left;
}

mpInfoLayer* mpWindow::IsInsideInfoLayer(wxPoint& point)
{
	wxLayerList::iterator li;
	for (li = m_layers.begin(); li != m_layers.end(); li++) {
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("mpWindow::IsInsideInfoLayer() examinining layer = %p"), (*li));
#endif // MATHPLOT_DO_LOGGING
		if ((*li)->IsInfo() && (*li)->IsVisible()) {
			mpInfoLayer* tmpLyr = (mpInfoLayer*)(*li);
#ifdef MATHPLOT_DO_LOGGING
			wxLogMessage(_("mpWindow::IsInsideInfoLayer() layer = %p"), (*li));
#endif // MATHPLOT_DO_LOGGING
			if (tmpLyr->Inside(point)) {
				return tmpLyr;
			}
		}
	}
	return NULL;
}
mpPointLayer* mpWindow::IsInsidePointLayer(wxPoint& point)
{
	wxLayerList::iterator li;
	for (li = m_layers.begin(); li != m_layers.end(); li++) {
#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("mpWindow::IsInsidePointLayer() examinining layer = %p"), (*li));
#endif // MATHPLOT_DO_LOGGING
		//
		if ((*li)->IsPointLayer() && (*li)->IsVisible()) {
			mpPointLayer* tmpLyr = (mpPointLayer*)(*li);
#ifdef MATHPLOT_DO_LOGGING
			wxLogMessage(_("mpWindow::IsInsidePointLayer() layer = %p"), (*li));
#endif // MATHPLOT_DO_LOGGING

			//Check if point is enabled
			//IsAllowedToMove
			if (tmpLyr->Inside(point) ||
				!tmpLyr->IsPointDefined() ||
				!tmpLyr->IsDraggingOnlyFromPoint())

			{
				return tmpLyr;
			}

		}
	}
	return NULL;
}
void mpWindow::SetLayerVisible(const wxString &name, bool viewable)
{
	mpLayer* lx = GetLayer(name);
	if (lx) {
		lx->SetVisible(viewable);
		UpdateAll();
	}
}

bool mpWindow::IsLayerVisible(const wxString &name)
{
	mpLayer* lx = GetLayer(name);
	return (lx) ? lx->IsVisible() : false;
}

void mpWindow::SetLayerVisible(const unsigned int position, bool viewable)
{
	mpLayer* lx = GetLayer(position);
	if (lx) {
		lx->SetVisible(viewable);
		UpdateAll();
	}
}

bool mpWindow::IsLayerVisible(const unsigned int position)
{
	mpLayer* lx = GetLayer(position);
	return (lx) ? lx->IsVisible() : false;
}

void mpWindow::SetColourTheme(const wxColour& bgColour, const wxColour& drawColour, const wxColour& axesColour)
{
	SetBackgroundColour(bgColour);
	SetForegroundColour(drawColour);
	m_bgColour = bgColour;
	m_fgColour = drawColour;
	m_axColour = axesColour;
	// cycle between layers to set colours and properties to them
	wxLayerList::iterator li;
	for (li = m_layers.begin(); li != m_layers.end(); li++) {
		if ((*li)->GetLayerType() == mpLAYER_AXIS) {
			wxPen axisPen = (*li)->GetPen(); // Get the old pen to modify only colour, not style or width
			axisPen.SetColour(axesColour);
			(*li)->SetPen(axisPen);

			mpScaleX* scale = dynamic_cast<mpScaleX*>(*li);
			scale->SetTicksColour(axesColour);

		}
		else if ((*li)->GetLayerType() == mpLAYER_INFO) {
			wxPen infoPen = (*li)->GetPen(); // Get the old pen to modify only colour, not style or width
			infoPen.SetColour(drawColour);
			(*li)->SetPen(infoPen);
		}
		else if ((*li)->GetLayerType() == mpLAYER_PLOT) {
			wxPen plotPen = (*li)->GetPen();  //Get the old pen to modify only colour, not style or width
			plotPen.SetColour(drawColour);
			(*li)->SetPen(plotPen);

			wxBrush plotBrush = (*li)->GetBrush(); //Get old brush
			plotBrush.SetColour(drawColour);
			(*li)->SetBrush(plotBrush);
		}
		else if ((*li)->GetLayerType() == mpLayer_POINT) {

		}
		else {
			wxBrush plotBrush = (*li)->GetBrush(); //Get old brush
			plotBrush.SetColour(drawColour);
			(*li)->SetBrush(plotBrush);

			wxPen plotPen = (*li)->GetPen();  //Get the old pen to modify only colour, not style or width
			plotPen.SetColour(drawColour);
			(*li)->SetPen(plotPen);
		}
	}
}

// void mpWindow::EnableCoordTooltip(bool value)
// {
//      m_coordTooltip = value;
// //      if (value) GetToolTip()->SetDelay(100);
// }

/*
double mpWindow::p2x(wxCoord pixelCoordX, bool drawOutside )
{
if (drawOutside) {
return m_posX + pixelCoordX/m_scaleX;
}
// Draw inside margins
double marginScaleX = ((double)(m_scrX - m_marginLeft - m_marginRight))/m_scrX;
return m_marginLeft + (m_posX + pixelCoordX/m_scaleX)/marginScaleX;
}

double mpWindow::p2y(wxCoord pixelCoordY, bool drawOutside )
{
if (drawOutside) {
return m_posY - pixelCoordY/m_scaleY;
}
// Draw inside margins
double marginScaleY = ((double)(m_scrY - m_marginTop - m_marginBottom))/m_scrY;
return m_marginTop + (m_posY - pixelCoordY/m_scaleY)/marginScaleY;
}

wxCoord mpWindow::x2p(double x, bool drawOutside)
{
if (drawOutside) {
return (wxCoord) ((x-m_posX) * m_scaleX);
}
// Draw inside margins
double marginScaleX = ((double)(m_scrX - m_marginLeft - m_marginRight))/m_scrX;
#ifdef MATHPLOT_DO_LOGGING
wxLogMessage(wxT("x2p ScrX = %d, marginRight = %d, marginLeft = %d, marginScaleX = %f"), m_scrX, m_marginRight, m_marginLeft,  marginScaleX);
#endif // MATHPLOT_DO_LOGGING
return (wxCoord) (int)(((x-m_posX) * m_scaleX)*marginScaleX) - m_marginLeft;
}

wxCoord mpWindow::y2p(double y, bool drawOutside)
{
if (drawOutside) {
return (wxCoord) ( (m_posY-y) * m_scaleY);
}
// Draw inside margins
double marginScaleY = ((double)(m_scrY - m_marginTop - m_marginBottom))/m_scrY;
#ifdef MATHPLOT_DO_LOGGING
wxLogMessage(wxT("y2p ScrY = %d, marginTop = %d, marginBottom = %d, marginScaleY = %f"), m_scrY, m_marginTop, m_marginBottom, marginScaleY);
#endif // MATHPLOT_DO_LOGGING
return (wxCoord) ((int)((m_posY-y) * m_scaleY)*marginScaleY) - m_marginTop;
}
*/
