#include "mpBitmapLayer.h"
#include "mpWindow.h"
#include <wx/log.h>

//-----------------------------------------------------------------------------
// mpBitmapLayer - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
void mpBitmapLayer::GetBitmapCopy(wxImage &outBmp) const
{
	if (m_validImg)
		outBmp = m_bitmap;
}

void mpBitmapLayer::SetBitmap(const wxImage &inBmp, double x, double y, double lx, double ly)
{
	if (!inBmp.Ok())
	{
		wxLogError(wxT("[mpBitmapLayer] Assigned bitmap is not Ok()!"));
	}
	else
	{
		m_bitmap = inBmp; //.GetSubBitmap( wxRect(0, 0, inBmp.GetWidth(), inBmp.GetHeight()));
		m_min_x = x;
		m_min_y = y;
		m_max_x = x + lx;
		m_max_y = y + ly;
		m_validImg = true;
	}
}


void mpBitmapLayer::Plot(wxDC & dc, mpWindow & w)
{
	if (m_visible && m_validImg)
	{
		/*	1st: We compute (x0,y0)-(x1,y1), the pixel coordinates of the real outer limits
		of the image rectangle within the (screen) mpWindow. Note that these coordinates
		might fall well far away from the real view limits when the user zoom in.

		2nd: We compute (dx0,dy0)-(dx1,dy1), the pixel coordinates the rectangle that will
		be actually drawn into the mpWindow, i.e. the clipped real rectangle that
		avoids the non-visible parts. (offset_x,offset_y) are the pixel coordinates
		that correspond to the window point (dx0,dy0) within the image "m_bitmap", and
		(b_width,b_height) is the size of the bitmap patch that will be drawn.

		(x0,y0) .................  (x1,y0)
		.                          .
		.                          .
		(x0,y1) ................   (x1,y1)
		(In pixels!!)
		*/

		// 1st step -------------------------------
		wxCoord x0 = w.x2p(m_min_x);
		wxCoord y0 = w.y2p(m_max_y);
		wxCoord x1 = w.x2p(m_max_x);
		wxCoord y1 = w.y2p(m_min_y);

		// 2nd step -------------------------------
		// Precompute the size of the actual bitmap pixel on the screen (e.g. will be >1 if zoomed in)
		double screenPixelX = (x1 - x0) / (double)m_bitmap.GetWidth();
		double screenPixelY = (y1 - y0) / (double)m_bitmap.GetHeight();

		// The minimum number of pixels that the streched image will overpass the actual mpWindow borders:
		wxCoord borderMarginX = (wxCoord)(screenPixelX + 1); // ceil
		wxCoord borderMarginY = (wxCoord)(screenPixelY + 1); // ceil

															 // The actual drawn rectangle (dx0,dy0)-(dx1,dy1) is (x0,y0)-(x1,y1) clipped:
		wxCoord dx0 = x0, dx1 = x1, dy0 = y0, dy1 = y1;
		if (dx0<0) dx0 = -borderMarginX;
		if (dy0<0) dy0 = -borderMarginY;
		if (dx1>w.GetScrX()) dx1 = w.GetScrX() + borderMarginX;
		if (dy1>w.GetScrY()) dy1 = w.GetScrY() + borderMarginY;

		// For convenience, compute the width/height of the rectangle to be actually drawn:
		wxCoord d_width = dx1 - dx0 + 1;
		wxCoord d_height = dy1 - dy0 + 1;

		// Compute the pixel offsets in the internally stored bitmap:
		wxCoord offset_x = (wxCoord)((dx0 - x0) / screenPixelX);
		wxCoord offset_y = (wxCoord)((dy0 - y0) / screenPixelY);

		// and the size in pixel of the area to be actually drawn from the internally stored bitmap:
		wxCoord b_width = (wxCoord)((dx1 - dx0 + 1) / screenPixelX);
		wxCoord b_height = (wxCoord)((dy1 - dy0 + 1) / screenPixelY);

#ifdef MATHPLOT_DO_LOGGING
		wxLogMessage(_("[mpBitmapLayer::Plot] screenPixel: x=%f y=%f  d_width=%ix%i"), screenPixelX, screenPixelY, d_width, d_height);
		wxLogMessage(_("[mpBitmapLayer::Plot] offset: x=%i y=%i  bmpWidth=%ix%i"), offset_x, offset_y, b_width, b_height);
#endif

		// Is there any visible region?
		if (d_width>0 && d_height>0)
		{
			// Build the scaled bitmap from the image, only if it has changed:
			if (m_scaledBitmap.GetWidth() != d_width ||
				m_scaledBitmap.GetHeight() != d_height ||
				m_scaledBitmap_offset_x != offset_x ||
				m_scaledBitmap_offset_y != offset_y)
			{
				wxRect r(wxRect(offset_x, offset_y, b_width, b_height));
				// Just for the case....
				if (r.x<0) r.x = 0;
				if (r.y<0) r.y = 0;
				if (r.width>m_bitmap.GetWidth()) r.width = m_bitmap.GetWidth();
				if (r.height>m_bitmap.GetHeight()) r.height = m_bitmap.GetHeight();

				m_scaledBitmap = wxBitmap(
					wxBitmap(m_bitmap).GetSubBitmap(r).ConvertToImage()
					.Scale(d_width, d_height));
				m_scaledBitmap_offset_x = offset_x;
				m_scaledBitmap_offset_y = offset_y;
			}

			// Draw it:
			dc.DrawBitmap(m_scaledBitmap, dx0, dy0, true);
		}
	}

	// Draw the name label
	if (!m_name.IsEmpty() && m_showName)
	{
		dc.SetFont(m_font);

		wxCoord tx, ty;
		dc.GetTextExtent(m_name, &tx, &ty);

		if (HasBBox())
		{
			wxCoord sx = (wxCoord)((m_max_x - w.GetPosX()) * w.GetScaleX());
			wxCoord sy = (wxCoord)((w.GetPosY() - m_max_y) * w.GetScaleY());

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