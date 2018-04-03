#ifndef _MP_PROFILE_H_
#define _MP_PROFILE_H_

#include "mpLayer.h"


/** Abstract base class providing plot and labeling functionality for functions F:Y->X.
Override mpProfile::GetX to implement a function.
This class is similar to mpFY, but the Plot method is different. The plot is in fact represented by lines instead of points, which gives best rendering of rapidly-varying functions, and in general, data which are not so close one to another.
Optionally implement a constructor and pass a name (label) and a label alignment
to the constructor mpProfile::mpProfile. If the layer name is empty, no label will be plotted.
*/
class WXDLLIMPEXP_MATHPLOT mpProfile : public mpLayer
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_BOTTOM, #mpALIGN_CENTER, #mpALIGN_TOP.
	*/
	mpProfile(wxString name = wxEmptyString, int flags = mpALIGN_TOP);

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

protected:
	int m_flags; //!< Holds label alignment

	DECLARE_DYNAMIC_CLASS(mpProfile)
};

#endif