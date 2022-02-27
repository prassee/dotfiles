#!/bin/bash

BAT=$(cat /sys/class/power_supply/BAT0/capacity)
CHR=$(cat /sys/class/power_supply/BAT0/status| cut -c 1-5 | tr a-z A-Z)

# Full and short texts
echo "$BAT-$CHR"
echo "$BAT-$CHR"

# Set urgent flag for <= 5% or use orange for <= 15%
[ ${BAT?} -le 5 ] && exit 33
[ ${BAT?} -le 15 ] && echo "#FF8000"
[ ${BAT?} -ge 30 ] && echo "#B3DAFF"
[ ${BAT?} -ge 96 ] && echo "#11FF99"

exit 0
