#!/bin/bash

ARGS=$@

export TERM="xterm"

function timecmd()
{
  local BRWN=$'\e[0;33m'
  local YE=$'\e[1;33m'
  local NC=$'\e[0m'
  local START=$( date +%s%N )
  "$@"
  local END=$( date +%s%N )
  local DELTA=$( expr substr $( echo "( $END - $START )/1000000000" | bc -l ) 1 8 )
  echo -e "\n${BRWN}🕛 Compilation time: ${YE}$DELTA s${NC}"
}

# Check if ccache should be used (controlled by USE_CCACHE environment variable)
if [ "$USE_CCACHE" = "1" ] || [ "$USE_CCACHE" = "true" ]; then
  echo "Using ccache for compilation (USE_CCACHE=1)..."
  
  # Set ccache environment variables
  export CCACHE_PATH="$PATH"
  export CCACHE_DIR=/src/.ccache
  
  # Clear ccache stats before compilation
  ccache -z > /dev/null 2>&1
  
  # Run make with timing
  timecmd nice -n19 make \
    CC='ccache powerpc-eabi-gcc' \
    CXX='ccache powerpc-eabi-g++' \
    -C/src $ARGS
  
  # Display ccache statistics
  echo
  echo -e " ────────────"
  echo -e " CCACHE STATS"
  echo -e " ────────────"
  ccache -s | sed '1,3d'
else
  echo "Using standard compilation (USE_CCACHE=0)..."
  
  # Run make with timing (no ccache)
  timecmd nice -n19 make \
    -C/src $ARGS
fi 