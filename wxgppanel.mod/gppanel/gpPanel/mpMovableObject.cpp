#include "mpMovableObject.h"
#include "wx/log.h"
#include "mpWindow.h"

//-----------------------------------------------------------------------------
// mpMovableObject - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
void mpMovableObject::TranslatePoint(double x, double y, double &out_x, double &out_y)
{
	double ccos = cos(m_reference_phi);  // Avoid computing cos/sin twice.
	double csin = sin(m_reference_phi);

	out_x = m_reference_x + ccos * x - csin * y;
	out_y = m_reference_y + csin * x + ccos * y;
}

// This method updates the buffers m_trans_shape_xs/ys, and the precomputed bounding box.
void mpMovableObject::ShapeUpdated()
{
	// Just in case...
	if (m_shape_xs.size() != m_shape_ys.size())
	{
		wxLogError(wxT("[mpMovableObject::ShapeUpdated] Error, m_shape_xs and m_shape_ys have different lengths!"));
	}
	else
	{
		double ccos = cos(m_reference_phi);  // Avoid computing cos/sin twice.
		double csin = sin(m_reference_phi);

		m_trans_shape_xs.resize(m_shape_xs.size());
		m_trans_shape_ys.resize(m_shape_xs.size());

		std::vector<double>::iterator itXi, itXo;
		std::vector<double>::iterator itYi, itYo;

		m_bbox_min_x = 1e300;
		m_bbox_max_x = -1e300;
		m_bbox_min_y = 1e300;
		m_bbox_max_y = -1e300;

		for (itXo = m_trans_shape_xs.begin(), itYo = m_trans_shape_ys.begin(), itXi = m_shape_xs.begin(), itYi = m_shape_ys.begin();
			itXo != m_trans_shape_xs.end(); itXo++, itYo++, itXi++, itYi++)
		{
			*itXo = m_reference_x + ccos * (*itXi) - csin * (*itYi);
			*itYo = m_reference_y + csin * (*itXi) + ccos * (*itYi);

			// Keep BBox:
			if (*itXo < m_bbox_min_x) m_bbox_min_x = *itXo;
			if (*itXo > m_bbox_max_x) m_bbox_max_x = *itXo;
			if (*itYo < m_bbox_min_y) m_bbox_min_y = *itYo;
			if (*itYo > m_bbox_max_y) m_bbox_max_y = *itYo;
		}
	}
}

void mpMovableObject::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible) {
		dc.SetPen(m_pen);


		std::vector<double>::iterator  itX = m_trans_shape_xs.begin();
		std::vector<double>::iterator  itY = m_trans_shape_ys.begin();

		if (!m_continuous)
		{
			// for some reason DrawPoint does not use the current pen,
			// so we use DrawLine for fat pens
			if (m_pen.GetWidth() <= 1)
			{
				while (itX != m_trans_shape_xs.end())
				{
					dc.DrawPoint(w.x2p(*(itX++)), w.y2p(*(itY++)));
				}
			}
			else
			{
				while (itX != m_trans_shape_xs.end())
				{
					wxCoord cx = w.x2p(*(itX++));
					wxCoord cy = w.y2p(*(itY++));
					dc.DrawLine(cx, cy, cx, cy);
				}
			}
		}
		else
		{
			wxCoord cx0 = 0, cy0 = 0;
			bool    first = TRUE;
			while (itX != m_trans_shape_xs.end())
			{
				wxCoord cx = w.x2p(*(itX++));
				wxCoord cy = w.y2p(*(itY++));
				if (first)
				{
					first = FALSE;
					cx0 = cx; cy0 = cy;
				}
				dc.DrawLine(cx0, cy0, cx, cy);
				cx0 = cx; cy0 = cy;
			}
		}

		if (!m_name.IsEmpty() && m_showName)
		{
			dc.SetFont(m_font);

			wxCoord tx, ty;
			dc.GetTextExtent(m_name, &tx, &ty);

			if (HasBBox())
			{
				wxCoord sx = (wxCoord)((m_bbox_max_x - w.GetPosX()) * w.GetScaleX());
				wxCoord sy = (wxCoord)((w.GetPosY() - m_bbox_max_y) * w.GetScaleY());

				tx = sx - tx - 8;
				ty = sy - 8 - ty;
			}
			else
			{
				const int sx = w.GetScrX() >> 1;
				const int sy = w.GetScrY() >> 1;

				if ((m_flags & mpALIGNMASK) == mpALIGN_NE)
				{
					tx = sx - tx - 8;
					ty = -sy + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_NW)
				{
					tx = -sx + 8;
					ty = -sy + 8;
				}
				else if ((m_flags & mpALIGNMASK) == mpALIGN_SW)
				{
					tx = -sx + 8;
					ty = sy - 8 - ty;
				}
				else
				{
					tx = sx - tx - 8;
					ty = sy - 8 - ty;
				}
			}

			dc.DrawText(m_name, tx, ty);
		}
	}
}