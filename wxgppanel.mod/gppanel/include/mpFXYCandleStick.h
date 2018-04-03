#ifndef _MP_FXYCANDLESTICK_H_
#define _MP_FXYCANDLESTICK_H_

#include "mpLayer.h"
/** mpFXYCandleStick class
*   by Jussi Vatjus-Anttila
*/
class WXDLLIMPEXP_MATHPLOT mpFXYCandleStick : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpFXYCandleStick(wxString name = wxEmptyString, int flags = mpALIGN_NE);
	/** virtual destructor */
	virtual ~mpFXYCandleStick() {}

	/** Rewind value enumeration with mpFXY::GetNextXY.
	Override this function in your implementation.
	*/
	virtual void Rewind() = 0;

	/** Get locus value for next N.
	Override this function in your implementation.
	@param x Returns X value
	@param y Returns Y value
	*/
	virtual bool GetNext(double & x, double & yCandleMin, double & yCandleMax, double& yStickMin, double& yStickMax) = 0;
	/**
	* Bar chart Lowest significant bit
	* default: not in use (return false)
	*/
	virtual bool GetLSB(double &l) { return false; }

	/** Layer plot handler.
	This implementation will plot the locus in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

	void SetGradientBackColour(bool t) { m_gradienBackground = t; }	//!< Enable gradient backcolours
	void SetCandleBrush(wxBrush brush) { m_candleBrush = brush; }	//!< Set candle brush when min<max. (default=black)
	void SetCandleBrush2(wxBrush brush) { m_candleBrush2 = brush; }	//!< Set candle brush when min>max. (default=white)
	void SetCandlePen(wxPen pen) { m_candlePen = pen; }	//!< Set candle pen (default: black)
	void SetStickPen(wxPen pen) { m_stickPen = pen; }	//!< Set stick pen (default: black)

protected:
	int m_flags; //!< Holds label alignment
	bool m_gradienBackground;	//!< True if gradien background enables

	wxPen m_stickPen;			//!< Stick pen
	wxBrush m_candleBrush;		//!< Candle brush, when yCandleMin < yCandleMax
	wxBrush m_candleBrush2;		//!< Candle brush, when yCandleMin > yCandleMax
	wxPen m_candlePen;			//!< Candle pen.


	DECLARE_CLASS(mpFXYCandleStick)
};

#endif