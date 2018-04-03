#include "barChartLayer.h"

/* ********************************************* */
/*  		XBAR CHART LAYER  					 */
/* ********************************************* */
barChartLayer::barChartLayer(wxString label) : mpFXYBar(label), baseXYData()
{
	m_drawOutsideMargins = false;
	m_lsb = 1;
}

barChartLayer::~barChartLayer() {}
void barChartLayer::SetLSB(double lsb) { m_lsb = lsb; }

/* Virtual functions for mpFXYBar*/
bool barChartLayer::GetNextXY(double & x, double & y, wxString & label)
{
	return baseXYData::GetNextXY(x, y, label);
}
bool barChartLayer::GetLSB(double &l) { l = m_lsb; return true; }
void barChartLayer::Rewind() { baseXYData::Rewind(); }
double barChartLayer::GetMinY() { return baseXYData::GetMinY(); }
double barChartLayer::GetMaxY() { return baseXYData::GetMaxY(); }
double barChartLayer::GetMinX() { return baseXYData::GetMinX() - m_lsb / 2; }
double barChartLayer::GetMaxX() { return baseXYData::GetMaxX() + m_lsb / 2; }