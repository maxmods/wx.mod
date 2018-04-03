#include "mpLayer.h"


IMPLEMENT_ABSTRACT_CLASS(mpLayer, wxObject)

mpLayer::mpLayer() : m_type(mpLAYER_UNDEF)
{
	SetPen((wxPen&)*wxBLACK_PEN);
	SetBrush((wxBrush&)*wxTRANSPARENT_BRUSH);
	SetFont((wxFont&)*wxNORMAL_FONT);
	m_continuous = FALSE; // Default
	m_showName = TRUE;  // Default
	m_drawOutsideMargins = TRUE;
	m_visible = true;
	m_invert = false;

	m_pointType = mpPOINT;
	m_RectSize = wxSize(4, 4);

	//m_drawingOrder = 5;
}

wxBitmap mpLayer::GetColourSquare(int side)
{
	wxBitmap square(side, side, -1);
	wxColour filler = m_pen.GetColour();
	wxBrush brush(filler, wxSOLID);
	wxMemoryDC dc;
	dc.SelectObject(square);
	dc.SetBackground(brush);
	dc.Clear();
	dc.SelectObject(wxNullBitmap);
	return square;
}