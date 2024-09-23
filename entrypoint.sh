#!/bin/sh
while [ 1 ]
do
   waitTime=$(shuf -i 1-5 -n 1)
   sleep $waitTime &
   wait $!
   instruction=$(shuf -i 0-4 -n 1)
   d=`date +%Y-%m-%dT%H:%M:%S`
   case "$instruction" in
      "1") echo "{\"timestamp\": \"$d\", \"level\": \"ERROR\", \"hostname\": \"$HOSTNAME\", \"message\": \"something happened in this execution.\"}"
      ;;
      "2") echo "{\"timestamp\": \"$d\", \"level\": \"ERROR\", \"hostname\": \"$HOSTNAME\", \"message\": \"takes the value and converts it to string.\"}"
      ;;
      "3") echo "{\"timestamp\": \"$d\", \"level\": \"ERROR\", \"hostname\": \"$HOSTNAME\", \"message\": \"variable not in use.\"}"
      ;;
      "4") echo "{\"timestamp\": \"$d\", \"level\": \"ERROR\", \"hostname\": \"$HOSTNAME\", \"message\": \"first loop completed.\"}"
      ;;
   esac
done
