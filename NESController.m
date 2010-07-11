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

#import "NESController.h"
#define INES_HEADER_SIZE 0x10
#define PRG_BANK_SIZE 0x4000
#define CHR_BANK_SIZE 0x2000
#define INES_IDENTIFIER 0x4e45531a

#define BASE_CLOCK 315.0/88.0*6.0
#define PPU_CLOCK BASE_CLOCK/4.0
#define CPU_CLOCK BASE_CLOCK/12.0
#define CPU_PPU_DIVIDER 3

#define PPU_CYCLE_LENGTH 1/PPU_CLOCK
#define CPU_CYCLE_LENGTH 1/CPU_CLOCK

@implementation NESController

@synthesize cpuAddressBus, cpuDataBus, reset;

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
		ppu = [[NES2C02 alloc] initWithController:self];
		
		cpu_queue = dispatch_queue_create("com.mesosynoptic.CoCoNES.cpu_queue", NULL);
		ppu_queue = dispatch_queue_create("com.mesosynoptic.CoCoNES.ppu_queue", NULL);
		
		
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
	
	dispatch_group_t tick_group = dispatch_group_create();
	
	while (TRUE) {
		
		if ([self isCancelled]) {
			break;
		}
		
		self.cpuAddressBus = cpu.address;
		if (cpu.write) {
			self.cpuDataBus = cpu.data;
		} else {
			self.cpuDataBus = [self readAddress:self.cpuAddressBus];
		}
		
		dispatch_group_async(tick_group, cpu_queue, ^{
			[cpu tick];
		});
		
		dispatch_group_async(tick_group, ppu_queue, ^{
			[ppu tick];
			[ppu tick];
			[ppu tick];
		});
		
		dispatch_group_wait(tick_group, DISPATCH_TIME_FOREVER);
	
	}
	
	dispatch_release(tick_group);
	
}

- (IBAction)startEmulation:(id)sender
{
	[self start];
}
- (IBAction)pauseEmulation:(id)sender
{
	[self cancel];
}
- (IBAction)resetEmulation:(id)sender
{
	self.reset = TRUE;
}

- (void)dealloc
{
	dispatch_release(cpu_queue);
	dispatch_release(ppu_queue);
	[super dealloc];
}

@end
