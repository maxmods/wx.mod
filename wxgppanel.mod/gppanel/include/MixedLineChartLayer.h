#ifndef __MIXEDLINECHARTLAYER_H__
#define __MIXEDLINECHARTLAYER_H__

#include "mpFXY.h"
#include "baseXYMixedData.h"

/**
*  Mixed Line chart
*  -use baseXYMixedLayer
*/
class MixedLineChartLayer : public mpFXY, public baseXYMixedData
{
private:

public:
	MixedLineChartLayer(wxString label);

protected:

	/**
	* Virtual functions for mpFXYBar
	*/
	virtual bool GetNextXY(double & x, double & y);
	virtual void Rewind();

};

#endif