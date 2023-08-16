#!/bin/bash

ARGS=$@

export PATH="/usr/lib/colorgcc/:$PATH"
export CCACHE_PATH="/usr/bin"
export CCACHE_DIR=/src/.ccache
export TERM="xterm"

function timecmd()
{
  local BRWN=$'\e[0;33m'
  local YE=$'\e[1;33m'
  local NC=$'\e[0m'
  local START=$( date +%s%N )
  $@
  local END=$( date +%s%N )
  local DELTA=$( expr substr $( echo "( $END - $START )/1000000" | bc -l ) 1 8 )
  echo -e "\n${BRWN}compilation time ${YE}$DELTA ms${NC}"
}

# clear statistics
ccache -z 

# COMPILE!
NICE="nice -n19"
timecmd $NICE make $ARGS -C/src

#show ccache stats
echo
echo -e " ────────────"
echo -e " CCACHE STATS"
echo -e " ────────────"
ccache -s | sed '1,3d'