#!/bin/bash

LOOK_IN="$1"
shift 1
IGNORE="$*"

if [ -z "$LOOK_IN" ]; then
    LOOK_IN="."
fi

# check that LOOK_IN exists, if not exit
if [ ! -d "$LOOK_IN" ]; then
    exit 0
fi


FOUND=$(find "$LOOK_IN" -type d -maxdepth 1)

dirs=""

for dir in $FOUND; do
    if [ "$dir" = "$LOOK_IN" ]; then
        # continue to next iterable
        continue
    fi

    # replace any leading "./" with nothing
    dir="${dir#"./"}"

    if [ -n "$IGNORE" ]; then
        for ignore in $IGNORE; do
            # check if dir is found within ignore
            case "$dir" in
            *"$ignore"*)
                # continue to next iterable
                continue 2
                ;;
            esac
        done
    fi

    dirs="$dirs $dir"
done

dirs="${dirs%" "}"

echo "$dirs"
