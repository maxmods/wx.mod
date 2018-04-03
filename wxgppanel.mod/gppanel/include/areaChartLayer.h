#ifndef __AREACHARTLAYER_H__
#define __AREACHARTLAYER_H__

#include "mpXYArea.h"
#include "baseXYData.h"

class areaChartLayer : public mpXYArea, public baseXYData
{
private:

public:
	areaChartLayer(wxString label);

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