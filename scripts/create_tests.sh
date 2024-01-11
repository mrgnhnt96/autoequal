#!/bin/bash

ROOT=$(realpath "$(dirname "$0")"/..)
cd "$ROOT" || exit 1

generateFiles() {
    BASE=$1
    GEN_DIR=$2
    IS_TEST=$3
    shift 3

    ARRAY=("$@")

    REPLACEMENTS=("${ARRAY[@]:${#ARRAY[@]}/2}")
    LOCATIONS=("${ARRAY[@]:0:${#ARRAY[@]}/2}")

    # remove old files
    rm -rf "$GEN_DIR"
    mkdir -p "$GEN_DIR"

    FILES=$(find "$BASE" -type f -name '*.dart')

    # copy files to GEN_DIR
    for file in $FILES; do
        FILE_NAME=$(basename "$file")

        if [ "$IS_TEST" = true ]; then
            FILE_NAME="${FILE_NAME%.*}_test.dart"
        fi

        for i in "${!LOCATIONS[@]}"; do
            DIR="${LOCATIONS[$i]}"
            REPLACEMENT="${REPLACEMENTS[$i]}"

            mkdir -p "$GEN_DIR/$DIR"

            GEN_FILE="$GEN_DIR/$DIR/$FILE_NAME"
            echo "$GEN_FILE"

            cp "$file" "$GEN_FILE"

            sed -i'b' "s/{REPLACE}/$REPLACEMENT/g" "$GEN_FILE"
        done

    done

    find "$GEN_DIR" -type f -name '*.dartb' -delete
}

DIRS=('extends' 'mixin')
CLAUSES=('extends Equatable' 'with EquatableMixin')

generateFiles test_project/lib/base test_project/lib/gen false "${DIRS[@]}" "${CLAUSES[@]}"
generateFiles test_project/test/base test_project/test/gen true "${DIRS[@]}" "${DIRS[@]}"
