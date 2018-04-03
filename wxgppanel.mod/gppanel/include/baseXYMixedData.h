#ifndef __BASEXYMIXED_DATA_H__
#define __BASEXYMIXED_DATA_H__
#include "baseXYData.h"


/**
*  baseXYMixedData:
*  -base mixed XY data class. Can be using straight with gpLayer or
*  used by
*  -use xyDeque_t for data storing
*/
class baseXYMixedData : protected CMinMax
{
protected:
	/**
	*  Constructor
	*  @param name name of mpLayer
	*/
	baseXYMixedData();
	virtual ~baseXYMixedData();   /// destructor
public:
	/**
	* Define new XY data for graph
	* @param newdata[in]   new data
	*/
	void SetData(xyDeque_t& newdata);
	/**
	*  alternative function to push only one x&y values to graph
	*  @param[in] x X value
	*  @param[in] y Y value
	*/
	void PushData(double &x, double &y);
	/**
	* get reference data from graph
	* @return xyDeque_t
	*/
	xyDeque_t& GetData();

protected:

	/*
	* Virtual functions for mpLayer usage
	*/

	/**
	*  GetNextXY virtual function for mpLayer
	*/
	virtual bool GetNextXY(double & x, double & y);
	virtual void   Rewind();
	virtual double GetMinY();
	virtual double GetMaxY();
	virtual double GetMinX();
	virtual double GetMaxX();

private:
	xyDeque_t              m_data;    //!< data stucture for graph
	xyDeque_t::iterator    m_it;      //!< data iterator for virtual functions

};

#endif