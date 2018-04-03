#include "lineChartLayer.h"

/* ******************************************** */
/*  		DEFAULT LINE CHART LAYER  			 */
/* ********************************************* */
lineChartLayer::lineChartLayer(wxString label) : mpFXY(label), baseXYData()
{
	m_drawOutsideMargins = false;
}

/* Virtual functions for mpFXY */
bool lineChartLayer::GetNextXY(double & x, double & y)
{
	return baseXYData::GetNextXY(x, y);
}
void lineChartLayer::Rewind() { baseXYData::Rewind(); }
double lineChartLayer::GetMinY() { return baseXYData::GetMinY(); }
double lineChartLayer::GetMaxY() { return baseXYData::GetMaxY(); }
double lineChartLayer::GetMinX() { return baseXYData::GetMinX(); }
double lineChartLayer::GetMaxX() { return baseXYData::GetMaxX(); }
void  lineChartLayer::CurrentBounds(double xmin, double xmax)
{
	baseXYData::CurrentBounds(xmin, xmax);
}