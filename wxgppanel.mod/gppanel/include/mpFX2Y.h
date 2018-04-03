#ifndef _MP_FX2Y_H_
#define _MP_FX2Y_H_

#include "mpLayer.h"

/** Double line with middle value
*/
class WXDLLIMPEXP_MATHPLOT mpFX2Y : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpFX2Y(wxString name = wxEmptyString, int flags = mpALIGN_NE);

	/** Rewind value enumeration with mpFXY::GetNextXY.
	Override this function in your implementation.
	*/
	virtual void Rewind() = 0;

	/** Get locus value for next N.
	Override this function in your implementation.
	@param x Returns X value
	@param y Returns Y value
	*/
	virtual bool GetNextX2Y(double & x, double & y1, double & y2) = 0;

	/** Layer plot handler.
	This implementation will plot the locus in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

protected:
	int m_flags; //!< Holds label alignment

	DECLARE_DYNAMIC_CLASS(mpFX2Y)
};

#endif