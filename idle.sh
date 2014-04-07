#!/bin/bash

idle=false
idleAfter=3000

while true; do
  idleTimeMillis=$(./getIdle)
  echo $idleTimeMillis
  if [[ $idleTimeMillis -gt $idleAfter && $idle = false  ]] ; then
    echo "start idle"
    kill "$fadeInPID"
    xbacklight -set 0  -time 4000 -steps 500 &
    fadeOutPID=$!
    idle=true
  fi

  if [[ $idleTimeMillis -lt $idleAfter && $idle = true ]] ; then
    echo "end idle"     # same here.
    kill "$fadeOutPID"
    xbacklight -set 70 -time 300  -steps 100 &
    fadeInPID=$!
    idle=false
  fi
  sleep 0.1
done
