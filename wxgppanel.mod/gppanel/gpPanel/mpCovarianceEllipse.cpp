#include "mpCovarianceEllipse.h"
#include <wx/log.h>

//-----------------------------------------------------------------------------
// mpCovarianceEllipse - provided by Jose Luis Blanco
//-----------------------------------------------------------------------------

// Called to update the m_shape_xs, m_shape_ys vectors, whenever a parameter changes.
void mpCovarianceEllipse::RecalculateShape()
{
	m_shape_xs.clear();
	m_shape_ys.clear();

	// Preliminar checks:
	if (m_quantiles<0) { wxLogError(wxT("[mpCovarianceEllipse] Error: quantiles must be non-negative")); return; }
	if (m_cov_00<0) { wxLogError(wxT("[mpCovarianceEllipse] Error: cov(0,0) must be non-negative")); return; }
	if (m_cov_11<0) { wxLogError(wxT("[mpCovarianceEllipse] Error: cov(1,1) must be non-negative")); return; }

	m_shape_xs.resize(m_segments, 0);
	m_shape_ys.resize(m_segments, 0);

	// Compute the two eigenvalues of the covariance:
	// -------------------------------------------------
	double b = -m_cov_00 - m_cov_11;
	double c = m_cov_00*m_cov_11 - m_cov_01*m_cov_01;

	double D = b*b - 4 * c;

	if (D<0) { wxLogError(wxT("[mpCovarianceEllipse] Error: cov is not positive definite")); return; }

	double eigenVal0 = 0.5*(-b + sqrt(D));
	double eigenVal1 = 0.5*(-b - sqrt(D));

	// Compute the two corresponding eigenvectors:
	// -------------------------------------------------
	double  eigenVec0_x, eigenVec0_y;
	double  eigenVec1_x, eigenVec1_y;

	if (fabs(eigenVal0 - m_cov_00)>1e-6)
	{
		double k1x = m_cov_01 / (eigenVal0 - m_cov_00);
		eigenVec0_y = 1;
		eigenVec0_x = eigenVec0_y * k1x;
	}
	else
	{
		double k1y = m_cov_01 / (eigenVal0 - m_cov_11);
		eigenVec0_x = 1;
		eigenVec0_y = eigenVec0_x * k1y;
	}

	if (fabs(eigenVal1 - m_cov_00)>1e-6)
	{
		double k2x = m_cov_01 / (eigenVal1 - m_cov_00);
		eigenVec1_y = 1;
		eigenVec1_x = eigenVec1_y * k2x;
	}
	else
	{
		double k2y = m_cov_01 / (eigenVal1 - m_cov_11);
		eigenVec1_x = 1;
		eigenVec1_y = eigenVec1_x * k2y;
	}

	// Normalize the eigenvectors:
	double len = sqrt(eigenVec0_x*eigenVec0_x + eigenVec0_y*eigenVec0_y);
	eigenVec0_x /= len;  // It *CANNOT* be zero
	eigenVec0_y /= len;

	len = sqrt(eigenVec1_x*eigenVec1_x + eigenVec1_y*eigenVec1_y);
	eigenVec1_x /= len;  // It *CANNOT* be zero
	eigenVec1_y /= len;


	// Take the sqrt of the eigenvalues (required for the ellipse scale):
	eigenVal0 = sqrt(eigenVal0);
	eigenVal1 = sqrt(eigenVal1);

	// Compute the 2x2 matrix M = diag(eigVal) * (~eigVec)  (each eigen vector is a row):
	double M_00 = eigenVec0_x * eigenVal0;
	double M_01 = eigenVec0_y * eigenVal0;

	double M_10 = eigenVec1_x * eigenVal1;
	double M_11 = eigenVec1_y * eigenVal1;

	// The points of the 2D ellipse:
	double ang;
	double Aang = 6.283185308 / (m_segments - 1);
	int    i;
	for (i = 0, ang = 0; i<m_segments; i++, ang += Aang)
	{
		double ccos = cos(ang);
		double csin = sin(ang);

		m_shape_xs[i] = m_quantiles * (ccos * M_00 + csin * M_10);
		m_shape_ys[i] = m_quantiles * (ccos * M_01 + csin * M_11);
	} // end for points on ellipse


	ShapeUpdated();
}