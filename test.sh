#!/bin/bash
(R CMD INSTALL --build ${SRC_PKG_FILE}.tar.gz > Rout.install && touch .finish) &
while [ ! -f .finish ]
do
  sleep 60
  printf "Still working..."
done

printf "Done"
rm .finish
