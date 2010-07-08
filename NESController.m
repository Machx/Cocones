//
//  NESController.m
//  CoCoNES
//
//  Created by Nicholas Meyer on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NESController.h"
#define INES_HEADER_SIZE 0x10
#define PRG_BANK_SIZE 0x4000
#define CHR_BANK_SIZE 0x2000
#define INES_IDENTIFIER 0x4e45531a
#define BASE_CLOCK 315/88*6


@implementation NESController

@synthesize cpuAddressBus, cpuDataBus;

- (id) initWithROMFile:(NSURL *)romURL
{
	self = [super init];
	if (self != nil) {
		// loading ROM
		NSData *romData = [NSData dataWithContentsOfURL:romURL];
		unsigned char header[16];
		[romData getBytes:&header range:NSMakeRange(0, INES_HEADER_SIZE)];
		romData = [romData subdataWithRange:NSMakeRange(INES_HEADER_SIZE, [romData length] - INES_HEADER_SIZE)];
		
		unsigned int ines_identifier = (header[0] << 24) | (header[1] << 16) | (header[2] << 8) | header[3];
		if (ines_identifier != INES_IDENTIFIER) {
			[NSAlert alertWithMessageText:@"Not a valid NES file!" defaultButton:@"Darn..." alternateButton:nil otherButton:nil informativeTextWithFormat:nil];
			return nil;
		}
		
		unsigned char prg_banks = header[4];
		unsigned char chr_banks = header[5];
		
		NSMutableArray *prgBanksTemp = [NSMutableArray array];
		for(int i = 0; i < prg_banks; i++) {
			NSData *prg_bank = [romData subdataWithRange:NSMakeRange(i*PRG_BANK_SIZE, PRG_BANK_SIZE)];
			[prgBanksTemp addObject:prg_bank];
		}
		
		prg_rom_banks = [prgBanksTemp copy];
		[[prg_rom_banks objectAtIndex:0] getBytes:&prg_rom];
		if (prg_banks < 2) {
			[[prg_rom_banks objectAtIndex:0] getBytes:&prg_rom[PRG_BANK_SIZE]];
		} else {
			[[prg_rom_banks objectAtIndex:1] getBytes:&prg_rom[PRG_BANK_SIZE]];
		}
		
		romData = [romData subdataWithRange:NSMakeRange(prg_banks*PRG_BANK_SIZE, [romData length]-prg_banks*PRG_BANK_SIZE)];
		
		NSMutableArray *chrBanksTemp = [NSMutableArray array];
		for(int i = 0; i < chr_banks; i++) {
			NSData *chr_bank = [romData subdataWithRange:NSMakeRange(i*CHR_BANK_SIZE, CHR_BANK_SIZE)];
			[chrBanksTemp addObject:chr_bank];
		}
		
		chr_rom_banks = [chrBanksTemp copy];
		
		[[chr_rom_banks objectAtIndex:0] getBytes:&chr_rom];
		
		cpu = [[NES2A03 alloc] initWithController:self];
		for (int i=0; i < 0x800; i++) {
			ram[i] = 0;
		}
		
		reset = TRUE;
	}

	return self;
}

- (unsigned char)readAddress:(unsigned short)address
{
	if (address < 0x2000) {
		address %= 0x800;
		return ram[address];
	} else if (address < 0x4000) {
		address %= 0x08;
		address += 0x2000;
		
	} else if (address < 0x4020) {
		
	} else if (address < 0x6000) {
		
	} else if (address < 0x8000) {
		
	} else {
		address -= 0x8000;
		return prg_rom[address];
	}
}

- (void)main
{
	
	self.cpuAddressBus = cpu.address;
	
	if(cpu.write)
		self.cpuDataBus = cpu.data;
	else
		self.cpuDataBus = [self readAddress:self.cpuAddressBus];
	
	[cpu tick];
}

- (IBAction)startEmulation:(id)sender
{
	
}
- (IBAction)pauseEmulation:(id)sender
{
	
}
- (IBAction)resetEmulation:(id)sender
{
	
}

@end