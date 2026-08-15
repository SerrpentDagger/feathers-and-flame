#!/bin/bash

pkill -x 'noctalia'
sleep 0.5
nohup noctalia >/dev/null 2>&1 &
