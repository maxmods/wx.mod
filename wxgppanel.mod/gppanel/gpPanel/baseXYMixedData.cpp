#include "baseXYMixedData.h"


/* ******************************************** */
/*  		MIXED DATA CONTAINER  				*/
/* ******************************************** */
baseXYMixedData::baseXYMixedData()
{
	m_it = m_data.begin();
}
baseXYMixedData::~baseXYMixedData() {}

/* public */
void baseXYMixedData::SetData(xyDeque_t& newdata)
{

	m_data.clear();
	if (newdata.empty())return;
	m_data = newdata;
	xyDeque_t::iterator it;

	//search largest and smallest values of data
	xMax = xMin = m_data[0].x;
	yMax = yMin = m_data[0].y;
	for (it = m_data.begin();
		it != m_data.end();
		it++)
	{
		minmax(it->x, it->y);
	}
}

void baseXYMixedData::PushData(double &x, double &y)
{
	m_data.push_back(xy_s(x, y));
	minmax(x, y);
}
xyDeque_t& baseXYMixedData::GetData() { return m_data; }

/* protected */
bool baseXYMixedData::GetNextXY(double & x, double & y)
{
	if (m_it != m_data.end())
	{
		x = m_it->x;
		y = m_it->y;
		m_it++;
		return true;
	}
	return false;
}
void   baseXYMixedData::Rewind() { m_it = m_data.begin(); }
double baseXYMixedData::GetMinY() { return yMin; }
double baseXYMixedData::GetMaxY() { return yMax; }
double baseXYMixedData::GetMinX() { return xMin; }
double baseXYMixedData::GetMaxX() { return xMax; }