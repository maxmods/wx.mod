#ifndef __YBARCHARTLAYER_H__
#define __YBARCHARTLAYER_H__

#include "mpFYXBar.h"
#include "baseXYData.h"

/**
* bar Chart Layer
* -use baseXYLayer (x scale is continous by default)
*/
class YbarChartLayer : public mpFYXBar, public baseXYData
{
private:
	double				m_lsb;

public:
	/** Constructor
	*	@param label
	*/
	YbarChartLayer(wxString label);
	virtual ~YbarChartLayer();
	/**
	*	Set LSB of bar chart
	*	@param lsb	LSB
	*/
	void SetLSB(double lsb);

	/**
	* Virtual functions for mpFYXBar
	*/
	virtual bool GetNextXY(double & x, double & y, wxString& label);

	virtual bool GetLSB(double &l);
	virtual void Rewind();
	virtual double GetMinY();
	virtual double GetMaxY();
	virtual double GetMinX();
	virtual double GetMaxX();
protected:
};

#endif