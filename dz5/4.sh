#!/bin/bash

ionice -c 1 dd if=/dev/urandom of=test1.img bs=1M count=20 &
ionice -c 3 dd if=/dev/urandom of=test2.img bs=1M count=20 &

wait
