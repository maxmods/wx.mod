#ifndef _MP_FY_H_
#define _MP_FY_H_

#include "mpLayer.h"

/** Abstract base class providing plot and labeling functionality for functions F:Y->X.
Override mpFY::GetX to implement a function.
Optionally implement a constructor and pass a name (label) and a label alignment
to the constructor mpFY::mpFY. If the layer name is empty, no label will be plotted.
*/
class WXDLLIMPEXP_MATHPLOT mpFY : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_BOTTOM, #mpALIGN_CENTER, #mpALIGN_TOP.
	*/
	mpFY(wxString name = wxEmptyString, int flags = mpALIGN_TOP);

	/** Get function value for argument.
	Override this function in your implementation.
	@param y Argument
	@return Function value
	*/
	virtual double GetX(double y) = 0;

	/** Layer plot handler.
	This implementation will plot the function in the visible area and
	put a label according to the aligment specified.
	*/
	virtual void Plot(wxDC & dc, mpWindow & w);

protected:
	int m_flags; //!< Holds label alignment

	DECLARE_DYNAMIC_CLASS(mpFY)
};

#endif