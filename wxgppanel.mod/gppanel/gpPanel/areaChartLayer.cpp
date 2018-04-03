#include "areaChartLayer.h"

/* ******************************************** */
/*  		DEFAULT AREA CHART LAYER  			 */
/* ********************************************* */
areaChartLayer::areaChartLayer(wxString label) : mpXYArea(label), baseXYData()
{
	m_drawOutsideMargins = false;
}

/* Virtual functions for mpFXY */
bool areaChartLayer::GetNextXY(double & x, double & y)
{
	return baseXYData::GetNextXY(x, y);
}
void areaChartLayer::Rewind() { baseXYData::Rewind(); }
double areaChartLayer::GetMinY() { return baseXYData::GetMinY(); }
double areaChartLayer::GetMaxY() { return baseXYData::GetMaxY(); }
double areaChartLayer::GetMinX() { return baseXYData::GetMinX(); }
double areaChartLayer::GetMaxX() { return baseXYData::GetMaxX(); }
void  areaChartLayer::CurrentBounds(double xmin, double xmax)
{
	baseXYData::CurrentBounds(xmin, xmax);
}