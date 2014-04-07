#!/bin/bash

idle=false
idleAfter=1000
brightnessValue=`xbacklight -get`

while true; do
  idleTimeMillis=$(./getIdle)
  echo $idleTimeMillis
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
