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

#import "NES2C02.h"
#define PIXELS_PER_SCANLINE 341
#define SCANLINES_PER_FRAME 262


@implementation NES2C02

@synthesize controller;

- (id) initWithController:(NESController *)nes_controller
{
	self = [super init];
	if (self != nil) {
		self.controller = nes_controller;
		
		pixel_counter = 0;
		scanline_counter = 0;
	}
	return self;
}

- (void)tick
{
	if(pixel_counter == PIXELS_PER_SCANLINE - 1) {
		pixel_counter = 0;
		if(scanline_counter == SCANLINES_PER_FRAME - 1) {
			scanline_counter = 0;
			controller.nmi = TRUE;
		} else {
			scanline_counter++;
		}
	} else {
		pixel_counter++;
	}
}

@end
