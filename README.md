# `wasmtime-libfuzzer-corpus`

libFuzzer corpus for our wasmtime fuzz targets.

[Read more about libFuzzer corpora here.](https://www.llvm.org/docs/LibFuzzer.html#corpus)

## Organization

Each fuzz target in `wasmtime/fuzz/fuzz_targets/*` has a corresponding directory
in this repository's root that serves as the corpus for that target. For
example, `wasmtime/fuzz/fuzz_targets/compile.rs`'s corpus is the contents of
`wasmtime-libfuzzer-corpus/compile/*`.

## Minimizing a Fuzz Target's Corpus

To take an existing corpus and shrink it down to its minimal size while
preserving the amount of code that is covered when running the corpus through
its fuzz target, run the `shrink-corpus.sh` script:

```shell
./shrink-corpus.sh ~/path/to/wasmtime my-fuzz-target
```

Where `my-fuzz-target` is the name of the fuzz target whose corpus you'd like to
minimize.
