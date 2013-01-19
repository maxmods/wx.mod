/*
  Copyright (c) 2007-2009 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "glue.h"

#include <CoreFoundation/CoreFoundation.h>

#include "wx/wx.h"
#include "wx/osx/core/cfstring.h"

#include	<IOKit/IOKitLib.h>
#include	<IOKit/serial/IOSerialKeys.h>
#include	<IOKit/IOBSD.h>


extern "C" {

	BBArray * bmx_wxctb_listserialports();

}

kern_return_t
createSerialIterator(io_iterator_t *serialIterator)
{
    kern_return_t	kernResult;
    mach_port_t		masterPort;
    CFMutableDictionaryRef	classesToMatch;
    if ((kernResult=IOMasterPort(NULL, &masterPort)) != KERN_SUCCESS)
    {
        printf("IOMasterPort returned %d\n", kernResult);
        return kernResult;
    }
    if ((classesToMatch = IOServiceMatching(kIOSerialBSDServiceValue)) == NULL)
    {
        printf("IOServiceMatching returned NULL\n");
        return kernResult;
    }
    CFDictionarySetValue(classesToMatch, CFSTR(kIOSerialBSDTypeKey),
                         CFSTR(kIOSerialBSDRS232Type));
    kernResult = IOServiceGetMatchingServices(masterPort, classesToMatch, serialIterator);
    if (kernResult != KERN_SUCCESS)
    {
        printf("IOServiceGetMatchingServices returned %d\n", kernResult);
    }
    return kernResult;
}

wxCFStringRef * getRegistryString(io_object_t sObj, char *propName) {

    CFStringRef nameCFstring = (CFStringRef)IORegistryEntryCreateCFProperty(sObj,
            CFStringCreateWithCString(kCFAllocatorDefault, propName, kCFStringEncodingASCII),
                                                   kCFAllocatorDefault, 0);

    if (nameCFstring) {
		return new wxCFStringRef(nameCFstring);
    }
    return NULL;
}

BBArray * bmx_wxctb_listserialports() {

    io_iterator_t	theSerialIterator;
    io_object_t		theObject;

    if (createSerialIterator(&theSerialIterator) != KERN_SUCCESS) {
        return &bbEmptyArray;
    }

	wxArrayString ports;

    while (theObject = IOIteratorNext(theSerialIterator)) {

        wxCFStringRef * dev = getRegistryString(theObject, kIODialinDeviceKey);

		if (dev) {
			ports.Add(dev->AsString());	
			delete dev;
		}
    }
    return wxArrayStringToBBStringArray(ports);
}

