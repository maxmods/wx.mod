#ifndef _MP_TEXT_H_
#define _MP_TEXT_H_
#include "mpLayer.h"


//-----------------------------------------------------------------------------
// mpText - provided by Val Greene
//-----------------------------------------------------------------------------

/** Plot layer implementing a text string.
The text is plotted using a percentage system 0-100%, so the actual
coordinates for the location are not required, and the text stays
on the plot reguardless of the other layers location and scaling
factors.
*/
class WXDLLIMPEXP_MATHPLOT mpText : public mpLayer
{
public:
	/** @param name text to be drawn in the plot
	@param offsetx holds offset for the X location in percentage (0-100)
	@param offsety holds offset for the Y location in percentage (0-100) */
	mpText(wxString name = wxT("Title"), int offsetx = 5, int offsety = 50);

	/** Text Layer plot handler.
	This implementation will plot text adjusted to the visible area. */
	virtual void Plot(wxDC & dc, mpWindow & w);

	/** mpText should not be used for scaling decisions. */
	virtual bool HasBBox() { return FALSE; }

protected:
	int m_offsetx; //!< Holds offset for X in percentage
	int m_offsety; //!< Holds offset for Y in percentage

	DECLARE_DYNAMIC_CLASS(mpText)
};

#endif