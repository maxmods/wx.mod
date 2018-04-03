#ifndef _MP_POLYGON_H_
#define _MP_POLYGON_H_

#include "mpMovableObject.h"

//-----------------------------------------------------------------------------
// mpPolygon - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
/** An arbitrary polygon, descendant of mpMovableObject.
*  Use "setPoints" to set the list of N points. This class also can draw non-closed polygons by
*   passing the appropriate parameters to "setPoints". To draw a point-cloud, call "SetContinuity(false)".
*/
class WXDLLIMPEXP_MATHPLOT mpPolygon : public mpMovableObject
{
public:
	/** Default constructor.
	*/
	mpPolygon(const wxString & layerName = wxT(""))
	{
		m_continuous = true;
		m_name = layerName;
	}

	virtual ~mpPolygon() {}

	/** Set the points in the polygon.
	* @param points_xs  The X coordinates of the points.
	* @param points_ys  The Y coordinates of the points.
	* @param closedShape If set to true, an additional segment will be added from the last to the first point.
	*/
	void setPoints(
		const std::vector<double>&  points_xs,
		const std::vector<double>&  points_ys,
		bool                   closedShape = true);
};

#endif