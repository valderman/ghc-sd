## What?
Dockerfile for building a GHC package for Debian/Ubuntu which supports
statically linking Haskell dependencies into dynamic (e.g. `.so`) libraries.

Supported GHC versions:
* 8.6.5

## How?
Install docker, run `make`, wait. When make is done, you'll find your package
in the `deb` subdirectory.

To build a shared library with all Haskell dependencies statically linked,
use the following GHC flags:
```
-fPIC -shared -optl-Wl,-Bstatic -lHSrts -lCffi -optl-Wl,-Bdynamic -lrt -lpthread
```

## Why?
Because it's nice to be able to distribute Haskell .so files without having to
also distribute the roughly seven million `libHSwhatever-x.y.z.so` it ends
up depending on with dynamic linking.

With the right flags, this GHC build produces .so files that are only dependent
on the standard system libraries `libc`, `libm`, `librt` and `libpthread`,
plus `libgmp`.
