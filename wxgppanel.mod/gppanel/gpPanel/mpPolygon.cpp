#include "mpPolygon.h"
#include "wx/log.h"

//-----------------------------------------------------------------------------
// mpPolygon - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
void mpPolygon::setPoints(
	const std::vector<double>&  points_xs,
	const std::vector<double>&  points_ys,
	bool                        closedShape)
{
	if (points_xs.size() != points_ys.size())
	{
		wxLogError(wxT("[mpPolygon] Error: points_xs and points_ys must have the same number of elements"));
	}
	else
	{
		m_shape_xs = points_xs;
		m_shape_ys = points_ys;

		if (closedShape && points_xs.size())
		{
			m_shape_xs.push_back(points_xs[0]);
			m_shape_ys.push_back(points_ys[0]);
		}

		ShapeUpdated();
	}
}