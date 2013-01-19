/////////////////////////////////////////////////////////////////////////////
// Name:        wx/xrc/xh_unkwn.h
// Purpose:     XML resource handler for unknown widget
// Author:      Vaclav Slavik
// Created:     2000/03/05
// RCS-ID:      $Id: xh_unkwn.h 72585 2012-09-30 22:19:24Z VZ $
// Copyright:   (c) 2000 Vaclav Slavik
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef _WX_XH_UNKWN_H_
#define _WX_XH_UNKWN_H_

#include "wx/xrc/xmlres.h"

#if wxUSE_XRC

class WXDLLIMPEXP_XRC wxUnknownWidgetXmlHandler : public wxXmlResourceHandler
{
    DECLARE_DYNAMIC_CLASS(wxUnknownWidgetXmlHandler)

public:
    wxUnknownWidgetXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);
};

#endif // wxUSE_XRC

#endif // _WX_XH_UNKWN_H_
