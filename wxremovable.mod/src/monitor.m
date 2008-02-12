/*
  Copyright (c) 2007,2008 Bruce A Henderson
 
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

#import <Cocoa/Cocoa.h>
#include <brl.mod/blitz.mod/blitz.h>

@interface Listener : NSObject
- (void)volumeDidMount:(NSNotification *)notif;
- (void)volumeDidUnmount:(NSNotification *)notif;
@end

// function definitions to be used later - Look mum, I can call BlitzMax from Obj-C :-)
void wx_wxremovable__volumeDidMount(BBString * devicePath);
void wx_wxremovable__volumeDidUnmount(BBString * devicePath);

// this is our listener instance !
static Listener *volumeListener;

static NSAutoreleasePool * volumePool;

// NOTE : if you don't use MaxGUI, you need to include this :

BBString *bbStringFromNSString(NSString *s){
	BBString	*bbstring;
	unsigned short	*buff;
	int		n;
	n=[s length];
	buff=malloc(n*2);
	[s getCharacters:buff];
	bbstring=bbStringFromShorts(buff,n);
	free(buff);
	return bbstring;	
}



@implementation Listener
- (void)volumeDidMount:(NSNotification *)notif
{
   wx_wxremovable__volumeDidMount(bbStringFromNSString([[notif userInfo] valueForKey:@"NSDevicePath"]));
}
- (void)volumeDidUnmount:(NSNotification *)notif
{
   wx_wxremovable__volumeDidUnmount(bbStringFromNSString([[notif userInfo] valueForKey:@"NSDevicePath"]));
}
@end



void startListener() {

	if (! volumePool) {
		volumePool = [[NSAutoreleasePool alloc] init];
	}

	if (! volumeListener) {
		volumeListener = [[Listener alloc] init];

		NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
	
		[[sharedWorkspace notificationCenter] addObserver: volumeListener selector:@selector(volumeDidMount:)
			name:NSWorkspaceDidMountNotification object:nil];
	
		[[sharedWorkspace notificationCenter] addObserver: volumeListener selector:@selector(volumeDidUnmount:)
			name:NSWorkspaceDidUnmountNotification object:nil];

	}
}

void stopListener() {
	if (volumeListener) {
		NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
		[[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver: volumeListener];
		[volumeListener release];
	}

	if (volumePool) {
   		[volumePool release];
	}
}