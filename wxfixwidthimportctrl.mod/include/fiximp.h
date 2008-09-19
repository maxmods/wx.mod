/////////////////////////////////////////////////////////////////////////////
// Name:        fiximp.h
// Purpose:     Header    Allow the user to set the fixed widths for text input
// Author:      Manuel Martin Sanz
// Created:     10-may-04
// Modified by: MM 12-ago-2008
// Modified:
// Copyright:   (c) 2008  Manuel Martin Sanz
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef FIXIMP_H
    #define FIXIMP_H

#include "wx/scrolbar.h"
#include "wx/dcclient.h"

#define wxFixWidthImportCtrlNameStr wxT("wxFixWidthImportCtrl")

//Scrollbars IDs
enum
{
    FW_SCROV = 1,
    FW_SCROH
};

// ----------------------------------------------------------------------------
// event constants
// ----------------------------------------------------------------------------
// declare a custom event, of type wxCommandEvent
DECLARE_EVENT_TYPE(wxEVT_COMMAND_FIXW_UPDATED, -1)


// ----------------------------------------------------------------------------
// This control is made of two scroll bars and the rest is a rect where
// we draw the scale, the file and the selector lines
// ----------------------------------------------------------------------------

class WXDLLEXPORT wxFixWidthImportCtrl : public wxControl
{

public:
    // construction
    wxFixWidthImportCtrl() { Init(); }
    wxFixWidthImportCtrl(wxWindow *parent,
                   wxWindowID id = -1,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = 0,
                   const wxString& name = wxFixWidthImportCtrlNameStr );

    bool Create(wxWindow *parent,
                wxWindowID id = -1,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxFixWidthImportCtrlNameStr );

    virtual ~wxFixWidthImportCtrl();

    virtual bool Destroy();

    //Accessors
    //Values: where in the scale vertical delimiters are set
    size_t GetValCount() const { return m_values.GetCount(); }
    const wxArrayInt& GetValues() const { return m_values; }
    void SetValues(const wxArrayInt& values);

    size_t GetLinesCount() const { return m_Lines.GetCount(); }
    size_t GetSelectedLineNu() const { return m_markedL; }
    const wxString& GetSelectedLine() const { return m_Lines[m_markedL]; }
    void SelectLine(size_t nline);
    //Getting a line. wxASSERT from dynarray.h if nline is out of range
    const wxString& GetLine(size_t nline) const { return m_Lines[nline]; }
    //The colors used to draw delimitiers and select line
    wxColour GetDelimColor() { return delimColor; }
    wxColour GetSelecColor() { return selecColor; }
    void SetDelimColor(unsigned char red, unsigned char green, unsigned char blue);
    void SetSelecColor(unsigned char red, unsigned char green, unsigned char blue);

    //The strings to show
    bool LoadFile(const wxString& filename, const wxMBConv& conv = wxConvLocal);
    void LoadText(const wxString& textInside);
    //This should be run before LoadFile/LoadText
    void SetTabSize(int tabSize); // default -1 means no tab->spaces convert
    int GetTabSize() const { return m_tabSize; }
    //To use after LoadFile/Text
    void ConvertTabsToSpaces();

    // forward these functions to all subcontrols
    virtual bool Enable(bool enable = true);
    virtual bool Show(bool show = true);

    //This function is usefull for just marking a line and scroll
    //  but not allowing to set/edit delimiters
    void EnableDelim(bool enable = true);

protected:
    // override the base class virtuals involved into geometry calculations
    virtual wxSize DoGetBestSize() const;
    virtual void DoMoveWindow(int x, int y, int width, int height);
    //The custom event to fire
    void FireEvent();

private:
    // common part of all ctors
    void Init();

    // override some base class virtuals
    virtual void DoSetSize(int x, int y, int width, int height, int sizeFlags);

    // event handlers
    void OnPaint(wxPaintEvent& event);
    void OnMouse(wxMouseEvent &event);
    void OnScroll(wxScrollEvent &sevent);

    //Helpers
    void AdjustScrollbars();
    void DrawDelimiter(wxDC* dc, wxCoord x, int modeFunc);
    //Replace TABs with needed spaces returning a 'tabulated' string
    wxString TabsToSpaces(const wxString& str) const;

    //The scrollbars
    wxScrollBar *m_scrbarH;
    wxScrollBar *m_scrbarV;
    wxCoord m_sbHheigth, m_sbVwidth; //Scrollbars's widths

    wxArrayString m_Lines; // lines to show from file/string
    size_t m_maxLen;       //The length of the largest line
    int m_tabSize;         // default TAB size

    //The font to use for the file
    wxFont *m_Ffont;
    //The font to use for the scale
    wxFont *m_Sfont;

    //Colours
    wxColour delimColor;
    wxColour selecColor;

    //The values (delimiters positions)
    wxArrayInt m_values; //current values
    wxArrayInt m_valuesB; //values backup

    //The current position of lines & scale
    size_t m_curposX;
    size_t m_curposL; //current first showed (change when scrolling)
    size_t m_markedL; //We show this line in other colour

    //The rect where strings are drawed;
    struct RectCoords
    {   wxCoord xmin;
        wxCoord xmax;
        wxCoord ymin;
        wxCoord ymax;
    } m_rS;

    //A margin between rects
    wxCoord m_margin;

    //Scroll events times
    wxLongLong m_timeInit;
    wxLongLong m_timeNow;
    WXTYPE m_lastType;
    WXTYPE m_NowType;

    //For mouse clicks
    wxCoord m_Lc; //Current (last) click position
    bool m_delPrev; //Delete previus delimiter or not
    bool m_captured; //Is mouse captured?
    wxCoord m_ybot; //Delimiter is a line from ybot to ytop
    wxCoord m_ytop;
    //Where first click was. It decides what to do
    int m_LAct; // 0 : nothing, 1 : at scale (a mark), 2 : at lines (colour)

    //Delimiters enabled
    bool deliEnabled;

    DECLARE_DYNAMIC_CLASS(wxFixWidthImportCtrl)
    DECLARE_EVENT_TABLE()

};
#endif //FIXIMP_H
