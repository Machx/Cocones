//
//  NESController.h
//  CoCoNES
//
//  Created by Nicholas Meyer on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NES2A03.h"

@class NES2A03;


@interface NESController : NSThread {
	
	NES2A03 *cpu;
	
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

- (id) initWithROMFile:(NSURL *)romURL;
- (unsigned char)readAddress:(unsigned short)address;

@end
