#include "xyMultimapLabel.h"

xyMultimapLabel::xyMultimapLabel(xyMultimapIt_t _it, wxString lbl)
{
	it = _it; label = lbl;
}

xyMultimapLabel::xyMultimapLabel(const xyMultimapLabel& copy)
{
	it = copy.it; label = copy.label;
}