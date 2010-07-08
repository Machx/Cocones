//
//  CoCoNESAppDelegate.m
//  CoCoNES
//
//  Created by Nicholas Meyer on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NESAppDelegate.h"

@implementation NESAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	NSOpenPanel *openRom = [NSOpenPanel openPanel];
	int result = [openRom runModal];
	
	NSURL *romURL;
	if (result == NSOKButton) {
		romURL = [[openRom URLs] objectAtIndex:0];
		NSLog(@"%@",[romURL className]);
	}
	
	nesController = [[NESController alloc] initWithROMFile:romURL];
	
}

- (IBAction)tick:(id)sender{
	[nesController tick];
}

@end
