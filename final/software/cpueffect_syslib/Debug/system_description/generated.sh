#!/bin/sh
#
# generated.sh - shell script fragment - not very useful on its own
#
# Machine generated for a CPU named "cpu_0" as defined in:
# /home/lucaspeng/dclab/final/software/cpueffect_syslib/../../cpueffect.ptf
#
# Generated: 2010-07-20 19:14:59.328

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# This variable indicates where the PTF file for this design is located
ptf=/home/lucaspeng/dclab/final/software/cpueffect_syslib/../../cpueffect.ptf

# This variable indicates whether there is a CPU debug core
nios2_debug_core=yes

# This variable indicates how to connect to the CPU debug core
nios2_instance=0

# This variable indicates the CPU module name
nios2_cpu_name=cpu_0

# Include operating system specific parameters, if they are supplied.

if test -f /home/lucaspeng/altera9.0/nios2eds/components/altera_hal/build/os.sh ; then
   . /home/lucaspeng/altera9.0/nios2eds/components/altera_hal/build/os.sh
fi
