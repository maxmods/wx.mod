#ifndef _MP_FX_H_
#define _MP_FX_H_

#include "mpLayer.h"


/** Abstract base class providing plot and labeling functionality for functions F:X->Y.
Override mpFX::GetY to implement a function.
Optionally implement a constructor and pass a name (label) and a label alignment
to the constructor mpFX::mpFX. If the layer name is empty, no label will be plotted.
*/
class WXDLLIMPEXP_MATHPLOT mpFX : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_RIGHT, #mpALIGN_CENTER, #mpALIGN_LEFT.
	*/
	mpFX(wxString name = wxEmptyString, int flags = mpALIGN_RIGHT);

	/** Get function value for argument.
	Override this function in your implementation.
	@param x Argument
	@return Function value
	*/
	virtual double GetY(double x) = 0;

	/** Layer plot handler.
	This implementation will plot the function in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

	void MarkCorners(bool t);

protected:
	int m_flags;            //!< Holds label alignment
	bool m_markCorners;     //!< Mark the curve corners
	wxCoord m_cornerMarkSize;

	DECLARE_DYNAMIC_CLASS(mpFX)
};

#endif