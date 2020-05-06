#!/bin/bash

CLEAR_LINE_STR="                                                               "

stopped=false
last_period_time=0
full_work_time=0
start_date=`date +%s`

while true; do
    if [[ $stopped = false ]]; then
        last_period_time=$((`date +%s` - $start_date))
        echo -ne "$CLEAR_LINE_STR\r$(date -u --date @$(($full_work_time + $last_period_time)) +%H:%M:%S)\r"
    fi

    read -t 0.25 -N 1 key
    case $key in
        # s for stop
        "s")
            if [[ $stopped = false ]]; then
                stopped=true
                full_work_time=$(($full_work_time + $last_period_time))
            fi
            ;;
        # r for restore
        "r")
            if [[ $stopped = true ]]; then
                stopped=false
                start_date=`date +%s`
            fi
            ;;
        # r for quit
        "q")
            echo -ne "And your time is $(date -u --date @$(($full_work_time + $last_period_time)) +%H:%M:%S)\n"
            exit 0
            ;;
        *)
            ;;
    esac
done