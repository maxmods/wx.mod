/////////////////////////////////////////////////////////////////////////////
// Name:        fiximp.cpp
// Purpose:     Allow the user to set the fixed widths for text input
// Author:      Manuel Martin Sanz. Thanks to Milan Babuskov.
// Created:     10-may-04
// Modified by: MM 12-ago-2008
// Modified:
// Copyright:   (c) 2008  Manuel Martin Sanz
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

// ----------------------------------------------------------------------------
// headers
// ----------------------------------------------------------------------------

// For compilers that support precompilation, includes "wx/wx.h".
#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

//other headers
#include <wx/textfile.h>

#include "fiximp.h"

//The event this control posts
DEFINE_EVENT_TYPE(wxEVT_COMMAND_FIXW_UPDATED)

//Constants
// the margin between the text control and the scale
static const wxCoord FWIMARGIN = 10;
// the scale's height
static const wxCoord FWISCALEH = 22;

// BaH
#ifdef __WXMAC__
#define FONTPADDING 0.2
#else
#define FONTPADDING 0
#endif

/////////////////////////////////////////////////////////////////////////////
// ----------------------------------------------------------------------------
// wxWin macros
// ----------------------------------------------------------------------------

BEGIN_EVENT_TABLE(wxFixWidthImportCtrl, wxControl)
    EVT_PAINT(wxFixWidthImportCtrl::OnPaint)
    EVT_MOUSE_EVENTS(wxFixWidthImportCtrl::OnMouse)
    EVT_COMMAND_SCROLL(FW_SCROV, wxFixWidthImportCtrl::OnScroll)
    EVT_COMMAND_SCROLL(FW_SCROH, wxFixWidthImportCtrl::OnScroll)
END_EVENT_TABLE()

IMPLEMENT_DYNAMIC_CLASS(wxFixWidthImportCtrl, wxControl);

wxFixWidthImportCtrl::wxFixWidthImportCtrl(wxWindow *parent,
                            wxWindowID id,
                            const wxPoint& pos,
                            const wxSize& size,
                            long style,
                            const wxString& name)
{
    Init();

    (void)Create(parent, id, pos, size, style, name);
}

void wxFixWidthImportCtrl::Init()
{
    m_scrbarH = (wxScrollBar*)NULL;
    m_scrbarV = (wxScrollBar*)NULL;
    m_curposX = m_curposL = m_markedL = 0;
    m_maxLen = 0;
    m_tabSize = -1;
    delimColor.Set(0, 255, 0); //green
    selecColor.Set(0, 0, 255); //blue
}

bool wxFixWidthImportCtrl::Create(wxWindow *parent,
                            wxWindowID id,
                            const wxPoint& pos,
                            const wxSize& size,
                            long style,
                            const wxString& name)
{
    if ( !wxControl::Create(parent, id, pos, size,
                            style,
                            wxDefaultValidator, name) )
    {
        return false;
    }

    //Create the scroll bars
    m_scrbarH = new wxScrollBar(this, FW_SCROH);
    m_scrbarV = new wxScrollBar(this, FW_SCROV,
                                wxDefaultPosition, wxDefaultSize, wxSB_VERTICAL);

    if (!m_scrbarH || !m_scrbarV)
        return false;

    m_margin = 2;
    m_sbHheigth = m_scrbarH->GetSize().GetHeight();
    m_sbVwidth  = m_scrbarV->GetSize().GetWidth();

    //Fonts we'll use are some more big and small than default's one
    int pointsizeDef = GetFont().GetPointSize();

    //A fixed pitch font for the file (a little bigger)
    m_Ffont = wxTheFontList->FindOrCreateFont((int)(pointsizeDef * 1.13),
                                              wxMODERN, wxNORMAL, wxNORMAL);

    //The font for the scale, also a pitch font (a little smaller)
    m_Sfont = wxTheFontList->FindOrCreateFont((int)(pointsizeDef * 0.88),
                                              wxMODERN, wxNORMAL, wxNORMAL);

    //Size
    wxSize sizeReal;
    if ( size.x == -1 || size.y == -1 )
    {
        sizeReal = DoGetBestSize();
        if ( size.x != -1 )
            sizeReal.x = size.x;
        if ( size.y != -1 )
            sizeReal.y = size.y;
    }
    else
    {
        sizeReal = size;
    }

    //SetSize calls DoMoveWindow, which sets sub-controls  size & position
    SetSize(pos.x, pos.y, sizeReal.x, sizeReal.y);

    m_curposX = m_curposL = m_markedL = m_LAct = 0;
    m_delPrev = false;
    m_captured = false;
    m_timeInit = m_timeNow = 0;
    m_lastType = 0;
    deliEnabled = true;

    return true;
}

wxFixWidthImportCtrl::~wxFixWidthImportCtrl()
{
    m_Lines.Clear();
    m_values.Clear();
}

bool wxFixWidthImportCtrl::Destroy()
{
    if ( m_scrbarH )
        m_scrbarH->Destroy();
    if ( m_scrbarV )
        m_scrbarV->Destroy();

    m_scrbarH = (wxScrollBar*)NULL;
    m_scrbarV = (wxScrollBar*)NULL;

    return wxControl::Destroy();
}

bool wxFixWidthImportCtrl::Show(bool show)
{
    if ( !wxControl::Show(show) )
        return false;

    // under GTK Show() is called the first time before we are fully
    // constructed
    if ( m_scrbarH )
        m_scrbarH->Show(show);
    if ( m_scrbarV )
        m_scrbarV->Show(show);

    return true;
}

bool wxFixWidthImportCtrl::Enable(bool enable)
{
    if ( !wxControl::Enable(enable) )
    {
        return false;
    }
    if ( m_scrbarH )
        m_scrbarH->Enable(enable);
    if ( m_scrbarV )
        m_scrbarV->Enable(enable);

    deliEnabled = enable;
    Refresh(); //Change colours
    return true;
}

void wxFixWidthImportCtrl::EnableDelim(bool enable)
{
    deliEnabled = enable;
    Refresh(); //Change colours
}

//---------------------------------------------------------------------------------
//Geometry
//From left to right we have:
//     margin, scrollbar (hor), margin, scrollbar (ver), margin
//From up to down we have:
//     scale, scale-margin, scrollbar (ver), margin, scrollbar (hor), margin
//---------------------------------------------------------------------------------

void wxFixWidthImportCtrl::DoSetSize(int x, int y,
                               int width, int height,
                               int sizeFlags)
{
    wxControl::DoSetSize(x, y, width, height, sizeFlags);

    if ( m_scrbarH )
    {
        m_scrbarH->SetSize(m_margin, height - m_sbHheigth - 2 * m_margin,
                           width - m_sbVwidth - 3 * m_margin, m_sbHheigth);
    }
    if ( m_scrbarV )
    {
        m_scrbarV->SetSize(width - m_sbVwidth - 2 * m_margin,
                           FWIMARGIN + FWISCALEH - m_margin,
                           m_sbVwidth,
                           height - FWIMARGIN - FWISCALEH - m_sbHheigth - 2 * m_margin);
    }
    AdjustScrollbars();
    Refresh();
}

wxSize wxFixWidthImportCtrl::DoGetBestSize() const
{
    wxSize sizeSBH = m_scrbarH->GetBestSize();
    wxSize sizeSBV = m_scrbarV->GetBestSize();
    int minx, miny = m_Ffont->GetPointSize();

    //At least 30 chars
    minx = sizeSBH.GetWidth() + m_sbVwidth + 30 * miny;
    //At last 3 lines
    miny = 3 * miny + sizeSBV.GetHeight() + m_sbHheigth + FWIMARGIN + FWISCALEH;

    return wxSize(minx, miny);
}

void wxFixWidthImportCtrl::DoMoveWindow(int x, int y, int width, int height)
{
    wxControl::DoMoveWindow(x, y, width, height);

    // position the subcontrols inside the 'this' client area
    wxSize sizeSBH = m_scrbarH->GetSize();
    wxSize sizeSBV = m_scrbarV->GetSize();

    m_scrbarH->SetSize(m_margin, height - m_sbHheigth - 2 * m_margin,
                       sizeSBH.GetWidth(), sizeSBH.GetHeight());

    m_scrbarV->SetSize(width - m_sbVwidth - 2 * m_margin, FWIMARGIN + FWISCALEH - m_margin,
                       sizeSBV.GetWidth(), sizeSBV.GetHeight());

}

//---------------------------------------------------------------------------------
//Events responses
//---------------------------------------------------------------------------------

void wxFixWidthImportCtrl::OnPaint(wxPaintEvent& event)
{
    wxPaintDC dc(this);

    //The colour to draw string lines
    wxColour sc;
    if ( deliEnabled )
        sc = wxTheColourDatabase->Find(wxT("BLACK"));
    else
        sc = wxTheColourDatabase->Find(wxT("GREY"));


    //The corners of the lines-rect
    m_rS.xmin = m_margin;
    m_rS.xmax = m_scrbarV->GetPosition().x - m_margin;
    m_rS.ymin = FWIMARGIN + FWISCALEH + m_margin;
    m_rS.ymax = m_scrbarH->GetPosition().y - m_margin;

    //Draw the rectangle
    if ( deliEnabled )
        dc.SetPen(*wxBLACK_PEN);
    else
        dc.SetPen(*wxGREY_PEN);
    dc.SetTextForeground(sc);
    dc.SetBrush(*wxWHITE_BRUSH);
    dc.DrawRectangle(m_rS.xmin, m_rS.ymin, m_rS.xmax - m_rS.xmin, m_rS.ymax - m_rS.ymin);

    //Draw marks
    wxDouble x  = m_rS.xmin + m_margin; // BaH
    wxCoord yb  = FWISCALEH;
    wxCoord yt1 = yb - 5; //for long marks
    wxCoord yt2 = yt1 - 2; //for short marks
    wxCoord y = 0;
    size_t n = m_curposX;

    dc.SetFont(*m_Ffont);
    //The char width of the font used for lines
    wxDouble fontW = dc.GetCharWidth() + FONTPADDING ;
    //The char width of the scale numbers
    dc.SetFont(*m_Sfont);
    wxCoord w,h;

    wxString strShow;

    while ( x < m_rS.xmax - fontW / 3)
    {
        if ( n++ % 5 == 0 )
            y = yt2;
        else
            y = yt1;
        if ( n == 1)
            y = yt2;
        dc.DrawLine(x, yb, x, y);

        if ( n % 10 == 0 && x < m_rS.xmax - fontW )
        {
            strShow = wxString::Format(wxT("%d"),n);
            dc.GetTextExtent(strShow, &w, &h);
            dc.DrawText(strShow, x + fontW - w / 2, 2);
        }
        x += fontW;
    }

    //Draw lines (strings)
    dc.SetFont(*m_Ffont);
    if ( m_Lines.GetCount() > 0)
    {
        n = m_curposL;
        y = m_rS.ymin + m_margin;
        h = dc.GetCharHeight();
        while ( y <= m_rS.ymax - m_margin - h )
        {
            strShow = m_Lines.Item(n).Mid(m_curposX,
                           (size_t)((m_rS.xmax - m_rS.xmin - 2 * m_margin)/fontW));
            if ( n == m_markedL)
                dc.SetTextForeground(selecColor);
            dc.DrawText(strShow, m_rS.xmin + m_margin, y);
            if ( n == m_markedL)
                dc.SetTextForeground(sc); //restore normal color

            y += h;
            if ( ++n >= m_Lines.GetCount() )
                break;
        }
    }


    m_ytop = FWISCALEH + FWIMARGIN / 2;
    m_ybot = m_rS.ymax;

    //Draw user delimiters
    size_t nval = m_values.GetCount();
    size_t val = 0;
    if ( nval && deliEnabled )
    {   for ( val = 0; val < nval; val++)
        {   x = ((wxCoord) m_values.Item(val) - m_curposX) * fontW + m_rS.xmin + m_margin;
            if ( x < m_rS.xmax - fontW / 3 )
                DrawDelimiter(&dc, x, wxCOPY);
        }
    }
    m_LAct = 0;
    m_delPrev = false;
    m_captured = false;
}

void wxFixWidthImportCtrl::DrawDelimiter(wxDC* dc, wxCoord x, int modeFunc)
{
    //Select the appropriate dc
    wxDC *pDC = (wxDC*) NULL;

    if ( modeFunc == wxINVERT || modeFunc == wxXOR )
        pDC = wxDynamicCast(dc, wxClientDC);
    else
        pDC = wxDynamicCast(dc, wxPaintDC);

    pDC->SetPen(delimColor);
    pDC->SetBackgroundMode(wxTRANSPARENT);

    int modeOld = pDC->GetLogicalFunction();
    pDC->SetLogicalFunction(modeFunc);

    //Draw the delimiter: a line and a circle on top
    pDC->DrawLine(x, m_ybot, x, m_ytop);
    pDC->DrawCircle(x, m_ytop, 3);

    pDC->SetLogicalFunction(modeOld);
}

void wxFixWidthImportCtrl::OnMouse(wxMouseEvent &event)
{
    if (event.GetEventType() == wxEVT_MOUSEWHEEL && !m_captured)
    {
        size_t curposOld = m_curposL;
        int wheelRot = event.GetWheelRotation();
        int lines = wheelRot / event.GetWheelDelta();
        int pos = (int)m_curposL - lines; //New position tried
        if (pos < 0)
            m_curposL = 0;
        else
        {   m_curposL = (size_t)pos;
            pos = m_scrbarV->GetRange() - m_scrbarV->GetThumbSize(); //Max pos
            if (m_curposL > (size_t)pos)
                m_curposL = (size_t)pos;
            if (pos < 0) //This should never happen
                m_curposL = 0;
        }
        if (curposOld != m_curposL)
        {
            m_scrbarV->SetThumbPosition((int)m_curposL);
            Refresh();
        }
        return;
    }

    bool drawNew  = false; //Draw a new delimiter
    bool deleVal  = false; //Delete a value
    bool addVal   = false; //Add a value
    bool changeCl = false; //Change file line's colour
    bool paintIt  = false; //Refresh it all
    bool isOnRect = false; //Click is inside strings rect
    wxCoord xm = event.GetPosition().x;
    wxCoord ym = event.GetPosition().y;
    size_t n = 0;

    //Where is the mouse?
    if (xm >= m_rS.xmin && ym >= m_rS.ymin) //Below upper left corner
        isOnRect = true;

    wxClientDC dc( this );
    dc.SetFont(*m_Ffont);
    wxDouble fontS = dc.GetCharWidth() + FONTPADDING;
    //the nearest mark to the mouse
    wxCoord mA = xm; //mouse actual
    mA = (wxCoord)((double) (mA - m_rS.xmin - m_margin) / fontS + 0.5);
    int markVal = (int) mA + m_curposX; //can be < 0 because of CaptureMouse
    //x coordinate of the mark
    mA = mA * fontS + m_rS.xmin + m_margin;

    //Delete previus delimiter
    if ( m_delPrev )
        DrawDelimiter(&dc, m_Lc, wxXOR);
    m_delPrev = false;

    //Decide what to do (stored in m_LAct)
    if (event.LeftDown()) //Fired at first click
    {
        m_captured = true;
        CaptureMouse(); //We want to get LeftUp even cursor is out of window

        if ( isOnRect ) //at text
            m_LAct = 2;
        else if ( xm < m_rS.xmin || xm > m_rS.xmax
                 || markVal >= (int) m_maxLen || markVal < 1 //out of bounds
                 || !deliEnabled ) //or delimiters not enabled
            m_LAct = 0;
        else //at scale
        {   m_LAct = 1;
            m_Lc = mA;
            drawNew = true; //Delimiter changes colour
            //check if click was on a existing delimiter
            if ( m_values.Index(markVal) != wxNOT_FOUND )
                deleVal = true; //Keep m_delPrev=false, keep changed colour
            else
                m_delPrev = true;
            //store values for later comparation
            for ( n = 0; n < m_values.GetCount(); n++)
                m_valuesB.Add(m_values.Item(n));
        }
    }

    else if (event.Dragging() && event.LeftIsDown() && m_LAct == 1)
    {
        //Should we draw a new delimiter?
        if (mA >= m_rS.xmin && mA <= m_rS.xmax
            && markVal < (int) m_maxLen && markVal > 0)
        {
             drawNew = true;
             m_delPrev = true;
        }
    }

    else if (event.LeftUp()) //Finishing
    {
        if ( m_captured )
        {   ReleaseMouse();
            m_captured = false;
        }
        SetFocus(); //Needed to response to mouseWheel
        m_Lc = 0;
        m_delPrev = false;
        paintIt = true;

        if ( m_LAct == 1 &&
             mA >= m_rS.xmin && mA <= m_rS.xmax
             && markVal < (int) m_maxLen && markVal > 0) //Not out of bounds

            addVal = true;

        if ( m_LAct == 2 )
            changeCl = true;
    }

    //Do the things that were decided to be done
    if ( drawNew )
    {   DrawDelimiter(&dc, mA, wxXOR);
        //Store new position
        m_Lc = mA;
    }

    if ( deleVal )
        m_values.Remove(markVal);

    if ( addVal )
    {   //We suppose array is small, so keeping it sorted is quick
        bool valueExist = false;
        size_t nval = m_values.GetCount();
        size_t val = (nval == 0 ? 1 : 0);
        while ( val < nval)
        {
            if ( m_values.Item(val) >= markVal )
            {
                if ( m_values.Item(val) == markVal )
                    valueExist = true;
                break;
            }
            else
                val++;
        }

        if ( !valueExist )
        {   if ( val == nval || nval == 0)
                m_values.Add(markVal);
            else
                m_values.Insert((int) markVal, val);
        }
    }
    if ( event.LeftUp() && m_LAct == 1 ) //Check if values changed
    {   if ( m_values.GetCount() != m_valuesB.GetCount() )
            FireEvent();
        else
            for ( n = 0; n < m_values.GetCount(); n++)
                if ( m_values.Item(n) != m_valuesB.Item(n) )
                {   FireEvent();
                    break;
                }
        m_valuesB.Clear();
    }

    if ( changeCl ) //Calculate new line to be coloured
    {
        if (xm >= m_rS.xmin && xm <= m_rS.xmax && ym >= m_rS.ymin && ym <= m_rS.ymax)
        {
            fontS = dc.GetCharHeight();
            //Mouse on line ...
            mA = (wxCoord)((double) (ym - m_rS.ymin - m_margin) / fontS);
            markVal = (int) mA + m_curposL; //can be < 0 because of CaptureMouse
            //Max line shown
            mA = (wxCoord)((double) (m_rS.ymax - m_rS.ymin - m_margin) / fontS - 0.5);
            mA = (int) mA + m_curposL;

            if ( markVal != (int) m_markedL &&
                markVal >=0 && markVal <= mA && markVal < (int) m_Lines.GetCount() )
            {   m_markedL = markVal;
                FireEvent();
                paintIt = true;
            }
        }
    }

    if ( paintIt )
        Refresh();
}

//---------------------------------------------------------------------------------
//Setting the lines to show
//---------------------------------------------------------------------------------
void wxFixWidthImportCtrl::SetTabSize(int tabSize)
{
    m_tabSize = tabSize;
}

//Fill array with file passed
bool wxFixWidthImportCtrl::LoadFile(const wxString& filename, const wxMBConv& conv)
{
    wxTextFile file;
    if (!file.Open(filename, conv) )
        return false;

    m_Lines.Clear();
    wxString str;
    m_maxLen = 0;
    size_t i = 0;
    size_t nto = file.GetLineCount();
    if (nto > 0)
    {   m_Lines.Alloc(nto);
        for ( i=0; i < nto; i++ )
        {   str = file.GetLine(i);

            if (m_tabSize > -1) //replace tabs with needed spaces
                str = TabsToSpaces(str);

            if (str.Len() > m_maxLen)
                m_maxLen = str.Len();

            m_Lines.Add(str);
        }
    }

    m_Lines.Shrink();

    m_curposX = m_curposL = m_markedL = m_LAct = 0;
    AdjustScrollbars();
    Refresh();
    FireEvent();
    return true;
}

//Fill array with string passed
void wxFixWidthImportCtrl::LoadText(const wxString& textInside)
{
    wxString singleLine, tabRep;
    wxChar ch;
    bool at_eol = false;
    size_t pos = 0;
    size_t nSp = 0;

    m_Lines.Clear();
    m_maxLen = 0;

    //Use code similar to wxTextBuffer::Translate
    wxChar chLast = 0;
    for ( wxString::const_iterator i = textInside.begin(); i != textInside.end(); ++i )
    {
        ch = *i;
        if ( ch == wxT('\n') )
        {
            at_eol = true;
            chLast = 0;
        }
        else if (ch == wxT('\r') )
        {
            if ( chLast == wxT('\r') )
            {// Mac empty line
                at_eol = true;
            }
            else
            {// just remember it: we don't know whether it is just "\r" or "\r\n" yet
                chLast = wxT('\r');
            }
        }
        else
        {
            if ( chLast == wxT('\r') )
            {// Mac line termination
                at_eol = true;
                chLast = 0;
            }
        }
        if ( at_eol )
        {
            if (singleLine.Len() > m_maxLen)
                m_maxLen = singleLine.Len();

            m_Lines.Add(singleLine);
            singleLine = wxT("");
            at_eol = false;
            pos = 0;
        }
        if ( ch != wxT('\n') && ch != wxT('\r') )
        {
            if (m_tabSize > -1 && ch == wxT('\t') )
            {//insert needed spaces so text becomes 'tabulated'
                if ( m_tabSize > 0) //m_tabSize=0 means 'erase this TAB'
                {   tabRep = wxT("");
                    nSp = (size_t)m_tabSize - (pos % (size_t)m_tabSize);
                    tabRep.Append(wxChar(' '), nSp);
                    singleLine += tabRep;
                    pos += nSp;
                }
            }
            else
            {
                singleLine += ch;
                pos++;
            }
        }
    }
    //Check if we are at a last Mac line
    if (chLast == wxT('\r') )
    {
        m_Lines.Add(singleLine);
        if (singleLine.Len() > m_maxLen)
            m_maxLen = singleLine.Len();
        singleLine = wxT("");
    }
    if (singleLine.Len() > 0) //pending line
    {   m_Lines.Add(singleLine);
        if (singleLine.Len() > m_maxLen)
            m_maxLen = singleLine.Len();
    }

    m_curposX = m_curposL = m_markedL = m_LAct = 0;
    AdjustScrollbars();
    Refresh();
    FireEvent();
}

//Replace TABs with needed spaces returning a 'tabulated' string
wxString wxFixWidthImportCtrl::TabsToSpaces(const wxString& str) const
{
    wxString stRes;

    if (m_tabSize < 0)
    {
        stRes = str;
        return stRes;
    }
    if (m_tabSize == 0)
    {
        stRes = str;
        // remove tabs
        stRes.Replace(wxT("\t"), wxEmptyString);
        return stRes;
    }

    size_t pos = 0;
    size_t nSp = 0;
    wxString tabRep;
    wxChar ch;

    for ( wxString::const_iterator i = str.begin(); i != str.end(); ++i )
    {
        ch = *i;
        if ( ch == wxT('\t') )
        {
            tabRep = wxT("");
            nSp = (size_t)m_tabSize - (pos % (size_t)m_tabSize);
            tabRep.Append(wxChar(' '), nSp);
            stRes += tabRep;
            pos += nSp;
        }
        else
        {
            stRes += ch;
            pos++;
        }
    }
    return stRes;
}


//You can call this function anytime. But it's only useful if previous text
//was loaded WITH m_tabSize = -1
//Once TABS are converted, there are no more TABS an so this function will just
// be a  waste of time.
void wxFixWidthImportCtrl::ConvertTabsToSpaces()
{
    if (m_tabSize < 0)
        return;

    size_t i, nlin = m_Lines.GetCount();
    for ( i=0; i<nlin; i++ )
    {
        m_Lines[i] = TabsToSpaces( m_Lines[i] );
    }
}

//---------------------------------------------------------------------------------
//Scrollbars and scrolling
//---------------------------------------------------------------------------------

//Arrange scrollbars
void wxFixWidthImportCtrl::AdjustScrollbars()
{
    int thumbSize=1, range=1;
    wxClientDC dc(this);//Only used for char measures
    dc.SetFont(*m_Ffont);

    //Horizontal
    if ( m_scrbarV )
        thumbSize = (int) (m_scrbarV->GetPosition().x - 4 * m_margin) / (dc.GetCharWidth() + FONTPADDING);

    thumbSize = wxMax(thumbSize, 1);
    range = wxMax(m_maxLen, 1);
    thumbSize = wxMin(thumbSize, range);

    m_scrbarH->SetScrollbar(m_curposX, thumbSize, (int) m_maxLen, thumbSize -1);

    //Vertical
    if ( m_Lines.GetCount() > 0)
        range = (int) m_Lines.GetCount();
    else
        range = 1;
    thumbSize = (int) m_scrbarH->GetPosition().y -
                      FWIMARGIN - FWISCALEH  - 4 * m_margin;
    thumbSize /= dc.GetCharHeight();
    thumbSize = wxMax(thumbSize, 1);
    thumbSize = wxMin(thumbSize, range);

    m_scrbarV->SetScrollbar(m_curposL, thumbSize, range, thumbSize -1);
}

//Scrolling. Calculate positions
void wxFixWidthImportCtrl::OnScroll(wxScrollEvent &sevent)
{
    m_NowType = sevent.GetEventType();

    //Uncomment next iy you want to avoid some flicker.
    //But dragging-scroll will be not so good
/*
    //When this event arrives here.
    //Event::GetTimestamp() is when it was fired.
    m_timeNow = wxGetLocalTimeMillis();

    //We want to avoid flicker when many EVT_SCROLL_THUMBTRACK are fired
    if ( m_timeNow - m_timeInit < 200
         && m_lastType == m_NowType )
        return;
*/
    //Avoid also consecutive THUMBRELEASE ENDSCROLL, they are so similar ...
    if ( m_lastType == wxEVT_SCROLL_THUMBRELEASE
        && m_NowType == wxEVT_SCROLL_CHANGED )
    {
        SetFocus(); //Avoid blinking bar
        return;
    }

    m_lastType = m_NowType;

    bool refresNow = false;
    size_t pos = (size_t) sevent.GetPosition();

    if ( sevent.GetId() == FW_SCROH && m_curposX != pos )
    {
        m_curposX = pos;
        refresNow = true;
    }
    if ( sevent.GetId() == FW_SCROV && m_curposL != pos )
    {
        m_curposL = pos;
        refresNow = true;
    }

    if ( refresNow )
    {
        m_timeInit = m_timeNow; //Reinit time
        Refresh();
    }
    SetFocus(); //Avoid blinking bar
}

//---------------------------------------------------------------------------------
//Other
//---------------------------------------------------------------------------------

//Setting the selected line (0 to nulines-1)
void wxFixWidthImportCtrl::SelectLine(size_t nline)
{
    size_t nulines = m_Lines.GetCount();
    if ( nline >= 0 && nline != m_markedL && nulines > 0)
    {   if ( nline >= nulines )
            m_markedL = nulines - 1;
        else
            m_markedL = nline;

        //Adjust vertical scrollbar's thumb position
        int pos=0; //number of hidden lines upwards
        int range = m_scrbarV->GetRange();
        int tsize = m_scrbarV->GetThumbSize();
        if (m_markedL == nulines - 1) //last line
            pos = range - tsize;
        else if (m_markedL > 0) //middle line, cuasi-center m_markedL
            pos = m_markedL - (tsize - 1)/2; //page is tsize-1

        pos = wxMin(pos, range - tsize);
        pos = wxMax(pos, 0);

        m_scrbarV->SetThumbPosition(pos);
        m_curposL = (size_t)pos;

        Refresh();
        FireEvent();
    }
}

//Setting values
void wxFixWidthImportCtrl::SetValues(const wxArrayInt& values)
{
    size_t nval = values.GetCount();
    size_t i, j, tot;
    int val;

    m_values.Clear();

    if ( nval < 1 )
    {   Refresh();
        FireEvent();
        return;
    }

    //Add the first value
    m_values.Add( values.Item(0) );

    //Add/insert the rest, avoiding duplicates
    for ( i=1; i<nval; i++)
    {   j=0;
        val = values.Item(i);
        tot = m_values.GetCount();
        while ( j < tot && val > m_values.Item(j) )
            j++;
        if ( j >= tot && val > m_values.Item(tot-1) )
            m_values.Add(val);
        if ( j < tot && val < m_values.Item(j) )
            m_values.Insert(val, j);
    }

    Refresh();
    FireEvent();
}

//Fire an event
// The event means: "I've been changed"
// Fired when:
//  - file/string loaded
//  - selected line changed
//  - values set/changed
void wxFixWidthImportCtrl::FireEvent()
{
    //This is a wxCommandEvent event. Your code process it using, i.e. the macro
    //EVT_COMMAND (ID_MY_WINDOW, wxEVT_COMMAND_FIXW_UPDATED, MyFrame::OnMyEvent)
    wxCommandEvent event(wxEVT_COMMAND_FIXW_UPDATED, GetId());
    event.SetEventObject(this);
    wxPostEvent(this, event);
}


void wxFixWidthImportCtrl::SetDelimColor(unsigned char red, unsigned char green, unsigned char blue)
{
    delimColor.Set(red, green, blue);
    Refresh();
}

void wxFixWidthImportCtrl::SetSelecColor(unsigned char red, unsigned char green, unsigned char blue)
{
    selecColor.Set(red, green, blue);
    Refresh();
}
