#include "CMinMax.h"

/* CminMax */
CMinMax::CMinMax(const CMinMax& copy)
{
	xMax = copy.GetMaxX();
	yMax = copy.GetMaxY();
	xMin = copy.GetMinX();
	yMin = copy.GetMinY();

}
double CMinMax::GetMaxX() const { return xMax; }
double CMinMax::GetMinX() const { return xMin; }
double CMinMax::GetMaxY() const { return yMax; }
double CMinMax::GetMinY() const { return yMin; }
void   CMinMax::SetMaxX(double d) { xMax = d; }
void   CMinMax::SetMinX(double d) { xMin = d; }
void   CMinMax::SetMaxY(double d) { yMax = d; }
void   CMinMax::SetMinY(double d) { yMin = d; }



/* Protected */
CMinMax::CMinMax()
{
	xMax = xMin = yMax = yMin = 0;
}
/** Destructor */
CMinMax::~CMinMax() {}

/**
*  Handle min and max values
*  @param[in] x X value to be check if it's min or max
*  @param[in] y Y value to be check if it's min or max
*/
void CMinMax::minmax(const double &x, const double &y)
{
	//check if values are supported. in limit.
	//if(!isanyinf<double>(x))return;
	//if(!isanyinf<double>(y))return;

	if (xMax < x)  xMax = x;
	if (xMin > x)  xMin = x;
	if (yMax < y)  yMax = y;
	if (yMin > y)  yMin = y;
}
void CMinMax::minmaxX(const double &x)
{
	if (xMax < x)  xMax = x;
	if (xMin > x)  xMin = x;
}
void CMinMax::minmaxY(const double &y)
{
	if (yMax < y)  yMax = y;
	if (yMin > y)  yMin = y;
}