#!/bin/bash

export LOGGING_LAYOUT_TEXT_LEVEL="OFF"
export LOGGING_LAYOUT_JSON_LEVEL="OFF"
if [ "$LOGGING_LAYOUT" = "TEXT" ]; then
	export LOGGING_LAYOUT_TEXT_LEVEL="ALL"
else
	export LOGGING_LAYOUT_JSON_LEVEL="ALL"
fi

bin_path=$(dirname "$0")
$bin_path/standalone.sh $@
