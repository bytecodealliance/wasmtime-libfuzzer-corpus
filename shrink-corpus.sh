#!/usr/bin/env bash

# USAGE:
#
#     ./shrink-corpus.sh <wasmtime> <target>
#
# Where `<wasmtime>` is a path to a local checkout of the `wasmtime` repository,
# and `<target>` is the fuzz target whose corpus you want to shink,
# e.g. "compile" or "instantiate_translated".

set -eux

cd "$(dirname $0)"

THIS_REPO=$(pwd)
WASMTIME=$1
TARGET=$2

cd "$WASMTIME"

OLD_CORPUS="$THIS_REPO/$TARGET"
NEW_CORPUS=$(mktemp -d -t "new.$TARGET.corpus.XXXXXX")
BACKUP_CORPUS=$(mktemp -u -t "backup.$TARGET.corpus.XXXXXX")

cargo fuzz run "$TARGET" "$OLD_CORPUS" \
      --release --debug-assertions \
      -- -merge=1 -shrink=1 "$NEW_CORPUS"

mv "$OLD_CORPUS" "$BACKUP_CORPUS"
mv "$NEW_CORPUS" "$OLD_CORPUS"
