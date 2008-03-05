#import <Cocoa/Cocoa.h>
#include <brl.mod/blitz.mod/blitz.h>

static NSAutoreleasePool * cocoaPool;

void initCocoa() {

	if (! cocoaPool) {
		cocoaPool = [[NSAutoreleasePool alloc] init];
		NSApplicationLoad();
	}

}