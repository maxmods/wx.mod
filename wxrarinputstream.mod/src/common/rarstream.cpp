/////////////////////////////////////////////////////////////////////////////
// Name:        zipstream.cpp
// Purpose:     Zip stream classes
// Author:      Ryan Norton
// Modified by:
// Created:     09/05/03
// RCS-ID:      $Id: rarstream.cpp,v 1.1 2004/07/17 20:08:03 ryannpcs Exp $
// Copyright:   (c) Guilhem Lavaux
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

//===========================================================================
//                          HEADERS
//===========================================================================

#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
#pragma implementation "rarstream.h"
#endif


// For compilers that support precompilation, includes "wx.h".
#include "wx/wxprec.h"

#ifdef __BORLANDC__
  #pragma hdrstop
#endif

#if wxUSE_STREAMS



#include "wx/rarstream.h"
#include "wx/utils.h"
#include "wx/intl.h"
#include "wx/log.h"

#include "../src/unrar/dll.hpp"

//===========================================================================
//                          IMPLEMENTATION
//===========================================================================

// ----------------------------------------------------------------------------
// wxRarInputStream
// ----------------------------------------------------------------------------

wxRarInputStream::wxRarInputStream(const wxChar* szFile)
{
	    RAROpenArchiveDataEx rx;
	    memset(&rx,0,sizeof(rx));
#if wxUSE_UNICODE
        rx.ArcNameW =((wxChar*) szFile);
#else /* !wxUSE_UNICODE */
	    rx.ArcName  =((wxChar*) szFile);
#endif
        rx.OpenMode=RAR_OM_EXTRACT;
	    rx.CmtBuf=m_Info.szComment=new char[2000];
	    rx.CmtBufSize=2000;
	    m_hRar = RAROpenArchiveEx(&rx);

        if (!m_hRar)
        {
            wxLogSysError(wxString::Format(_("Couldn't open rar file %s"), szFile));
            delete m_Info.szComment;
        }

	    RARSetPassword(m_hRar,"");
}

wxRarInputStream::~wxRarInputStream()
{
 	RARCloseArchive(m_hRar);	    
}

/*
wxInputStream& wxRarInputStream::ReadRaw(void* pBuffer, size_t size)
{
	return m_parent_i_stream->Read(pBuffer, size);
}

off_t wxRarInputStream::TellRawI()
{
	return m_parent_i_stream->TellI();
}

off_t wxRarInputStream::SeekRawI(off_t pos, wxSeekMode sm)
{
	return m_parent_i_stream->SeekI(pos, sm);
}
*/

bool wxRarInputStream::OpenNextFile()
{
	RARHeaderData hd;

    int nError;

    if ((nError = RARReadHeader(m_hRar, &hd)) != 0)
    {
        wxMessageBox(wxString::Format(_T("AHH  %ld"), nError));
        return false;
	}
	
//	wxMessageBox(hd.FileName);
	return true;
}

bool wxRarInputStream::ExtractFile(const char* szDestPath, const char* szDestName)
{
    int nError;
	if(
        (nError = RARProcessFile(
                        m_hRar, RAR_EXTRACT, (char*)szDestPath, (char*)szDestName
                                )) != 0
      )
    {
	    wxMessageBox(wxString::Format(_T("AHHPROCESS  %ld"), nError));
        return false;
    }
    return true;
}


bool wxRarInputStream::OpenFile(const char* szFileName)
{
	return false;
}

bool wxRarInputStream::GetFileInfo(wxRarFileInfo& Info)
{
	return true;
}

size_t wxRarInputStream::OnSysRead(void* buffer, size_t bufsize)
{
    return 0;
}

#endif  //wxUSE_STREAMS