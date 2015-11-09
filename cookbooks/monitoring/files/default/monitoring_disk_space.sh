#!/bin/bash
CURRENT=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
THRESHOLD=90

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
  mailer -s='Disk Space Alert' -m='Your root partition remaining free space is critically low.'
fi
