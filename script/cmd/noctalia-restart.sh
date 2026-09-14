#!/bin/bash

pkill -f 'qs -c noctalia-shell' || true
pkill -x 'noctalia'
sleep 0.5
nohup noctalia >/dev/null 2>&1 &
