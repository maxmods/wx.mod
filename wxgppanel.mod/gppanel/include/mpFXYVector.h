#ifndef _MP_FXYVECTOR_H_
#define _MP_FXYVECTOR_H_

#include "mpFXY.h"

//-----------------------------------------------------------------------------
// mpFXYVector - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------

/** A class providing graphs functionality for a 2D plot (either continuous or a set of points), from vectors of data.
This class can be used directly, the user does not need to derive any new class. Simply pass the data as two vectors
with the same length containing the X and Y coordinates to the method SetData.

To generate a graph with a set of points, call
\code
layerVar->SetContinuity(false)
\endcode

or

\code
layerVar->SetContinuity(true)
\endcode

to render the sequence of coordinates as a continuous line.

(Added: Jose Luis Blanco, AGO-2007)
*/
class WXDLLIMPEXP_MATHPLOT mpFXYVector : public mpFXY
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpFXYVector(wxString name = wxEmptyString, int flags = mpALIGN_NE);

	/** Changes the internal data: the set of points to draw.
	Both vectors MUST be of the same length. This method DOES NOT refresh the mpWindow, do it manually.
	* @sa Clear
	*/
	void SetData(const std::vector<double> &xs, const std::vector<double> &ys);

	/** Clears all the data, leaving the layer empty.
	* @sa SetData
	*/
	void Clear();

protected:
	/** The internal copy of the set of data to draw.
	*/
	std::vector<double>  m_xs, m_ys;

	/** The internal counter for the "GetNextXY" interface
	*/
	size_t              m_index;

	/** Loaded at SetData
	*/
	double              m_minX, m_maxX, m_minY, m_maxY;

	/** Rewind value enumeration with mpFXY::GetNextXY.
	Overridden in this implementation.
	*/
	void Rewind();

	/** Get locus value for next N.
	Overridden in this implementation.
	@param x Returns X value
	@param y Returns Y value
	*/
	bool GetNextXY(double & x, double & y);

	/** Returns the actual minimum X data (loaded in SetData).
	*/
	double GetMinX() { return m_minX; }

	/** Returns the actual minimum Y data (loaded in SetData).
	*/
	double GetMinY() { return m_minY; }

	/** Returns the actual maximum X data (loaded in SetData).
	*/
	double GetMaxX() { return m_maxX; }

	/** Returns the actual maximum  Y data (loaded in SetData).
	*/
	double GetMaxY() { return m_maxY; }

	int     m_flags; //!< Holds label alignment

	DECLARE_DYNAMIC_CLASS(mpFXYVector)
};

#endif