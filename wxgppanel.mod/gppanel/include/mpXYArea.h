#ifndef _MP_XYAREA_H_
#define _MP_XYAREA_H_

#include "mpFXY.h"

class mpXYArea : public mpFXY
{
public:
	/** @param name  Label
	@param flags Label alignment, pass one of #mpALIGN_NE, #mpALIGN_NW, #mpALIGN_SW, #mpALIGN_SE.
	*/
	mpXYArea(wxString name = wxEmptyString, int flags = mpALIGN_NE);
	void Plot(wxDC & dc, mpWindow & w) override;
protected:
	//DECLARE_DYNAMIC_CLASS(mpXYArea)
};

#endif