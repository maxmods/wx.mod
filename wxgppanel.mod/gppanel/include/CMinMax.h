#ifndef __CMINMAX_H__
#define __CMINMAX_H__

/**
*  Base class for XY data
*/
class CMinMax
{
	// protected variables
protected:

	double 	 xMax   ///< X max value
		, yMax   ///< Y max value
		, xMin   ///< X min value
		, yMin;  ///< Y min value

				 // public functions
public:

	double GetMaxX() const;     /// @return max X value
	double GetMinX() const;     /// @return min X value
	double GetMaxY() const;     /// @return max Y value
	double GetMinY() const;     /// @return min Y value
	void SetMaxX(double d);   /// @return max X value
	void SetMinX(double d);   /// @return min X value
	void SetMaxY(double d);   /// @return max Y value
	void SetMinY(double d);   /// @return min Y value
							  /** copy constructor */
	explicit CMinMax(const CMinMax& copy);

	//Protected functions
protected:
	/** Constructor */
	CMinMax();
	/** Destructor */
	~CMinMax();
	/**
	*  Handle min and max values
	*  @param[in] x X value to be check if it's min or max
	*  @param[in] y Y value to be check if it's min or max
	*/
	void minmax(const double &x, const double &y);
	/**
	*	Handle Y-value for minmax
	*	@param[in] x  x-value for check
	*/
	void minmaxX(const double &x);
	/**
	*	Handle Y-value for minmax
	*	@param[in] y  y-value for check
	*/
	void minmaxY(const double &y);
};

#endif