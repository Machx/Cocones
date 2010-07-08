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

#import "NES2A03.h"
#define RESET_VECTOR 0xfffc
#define IRQ_VECTOR 0xfffe
#define NMI_VECTOR 0xfffa


@implementation NES2A03
@synthesize controller;

- (id) initWithController: (NESController *)nescontroller
{
	self = [super init];
	if (self != nil) {
		
		self.controller = nescontroller;
		
		// initializing the opcode dispatch table
		
		for(int i = 0; i < 256; i++) {
			opcode[i] = NULL;
		}
		
		opcode[0x00] = opcode_00;
		opcode[0x01] = opcode_01;
		opcode[0x05] = opcode_05;
		opcode[0x06] = opcode_06;
		opcode[0x08] = opcode_08;
		opcode[0x09] = opcode_09;
		opcode[0x0a] = opcode_0a;
		opcode[0x0d] = opcode_0d;
		opcode[0x0e] = opcode_0e;
		opcode[0x10] = opcode_10;
		opcode[0x11] = opcode_11;
		opcode[0x15] = opcode_15;
		opcode[0x16] = opcode_16;
		opcode[0x18] = opcode_18;
		opcode[0x19] = opcode_19;
		opcode[0x1d] = opcode_1d;
		opcode[0x1e] = opcode_1e;
		opcode[0x20] = opcode_20;
		opcode[0x21] = opcode_21;
		opcode[0x24] = opcode_24;
		opcode[0x25] = opcode_25;
		opcode[0x26] = opcode_26;
		opcode[0x28] = opcode_28;
		opcode[0x29] = opcode_29;
		opcode[0x2a] = opcode_2a;
		opcode[0x2c] = opcode_2c;
		opcode[0x2d] = opcode_2d;
		opcode[0x2e] = opcode_2e;
		opcode[0x30] = opcode_30;
		opcode[0x31] = opcode_31;
		opcode[0x35] = opcode_35;
		opcode[0x36] = opcode_36;
		opcode[0x38] = opcode_38;
		opcode[0x39] = opcode_39;
		opcode[0x3d] = opcode_3d;
		opcode[0x3e] = opcode_3e;
		opcode[0x40] = opcode_40;
		opcode[0x41] = opcode_41;
		opcode[0x45] = opcode_45;
		opcode[0x46] = opcode_46;
		opcode[0x48] = opcode_48;
		opcode[0x49] = opcode_49;
		opcode[0x4a] = opcode_4a;
		opcode[0x4c] = opcode_4c;
		opcode[0x4d] = opcode_4d;
		opcode[0x4e] = opcode_4e;
		opcode[0x50] = opcode_50;
		opcode[0x51] = opcode_51;
		opcode[0x55] = opcode_55;
		opcode[0x56] = opcode_56;
		opcode[0x58] = opcode_58;
		opcode[0x59] = opcode_59;
		opcode[0x5d] = opcode_5d;
		opcode[0x5e] = opcode_5e;
		opcode[0x60] = opcode_60;
		opcode[0x61] = opcode_61;
		opcode[0x65] = opcode_65;
		opcode[0x66] = opcode_66;
		opcode[0x68] = opcode_68;
		opcode[0x69] = opcode_69;
		opcode[0x6a] = opcode_6a;
		opcode[0x6c] = opcode_6c;
		opcode[0x6d] = opcode_6d;
		opcode[0x6e] = opcode_6e;
		opcode[0x70] = opcode_70;
		opcode[0x71] = opcode_71;
		opcode[0x75] = opcode_75;
		opcode[0x76] = opcode_76;
		opcode[0x78] = opcode_78;
		opcode[0x79] = opcode_79;
		opcode[0x7d] = opcode_7d;
		opcode[0x7e] = opcode_7e;
		opcode[0x81] = opcode_81;
		opcode[0x84] = opcode_84;
		opcode[0x85] = opcode_85;
		opcode[0x86] = opcode_86;
		opcode[0x88] = opcode_88;
		opcode[0x8a] = opcode_8a;
		opcode[0x8c] = opcode_8c;
		opcode[0x8d] = opcode_8d;
		opcode[0x8e] = opcode_8e;
		opcode[0x90] = opcode_90;
		opcode[0x91] = opcode_91;
		opcode[0x94] = opcode_94;
		opcode[0x95] = opcode_95;
		opcode[0x96] = opcode_96;
		opcode[0x98] = opcode_98;
		opcode[0x99] = opcode_99;
		opcode[0x9a] = opcode_9a;
		opcode[0x9d] = opcode_9d;
		opcode[0xa0] = opcode_a0;
		opcode[0xa1] = opcode_a1;
		opcode[0xa2] = opcode_a2;
		opcode[0xa4] = opcode_a4;
		opcode[0xa5] = opcode_a5;
		opcode[0xa6] = opcode_a6;
		opcode[0xa8] = opcode_a8;
		opcode[0xa9] = opcode_a9;
		opcode[0xaa] = opcode_aa;
		opcode[0xac] = opcode_ac;
		opcode[0xad] = opcode_ad;
		opcode[0xae] = opcode_ae;
		opcode[0xb0] = opcode_b0;
		opcode[0xb1] = opcode_b1;
		opcode[0xb4] = opcode_b4;
		opcode[0xb5] = opcode_b5;
		opcode[0xb6] = opcode_b6;
		opcode[0xb8] = opcode_b8;
		opcode[0xb9] = opcode_b9;
		opcode[0xba] = opcode_ba;
		opcode[0xbc] = opcode_bc;
		opcode[0xbd] = opcode_bd;
		opcode[0xbe] = opcode_be;
		opcode[0xc0] = opcode_c0;
		opcode[0xc1] = opcode_c1;
		opcode[0xc4] = opcode_c4;
		opcode[0xc5] = opcode_c5;
		opcode[0xc6] = opcode_c6;
		opcode[0xc8] = opcode_c8;
		opcode[0xc9] = opcode_c9;
		opcode[0xca] = opcode_ca;
		opcode[0xcc] = opcode_cc;
		opcode[0xcd] = opcode_cd;
		opcode[0xce] = opcode_ce;
		opcode[0xd0] = opcode_d0;
		opcode[0xd1] = opcode_d1;
		opcode[0xd5] = opcode_d5;
		opcode[0xd6] = opcode_d6;
		opcode[0xd8] = opcode_d8;
		opcode[0xd9] = opcode_d9;
		opcode[0xdd] = opcode_dd;
		opcode[0xde] = opcode_de;
		opcode[0xe0] = opcode_e0;
		opcode[0xe1] = opcode_e1;
		opcode[0xe4] = opcode_e4;
		opcode[0xe5] = opcode_e5;
		opcode[0xe6] = opcode_e6;
		opcode[0xe8] = opcode_e8;
		opcode[0xe9] = opcode_e9;
		opcode[0xea] = opcode_ea;
		opcode[0xec] = opcode_ec;
		opcode[0xed] = opcode_ed;
		opcode[0xee] = opcode_ee;
		opcode[0xf0] = opcode_f0;
		opcode[0xf1] = opcode_f1;
		opcode[0xf5] = opcode_f5;
		opcode[0xf6] = opcode_f6;
		opcode[0xf8] = opcode_f8;
		opcode[0xf9] = opcode_f9;
		opcode[0xfd] = opcode_fd;
		opcode[0xfe] = opcode_fe;
		
		
		// starting up the CPU (setting initial values)
		
		cpu_data.pcl = [controller readAddress:RESET_VECTOR];
		cpu_data.pch = [controller readAddress:RESET_VECTOR + 1];
				
		cpu_data.a = 0x0;
		cpu_data.x = 0x0;
		cpu_data.y = 0x0;
		cpu_data.sp = 0xFF;
		cpu_data.reset = false;
		cpu_data.write = false;
		cpu_data.irq = false;
		cpu_data.nmi = false;
		
		cpu_data.ic = 0;
		
		cpu_data.c = false;
		cpu_data.z = false;
		cpu_data.i = false;
		cpu_data.d = false;
		cpu_data.b = false;
		cpu_data.v = false;
		cpu_data.n = false;
		
		pc_to_adr(&cpu_data);
		cpu_data.opcode = 0;
		
	}
	
	
	return self;
}

- (void)tick
{
	if (!cpu_data.write)
		cpu_data.data = controller.cpuDataBus;
	else
		cpu_data.write = FALSE;
	
	if(cpu_data.ic == 0)
	{
		cpu_data.opcode = cpu_data.data;
		cpu_data.ic = 1;
		increment_pc(&cpu_data);
		pc_to_adr(&cpu_data);
	} else {
		opcode[cpu_data.opcode](&cpu_data);
	}
	
}

- (unsigned short)address
{
	return cpu_data.adl | (cpu_data.adh << 8);
}

- (unsigned char)data
{
	return cpu_data.data;
}

- (bool)write
{
	return cpu_data.write;
}

@end

void start_opcode(cpudata *cpu) {
	cpu->opcode = cpu->data;
	cpu->ic = 1;
	increment_pc(cpu);
	pc_to_adr(cpu);
}

unsigned char encode_p(cpudata *cpu)
{
	return (cpu->n << 7) | (cpu->v << 6) | (1 << 5) | (cpu->b << 4) | (cpu->d << 3) | (cpu->i << 2) | (cpu->z << 1) | cpu->c;

}

void increment_pc(cpudata *cpu) {
	if(cpu->pcl == 0xff) {
		cpu->pcl = 0x00;
		cpu->pch++;
	} else {
		cpu->pcl++;
	}
}

unsigned short get_pc(cpudata *cpu) {
	return (cpu->pch << 8) | cpu->pcl;
}

void pc_to_adr(cpudata *cpu) {
	cpu->adl = cpu->pcl;
	cpu->adh = cpu->pch;
}

void stack_to_adr(cpudata *cpu) {
	cpu->adh = 0x01;
	cpu->adl = cpu->sp;
}

void set_adr(cpudata *cpu, unsigned short vector)
{
	cpu->adl = vector & 0xFF;
	cpu->adh = vector >> 8;
}

void increment_adr(cpudata *cpu)
{
	if(cpu->adl == 0xFF) {
		cpu->adl = 0x00;
		cpu->adh++;
	} else {
		cpu->adl++;
	}
}

void increment_adl_only(cpudata *cpu)
{
	if(cpu->adl == 0xFF)
		cpu->adl = 0x00;
	else
		cpu->adl++;
}

unsigned char add_low(unsigned short op1, unsigned short op2)
{
	return (op1 + op2) % 0x100;
}


void opcode_00(cpudata *cpu) { //BRK
	switch (cpu->ic) {
		case 1:
			increment_pc(cpu);
			stack_to_adr(cpu);
			cpu->write = TRUE;
			cpu->data = cpu->pch;
			cpu->sp--;
			cpu->ic++;
			break;
		case 2:
			stack_to_adr(cpu);
			cpu->write = TRUE;
			cpu->data = cpu->pcl;
			cpu->sp--;
			cpu->ic++;
			break;
		case 3:
			stack_to_adr(cpu);
			cpu->write = TRUE;
			cpu->data = encode_p(cpu);
			cpu->sp--;
			cpu->ic++;
			break;
		case 4:
			set_adr(cpu, IRQ_VECTOR);
			cpu->ic++;
			break;
		case 5:
			cpu->pcl = cpu->data;
			set_adr(cpu, IRQ_VECTOR + 1);
			cpu->ic++;
			break;
		case 6:
			cpu->pch = cpu->data;
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 7:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}

void opcode_01(cpudata *cpu) { // ORA (Indirect,X)
	switch (cpu->ic) {
		case 1:
			cpu->ir = cpu->data;
			set_adr(cpu, cpu->ir);
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 2:
			set_adr(cpu, add_low(cpu->ir, cpu->x));
			cpu->ic++;
			break;
		case 3:
			increment_adl_only(cpu);
			cpu->ir = cpu->data;
			cpu->ic++;
			break;
		case 4:
			cpu->adl = cpu->ir;
			cpu->adh = cpu->data;
			cpu->ic++;
			break;
		case 5:
			ora(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 6:
			start_opcode(cpu);
			break;
		default:
			break;
	}
} 

void opcode_05(cpudata *cpu) { // ORA (ZP)
	switch (cpu->ic) {
		case 1:
			set_adr(cpu, cpu->data);
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 2:
			ora(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 3:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}

void opcode_06(cpudata *cpu) { // ASL (ZP)
	switch(cpu->ic) {
		case 1:
			set_adr(cpu, cpu->data);
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 2:
			cpu->ir = cpu->data;
			cpu->write = TRUE;
			cpu->ic++;
			break;
		case 3:
			cpu->write = TRUE;
			asl(cpu);
			cpu->data = cpu->ir;
			cpu->ic++;
			break;
		case 4:
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 5:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}

void opcode_08(cpudata *cpu) { // PHP
	switch (cpu->ic) {
		case 1:
			cpu->write = TRUE;
			stack_to_adr(cpu);
			cpu->sp--;
			cpu->data = encode_p(cpu);
			cpu->ic++;
			break;
		case 2:
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 3:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}
void opcode_09(cpudata *cpu) {  // ORA (Immediate)
	switch (cpu->ic) {
		case 1:
			increment_pc(cpu);
			pc_to_adr(cpu);
			ora(cpu);
			cpu->ic++;
			break;
		case 2:
			start_opcode(cpu);
			break;
		default:
			break;
	}
	
}
void opcode_0a(cpudata *cpu) { // ASL (Accumulator)
	switch (cpu->ic) {
		case 1:
			cpu->ir = cpu->a;
			pc_to_adr(cpu);
			asl(cpu);
			cpu->a = cpu->ir;
			cpu->ic++;
			break;
		case 2:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}
void opcode_0d(cpudata *cpu) { // ORA (Absolute)
	switch (cpu->ic) {
		case 1:
			cpu->ir = cpu->data;
			increment_pc(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 2:
			increment_pc(cpu);
			cpu->adl = cpu->ir;
			cpu->adh = cpu->data;
			cpu->ic++;
			break;
		case 3:
			ora(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 4:
			start_opcode(cpu);
			break;
		default:
			break;
	}
} 
void opcode_0e(cpudata *cpu) { // ASL (Absolute)
	switch (cpu->ic) {
		case 1:
			cpu->ir = cpu->data;
			increment_pc(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 2:
			cpu->adl = cpu->ir;
			cpu->adh = cpu->data;
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 3:
			cpu->write = TRUE;
			cpu->ir = cpu->data;
			cpu->ic++;
			break;
		case 4:
			cpu->write = TRUE;
			asl(cpu);
			cpu->data = cpu->ir;
			cpu->ic++;
			break;
		case 5:
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 6:
			start_opcode(cpu);
			break;
		default:
			break;
	}
	
}

void opcode_10(cpudata *cpu) { // BPL
	switch (cpu->ic) {
		case 1:
			increment_pc(cpu);
			cpu->ir = cpu->data;
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 2:
			if(cpu->n) {
				start_opcode(cpu);
			} else {
				if (cpu->pcl + cpu->ir > 0x100) 
					cpu->page_crossing = TRUE;
				
				cpu->pcl = (cpu->pcl + cpu->ir) % 0x100;
				pc_to_adr(cpu);
				cpu->ic++;
			}
			break;
		case 3:
			if(cpu->page_crossing) {
				cpu->page_crossing = FALSE;
				cpu->pch++;
				pc_to_adr(cpu);
				cpu->ic++;
			} else {
				start_opcode(cpu);
			}
			break;
		case 4:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}
void opcode_11(cpudata *cpu) { // ORA (Indirect,Y)
	switch (cpu->ic) {
		case 1:
			set_adr(cpu,cpu->data);
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 2:
			cpu->ir = cpu->data;
			increment_adl_only(cpu);
			cpu->ic++;
			break;
		case 3:
			if(cpu->ir + cpu->y > 0x100)
				cpu->page_crossing = TRUE;
			cpu->adl = add_low(cpu->ir, cpu->y);
			cpu->adh = cpu->data;
			cpu->ic++;
			break;
		case 4:
			if(cpu->page_crossing == TRUE) {
				cpu->adh++;
			} else {
				ora(cpu);
				pc_to_adr(cpu);
			}
			cpu->ic++;
			break;
		case 5:
			if(cpu->page_crossing == TRUE) {
				ora(cpu);
				pc_to_adr(cpu);
				cpu->ic++;
			} else {
				start_opcode(cpu);
			}
			break;
		case 6:
			start_opcode(cpu);
			break;
		default:
			break;
	}
} 
void opcode_15(cpudata *cpu) { // ORA (ZP,X)
	switch (cpu->ic) {
		case 1:
			set_adr(cpu, cpu->data);
			increment_pc(cpu);
			cpu->ic++;
			break;
		case 2:
			set_adr(cpu,add_low(cpu->adl, cpu->x));
			cpu->ic++;
			break;
		case 3:
			ora(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 4:
			start_opcode(cpu);
			break;
		default:
			break;
	}
}
void opcode_16(cpudata *cpu) { // ASL (ZP,X)
	switch (cpu->ic) {
		case 1:
			
			break;
		default:
			break;
	}
} // ASL (ZP,X)
  // 17 undefined
void opcode_18(cpudata *cpu) {
	
} // CLC
void opcode_19(cpudata *cpu) {
	
} // ORA (Absolute,Y)
  // 1a-1c undefined
void opcode_1d(cpudata *cpu) {
	
} // ORA (Absolute,X)
void opcode_1e(cpudata *cpu) {
	
} // ASL (Absolute,X)
  // 1f undefined
void opcode_20(cpudata *cpu) {
	
} // JSR
void opcode_21(cpudata *cpu) {
	
} // AND (Indirect,X)
  // 22-23 undefined
void opcode_24(cpudata *cpu) {
	
} // BIT (ZP)
void opcode_25(cpudata *cpu) {
	
} // AND (ZP)
void opcode_26(cpudata *cpu) {
	
} // ROL (ZP)
  // 27 undefined
void opcode_28(cpudata *cpu) {
	
} // PLP
void opcode_29(cpudata *cpu) {
	
} // AND (Immediate)
void opcode_2a(cpudata *cpu) {
	
} // ROL (Accumulator)
  // 2b undefined
void opcode_2c(cpudata *cpu) {
	
} // BIT (Absolute)
void opcode_2d(cpudata *cpu) {
	
} // AND (Absolute)
void opcode_2e(cpudata *cpu) {
	
} // ROL (Absolute)
  // 2f undefined
void opcode_30(cpudata *cpu) {
	
} // BMI
void opcode_31(cpudata *cpu) {
	
} // AND (Indirect,Y)
  // 32-34 undefined
void opcode_35(cpudata *cpu) {
	
} // AND (ZP,X)
void opcode_36(cpudata *cpu) {
	
} // ROL (ZP,X)
  // 37 undefined
void opcode_38(cpudata *cpu) {
	
} // SEC
void opcode_39(cpudata *cpu) {
	
} // AND (Absolute,Y)
  // 3a-3c undefined
void opcode_3d(cpudata *cpu) {
	
} // AND (Absolute,X)
void opcode_3e(cpudata *cpu) {
	
} // ROL (Absolute,X)
  // 3f undefined
void opcode_40(cpudata *cpu) {
	
} // RTI
void opcode_41(cpudata *cpu) {
	
} // EOR (Indirect,X)
  // 42-44 undefined
void opcode_45(cpudata *cpu) {
	
} // EOR (ZP)
void opcode_46(cpudata *cpu) {
	
} // LSR (ZP)
  // 47 undefined
void opcode_48(cpudata *cpu) {
	
} // PHA
void opcode_49(cpudata *cpu) {
	
} // EOR (Immediate)
void opcode_4a(cpudata *cpu) {
	
} // LSR (Accumulator)
  // 4b undefined
void opcode_4c(cpudata *cpu) {
	
} // JMP (Absolute)
void opcode_4d(cpudata *cpu) {
	
} // EOR (Absolute)
void opcode_4e(cpudata *cpu) {
	
} // LSR (Absolute)
  // 4f undefined
void opcode_50(cpudata *cpu) {
	
} // BVC
void opcode_51(cpudata *cpu) {
	
} // EOR (Indirect,Y)
  // 52-54 undefined
void opcode_55(cpudata *cpu) {
	
} // EOR (ZP,X)
void opcode_56(cpudata *cpu) {
	
} // LSR (ZP,X)
  // 57 undefined
void opcode_58(cpudata *cpu) {
	
} // CLI
void opcode_59(cpudata *cpu) {
	
} // EOR (Absolute,Y)
  // 5a-5c undefined
void opcode_5d(cpudata *cpu) {
	
} // EOR (Absolute,X)
void opcode_5e(cpudata *cpu) {
	
} // LSR (Absolute,X)
  // 5f undefined
void opcode_60(cpudata *cpu) {
	
} // RTS
void opcode_61(cpudata *cpu) {
	
} // ADC (Indirect,X)
  // 62-64 undefined
void opcode_65(cpudata *cpu) {
	
} // ADC (ZP)
void opcode_66(cpudata *cpu) {
	
} // ROR (ZP)
  // 67 undefined
void opcode_68(cpudata *cpu) {
	
} // PLA
void opcode_69(cpudata *cpu) {
	
} // ADC (Immediate)
void opcode_6a(cpudata *cpu) {
	
} // ROR (Accumulator)
  // 6b undefined
void opcode_6c(cpudata *cpu) {
	
} // JMP (Indirect)
void opcode_6d(cpudata *cpu) {
	
} // ADC (Absolute)
void opcode_6e(cpudata *cpu) {
	
} // ROR (Absolute)
  // 6f undefined
void opcode_70(cpudata *cpu) {
	
} // BVS
void opcode_71(cpudata *cpu) {
	
} // ADC (Indirect,Y) 
  // 72-74 undefined
void opcode_75(cpudata *cpu) {
	
} // ADC (ZP,X)
void opcode_76(cpudata *cpu) {
	
} // ROR (ZP,X)
  // 77 undefined
void opcode_78(cpudata *cpu) { // SEI
	switch (cpu->ic) {
		case 1:
			cpu->ic++;
			break;
		case 2:
			cpu->i = TRUE;
			start_opcode(cpu);
		default:
			break;
	}
} // SEI
void opcode_79(cpudata *cpu) {
	
} // ADC (Absolute,Y)
  // 7a-7c undefined
void opcode_7d(cpudata *cpu) {
	
} // ADC (Absolute,X)
void opcode_7e(cpudata *cpu) {
	
} // ROR (Absolute,X)
  // 7f-80 undefined
void opcode_81(cpudata *cpu) {
	
} // STA (Indirect,X)
  // 82-83 undefined
void opcode_84(cpudata *cpu) {
	
} // STY (ZP)
void opcode_85(cpudata *cpu) {
	
} // STA (ZP)
void opcode_86(cpudata *cpu) {
	
} // STX (ZP)
  // 87 undefined
void opcode_88(cpudata *cpu) {
	
} // DEY
  // 89 undefined
void opcode_8a(cpudata *cpu) {
	
} // TXA
  // 8b undefined
void opcode_8c(cpudata *cpu) {
	
} // STY (Absolute)
void opcode_8d(cpudata *cpu) {

	
} // STA (Absolute)
void opcode_8e(cpudata *cpu) {
	
} // STX (Absolute)
  // 8f undefined
void opcode_90(cpudata *cpu) {
	
} // BCC
void opcode_91(cpudata *cpu) {
	
} // STA (Indirect,Y)
  // 92-93 undefined
void opcode_94(cpudata *cpu) {
	
} // STY (ZP,X)
void opcode_95(cpudata *cpu) {
	
} // STA (ZP,X)
void opcode_96(cpudata *cpu) {
	
} // STX (ZP,X)
  // 97 undefined
void opcode_98(cpudata *cpu) {
	
} // TYA
void opcode_99(cpudata *cpu) {
	
} // STA (Absolute,Y)
void opcode_9a(cpudata *cpu) {
	
} // TXS
  // 9b-9c undefined
void opcode_9d(cpudata *cpu) {
	
} // STA (Absolute,X)
  // 9e-9f undefined
void opcode_a0(cpudata *cpu) {
	
} // LDY (Immediate)
void opcode_a1(cpudata *cpu) {
	
} // LDA (Indirect,X)
void opcode_a2(cpudata *cpu) {
	
} // LDX (Immediate)
  // a3 undefined
void opcode_a4(cpudata *cpu) {
	
} // LDY (ZP)
void opcode_a5(cpudata *cpu) {
	
} // LDA (ZP)
void opcode_a6(cpudata *cpu) {
	
} // LDX (ZP)
  // a7 undefined
void opcode_a8(cpudata *cpu) {
	
} // TAY
void opcode_a9(cpudata *cpu) {
	switch (cpu->ic) {
		case 1:
			cpu->ir = cpu->data;
			increment_pc(cpu);
			pc_to_adr(cpu);
			cpu->ic++;
			break;
		case 2:
			cpu->a = cpu->ir;
			(cpu->ir >> 7 == 1) ? (cpu->n = TRUE) : (cpu->n = FALSE);
			(cpu->ir == 0) ? (cpu->z = TRUE) : (cpu->z = FALSE);
			start_opcode(cpu);
		default:
			break;
	}
} // LDA (Immediate)
void opcode_aa(cpudata *cpu) {
	
} // TAX
  // ab undefined
void opcode_ac(cpudata *cpu) {
	
} // LDY (Absolute)
void opcode_ad(cpudata *cpu) {
	
} // LDA (Absolute)
void opcode_ae(cpudata *cpu) {
	
} // LDX (Absolute)
  // af undefined
void opcode_b0(cpudata *cpu) {
	
} // BCS
void opcode_b1(cpudata *cpu) {
	
} // LDA (Indirect,Y)
  // b2-b3 undefined
void opcode_b4(cpudata *cpu) {
	
} // LDY (ZP,X)
void opcode_b5(cpudata *cpu) {
	
} // LDA (ZP,X)
void opcode_b6(cpudata *cpu) {
	
} // LDX (ZP,Y)
  // b7 undefined
void opcode_b8(cpudata *cpu) {
	
} // CLV
void opcode_b9(cpudata *cpu) {
	
} // LDA (Absolute,Y)
void opcode_ba(cpudata *cpu) {
	
} // TSX
  // bb undefined
void opcode_bc(cpudata *cpu) {
	
} // LDY (Absolute,X)
void opcode_bd(cpudata *cpu) {
	
} // LDA (Absolute,X)
void opcode_be(cpudata *cpu) {
	
} // LDX (Absolute,Y)
  // bf undefined
void opcode_c0(cpudata *cpu) {
	
} // CPY (Immediate)
void opcode_c1(cpudata *cpu) {
	
} // CMP (Indirect,X)
  // c2-c3 undefined
void opcode_c4(cpudata *cpu) {
	
} // CPY (ZP)
void opcode_c5(cpudata *cpu) {
	
} // CMP (ZP)
void opcode_c6(cpudata *cpu) {
	
} // DEC (ZP)
  // c7 undefined
void opcode_c8(cpudata *cpu) {
	
} // INY
void opcode_c9(cpudata *cpu) {
	
} // CMP (Immediate)
void opcode_ca(cpudata *cpu) {
	
} // DEX
  // cb undefined
void opcode_cc(cpudata *cpu) {
	
} // CPY (Absolute)
void opcode_cd(cpudata *cpu) {
	
} // CMP (Absolute)
void opcode_ce(cpudata *cpu) {
	
} // DEC (Absolute)
  // cf undefined
void opcode_d0(cpudata *cpu) {
	
} // BNE
void opcode_d1(cpudata *cpu) {
	
} // CMP (Indirect,Y)
  // d2-d4 undefined
void opcode_d5(cpudata *cpu) {
	
} // CMP (ZP,X)
void opcode_d6(cpudata *cpu) {
	
} // DEC (ZP,X)
  // d7 undefined
void opcode_d8(cpudata *cpu) {
	switch (cpu->ic) {
		case 1:
			cpu->ic++;
			break;
		case 2:
			cpu->d = FALSE;
			start_opcode(cpu);
		default:
			break;
	}
} // CLD
void opcode_d9(cpudata *cpu) {
	
} // CMP (Absolute,Y)
  // da-dc undefined
void opcode_dd(cpudata *cpu) {
	
} // CMP (Absolute,X)
void opcode_de(cpudata *cpu) {
	
} // DEC (Absolute,X)
  // df undefined
void opcode_e0(cpudata *cpu) {
	
} // CPX (Immediate)
void opcode_e1(cpudata *cpu) {
	
} // SBC (Indirect,X)
  // e2-e3 undefined
void opcode_e4(cpudata *cpu) {
	
} // CPX (ZP)
void opcode_e5(cpudata *cpu) {
	
} // SBC (ZP)
void opcode_e6(cpudata *cpu) {
	
} // INC (ZP)
  // e7 undefined
void opcode_e8(cpudata *cpu) {
	
} // INX
void opcode_e9(cpudata *cpu) {
	
} // SBC (Immediate)
void opcode_ea(cpudata *cpu) {
	
} // NOP
  // eb undefined
void opcode_ec(cpudata *cpu) {
	
} // CPX - Absolute
void opcode_ed(cpudata *cpu) {
	
} // SBC - Absolute
void opcode_ee(cpudata *cpu) {
	
} // INC - Absolute
  // ef undefined
void opcode_f0(cpudata *cpu) {
	
} // BEQ
void opcode_f1(cpudata *cpu) {
	
} // SBC (Indirect,Y)
  // f2-f4 undefined
void opcode_f5(cpudata *cpu) {
	
} // SBC (ZP,X)
void opcode_f6(cpudata *cpu) {
	
} // INC (ZP,X)
  // f7 undefined
void opcode_f8(cpudata *cpu) {
	
} // SED
void opcode_f9(cpudata *cpu) {
	
} // SBC (Absolute,Y)
  // fa-fc undefined
void opcode_fd(cpudata *cpu) {
	
} // SBC (Absolute,X)
void opcode_fe(cpudata *cpu) {
	
} // INC (Absolute,X)
  // ff undefined

void ora(cpudata *cpu) {
	cpu->a = cpu->a | cpu->data;
	(cpu->a >> 7 == 1) ? (cpu->n = TRUE) : (cpu->n = FALSE);
	(cpu->a == 0) ? (cpu->z = TRUE) : (cpu->z = FALSE);
}

void asl(cpudata *cpu) {
	cpu->c = cpu->ir >> 7;
	cpu->ir = (cpu->ir << 1) & 0xfe;
	(cpu->ir >> 7 == 1) ? (cpu->n = TRUE) : (cpu->n = FALSE);
	(cpu->ir == 0) ? (cpu->z = TRUE) : (cpu->z = FALSE);
}