#!/bin/bash

export LOGGING_LAYOUT_TEXT_ENABLED=false
export LOGGING_LAYOUT_JSON_ENABLED=false
if [ "$LOGGING_LAYOUT" = "TEXT" ]; then
	export LOGGING_LAYOUT_TEXT_ENABLED=true
else
	export LOGGING_LAYOUT_JSON_ENABLED=true
fi

bin_path=$(dirname "$0")
$bin_path/standalone.sh $@
