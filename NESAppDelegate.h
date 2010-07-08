//
//  CoCoNESAppDelegate.h
//  CoCoNES
//
//  Created by Nicholas Meyer on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NESController.h"

@interface NESAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NESController *nesController;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)tick:(id)sender;

@end
