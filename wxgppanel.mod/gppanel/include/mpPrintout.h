#ifndef _MP_PRINTOUT_H_
#define _MP_PRINTOUT_H_

#include "mpLayer.h"
#include <wx/prntbase.h>

//-----------------------------------------------------------------------------
// mpPrintout - provided by Davide Rondini
//-----------------------------------------------------------------------------

/** Printout class used by mpWindow to draw in the objects to be printed.
The object itself can then used by the default wxWidgets printing system
to print mppWindow objects.
*/
class WXDLLIMPEXP_MATHPLOT mpPrintout : public wxPrintout
{
public:
	mpPrintout(mpWindow* drawWindow, const wxChar *title = _T("wxMathPlot print output"));
	virtual ~mpPrintout() {};

	void SetDrawState(bool drawState) { drawn = drawState; };
	bool OnPrintPage(int page);
	bool HasPage(int page);

private:
	bool drawn;
	mpWindow *plotWindow;
};

#endif