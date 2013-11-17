///////////////////////////////////////////////////////////////////////////////
// Name:        sheetevt.h
// Purpose:     wxSheetEvent and other wxEvent classes for the wxSheet
// Author:      John Labenski, Michael Bedward (based on code by Julian Smart, Robin Dunn)
// Modified by:
// Created:     1/08/1999
// Copyright:   (c) John Labenski, Michael Bedward
// Licence:     wxWidgets licence
///////////////////////////////////////////////////////////////////////////////

#ifndef __WX_SHEETEVT_H__
#define __WX_SHEETEVT_H__

#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
    #pragma interface "sheetevt.h"
#endif

#include <wx/event.h>

#include "wx/sheet/sheetdef.h" // Always include sheetdef.h first
#include "wx/sheet/sheet.h"

// ----------------------------------------------------------------------------
// wxSheetEvent
// ----------------------------------------------------------------------------
class WXDLLIMPEXP_SHEET wxSheetEvent : public wxNotifyEvent
{
public:
    wxSheetEvent(wxWindowID id = 0, wxEventType type = wxEVT_NULL,
                 wxObject* obj = NULL,
                 const wxSheetCoords &coords = wxNullSheetCoords,
                 const wxPoint &pos = wxPoint(-1, -1), bool sel = true);

    wxSheetEvent(const wxSheetEvent& event) : wxNotifyEvent(event),
                     m_coords(event.m_coords),
                     m_pos(event.m_pos), m_scrPos(event.m_scrPos),
                     m_selecting(event.m_selecting),
                     m_control(event.m_control), m_shift(event.m_shift),
                     m_alt(event.m_alt), m_meta(event.m_meta),
                     m_evtWin(event.m_evtWin) { }

    // Get the coords for the cell the event is for or the cursor cell.
    inline int   GetRow() const { return m_coords.m_row; }
    inline int   GetCol() const { return m_coords.m_col; }
    inline const wxSheetCoords& GetCoords() const { return m_coords; }

    // For (de)selection events
    bool  Selecting()   const { return m_selecting; }
    // Are these keys pressed, for events generated from key/mouse events
    bool  ControlDown() const { return m_control; }
    bool  ShiftDown()   const { return m_shift; }
    bool  AltDown()     const { return m_alt; }
    bool  MetaDown()    const { return m_meta; }

    // Get the unscrolled position of the mouse for a mouse generated event
    const wxPoint& GetPosition() const { return m_pos; }
    // Get the scrolled position of the mouse relative to the upper left of
    //   the window that it occured in.
    const wxPoint& GetScrolledPosition() const { return m_scrPos; }
    // Get the window that the event originally occured in.
    //   (for mouse and key events)
    //   example for wxEVT_SHEET_CELL_RIGHT_UP
    //   if (evt.GetEventWindow())
    //       evt.GetEventWindow()->PopupMenu(menu, evt.GetScrolledPosition());
    wxWindow* GetEventWindow() const { return m_evtWin; }

    // implementation

    // Setup the Ctrl/Shift/Alt/Meta keysDown and the mouse position from a
    //  wxKeyEvent or wxMouseEvent.
    //  The GetEventObject() of this must be of type wxSheet
    bool SetKeysDownMousePos(wxEvent *mouseOrKeyEvent);

    virtual wxEvent *Clone() const { return new wxSheetEvent(*this); }

    wxSheetCoords m_coords;
    wxPoint       m_pos;
    wxPoint       m_scrPos;
    bool m_selecting;
    bool m_control;
    bool m_shift;
    bool m_alt;
    bool m_meta;
    wxWindow *m_evtWin;

    DECLARE_DYNAMIC_CLASS_NO_ASSIGN(wxSheetEvent)
};

// ----------------------------------------------------------------------------
// wxSheetCellSizeEvent - wxEVT_SHEET_ROW/COL_SIZE/ING/ED
// ----------------------------------------------------------------------------
class WXDLLIMPEXP_SHEET wxSheetCellSizeEvent : public wxSheetEvent
{
public:
    wxSheetCellSizeEvent( wxWindowID id = 0, wxEventType type = wxEVT_NULL,
                          wxObject* obj = NULL,
                          const wxSheetCoords &coords = wxNullSheetCoords,
                          int size = 0 );

    wxSheetCellSizeEvent(const wxSheetCellSizeEvent& event)
        : wxSheetEvent(event) { }

    int GetSize() const { return GetInt(); }

    // implementation
    virtual wxEvent *Clone() const { return new wxSheetCellSizeEvent(*this); }

    DECLARE_DYNAMIC_CLASS_NO_ASSIGN(wxSheetCellSizeEvent)
};

// ----------------------------------------------------------------------------
// wxSheetRangeSelectEvent - wxEVT_SHEET_RANGE_SELECTING(ED)
// ----------------------------------------------------------------------------
class WXDLLIMPEXP_SHEET wxSheetRangeSelectEvent : public wxSheetEvent
{
public:
    wxSheetRangeSelectEvent( wxWindowID id = 0, wxEventType type = wxEVT_NULL,
                             wxObject* obj = NULL,
                             const wxSheetBlock& block = wxNullSheetBlock,
                             bool sel = false, bool add_to_sel = false );

    wxSheetRangeSelectEvent(const wxSheetRangeSelectEvent& event)
        : wxSheetEvent(event), m_block(event.m_block), m_add(event.m_add) { }

    const wxSheetBlock& GetBlock() const { return m_block; }
    bool GetAddToSelection() const       { return m_add; }

    void SetBlock( const wxSheetBlock& block ) { m_block = block; }

    // wxPoint GetPosition() is unused
    // int GetCoords/Row/Col() is unused

    // implementation
    virtual wxEvent *Clone() const { return new wxSheetRangeSelectEvent(*this); }

    wxSheetBlock m_block;
    bool m_add;

    DECLARE_DYNAMIC_CLASS_NO_ASSIGN(wxSheetRangeSelectEvent)
};

// ----------------------------------------------------------------------------
// wxSheetEditorCreatedEvent - wxEVT_SHEET_EDITOR_CREATED
// ----------------------------------------------------------------------------
class WXDLLIMPEXP_SHEET wxSheetEditorCreatedEvent : public wxCommandEvent
{
public:
    wxSheetEditorCreatedEvent( wxWindowID id = 0, wxEventType type = wxEVT_NULL,
                               wxObject* obj = NULL,
                               const wxSheetCoords& coords = wxNullSheetCoords,
                               wxWindow* ctrl = NULL );

    wxSheetEditorCreatedEvent(const wxSheetEditorCreatedEvent& evt)
        : wxCommandEvent(evt), m_coords(evt.m_coords), m_ctrl(evt.m_ctrl) { }


    const wxSheetCoords& GetCoords() const { return m_coords; }
    wxWindow* GetControl() const           { return m_ctrl; }

    void SetCoords(const wxSheetCoords& coords) { m_coords = coords; }
    void SetControl(wxWindow* ctrl)             { m_ctrl = ctrl; }

    // implementation
    virtual wxEvent *Clone() const { return new wxSheetEditorCreatedEvent(*this); }

    wxSheetCoords m_coords;
    wxWindow*     m_ctrl;

    DECLARE_DYNAMIC_CLASS_NO_ASSIGN(wxSheetEditorCreatedEvent)
};

// ----------------------------------------------------------------------------
// events
// ----------------------------------------------------------------------------

BEGIN_DECLARE_EVENT_TYPES()
    // The origin of the grid window has changed
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_VIEW_CHANGED, 1592)

    // The grid cursor is about to be in a new cell, veto or !Skip() to block
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_SELECTING_CELL, 1592)
    // The grid cursor is in a new cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_SELECTED_CELL, 1592)

    // left down click in a grid cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_LEFT_DOWN, 1580)
    // right down click in a grid cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_RIGHT_DOWN, 1581)
    // left up click in a grid cell, sent after default processing
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_LEFT_UP, 1580)
    // right up click in a grid cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_RIGHT_UP, 1581)
    // left double click in a grid cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_LEFT_DCLICK, 1582)
    // right double click in a grid cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_RIGHT_DCLICK, 1583)

    // left down click in a label cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_LEFT_DOWN, 1584)
    // right down click in a label cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_RIGHT_DOWN, 1585)
    // left up click in a label cell, sent after default processing
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_LEFT_UP, 1584)
    // right up click in a label cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_RIGHT_UP, 1585)
    // left double click in a label cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_LEFT_DCLICK, 1586)
    // right double click in a label cell
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_LABEL_RIGHT_DCLICK, 1587)

    // A row is about to be resized, the mouse is over an edge of cell
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_ROW_SIZE, 1588)
    // A row is being resized
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_ROW_SIZING, 1588)
    // A row has been resized, sent after default processing
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_ROW_SIZED, 1588)
    // A col is about to be resized, the mouse is over an edge of cell
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_COL_SIZE, 1589)
    // A col is being resized
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_COL_SIZING, 1589)
    // A col has been resized, sent after default processing
    // This is a wxSheetCellSizeEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_COL_SIZED, 1589)

    // A block of cells is about to be (de)selected (veto to stop)
    // This is a wxSheetRangeSelectEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_RANGE_SELECTING, 1590)
    // A block of cells has been (de)selected
    // This is a wxSheetRangeSelectEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_RANGE_SELECTED, 1590)

    // The value of a cell is about to be changed (veto to stop)
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_VALUE_CHANGING, 1591)
    // The value of a cell has been changed (veto to put old val back)
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_CELL_VALUE_CHANGED, 1591)

    // From EnableCellEditControl, the control is about to enabled (can veto)
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_EDITOR_ENABLED, 1593)
    // From DisableCellEditControl, the control is about to disabled (can veto)
    // This is a wxSheetEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_EDITOR_DISABLED, 1594)
    // From EnableCellEditControl, the edit control has been created
    // This is a wxSheetEditorCreatedEvent
    DECLARE_EXPORTED_EVENT_TYPE(WXDLLIMPEXP_SHEET, wxEVT_SHEET_EDITOR_CREATED, 1595)
END_DECLARE_EVENT_TYPES()

typedef void (wxEvtHandler::*wxSheetEventFunction)(wxSheetEvent&);
typedef void (wxEvtHandler::*wxSheetCellSizeEventFunction)(wxSheetCellSizeEvent&);
typedef void (wxEvtHandler::*wxSheetRangeSelectEventFunction)(wxSheetRangeSelectEvent&);
typedef void (wxEvtHandler::*wxSheetEditorCreatedEventFunction)(wxSheetEditorCreatedEvent&);

#define wxSheetEventHandler(func) \
    (wxObjectEventFunction)(wxEventFunction)wxStaticCastEvent(wxSheetEventFunction, &func)
#define wxSheetCellSizeEventHandler(func) \
    (wxObjectEventFunction)(wxEventFunction)wxStaticCastEvent(wxSheetCellSizeEventFunction, &func)
#define wxSheetRangeSelectEventHandler(func) \
    (wxObjectEventFunction)(wxEventFunction)wxStaticCastEvent(wxSheetRangeSelectEventFunction, &func)
#define wxSheetEditorCreatedEventHandler(func) \
    (wxObjectEventFunction)(wxEventFunction)wxStaticCastEvent(wxSheetEditorCreatedEventFunction, &func)

#define wx__DECLARE_SHEETEVT(evt, id, fn)         wx__DECLARE_EVT1( evt, id, wxSheetEventHandler(fn))
#define wx__DECLARE_SHEETCELLSIZEEVT(evt, id, fn) wx__DECLARE_EVT1( evt, id, wxSheetCellSizeEventHandler(fn))
#define wx__DECLARE_SHEETRANGESELEVT(evt, id, fn) wx__DECLARE_EVT1( evt, id, wxSheetRangeSelectEventHandler(fn))
#define wx__DECLARE_SHEETEDITOREVT(evt, id, fn)   wx__DECLARE_EVT1( evt, id, wxSheetEditorCreatedEventHandler(fn))

#define EVT_SHEET_VIEW_CHANGED(id, fn)        wx__DECLARE_SHEETEVT( wxEVT_SHEET_VIEW_CHANGED,        id, fn )
#define EVT_SHEET_SELECTING_CELL(id, fn)      wx__DECLARE_SHEETEVT( wxEVT_SHEET_SELECTING_CELL,      id, fn )
#define EVT_SHEET_SELECTED_CELL(id, fn)       wx__DECLARE_SHEETEVT( wxEVT_SHEET_SELECTED_CELL,       id, fn )
#define EVT_SHEET_CELL_LEFT_DOWN(id, fn)      wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_LEFT_DOWN,      id, fn )
#define EVT_SHEET_CELL_RIGHT_DOWN(id, fn)     wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_RIGHT_DOWN,     id, fn )
#define EVT_SHEET_CELL_LEFT_UP(id, fn)        wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_LEFT_UP,        id, fn )
#define EVT_SHEET_CELL_RIGHT_UP(id, fn)       wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_RIGHT_UP,       id, fn )
#define EVT_SHEET_CELL_LEFT_DCLICK(id, fn)    wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_LEFT_DCLICK,    id, fn )
#define EVT_SHEET_CELL_RIGHT_DCLICK(id, fn)   wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_RIGHT_DCLICK,   id, fn )
#define EVT_SHEET_LABEL_LEFT_DOWN(id, fn)     wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_LEFT_DOWN,     id, fn )
#define EVT_SHEET_LABEL_RIGHT_DOWN(id, fn)    wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_RIGHT_DOWN,    id, fn )
#define EVT_SHEET_LABEL_LEFT_UP(id, fn)       wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_LEFT_UP,       id, fn )
#define EVT_SHEET_LABEL_RIGHT_UP(id, fn)      wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_RIGHT_UP,      id, fn )
#define EVT_SHEET_LABEL_LEFT_DCLICK(id, fn)   wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_LEFT_DCLICK,   id, fn )
#define EVT_SHEET_LABEL_RIGHT_DCLICK(id, fn)  wx__DECLARE_SHEETEVT( wxEVT_SHEET_LABEL_RIGHT_DCLICK,  id, fn )
#define EVT_SHEET_ROW_SIZE(id, fn)            wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_ROW_SIZE,    id, fn )
#define EVT_SHEET_ROW_SIZING(id, fn)          wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_ROW_SIZING,  id, fn )
#define EVT_SHEET_ROW_SIZED(id, fn)           wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_ROW_SIZED,   id, fn )
#define EVT_SHEET_COL_SIZE(id, fn)            wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_COL_SIZE,    id, fn )
#define EVT_SHEET_COL_SIZING(id, fn)          wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_COL_SIZING,  id, fn )
#define EVT_SHEET_COL_SIZED(id, fn)           wx__DECLARE_SHEETCELLSIZEEVT( wxEVT_SHEET_COL_SIZED,   id, fn )
#define EVT_SHEET_RANGE_SELECTING(id, fn)     wx__DECLARE_SHEETRANGESELEVT( wxEVT_SHEET_RANGE_SELECTING, id, fn )
#define EVT_SHEET_RANGE_SELECTED(id, fn)      wx__DECLARE_SHEETRANGESELEVT( wxEVT_SHEET_RANGE_SELECTED,  id, fn )
#define EVT_SHEET_CELL_VALUE_CHANGING(id, fn) wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_VALUE_CHANGING,  id, fn )
#define EVT_SHEET_CELL_VALUE_CHANGED(id, fn)  wx__DECLARE_SHEETEVT( wxEVT_SHEET_CELL_VALUE_CHANGED,   id, fn )
#define EVT_SHEET_EDITOR_ENABLED(id, fn)      wx__DECLARE_SHEETEVT( wxEVT_SHEET_EDITOR_ENABLED,       id, fn )
#define EVT_SHEET_EDITOR_DISABLED(id, fn)     wx__DECLARE_SHEETEVT( wxEVT_SHEET_EDITOR_DISABLED,      id, fn )
#define EVT_SHEET_EDITOR_CREATED(id, fn)      wx__DECLARE_SHEETEDITOREVT( wxEVT_SHEET_EDITOR_CREATED, id, fn )

#if 0  // TODO: implement these ?  others ?

wxEVT_SHEET_CREATE_CELL;
wxEVT_SHEET_CHANGE_LABELS;
wxEVT_SHEET_CHANGE_SEL_LABEL;

#define EVT_SHEET_CREATE_CELL(id, fn)      DECLARE_EVENT_TABLE_ENTRY( wxEVT_SHEET_CREATE_CELL,      id, wxID_ANY, (wxObjectEventFunction) (wxEventFunction) (wxSheetEventFunction) &fn, NULL ),
#define EVT_SHEET_CHANGE_LABELS(id, fn)    DECLARE_EVENT_TABLE_ENTRY( wxEVT_SHEET_CHANGE_LABELS,    id, wxID_ANY, (wxObjectEventFunction) (wxEventFunction) (wxSheetEventFunction) &fn, NULL ),
#define EVT_SHEET_CHANGE_SEL_LABEL(id, fn) DECLARE_EVENT_TABLE_ENTRY( wxEVT_SHEET_CHANGE_SEL_LABEL, id, wxID_ANY, (wxObjectEventFunction) (wxEventFunction) (wxSheetEventFunction) &fn, NULL ),

#endif // 0

#endif  // __WX_SHEETEVT_H__
