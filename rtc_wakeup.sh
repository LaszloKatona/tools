#!/bin/bash 
if [ $# -ne 1 ]; then
    echo 1>&2 "$0: missing time argument (e.g. 7:00)"
    exit 2
fi
WAKE_TIME=$1
NOW=$(date "+%s")
WAKE_TOMORROW=$(date "+%s" -d "tomorrow $WAKE_TIME")
WAKE_TODAY=$(date "+%s" -d "$WAKE_TIME")
if [ $NOW -lt $WAKE_TODAY ]
then
    WAKE=$WAKE_TODAY
else
    WAKE=$WAKE_TOMORROW
fi
echo 0 > /sys/class/rtc/rtc0/wakealarm 
echo $WAKE > /sys/class/rtc/rtc0/wakealarm 
echo "RTC wake up time is set to $(date -d @$WAKE)"

