#!/bin/sh

# This flash script dynamically generates a file with a set of commands which
# have to be handed to the flashing script of SEGGER (JLinkExe >4.84).
# After that, JLinkExe will be executed with that set of commands to flash the
# latest .bin file to the board.

# @author Hauke Petersen <hauke.petersen@fu-berlin.de>

BINDIR=$1
BINFILE=$2
FLASHADDR=200000

# setup JLink command file
echo "speed 4000kHz" > $BINDIR/burn.seg
echo "SelectInterface JTAG" >> $BINDIR/burn.seg
echo "jtagconf -1,-1" >> $BINDIR/burn.seg
echo "loadbin $BINFILE $FLASHADDR" >> $BINDIR/burn.seg
echo "r" >> $BINDIR/burn.seg
echo "g" >> $BINDIR/burn.seg
echo "exit" >> $BINDIR/burn.seg

# flash new binary to the board
JLinkExe -device CC2538SF53 < $BINDIR/burn.seg
echo ""
