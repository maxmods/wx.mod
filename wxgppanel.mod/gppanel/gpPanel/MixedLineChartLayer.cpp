#include "MixedLineChartLayer.h"

/* ******************************************** */
/*  		MIXED LINE CHART LAYER  			 */
/* ********************************************* */
MixedLineChartLayer::MixedLineChartLayer(wxString label) : mpFXY(label), baseXYMixedData()
{
	m_drawOutsideMargins = false;
}

/* protected */

/* Virtual functions for mpFXYBar */

bool MixedLineChartLayer::GetNextXY(double & x, double & y)
{
	return baseXYMixedData::GetNextXY(x, y);
}

void MixedLineChartLayer::Rewind()
{
	baseXYMixedData::Rewind();
}