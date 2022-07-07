# `wasmtime-libfuzzer-corpus`

libFuzzer corpus for our wasmtime fuzz targets.

[Read more about libFuzzer corpora here.](https://www.llvm.org/docs/LibFuzzer.html#corpus)

As the documentation says, "LibFuzzer will work without any initial seeds, but
will be less efficient if the library under test accepts complex, structured
inputs."

However, most wasmtime fuzz targets actually accept entirely unstructured input,
and use the `arbitrary` crate to transform raw bytes into valid structure. Those
targets don't get any value from having a preset corpus here; they're better off
letting libFuzzer explore code paths from scratch.

So only those fuzz targets which take structured input, such as raw wasm
binaries, should have a corpus committed here.

## Usage

See `fuzz/README.md` in the wasmtime repo for instructions.

## Organization

Each fuzz target in `wasmtime/fuzz/fuzz_targets/*` can have a corresponding
directory in this repository's root that serves as the corpus for that target.
For example, `wasmtime/fuzz/fuzz_targets/compile.rs`'s corpus is the contents of
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
