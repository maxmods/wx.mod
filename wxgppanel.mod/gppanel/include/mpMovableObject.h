#ifndef _MP_MOVABLE_OBJECT_H_
#define _MP_MOVABLE_OBJECT_H_


#include "mpLayer.h"

//-----------------------------------------------------------------------------
// mpMovableObject  - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
/** This virtual class represents objects that can be moved to an arbitrary 2D location+rotation.
*  The current transformation is set through SetCoordinateBase.
*  To ease the implementation of descendent classes, mpMovableObject will
*  be in charge of Bounding Box computation and layer rendering, assuming that
*  the object updates its shape in m_shape_xs & m_shape_ys.
*/
class WXDLLIMPEXP_MATHPLOT mpMovableObject : public mpLayer
{
public:
	/** Default constructor (sets location and rotation to (0,0,0))
	*/
	mpMovableObject() :
		m_reference_x(0),
		m_reference_y(0),
		m_reference_phi(0),
		m_shape_xs(0),
		m_shape_ys(0)
	{
		m_type = mpLAYER_PLOT;
		m_flags = 0;
		m_bbox_min_x = 0;
		m_bbox_max_x = 0;
		m_bbox_min_y = 0;
		m_bbox_max_y = 0;
	}

	virtual ~mpMovableObject() {};

	/** Get the current coordinate transformation.
	*/
	void GetCoordinateBase(double &x, double &y, double &phi) const
	{
		x = m_reference_x;
		y = m_reference_y;
		phi = m_reference_phi;
	}

	/** Set the coordinate transformation (phi in radians, 0 means no rotation).
	*/
	void SetCoordinateBase(double x, double y, double phi = 0)
	{
		m_reference_x = x;
		m_reference_y = y;
		m_reference_phi = phi;
		m_flags = mpALIGN_NE;
		ShapeUpdated();
	}

	virtual bool IsMovableLayer() { return true; }
	virtual bool Inside(const wxPoint& point) { return false; }

	virtual bool HasBBox() { return m_trans_shape_xs.size() != 0; }

	/** Get inclusive left border of bounding box.
	*/
	virtual double GetMinX() { return m_bbox_min_x; }

	/** Get inclusive right border of bounding box.
	*/
	virtual double GetMaxX() { return  m_bbox_max_x; }

	/** Get inclusive bottom border of bounding box.
	*/
	virtual double GetMinY() { return m_bbox_min_y; }

	/** Get inclusive top border of bounding box.
	*/
	virtual double GetMaxY() { return m_bbox_max_y; }

	virtual void   Plot(wxDC & dc, mpWindow & w);

	/** Set label axis alignment.
	*  @param align alignment (choose between mpALIGN_NE, mpALIGN_NW, mpALIGN_SW, mpALIGN_SE
	*/
	void SetAlign(int align) { m_flags = align; };

protected:
	int m_flags; //!< Holds label alignment

				 /** The coordinates of the object (orientation "phi" is in radians).
				 */
	double m_reference_x, m_reference_y, m_reference_phi;

	/** A method for 2D translation and rotation, using the current transformation stored in m_reference_x,m_reference_y,m_reference_phi.
	*/
	void TranslatePoint(double x, double y, double &out_x, double &out_y);

	/** This contains the object points, in local coordinates (to be transformed by the current transformation).
	*/
	std::vector<double>  m_shape_xs, m_shape_ys;

	/** The buffer for the translated & rotated points (to avoid recomputing them with each mpWindow refresh).
	*
	*/
	std::vector<double>  m_trans_shape_xs, m_trans_shape_ys;

	/** The precomputed bounding box:
	* @sa ShapeUpdated
	*/
	double  m_bbox_min_x, m_bbox_max_x, m_bbox_min_y, m_bbox_max_y;

	/** Must be called by the descendent class after updating the shape (m_shape_xs/ys), or when the transformation changes.
	*  This method updates the buffers m_trans_shape_xs/ys, and the precomputed bounding box.
	*/
	void ShapeUpdated();

};

#endif