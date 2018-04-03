#include "YbarChartLayer.h"

/* ********************************************* */
/*  		YBAR CHART LAYER  					 */
/* ********************************************* */
YbarChartLayer::YbarChartLayer(wxString label) : mpFYXBar(label), baseXYData()
{
	m_drawOutsideMargins = false;
	m_lsb = 1;
}

YbarChartLayer::~YbarChartLayer() {}
/**
*	Set LSB of bar chart
*	@param lsb	LSB
*/
void YbarChartLayer::SetLSB(double lsb) { m_lsb = lsb; }

/* virtual functions for mpFYXBar */
bool YbarChartLayer::GetNextXY(double & x, double & y, wxString& label)
{
	return baseXYData::GetNextXY(x, y, label);
}
bool YbarChartLayer::GetLSB(double &l) { l = m_lsb; return true; }
void YbarChartLayer::Rewind() { baseXYData::Rewind(); }
double YbarChartLayer::GetMinY() { return baseXYData::GetMinY() - m_lsb / 2; }
double YbarChartLayer::GetMaxY() { return baseXYData::GetMaxY() + m_lsb / 2; }
double YbarChartLayer::GetMinX() { return baseXYData::GetMinX(); }
double YbarChartLayer::GetMaxX() { return baseXYData::GetMaxX(); }