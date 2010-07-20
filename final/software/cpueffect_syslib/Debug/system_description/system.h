/* system.h
 *
 * Machine generated for a CPU named "cpu_0" as defined in:
 * /home/lucaspeng/dclab/final/software/cpueffect_syslib/../../cpueffect.ptf
 *
 * Generated: 2010-07-20 19:14:47.738
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "cpueffect"
#define ALT_CPU_NAME "cpu_0"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_STDIN "/dev/null"
#define ALT_STDIN_TYPE ""
#define ALT_STDIN_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDIN_DEV null
#define ALT_STDOUT "/dev/null"
#define ALT_STDOUT_TYPE ""
#define ALT_STDOUT_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDOUT_DEV null
#define ALT_STDERR "/dev/null"
#define ALT_STDERR_TYPE ""
#define ALT_STDERR_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDERR_DEV null
#define ALT_CPU_FREQ 100000000
#define ALT_IRQ_BASE NULL

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x00008020
#define NIOS2_RESET_ADDR 0x00008000
#define NIOS2_BREAK_ADDR 0x00010820

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_PLL
#define __ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO

/*
 * pll_0 configuration
 *
 */

#define PLL_0_NAME "/dev/pll_0"
#define PLL_0_TYPE "altera_avalon_pll"
#define PLL_0_BASE 0x00011000
#define PLL_0_SPAN 32
#define PLL_0_ARESET "None"
#define PLL_0_PFDENA "None"
#define PLL_0_LOCKED "None"
#define PLL_0_PLLENA "None"
#define PLL_0_SCANCLK "None"
#define PLL_0_SCANDATA "None"
#define PLL_0_SCANREAD "None"
#define PLL_0_SCANWRITE "None"
#define PLL_0_SCANCLKENA "None"
#define PLL_0_SCANACLR "None"
#define PLL_0_SCANDATAOUT "None"
#define PLL_0_SCANDONE "None"
#define PLL_0_CONFIGUPDATE "None"
#define PLL_0_PHASECOUNTERSELECT "None"
#define PLL_0_PHASEDONE "None"
#define PLL_0_PHASEUPDOWN "None"
#define PLL_0_PHASESTEP "None"
#define PLL_0_CONFIG_DONE 0
#define ALT_MODULE_CLASS_pll_0 altera_avalon_pll

/*
 * onchip_memory2_0 configuration
 *
 */

#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_BASE 0x00008000
#define ONCHIP_MEMORY2_0_SPAN 20480
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "M4K"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEMORY2_0_WRITEABLE 1
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_SIZE_VALUE 20480
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_USE_SHALLOW_MEM_BLOCKS 0
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_IGNORE_AUTO_BLOCK_TYPE_ASSIGNMENT 1
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2

/*
 * vibrato_on configuration
 *
 */

#define VIBRATO_ON_NAME "/dev/vibrato_on"
#define VIBRATO_ON_TYPE "altera_avalon_pio"
#define VIBRATO_ON_BASE 0x00011020
#define VIBRATO_ON_SPAN 16
#define VIBRATO_ON_DO_TEST_BENCH_WIRING 0
#define VIBRATO_ON_DRIVEN_SIM_VALUE 0
#define VIBRATO_ON_HAS_TRI 0
#define VIBRATO_ON_HAS_OUT 0
#define VIBRATO_ON_HAS_IN 1
#define VIBRATO_ON_CAPTURE 0
#define VIBRATO_ON_DATA_WIDTH 1
#define VIBRATO_ON_RESET_VALUE 0
#define VIBRATO_ON_EDGE_TYPE "NONE"
#define VIBRATO_ON_IRQ_TYPE "NONE"
#define VIBRATO_ON_BIT_CLEARING_EDGE_REGISTER 0
#define VIBRATO_ON_BIT_MODIFYING_OUTPUT_REGISTER 0
#define VIBRATO_ON_FREQ 100000000
#define ALT_MODULE_CLASS_vibrato_on altera_avalon_pio

/*
 * chorus_on configuration
 *
 */

#define CHORUS_ON_NAME "/dev/chorus_on"
#define CHORUS_ON_TYPE "altera_avalon_pio"
#define CHORUS_ON_BASE 0x00011030
#define CHORUS_ON_SPAN 16
#define CHORUS_ON_DO_TEST_BENCH_WIRING 0
#define CHORUS_ON_DRIVEN_SIM_VALUE 0
#define CHORUS_ON_HAS_TRI 0
#define CHORUS_ON_HAS_OUT 0
#define CHORUS_ON_HAS_IN 1
#define CHORUS_ON_CAPTURE 0
#define CHORUS_ON_DATA_WIDTH 1
#define CHORUS_ON_RESET_VALUE 0
#define CHORUS_ON_EDGE_TYPE "NONE"
#define CHORUS_ON_IRQ_TYPE "NONE"
#define CHORUS_ON_BIT_CLEARING_EDGE_REGISTER 0
#define CHORUS_ON_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CHORUS_ON_FREQ 100000000
#define ALT_MODULE_CLASS_chorus_on altera_avalon_pio

/*
 * clk configuration
 *
 */

#define CLK_NAME "/dev/clk"
#define CLK_TYPE "altera_avalon_pio"
#define CLK_BASE 0x00011040
#define CLK_SPAN 16
#define CLK_DO_TEST_BENCH_WIRING 0
#define CLK_DRIVEN_SIM_VALUE 0
#define CLK_HAS_TRI 0
#define CLK_HAS_OUT 0
#define CLK_HAS_IN 1
#define CLK_CAPTURE 0
#define CLK_DATA_WIDTH 1
#define CLK_RESET_VALUE 0
#define CLK_EDGE_TYPE "NONE"
#define CLK_IRQ_TYPE "NONE"
#define CLK_BIT_CLEARING_EDGE_REGISTER 0
#define CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CLK_FREQ 100000000
#define ALT_MODULE_CLASS_clk altera_avalon_pio

/*
 * adclrc configuration
 *
 */

#define ADCLRC_NAME "/dev/adclrc"
#define ADCLRC_TYPE "altera_avalon_pio"
#define ADCLRC_BASE 0x00011050
#define ADCLRC_SPAN 16
#define ADCLRC_DO_TEST_BENCH_WIRING 0
#define ADCLRC_DRIVEN_SIM_VALUE 0
#define ADCLRC_HAS_TRI 0
#define ADCLRC_HAS_OUT 0
#define ADCLRC_HAS_IN 1
#define ADCLRC_CAPTURE 0
#define ADCLRC_DATA_WIDTH 1
#define ADCLRC_RESET_VALUE 0
#define ADCLRC_EDGE_TYPE "NONE"
#define ADCLRC_IRQ_TYPE "NONE"
#define ADCLRC_BIT_CLEARING_EDGE_REGISTER 0
#define ADCLRC_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADCLRC_FREQ 100000000
#define ALT_MODULE_CLASS_adclrc altera_avalon_pio

/*
 * datain configuration
 *
 */

#define DATAIN_NAME "/dev/datain"
#define DATAIN_TYPE "altera_avalon_pio"
#define DATAIN_BASE 0x00011060
#define DATAIN_SPAN 16
#define DATAIN_DO_TEST_BENCH_WIRING 0
#define DATAIN_DRIVEN_SIM_VALUE 0
#define DATAIN_HAS_TRI 0
#define DATAIN_HAS_OUT 0
#define DATAIN_HAS_IN 1
#define DATAIN_CAPTURE 0
#define DATAIN_DATA_WIDTH 16
#define DATAIN_RESET_VALUE 0
#define DATAIN_EDGE_TYPE "NONE"
#define DATAIN_IRQ_TYPE "NONE"
#define DATAIN_BIT_CLEARING_EDGE_REGISTER 0
#define DATAIN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATAIN_FREQ 100000000
#define ALT_MODULE_CLASS_datain altera_avalon_pio

/*
 * dataout configuration
 *
 */

#define DATAOUT_NAME "/dev/dataout"
#define DATAOUT_TYPE "altera_avalon_pio"
#define DATAOUT_BASE 0x00011070
#define DATAOUT_SPAN 16
#define DATAOUT_DO_TEST_BENCH_WIRING 0
#define DATAOUT_DRIVEN_SIM_VALUE 0
#define DATAOUT_HAS_TRI 0
#define DATAOUT_HAS_OUT 1
#define DATAOUT_HAS_IN 0
#define DATAOUT_CAPTURE 0
#define DATAOUT_DATA_WIDTH 16
#define DATAOUT_RESET_VALUE 0
#define DATAOUT_EDGE_TYPE "NONE"
#define DATAOUT_IRQ_TYPE "NONE"
#define DATAOUT_BIT_CLEARING_EDGE_REGISTER 0
#define DATAOUT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATAOUT_FREQ 100000000
#define ALT_MODULE_CLASS_dataout altera_avalon_pio

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       ONCHIP_MEMORY2_0
#define ALT_RODATA_DEVICE     ONCHIP_MEMORY2_0
#define ALT_RWDATA_DEVICE     ONCHIP_MEMORY2_0
#define ALT_EXCEPTIONS_DEVICE ONCHIP_MEMORY2_0
#define ALT_RESET_DEVICE      ONCHIP_MEMORY2_0

/*
 * The text section is initialised so no bootloader will be required.
 * Set a variable to tell crt0.S to provide code at the reset address and
 * to initialise rwdata if appropriate.
 */

#define ALT_NO_BOOTLOADER


#endif /* __SYSTEM_H_ */
