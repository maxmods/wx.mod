#ifndef _MP_COVARIANCE_ELLIPSE_H_
#define _MP_COVARIANCE_ELLIPSE_H_

#include "mpMovableObject.h"

//-----------------------------------------------------------------------------
// mpCovarianceEllipse  - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------
/** A 2D ellipse, described by a 2x2 covariance matrix.
*  The relation between the multivariate Gaussian confidence interval and
*   the "quantiles" in this class is:
*     - 1 : 68.27% confidence interval
*     - 2 : 95.45%
*     - 3 : 99.73%
*     - 4 : 99.994%
* For example, see http://en.wikipedia.org/wiki/Normal_distribution#Standard_deviation_and_confidence_intervals
*
* The ellipse will be always centred at the origin. Use mpMovableObject::SetCoordinateBase to move it.
*/
class WXDLLIMPEXP_MATHPLOT mpCovarianceEllipse : public mpMovableObject
{
public:
	/** Default constructor.
	* Initializes to a unity diagonal covariance matrix, a 95% confidence interval (2 sigmas), 32 segments, and a continuous plot (m_continuous=true).
	*/
	mpCovarianceEllipse(
		double cov_00 = 1,
		double cov_11 = 1,
		double cov_01 = 0,
		double quantiles = 2,
		int    segments = 32,
		const wxString & layerName = wxT("")) :
		m_cov_00(cov_00),
		m_cov_11(cov_11),
		m_cov_01(cov_01),
		m_quantiles(quantiles),
		m_segments(segments)
	{
		m_continuous = true;
		m_name = layerName;
		RecalculateShape();
		m_type = mpLAYER_PLOT;
	}

	virtual ~mpCovarianceEllipse() {}

	double GetQuantiles() const { return m_quantiles; }

	/** Set how many "quantiles" to draw, that is, the confidence interval of the ellipse (see above).
	*/
	void SetQuantiles(double q)
	{
		m_quantiles = q;
		RecalculateShape();
	}

	void SetSegments(int segments) { m_segments = segments; }
	int GetSegments() const { return m_segments; }

	/** Returns the elements of the current covariance matrix:
	*/
	void GetCovarianceMatrix(double &cov_00, double &cov_01, double &cov_11) const
	{
		cov_00 = m_cov_00;
		cov_01 = m_cov_01;
		cov_11 = m_cov_11;
	}

	/** Changes the covariance matrix:
	*/
	void SetCovarianceMatrix(double cov_00, double cov_01, double cov_11)
	{
		m_cov_00 = cov_00;
		m_cov_01 = cov_01;
		m_cov_11 = cov_11;
		RecalculateShape();
	}

protected:
	/** The elements of the matrix (only 3 since cov(0,1)=cov(1,0) in any positive definite matrix).
	*/
	double m_cov_00, m_cov_11, m_cov_01;
	double m_quantiles;

	/** The number of line segments that build up the ellipse.
	*/
	int m_segments;

	/** Called to update the m_shape_xs, m_shape_ys vectors, whenever a parameter changes.
	*/
	void RecalculateShape();
};

#endif