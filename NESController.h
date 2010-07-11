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
#import "NES2A03.h"

@class NES2A03;

@interface NESController : NSThread {
	
	NES2A03 *cpu;
	NES2C02 *ppu;
	
	dispatch_queue_t cpu_queue;
	dispatch_queue_t ppu_queue;
	
	unsigned short cpuAddressBus;
	unsigned char cpuDataBus;
	
	unsigned char ram[0x800];
	unsigned char prg_rom[0x8000];
	
	unsigned char chr_rom[0x4000];
	
	NSArray *prg_rom_banks;
	NSArray *chr_rom_banks;
	
	bool reset;
}

@property(assign) unsigned short cpuAddressBus;
@property(assign) unsigned char cpuDataBus;
@property(assign) bool reset;

- (id) initWithROMFile:(NSURL *)romURL;
- (unsigned char)readAddress:(unsigned short)address;

- (IBAction)startEmulation:(id)sender;
- (IBAction)pauseEmulation:(id)sender;
- (IBAction)resetEmulation:(id)sender;

@end
