/////////////////////////////////////////////////////////////////////////////
// Name:        rarstream.h
// Purpose:     Rar stream classes
// Author:      Ryan Norton
// Modified by:
// Created:     09/05/03
// RCS-ID:      $Id: rarstream.h,v 1.1 2004/07/17 20:08:03 ryannpcs Exp $
// Copyright:   (c) Ryan Norton
// Licence:     wxWindows licence (Can't make rar compressor!)
/////////////////////////////////////////////////////////////////////////////

#ifndef _WX_WXRARSTREAM_H__
#define _WX_WXRARSTREAM_H__


#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
#pragma interface "rarstream.h"
#endif

#include "wx/defs.h"

#if wxUSE_STREAMS
#include "wx/stream.h"

struct wxRarFileInfo
{
	wxString szName;
	char* szComment;

	wxUint32 dwUncompressedSize;
	wxUint32 dwCompressedSize;
	wxUint32 dwTime;
};

class wxRarInputStream
{
public:
	wxRarInputStream(const wxChar* szFile);
	virtual ~wxRarInputStream();

	bool OpenFile(const char* szFileName);
	bool OpenNextFile();
    bool ExtractFile(const char* szDestPath, const char* szDestName);
	bool GetFileInfo(wxRarFileInfo& Info);

	void* GetHandleI() {return m_hRar;}
protected:
	virtual size_t OnSysRead(void *buffer, size_t size);

	void* m_hRar;
    wxRarFileInfo m_Info;
};

#endif
#endif