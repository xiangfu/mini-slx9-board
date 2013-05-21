#!/bin/sh

# Use `git clean -xdf` for clean generate files. include the bits/ folder
#  MAKE SURE you have commit all your new files and change
#  MAKE SURE you run this command in CURRECT folder

source /opt/Xilinx/14.2/ISE_DS/settings64.sh && \
touch *.v && \
FPGA_TARGET=xc6slx9-2-csg324 make && \
touch *.v && \
FPGA_TARGET=xc6slx9-2-ftg256 make && \
touch *.v && \
FPGA_TARGET=xc6slx9-2-tqg144 make && \
touch *.v && \
FPGA_TARGET=xc6slx16-2-ftg256 make blinking.bit
