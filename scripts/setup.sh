#!/bin/bash

CURRENT_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source $CURRENT_SCRIPT_DIR/env.sh
source $SCRIPTS_DIR/util.sh

if [ ! -d "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR"
fi

if [ ! -d "$USERDATA_DIR" ]; then
    mkdir -p "$USERDATA_DIR"
fi

