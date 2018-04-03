#ifndef __XYMULTIMAPLABEL_H__
#define __XYMULTIMAPLABEL_H__

#include <map>
#include <vector>
#include <wx/string.h>

/**
* Multimap make continously x-axis.
* Many same x values but differents y is allowed.
*/
typedef std::multimap< double, double >      xyMultimap_t;
/** typedef for xyMultimap iterator*/
typedef xyMultimap_t::iterator          xyMultimapIt_t;

/**
*  key - value pairs:
*  key = xyMultimap_t iterator
*  value = label
*/
class xyMultimapLabel
{
public:
	xyMultimapIt_t  it;			//!< iterator to xyMultiMap
	wxString        label;		//!< label

public:
	/** Default constructor
	*  @param _it	iterator
	*	@param lbl	label
	*/
	xyMultimapLabel(xyMultimapIt_t _it, wxString lbl);
	/**
	*	Copy constructor
	*	@param copy	class to copy
	*/
	xyMultimapLabel(const xyMultimapLabel& copy);
};
/** typedef for xyMultimapLabel*/
typedef std::vector< xyMultimapLabel >    xyMultimapLabel_t;

#endif