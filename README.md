This repository was created to demonstrate a "bug" in cargo/rustc where
even though the crate is built with RUSTFLAGS="-Z embed-bitcode" when doing
debug build then the external dependencies aren't built with bitcode.
When doing a release build, the bitcode is generated for the external dependencies.

You can run `./build.sh` to see the behaviour for a debug build, and `./build.sh --release`
to see the behaviour for a release build.

For example, when using `./build.sh` then one of the external crates, rand_core doesn't
get bitcode generated:
```
rand_core-62a2687e69fa8d38.rand_core.drr5nit3-cgu.0.rcgu.o DOES NOT have bitcode
rand_core-62a2687e69fa8d38.rand_core.drr5nit3-cgu.1.rcgu.o DOES NOT have bitcode
rand_core-62a2687e69fa8d38.rand_core.drr5nit3-cgu.10.rcgu.o DOES NOT have bitcode
rand_core-62a2687e69fa8d38.rand_core.drr5nit3-cgu.11.rcgu.o DOES NOT have bitcode
...
```
and when using `./build.sh --release` then rand_core does get bitcode generated:
```
rand_core-ccf0db453757c52c.rand_core.dms6o7sm-cgu.0.rcgu.o has bitcode
rand_core-ccf0db453757c52c.rand_core.dms6o7sm-cgu.1.rcgu.o has bitcode
rand_core-ccf0db453757c52c.rand_core.dms6o7sm-cgu.2.rcgu.o has bitcode
rand_core-ccf0db453757c52c.rand_core.dms6o7sm-cgu.3.rcgu.o has bitcode
```

The above was observed when using `rustc 1.41.0-nightly (412f43ac5 2019-11-24)`

I do realize that the "standard" libraries that come bundled with rust don't have
bitcode present, but I would normally be using a toolchain that has those compiled
with bitcode embedded. I see the exact same behaviour when using such a toolchain.