#!/bin/bash
R CMD INSTALL --build ${SRC_PKG_FILE}.tar.gz > Rout.install &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  sleep 60
  printf "\b${sp:i++%${#sp}:1}"
done
