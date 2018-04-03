#ifndef _MP_FXY_H_
#define _MP_FXY_H_

#include "mpLayer.h"

/** Abstract base class providing plot and labeling functionality for a locus plot F:N->X,Y.
Locus argument N is assumed to be in range 0 .. MAX_N, and implicitly derived by enumerating
all locus values. Override mpFXY::Rewind and mpFXY::GetNextXY to implement a locus.
Optionally implement a constructor and pass a name (label) and a label alignment
to the constructor mpFXY::mpFXY. If the layer name is empty, no label will be plotted.
*/
class WXDLLIMPEXP_MATHPLOT mpFXY : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpFXY(wxString name = wxEmptyString, int flags = mpALIGN_NE);

	/** Rewind value enumeration with mpFXY::GetNextXY.
	Override this function in your implementation.
	*/
	virtual void Rewind() = 0;
	virtual void CurrentBounds(double xmin, double xmax) {}

	/** Get locus value for next N.
	Override this function in your implementation.
	@param x Returns X value
	@param y Returns Y value
	*/
	virtual bool GetNextXY(double & x, double & y) = 0;
	/** Find nearest coordinate according arguments
	@param w mpWindow instance
	@param x x point in curve
	@param y y point in curve
	return true if found any
	*/
	virtual bool GetNearestCoord(mpWindow & w, double & x, double & y);
	/**  Mark corners to curve
	@param t true/false
	*/
	void MarkCorners(bool t = true);
	/** Layer plot handler.
	This implementation will plot the locus in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

protected:
	int m_flags;                //!< Holds label alignment
	bool m_markCorners;         //!< Mark the curve corners
	wxCoord m_cornerMarkSize;

	// Data to calculate label positioning
	wxCoord maxDrawX, minDrawX, maxDrawY, minDrawY;
	//int drawnPoints;

	/** Update label positioning data
	@param xnew New x coordinate
	@param ynew New y coordinate
	*/
	void UpdateViewBoundary(wxCoord xnew, wxCoord ynew);

	DECLARE_DYNAMIC_CLASS(mpFXY)
};

#endif