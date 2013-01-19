/////////////////////////////////////////////////////////////////////////////
// Name:        wx/xrc/xh_auinotbk.h
// Purpose:     XML resource handler for wxAuiNotebook
// Author:      Steve Lamerton
// Created:     2009-06-12
// RCS-ID:      $Id: xh_auinotbk.h 72728 2012-10-23 13:51:58Z VZ $
// Copyright:   (c) 2009 Steve Lamerton
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef _WX_XRC_XH_AUINOTEBOOK_H_
#define _WX_XRC_XH_AUINOTEBOOK_H_

#include "wx/xrc/xmlres.h"

class WXDLLIMPEXP_FWD_AUI wxAuiNotebook;

#if wxUSE_XRC && wxUSE_AUI

class WXDLLIMPEXP_AUI wxAuiNotebookXmlHandler : public wxXmlResourceHandler
{
public:
    wxAuiNotebookXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);

private:
    bool m_isInside;
    wxAuiNotebook *m_notebook;

    wxDECLARE_DYNAMIC_CLASS(wxAuiNotebookXmlHandler);
};

#endif // wxUSE_XRC && wxUSE_AUI

#endif // _WX_XRC_XH_AUINOTEBOOK_H_
