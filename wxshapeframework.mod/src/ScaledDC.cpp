/***************************************************************
 * Name:      ScaledDC.cpp
 * Purpose:   Implements scaled DC class
 * Author:    Michal Bližňák (michal.bliznak@tiscali.cz)
 * Created:   2008-11-7
 * Copyright: Michal Bližňák
 * License:   wxWidgets license (www.wxwidgets.org)
 * Notes:
 **************************************************************/
 
#include "wx_pch.h"

#ifdef _DEBUG_MSVC
#define new DEBUG_NEW
#endif

#include "wx/wxsf/ScaledDC.h"

//----------------------------------------------------------------------------------//
// Constructor and destructor
//----------------------------------------------------------------------------------//

wxSFScaledDC::wxSFScaledDC( wxWindowDC *target, double scale) : wxDC( new wxSFDCImplWrapper( target->GetImpl(), scale ) )
{
}

wxSFScaledDC::~wxSFScaledDC()
{
}
