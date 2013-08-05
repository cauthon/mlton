#!/bin/bash
for i in "$@"; do
    case $i in 
        basic|basic2|simple) TARGET="$TARGET $i";;
        *) ARGS="$ARGS $i"
    esac
done
srcdir=$(dirname $0)
MLton="$srcdir/../build/bin/mlton"
ARGS="$ARGS -codegen c "
for i in $TARGET; do
    case $i in 
        basic|basic2) $MLton $ARGS $srcdir/${i}.mlb $srcdir/${i}.c;;
        simple) $MLtom $ARGS $srcdir/${i}.mlb
    esac
done
