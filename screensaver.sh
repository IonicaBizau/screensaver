#!/bin/bash


########
# Help #
########
if [[ $1 = "--help" ]] ; then
    echo "screensaver --help"
    echo "usage: screensaver [options] idle-time"
    echo ""
    echo "Lightweight screensaver for Ubuntu"
    echo ""
    echo "options:"
    echo "  --v, --version          print the version"
    echo "  --help                  print this output"
    echo ""
    echo "idle-time"
    echo "  The time in milliseconds when the computer is considered to be idle."
    echo ""
    echo "Documentation can be found at https://github.com/IonicaBizau/screensaver"
    exit
fi

idle=false
idleAfter=5000
brightnessValue=`xbacklight -get`

while true; do
  idleTimeMillis=$(./getIdle)
  if [[ $idleTimeMillis -gt $idleAfter && $idle = false  ]] ; then
    kill "$fadeInPID"
    brightnessValue=`xbacklight -get`
    xbacklight -set 0  -time 4000 -steps 500 &
    fadeOutPID=$!
    idle=true
  fi

  if [[ $idleTimeMillis -lt $idleAfter && $idle = true ]] ; then
    kill "$fadeOutPID"
    echo "Fade in to $brightnessValue"
    xbacklight -set $brightnessValue -time 300  -steps 100 &
    fadeInPID=$!
    idle=false
  fi
  sleep 0.1
done
