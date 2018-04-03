#ifndef _MP_BITMAPLAYER_H_
#define _MP_BITMAPLAYER_H_

#include "mpLayer.h"

/** This virtual class represents objects that can be moved to an arbitrary 2D location+rotation.
*  The current transformation is set through SetCoordinateBase.
*  To ease the implementation of descendent classes, mpMovableObject will
*  be in charge of Bounding Box computation and layer render, assuming that
*  the object updates its shape in m_shape_xs & m_shape_ys.
*/
class WXDLLIMPEXP_MATHPLOT mpBitmapLayer : public mpLayer
{
public:
	/** Default constructor.
	*/
	mpBitmapLayer()
	{
		m_min_x = m_max_x =
			m_min_y = m_max_y = 0;
		m_validImg = false;
		m_type = mpLAYER_BITMAP;
		m_flags = 0;
	}

	virtual ~mpBitmapLayer() {};

	/** Returns a copy of the current bitmap assigned to the layer.
	*/
	void GetBitmapCopy(wxImage &outBmp) const;

	/** Change the bitmap associated with the layer (to update the screen, refresh the mpWindow).
	*  @param inBmp The bitmap to associate. A copy is made, thus it can be released after calling this.
	*  @param x The left corner X coordinate (in plot units).
	*  @param y The top corner Y coordinate (in plot units).
	*  @param lx The width in plot units.
	*  @param ly The height in plot units.
	*/
	void SetBitmap(const wxImage &inBmp, double x, double y, double lx, double ly);

	virtual bool HasBBox() { return true; }

	/** Get inclusive left border of bounding box.
	*/
	virtual double GetMinX() { return m_min_x; }

	/** Get inclusive right border of bounding box.
	*/
	virtual double GetMaxX() { return  m_max_x; }

	/** Get inclusive bottom border of bounding box.
	*/
	virtual double GetMinY() { return m_min_y; }

	/** Get inclusive top border of bounding box.
	*/
	virtual double GetMaxY() { return m_max_y; }

	virtual void   Plot(wxDC & dc, mpWindow & w);

	/** Set label axis alignment.
	*  @param align alignment (choose between mpALIGN_NE, mpALIGN_NW, mpALIGN_SW, mpALIGN_SE
	*/
	void SetAlign(int align) { m_flags = align; };

protected:
	int m_flags; //!< Holds label alignment

				 /** The internal copy of the Bitmap:
				 */
	wxImage      m_bitmap;
	wxBitmap     m_scaledBitmap;
	wxCoord      m_scaledBitmap_offset_x, m_scaledBitmap_offset_y;


	bool            m_validImg;


	/** The shape of the bitmap:
	*/
	double  m_min_x, m_max_x, m_min_y, m_max_y;


};

#endif