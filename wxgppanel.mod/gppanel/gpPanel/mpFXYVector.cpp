#include "mpFXYVector.h"
#include "wx/log.h"

//-----------------------------------------------------------------------------
// mpFXYVector implementation - by Jose Luis Blanco (AGO-2007)
//-----------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(mpFXYVector, mpFXY)

// Constructor
mpFXYVector::mpFXYVector(wxString name, int flags) : mpFXY(name, flags)
{
	m_index = 0;
	m_minX = -1;
	m_maxX = 1;
	m_minY = -1;
	m_maxY = 1;
	m_type = mpLAYER_PLOT;
}

void mpFXYVector::Rewind()
{
	m_index = 0;
}

bool mpFXYVector::GetNextXY(double & x, double & y)
{
	if (m_index >= m_xs.size())
		return FALSE;
	else
	{
		x = m_xs[m_index];
		y = m_ys[m_index];
		return (++m_index) <= m_xs.size();
	}
}
void mpFXYVector::Clear()
{
	m_xs.clear();
	m_ys.clear();
}

void mpFXYVector::SetData(const std::vector<double> &xs, const std::vector<double> &ys)
{
	// Check if the data vectora are of the same size
	if (xs.size() != ys.size()) {
		wxLogError(_("wxMathPlot error: X and Y vector are not of the same length!"));
		return;
	}
	// Copy the data:
	m_xs = xs;
	m_ys = ys;


	// Update internal variables for the bounding box.
	if (xs.empty())
	{
		m_minX = xs[0];
		m_maxX = xs[0];
		m_minY = ys[0];
		m_maxY = ys[0];

		std::vector<double>::const_iterator  it;

		for (it = xs.begin(); it != xs.end(); it++)
		{
			if (*it<m_minX) m_minX = *it;
			if (*it>m_maxX) m_maxX = *it;
		}
		for (it = ys.begin(); it != ys.end(); it++)
		{
			if (*it<m_minY) m_minY = *it;
			if (*it>m_maxY) m_maxY = *it;
		}
		m_minX -= 0.5f;
		m_minY -= 0.5f;
		m_maxX += 0.5f;
		m_maxY += 0.5f;
	}
	else
	{
		m_minX = -1;
		m_maxX = 1;
		m_minY = -1;
		m_maxY = 1;
	}
}