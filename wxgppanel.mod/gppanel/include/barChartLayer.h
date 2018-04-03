#ifndef __BARCHARTLAYER_H__
#define __BARCHARTLAYER_H__

#include "mpFXYBar.h"
#include "baseXYData.h"

/**
* bar Chart Layer
* -use baseXYLayer (x scale is continous by default)
*/
class barChartLayer : public mpFXYBar, public baseXYData
{
private:
	double				m_lsb;

public:
	/** Constructor
	*	@param label
	*/
	barChartLayer(wxString label);
	virtual ~barChartLayer();
	/**
	*	Set LSB of bar chart
	*	@param lsb	LSB
	*/
	void SetLSB(double lsb);

	/**
	* Virtual functions for mpFXYBar
	*/
	virtual bool GetNextXY(double & x, double & y, wxString & label);

	virtual bool GetLSB(double &l);
	virtual void Rewind();
	virtual double GetMinY();
	virtual double GetMaxY();
	virtual double GetMinX();
	virtual double GetMaxX();
protected:
};


#endif