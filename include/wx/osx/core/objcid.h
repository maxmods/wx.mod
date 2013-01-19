///////////////////////////////////////////////////////////////////////////////
// Name:        wx/osx/core/objcid.h
// Purpose:     Define wxObjCID working in both C++ and Objective-C.
// Author:      Vadim Zeitlin
// Created:     2012-05-20
// RCS-ID:      $Id: objcid.h 71567 2012-05-26 12:29:39Z VZ $
// Copyright:   (c) 2012 Vadim Zeitlin <vadim@wxwidgets.org>
// Licence:     wxWindows licence
///////////////////////////////////////////////////////////////////////////////

#ifndef _WX_OSX_CORE_OBJCID_H_
#define _WX_OSX_CORE_OBJCID_H_

// ----------------------------------------------------------------------------
// wxObjCID: Equivalent of Objective-C "id" that works in C++ code.
// ----------------------------------------------------------------------------

#ifdef __OBJC__
    #define wxObjCID id
#else
    typedef struct objc_object* wxObjCID;
#endif

#endif // _WX_OSX_CORE_OBJCID_H_
