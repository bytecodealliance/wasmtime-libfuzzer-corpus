# `wasmtime-libfuzzer-corpus`

libFuzzer corpus for our wasmtime fuzz targets.

[Read more about libFuzzer corpora here.](https://www.llvm.org/docs/LibFuzzer.html#corpus)

## Organization

Each fuzz target in `wasmtime/fuzz/fuzz_targets/*` has a corresponding directory
in this repository's root that serves as the corpus for that target. For
example, `wasmtime/fuzz/fuzz_targets/compile.rs`'s corpus is the contents of
`wasmtime-libfuzzer-corpus/compile/*`.

## Minimizing a Fuzz Target's Corpus

```shell
# In the wasmtime repository.
cd ~/path/to/wasmtime

# Create a new directory for the target's minimized corpus.
mkdir /tmp/my_new_corpus

# Populate the new corpus with a minimal-but-coverage-preserving
# set of inputs based on the old corpus.
cargo fuzz run my_fuzz_target \
    ~/path/to/wasmtime-libfuzzer-corpus/my_fuzz_target \
    -- -merge=1 -shrink=1 /tmp/my_new_corpus

# Move the target's old corpus aside.
mv ~/path/to/wasmtime-libfuzzer-corpus/my_fuzz_target /tmp/my_fuzz_target_backup

# Replace the old corpus with the new, minimal one.
mv /tmp/my_new_corpus ~/path/to/wasmtime-libfuzzer-corpus/my_fuzz_target

# Commit the new, minimized corpus.
cd ~/path/to/wasmtime-libfuzzer-corpus
git add my_fuzz_target
```
