#!/bin/bash
#
# get_mem_info    This shell script gets memory information from a linux server
#                 using free.
#
# Created by Wilton (wilton.p.silva@vivo.com.br)
#
# Version 0.2 - Fri Aug 25 11:28:28 BRT 2011
# Control by lockfile created by Wilton Paulo (wilton.p.silva@vivo.com.br)
# Version 0.1 - Fri Aug 19 15:45:28 BRT 2011
# First release.
#
#
MCONNECT="/usr/bin/mcacheconnect"
SERVER=`hostname` 
FREE=`which free`
GREP=`which grep`
EXPR=`which expr`
COUNT=1
LOCKFILE="/tmp/get_mem_info.lock"

if [ -f $LOCKFILE ]; then
  echo "Script $0 is already running (lockfile exists)"
  exit 1
else
  touch $LOCKFILE

  for LINE in `${FREE}`
  do 
  #  echo $COUNT $LINE
    case "$COUNT" in
      8)
        echo -n "mem_total:$LINE "
  	$MCONNECT -c set -s $SERVER -k mem_total -n $LINE
        ;;
      16)
        echo -n "mem_used:$LINE "
  	$MCONNECT -c set -s $SERVER -k mem_used -n $LINE
        ;;
      10)
        echo -n "mem_free:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_free -n $LINE
        ;;
      11)
        echo -n "mem_shared:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_shared -n $LINE
        ;;
      12)
        echo -n "mem_buffers:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_buffer -n $LINE
        ;;
      13)
        echo -n "mem_cached:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_cached -n $LINE
        ;;
      19)
        echo -n "mem_swap_total:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_swap_total -n $LINE
        ;;
      20)
        echo -n "mem_swap_used:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_swap_used -n $LINE
        ;;
      21)
        echo -n "mem_swap_free:$LINE "
	$MCONNECT -c set -s $SERVER -k mem_swap_free -n $LINE
        ;;
    esac
    COUNT=`$EXPR ${COUNT} + 1`
  done
  rm -f $LOCKFILE # Removes LockFile
  exit 0
fi
exit 0
