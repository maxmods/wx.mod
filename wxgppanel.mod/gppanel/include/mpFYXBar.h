#ifndef _MP_FY_BAR_H_
#define _MP_FY_BAR_H_
#include "mpLayer.h"

/** mpFYXBar class
*   by Jussi Vatjus-Anttila
*
*   |-----+
*   |-----+---+
*   |--------++
*   |--------+
´* '''''''''''''''''''''
*/
class WXDLLIMPEXP_MATHPLOT mpFYXBar : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpFYXBar(wxString name = wxEmptyString, int flags = mpALIGN_NE);
	virtual ~mpFYXBar() {}

	/** Rewind value enumeration with mpFXY::GetNextXY.
	Override this function in your implementation.
	*/
	virtual void Rewind() = 0;

	/** Get locus value for next N.
	Override this function in your implementation.
	@param x Returns X value
	@param y Returns Y value
	*/
	virtual bool GetNextXY(double & x, double & y, wxString& label) = 0;
	/**
	* Bar chart Lowest significant bit
	* default: not in use (return false)
	*/
	virtual bool GetLSB(double &l) { return false; }
	/** Returns the actual minimum X data (loaded in SetData).
	*/
	virtual double GetMinX() = 0;

	/** Returns the actual minimum Y data (loaded in SetData).
	*/
	virtual double GetMinY() = 0;

	/** Returns the actual maximum X data (loaded in SetData).
	*/
	virtual double GetMaxX() = 0;

	/** Returns the actual maximum  Y data (loaded in SetData).
	*/
	virtual double GetMaxY() = 0;

	/** Layer plot handler.
	This implementation will plot the locus in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

	void SetGradientBackColour(bool t) { m_gradienBackground = t; }
	void ShowLabel(bool t) { m_showLabel = t; }
	void UseCustomLabel(bool t) { m_useCustomLabel = t; }

protected:
	int m_flags; //!< Holds label alignment
	bool m_gradienBackground;
	bool m_showLabel;
	bool m_useCustomLabel;

	DECLARE_CLASS(mpFYXBar)
};

#endif