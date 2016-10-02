#!/bin/bash
#
# get_cpu_info    This shell script gets cpu information from a linux server
#                 using free.
#
SERVER=`hostname`
MCONNECT="/usr/bin/mcacheconnect"
STAT="/proc/stat"
GREP='/bin/grep'
EXPR=`which expr`
COUNT=0
LOCKFILE="/tmp/get_cpu_info.lock"

if [ -f $LOCKFILE ]; then
  echo "Script $0 is already running (lockfile exists)"
  exit 1
else
  touch $LOCKFILE
  for LINE in `vmstat -a 2 5 | tail -1 | awk '{print $1, $2, $9, $10, $11, $12, $13, $14, $15, $16, $17}'`
  do
    case "$COUNT" in
        0)
                echo -n "RunTime:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_RunTime -n $LINE
                ;;
        1)
                echo -n "Uninterruptible:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_Uninterruptible -n $LINE
                ;;
        2)
                echo -n "SwapIn:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_SwapIn -n $LINE
                ;;
        3)
                echo -n "SwapOut:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_SwapOut  -n $LINE
                ;;
        4)
               echo -n "Interrupts:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_Interrupts -n $LINE
                ;;

        5)
               echo -n "ContextSwitches:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_ContextSwitches -n $LINE
                ;;

	6)
                echo -n "User:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_User -n $LINE
                ;;
        7)
                echo -n "System:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_System -n $LINE
                ;;
        8)
                echo -n "Idle:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_Idle -n $LINE
                ;;
        9)
                echo -n "Waiting_IO:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_Waiting_io  -n $LINE
                ;;
        10)
               echo -n "Stollen:$LINE "
                $MCONNECT -c set -s $SERVER -k Cpu_Stollen -n $LINE
                ;;
    esac
    COUNT=`$EXPR ${COUNT} + 1`
  done

  PROCESSES=`$GREP -w processes $STAT | awk '{print $2}'`
  $MCONNECT -c set -s $SERVER -k Cpu_Processes -n $PROCESSES

  PROCS_RUNNING=`$GREP -w procs_running $STAT | awk '{print $2}'`
  $MCONNECT -c set -s $SERVER -k Cpu_Procs_Running -n $PROCS_RUNNING
	
  PROCS_BLOCKED=`$GREP -w procs_blocked $STAT | awk '{print $2}'`
  $MCONNECT -c set -s $SERVER -k Cpu_Procs_Blocked -n $PROCS_BLOCKED

  rm -f $LOCKFILE # Removes LockFile
  exit 0
fi
exit 0
