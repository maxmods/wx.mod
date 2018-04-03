#ifndef __LINECHARTLAYER_H__
#define __LINECHARTLAYER_H__

#include "mpFXY.h"
#include "baseXYData.h"

/**
*  Mixed Line chart
*  -use baseXYMixedLayer
*/
class lineChartLayer : public mpFXY, public baseXYData
{
private:

public:
	lineChartLayer(wxString label);

	/**
	* Virtual functions for mpFXY
	*/
	virtual bool GetNextXY(double & x, double & y);
	virtual void Rewind();
	virtual double GetMinY();
	virtual double GetMaxY();
	virtual double GetMinX();
	virtual double GetMaxX();
	virtual void CurrentBounds(double xmin, double xmax);

protected:
};

#endif