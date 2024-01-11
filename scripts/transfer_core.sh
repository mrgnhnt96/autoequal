#!/bin/bash

ROOT=$(realpath "$(dirname "$0")"/..)
cd "$ROOT" || exit 1

# get files from _core/lib (recursive)
CORE_FILES=$(find _core/lib -type f -name '*.dart')

GEN_DIR=autoequal_gen/lib/gen

# remove old files
rm -rf "$GEN_DIR"
mkdir -p "$GEN_DIR"

for file in $CORE_FILES; do
    FILE_NAME=$(basename "$file")
    echo "$FILE_NAME"
    GEN_FILE="$GEN_DIR/$FILE_NAME"
    cp "$file" "$GEN_FILE"

    # remove all lines that start with '@'
    grep -v '^@' "$GEN_FILE" >tmpfile && mv tmpfile "$GEN_FILE"
    grep -v '^import \x27package' "$GEN_FILE" >tmpfile && mv tmpfile "$GEN_FILE"

done
