/********************************************************************************
 *
 * Copyright 2010 MesoSynoptic Studios.
 *
 * This file is part of CoCoNES.
 * 
 * CoCoNES is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * CoCoNES is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with CoCoNES.  If not, see <http://www.gnu.org/licenses/>.
 *
 ********************************************************************************/

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
