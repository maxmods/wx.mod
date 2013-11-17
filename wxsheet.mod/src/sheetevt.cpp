///////////////////////////////////////////////////////////////////////////////
// Name:        sheetevt.cpp
// Purpose:     wxSheetEvent and other wxEvent classes for the wxSheet
// Author:      John Labenski, Michael Bedward (based on code by Julian Smart, Robin Dunn)
// Modified by: John Labenski, Robin Dunn, Vadim Zeitlin
// Created:     1/08/1999
// Copyright:   (c) John Labenski, Michael Bedward (mbedward@ozemail.com.au)
// Licence:     wxWidgets licence
///////////////////////////////////////////////////////////////////////////////

#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
    #pragma implementation "sheetevt.h"
#endif

#include "precomp.h"

// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

#ifndef WX_PRECOMP
    #include <wx/defs.h>
#endif // WX_PRECOMP

#include "wx/sheet/sheetevt.h"

// ----------------------------------------------------------------------------
// events
// ----------------------------------------------------------------------------

DEFINE_EVENT_TYPE(wxEVT_SHEET_VIEW_CHANGED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_SELECTING_CELL)
DEFINE_EVENT_TYPE(wxEVT_SHEET_SELECTED_CELL)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_LEFT_DOWN)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_RIGHT_DOWN)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_LEFT_UP)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_RIGHT_UP)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_LEFT_DCLICK)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_RIGHT_DCLICK)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_LEFT_DOWN)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_RIGHT_DOWN)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_LEFT_UP)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_RIGHT_UP)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_LEFT_DCLICK)
DEFINE_EVENT_TYPE(wxEVT_SHEET_LABEL_RIGHT_DCLICK)
DEFINE_EVENT_TYPE(wxEVT_SHEET_ROW_SIZE)
DEFINE_EVENT_TYPE(wxEVT_SHEET_ROW_SIZING)
DEFINE_EVENT_TYPE(wxEVT_SHEET_ROW_SIZED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_COL_SIZE)
DEFINE_EVENT_TYPE(wxEVT_SHEET_COL_SIZING)
DEFINE_EVENT_TYPE(wxEVT_SHEET_COL_SIZED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_RANGE_SELECTING)
DEFINE_EVENT_TYPE(wxEVT_SHEET_RANGE_SELECTED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_VALUE_CHANGING)
DEFINE_EVENT_TYPE(wxEVT_SHEET_CELL_VALUE_CHANGED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_EDITOR_ENABLED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_EDITOR_DISABLED)
DEFINE_EVENT_TYPE(wxEVT_SHEET_EDITOR_CREATED)

// ----------------------------------------------------------------------------
// wxSheetEvent
// ----------------------------------------------------------------------------
IMPLEMENT_DYNAMIC_CLASS( wxSheetEvent, wxNotifyEvent )

wxSheetEvent::wxSheetEvent(wxWindowID id, wxEventType type, wxObject* obj,
                           const wxSheetCoords& coords, const wxPoint &pos,
                           bool sel )
             : wxNotifyEvent(type, id), m_coords(coords), m_pos(pos), m_scrPos(pos),
                  m_selecting(sel),
                  m_control(false), m_shift(false), m_alt(false), m_meta(false),
                  m_evtWin(NULL)
{
    SetEventObject(obj);
}

bool wxSheetEvent::SetKeysDownMousePos(wxEvent *event)
{
    if (!event) return false;
    wxMouseEvent *mouseEvt = wxDynamicCast(event, wxMouseEvent);

    if (mouseEvt)
    {
        m_control = mouseEvt->ControlDown();
        m_shift   = mouseEvt->ShiftDown();
        m_alt     = mouseEvt->AltDown();
        m_meta    = mouseEvt->MetaDown();
        m_pos = m_scrPos = mouseEvt->GetPosition();
    }
    else
    {
        wxKeyEvent *keyEvt = wxDynamicCast(event, wxKeyEvent);
        if (keyEvt)
        {
            m_control = keyEvt->ControlDown();
            m_shift   = keyEvt->ShiftDown();
            m_alt     = keyEvt->AltDown();
            m_meta    = keyEvt->MetaDown();
            m_pos = m_scrPos = keyEvt->GetPosition();
        }
        else
            return false;  // neither mouse nor key event
    }

    // FIXME - do I really want to scroll the position? or leave it as is
    // we've set the position from the event, now scroll it
    wxSheet *sheet = wxDynamicCast(GetEventObject(), wxSheet);
    wxWindow *win = wxDynamicCast(event->GetEventObject(), wxWindow);
    if (win) m_evtWin = win;

    if (sheet && win)
    {
        if ( win == sheet->GetGridWindow())
            m_pos = sheet->CalcUnscrolledPosition(m_pos);
        else if (win == sheet->GetRowLabelWindow())
            sheet->CalcUnscrolledPosition(0, m_pos.y, NULL, &m_pos.y);
        else if (win == sheet->GetColLabelWindow())
            sheet->CalcUnscrolledPosition(m_pos.x, 0, &m_pos.x, NULL);
    }

    return true;
}

// ----------------------------------------------------------------------------
// wxSheetRangeSelectEvent
// ----------------------------------------------------------------------------
IMPLEMENT_DYNAMIC_CLASS( wxSheetCellSizeEvent, wxSheetEvent )

wxSheetCellSizeEvent::wxSheetCellSizeEvent( wxWindowID id, wxEventType type, wxObject* obj,
                                            const wxSheetCoords &coords, int size )
                     :wxSheetEvent(id, type, obj, coords)
{
    SetInt(size);
}

// ----------------------------------------------------------------------------
// wxSheetRangeSelectEvent
// ----------------------------------------------------------------------------
IMPLEMENT_DYNAMIC_CLASS( wxSheetRangeSelectEvent, wxSheetEvent )

wxSheetRangeSelectEvent::wxSheetRangeSelectEvent(wxWindowID id, wxEventType type, wxObject* obj,
                                                 const wxSheetBlock& block,
                                                 bool sel, bool add )
        : wxSheetEvent(id, type, obj, wxNullSheetCoords, wxPoint(-1, -1), sel),
          m_block(block), m_add(add)
{
}

// ----------------------------------------------------------------------------
// wxSheetEditorCreatedEvent
// ----------------------------------------------------------------------------
IMPLEMENT_DYNAMIC_CLASS(wxSheetEditorCreatedEvent, wxCommandEvent)

wxSheetEditorCreatedEvent::wxSheetEditorCreatedEvent(wxWindowID id, wxEventType type,
                                                     wxObject* obj,
                                                     const wxSheetCoords& coords,
                                                     wxWindow* ctrl)
    : wxCommandEvent(type, id), m_coords(coords), m_ctrl(ctrl)
{
    SetEventObject(obj);
}
