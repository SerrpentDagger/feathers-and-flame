#!/bin/bash

if [[ -z "$SCALET" ]]; then
    echo "SCALET is not set!"
    exit 1
fi
mkdir "$SCALET"
