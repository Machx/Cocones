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

typedef struct _cpudata {
	
	unsigned char adl;
	unsigned char adh;
	unsigned char data;
	bool reset;
	bool irq;
	bool nmi;
	bool write;
	
	unsigned char a;
	unsigned char x;
	unsigned char y;
	unsigned char sp;
	unsigned char pcl;
	unsigned char pch;
	
	bool c;
	bool z;
	bool i;
	bool d;
	bool b;
	bool v;
	bool n;
	
	bool page_crossing;
	unsigned char opcode;
	unsigned char ic;
	unsigned char ir;
	
} cpudata;

@interface NES2A03 : NSObject {
	
	NESController *controller;
	
	void (*opcode[255])(cpudata*);
	cpudata cpu_data;
	
	unsigned short address;
	unsigned char data;
	bool write;
}

@property(retain) NESController *controller;
@property(readonly) unsigned short address;
@property(readonly) unsigned char data;
@property(readonly) bool write;

- (id)initWithController:(NESController *)controller;
- (void)tick;

@end

void start_opcode(cpudata*);
void increment_pc(cpudata*);
void pc_to_adr(cpudata*);
void set_adr(cpudata*,unsigned short);
void increment_adr(cpudata*);
void increment_adl_only(cpudata*);
unsigned char add_low(unsigned short, unsigned short);
unsigned char encode_p(cpudata*);
unsigned short get_pc(cpudata*);

void opcode_00(cpudata*); // BRK
void opcode_01(cpudata*); // ORA (Indirect,X)
						  // 02-04 undefined
void opcode_05(cpudata*); // ORA (ZP)
void opcode_06(cpudata*); // ASL (ZP)
						  // 07 undefined
void opcode_08(cpudata*); // PHP
void opcode_09(cpudata*); // ORA (Immediate)
void opcode_0a(cpudata*); // ASL (Accumulator)
						  // 0b-0c undefined
void opcode_0d(cpudata*); // ORA (Absolute)
void opcode_0e(cpudata*); // ASL (Absolute)
						  // 0f undefined
void opcode_10(cpudata*); // BPL
void opcode_11(cpudata*); // ORA (Indirect,Y)
						  // 12-14 undefined
void opcode_15(cpudata*); // ORA (ZP,X)
void opcode_16(cpudata*); // ASL (ZP,X)
						  // 17 undefined
void opcode_18(cpudata*); // CLC
void opcode_19(cpudata*); // ORA (Absolute,Y)
						  // 1a-1c undefined
void opcode_1d(cpudata*); // ORA (Absolute,X)
void opcode_1e(cpudata*); // ASL (Absolute,X)
						  // 1f undefined
void opcode_20(cpudata*); // JSR
void opcode_21(cpudata*); // AND (Indirect,X)
						  // 22-23 undefined
void opcode_24(cpudata*); // BIT (ZP)
void opcode_25(cpudata*); // AND (ZP)
void opcode_26(cpudata*); // ROL (ZP)
						  // 27 undefined
void opcode_28(cpudata*); // PLP
void opcode_29(cpudata*); // AND (Immediate)
void opcode_2a(cpudata*); // ROL (Accumulator)
						  // 2b undefined
void opcode_2c(cpudata*); // BIT (Absolute)
void opcode_2d(cpudata*); // AND (Absolute)
void opcode_2e(cpudata*); // ROL (Absolute)
						  // 2f undefined
void opcode_30(cpudata*); // BMI
void opcode_31(cpudata*); // AND (Indirect,Y)
						  // 32-34 undefined
void opcode_35(cpudata*); // AND (ZP,X)
void opcode_36(cpudata*); // ROL (ZP,X)
						  // 37 undefined
void opcode_38(cpudata*); // SEC
void opcode_39(cpudata*); // AND (Absolute,Y)
						  // 3a-3c undefined
void opcode_3d(cpudata*); // AND (Absolute,X)
void opcode_3e(cpudata*); // ROL (Absolute,X)
						  // 3f undefined
void opcode_40(cpudata*); // RTI
void opcode_41(cpudata*); // EOR (Indirect,X)
						  // 42-44 undefined
void opcode_45(cpudata*); // EOR (ZP)
void opcode_46(cpudata*); // LSR (ZP)
						  // 47 undefined
void opcode_48(cpudata*); // PHA
void opcode_49(cpudata*); // EOR (Immediate)
void opcode_4a(cpudata*); // LSR (Accumulator)
						  // 4b undefined
void opcode_4c(cpudata*); // JMP (Absolute)
void opcode_4d(cpudata*); // EOR (Absolute)
void opcode_4e(cpudata*); // LSR (Absolute)
						  // 4f undefined
void opcode_50(cpudata*); // BVC
void opcode_51(cpudata*); // EOR (Indirect,Y)
						  // 52-54 undefined
void opcode_55(cpudata*); // EOR (ZP,X)
void opcode_56(cpudata*); // LSR (ZP,X)
						  // 57 undefined
void opcode_58(cpudata*); // CLI
void opcode_59(cpudata*); // EOR (Absolute,Y)
						  // 5a-5c undefined
void opcode_5d(cpudata*); // EOR (Absolute,X)
void opcode_5e(cpudata*); // LSR (Absolute,X)
						  // 5f undefined
void opcode_60(cpudata*); // RTS
void opcode_61(cpudata*); // ADC (Indirect,X)
						  // 62-64 undefined
void opcode_65(cpudata*); // ADC (ZP)
void opcode_66(cpudata*); // ROR (ZP)
						  // 67 undefined
void opcode_68(cpudata*); // PLA
void opcode_69(cpudata*); // ADC (Immediate)
void opcode_6a(cpudata*); // ROR (Accumulator)
						  // 6b undefined
void opcode_6c(cpudata*); // JMP (Indirect)
void opcode_6d(cpudata*); // ADC (Absolute)
void opcode_6e(cpudata*); // ROR (Absolute)
						  // 6f undefined
void opcode_70(cpudata*); // BVS
void opcode_71(cpudata*); // ADC (Indirect,Y) 
						  // 72-74 undefined
void opcode_75(cpudata*); // ADC (ZP,X)
void opcode_76(cpudata*); // ROR (ZP,X)
						  // 77 undefined
void opcode_78(cpudata*); // SEI
void opcode_79(cpudata*); // ADC (Absolute,Y)
						  // 7a-7c undefined
void opcode_7d(cpudata*); // ADC (Absolute,X)
void opcode_7e(cpudata*); // ROR (Absolute,X)
						  // 7f-80 undefined
void opcode_81(cpudata*); // STA (Indirect,X)
						  // 82-83 undefined
void opcode_84(cpudata*); // STY (ZP)
void opcode_85(cpudata*); // STA (ZP)
void opcode_86(cpudata*); // STX (ZP)
						  // 87 undefined
void opcode_88(cpudata*); // DEY
						  // 89 undefined
void opcode_8a(cpudata*); // TXA
						  // 8b undefined
void opcode_8c(cpudata*); // STY (Absolute)
void opcode_8d(cpudata*); // STA (Absolute)
void opcode_8e(cpudata*); // STX (Absolute)
						  // 8f undefined
void opcode_90(cpudata*); // BCC
void opcode_91(cpudata*); // STA (Indirect,Y)
						  // 92-93 undefined
void opcode_94(cpudata*); // STY (ZP,X)
void opcode_95(cpudata*); // STA (ZP,X)
void opcode_96(cpudata*); // STX (ZP,X)
						  // 97 undefined
void opcode_98(cpudata*); // TYA
void opcode_99(cpudata*); // STA (Absolute,Y)
void opcode_9a(cpudata*); // TXS
						  // 9b-9c undefined
void opcode_9d(cpudata*); // STA (Absolute,X)
						  // 9e-9f undefined
void opcode_a0(cpudata*); // LDY (Immediate)
void opcode_a1(cpudata*); // LDA (Indirect,X)
void opcode_a2(cpudata*); // LDX (Immediate)
						  // a3 undefined
void opcode_a4(cpudata*); // LDY (ZP)
void opcode_a5(cpudata*); // LDA (ZP)
void opcode_a6(cpudata*); // LDX (ZP)
						  // a7 undefined
void opcode_a8(cpudata*); // TAY
void opcode_a9(cpudata*); // LDA (Immediate)
void opcode_aa(cpudata*); // TAX
						  // ab undefined
void opcode_ac(cpudata*); // LDY (Absolute)
void opcode_ad(cpudata*); // LDA (Absolute)
void opcode_ae(cpudata*); // LDX (Absolute)
						  // af undefined
void opcode_b0(cpudata*); // BCS
void opcode_b1(cpudata*); // LDA (Indirect,Y)
						  // b2-b3 undefined
void opcode_b4(cpudata*); // LDY (ZP,X)
void opcode_b5(cpudata*); // LDA (ZP,X)
void opcode_b6(cpudata*); // LDX (ZP,Y)
						  // b7 undefined
void opcode_b8(cpudata*); // CLV
void opcode_b9(cpudata*); // LDA (Absolute,Y)
void opcode_ba(cpudata*); // TSX
						  // bb undefined
void opcode_bc(cpudata*); // LDY (Absolute,X)
void opcode_bd(cpudata*); // LDA (Absolute,X)
void opcode_be(cpudata*); // LDX (Absolute,Y)
						  // bf undefined
void opcode_c0(cpudata*); // CPY (Immediate)
void opcode_c1(cpudata*); // CMP (Indirect,X)
						  // c2-c3 undefined
void opcode_c4(cpudata*); // CPY (ZP)
void opcode_c5(cpudata*); // CMP (ZP)
void opcode_c6(cpudata*); // DEC (ZP)
						  // c7 undefined
void opcode_c8(cpudata*); // INY
void opcode_c9(cpudata*); // CMP (Immediate)
void opcode_ca(cpudata*); // DEX
						  // cb undefined
void opcode_cc(cpudata*); // CPY (Absolute)
void opcode_cd(cpudata*); // CMP (Absolute)
void opcode_ce(cpudata*); // DEC (Absolute)
						  // cf undefined
void opcode_d0(cpudata*); // BNE
void opcode_d1(cpudata*); // CMP (Indirect,Y)
						  // d2-d4 undefined
void opcode_d5(cpudata*); // CMP (ZP,X)
void opcode_d6(cpudata*); // DEC (ZP,X)
						  // d7 undefined
void opcode_d8(cpudata*); // CLD
void opcode_d9(cpudata*); // CMP (Absolute,Y)
						  // da-dc undefined
void opcode_dd(cpudata*); // CMP (Absolute,X)
void opcode_de(cpudata*); // DEC (Absolute,X)
						  // df undefined
void opcode_e0(cpudata*); // CPX (Immediate)
void opcode_e1(cpudata*); // SBC (Indirect,X)
						  // e2-e3 undefined
void opcode_e4(cpudata*); // CPX (ZP)
void opcode_e5(cpudata*); // SBC (ZP)
void opcode_e6(cpudata*); // INC (ZP)
						  // e7 undefined
void opcode_e8(cpudata*); // INX
void opcode_e9(cpudata*); // SBC (Immediate)
void opcode_ea(cpudata*); // NOP
						  // eb undefined
void opcode_ec(cpudata*); // CPX - Absolute
void opcode_ed(cpudata*); // SBC - Absolute
void opcode_ee(cpudata*); // INC - Absolute
						  // ef undefined
void opcode_f0(cpudata*); // BEQ
void opcode_f1(cpudata*); // SBC (Indirect,Y)
						  // f2-f4 undefined
void opcode_f5(cpudata*); // SBC (ZP,X)
void opcode_f6(cpudata*); // INC (ZP,X)
						  // f7 undefined
void opcode_f8(cpudata*); // SED
void opcode_f9(cpudata*); // SBC (Absolute,Y)
						  // fa-fc undefined
void opcode_fd(cpudata*); // SBC (Absolute,X)
void opcode_fe(cpudata*); // INC (Absolute,X)
						  // ff undefined

void ora(cpudata*);
void asl(cpudata*);