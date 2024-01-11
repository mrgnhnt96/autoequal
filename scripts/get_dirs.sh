#!/bin/bash

LOOK_IN="$1"
shift 1
IGNORE="$*"

if [ -z "$LOOK_IN" ]; then
    LOOK_IN="."
fi

FOUND=$(find "$LOOK_IN" -type d -maxdepth 1)

dirs=""

for dir in $FOUND; do
    if [ "$dir" = "$LOOK_IN" ]; then
        # continue to next iterable
        continue
    fi
    dir="${dir#"${dir%%[!./]*}"}"

    if [ -n "$IGNORE" ]; then
        for ignore in $IGNORE; do
            # check if dir is found within ignore
            if [[ "$dir" == *"$ignore"* ]]; then
                # continue to next iterable
                continue 2
            fi

        done
    fi

    dirs="$dirs $dir"
done

dirs="${dirs%" "}"

echo "$dirs"
