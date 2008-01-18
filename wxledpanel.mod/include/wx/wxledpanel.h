/***************************************************************
 * Name:      wxledpanel.h
 * Purpose:   Defines Class wxLEDPanel
 * Author:    Christian Gräfe (info@mcs-soft.de)
 * Created:   2007-02-28
 * Copyright: Christian Gräfe (www.mcs-soft.de)
 * License:	  wxWindows licence
 **************************************************************/
#ifndef WXLEDPANEL_H
#define WXLEDPANEL_H

#include "wx/advancedmatrixobject.h"
#include "wx/wxledfont.h"
//#include "wx/wxledpaneldef.h"
#include <wx/wx.h>

enum wxLEDColour
{
	wxLED_COLOUR_RED = 1,
	wxLED_COLOUR_GREEN = 2,
	wxLED_COLOUR_BLUE = 3,
	wxLED_COLOUR_YELLOW = 4,
	wxLED_COLOUR_MAGENTA = 5,
	wxLED_COLOUR_CYAN = 6,
	wxLED_COLOUR_GREY = 7
};

enum wxLEDScrollDirection
{
	wxLED_SCROLL_NONE = 0,
	wxLED_SCROLL_UP = 1,
	wxLED_SCROLL_DOWN = 2,
	wxLED_SCROLL_LEFT = 3,
	wxLED_SCROLL_RIGHT = 4
};

enum wxLEDTextAlign
{
	wxLED_TEXTALIGN_LEFT = 0,
	wxLED_TEXTALIGN_RIGHT = 1,
	wxLED_TEXTALIGN_CENTER = 2
};

enum wxLEDTextVAlign
{
	wxLED_TEXTVALIGN_TOP = 0,
	wxLED_TEXTVALIGN_BOTTOM = 1,
	wxLED_TEXTVALIGN_CENTER = 2
};

class wxLEDPanel : public wxControl
{
	public:
		// Ctor
		wxLEDPanel();
		wxLEDPanel(wxWindow* parent, wxWindowID id,
					const wxSize& pointsize, const wxSize& fieldsize, int padding=0,
					const wxPoint& pos = wxDefaultPosition,
					long style = wxNO_BORDER,
					const wxValidator& validator = wxDefaultValidator);

        // Dtor
		virtual ~wxLEDPanel();

		// Create the Element
		bool Create(wxWindow* parent, wxWindowID id,
					const wxSize& pointsize, const wxSize& fieldsize, int padding=0,
					const wxPoint& pos = wxDefaultPosition,
					long style = wxNO_BORDER,
					const wxValidator& validator = wxDefaultValidator);

		// Size of the element
		wxSize DoGetBestSize() const;

		// Clear the Context
		void Clear();

		// Reset the Context
		void Reset();

		// Größenangaben
		wxSize GetFieldsize() const;
		wxSize GetPointsize() const;

		// Set the Colour of the LEDs
		void SetLEDColour(wxLEDColour colourID);
		const wxColour& GetLEDColour() const;

		// ScrollSpeed
		void SetScrollSpeed(int speed);
		int GetScrollSpeed() const;

		// Scrolldirection
		void SetScrollDirection(wxLEDScrollDirection d);
		wxLEDScrollDirection GetScrollDirection() const;

		// Draw Invertet (default behavior is false)
		void ShowInvertet(bool invert=true);

		// Show inactiv LEDs? (default behavior is true)
		void ShowInactivLEDs(bool show_inactivs=true);

		// Text Alignment if wxLED_SCROLL_NONE
		void SetTextAlign(int a);	// a -> wxAlignment e.g. wxALIGN_TOP|wxALIGN_RIGHT
		int GetTextAlign() const;

		// Text to show
		void SetText(const wxString& text, int align=-1);	// align e.g. "wxLEFT|wxTOP", align=-1 -> Use corrent align
		const wxString& GetText() const;

		// TextPadding (only used when wxALIGN_LEFT or wxALIGN_RIGHT)
		void SetTextPaddingLeft(int padLeft);
		void SetTextPaddingRight(int padRight);
		int GetTextPaddingLeft() const;
		int GetTextPaddingRight() const;

		// Space Between the Letters
		void SetLetterSpace(int letterSpace);
		int GetLetterSpace() const;

		// FontType
		void SetFontTypeWide();
		void SetFontTypeSmall();
		bool IsFontTypeSmall() const;

    protected:
		// Drawing
		void DrawField(wxDC& dc);
		void OnEraseBackground(wxEraseEvent& event);
		void OnPaint(wxPaintEvent &event);

		// Move the Content
		void ShiftLeft();
		void ShiftRight();
		void ShiftUp();
		void ShiftDown();

		// the data for the LED-field
		AdvancedMatrixObject m_field;

		// Control-Properties
		wxSize m_pointsize;
        int m_padding;
        int m_textalign;
        int m_padLeft;
        int m_padRight;
        wxLEDColour m_activ_colour_id;
        bool m_invert;
        bool m_show_inactivs;

        // Scroll-Properties
        int m_scrollspeed;
		wxLEDScrollDirection m_scrolldirection;
        wxTimer m_scrollTimer;

        // Scroll-function
        void OnScrollTimer(wxTimerEvent& event);

		// Bitmaps with "LED on" and "LED off"
        wxBitmap m_bmp_led_on;
        wxBitmap m_bmp_led_off;

        // the text
        wxString m_text;
        MatrixObject m_text_mo;
        wxPoint m_text_pos;
        wxLEDFont m_font;

        void ResetTextPos();

        // Colours
        static const wxColour s_colour[7];
        static const wxColour s_colour_dark[7];
        static const wxColour s_colour_verydark[7];
        static const wxColour s_colour_light[7];

        // The Event Table
        DECLARE_EVENT_TABLE()
};



#endif // WXLEDPANEL_H
