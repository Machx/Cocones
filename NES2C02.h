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
#import <Cocoa/Cocoa.h>
#import "NESController.h"

@class NESController;


@interface NES2C02 : NSObject {

	NESController *controller;
	int pixel_counter, scanline_counter;
	
}

@property(retain) NESController *controller;

- (id)initWithController:(NESController *)controller;
- (void)tick;


@end
