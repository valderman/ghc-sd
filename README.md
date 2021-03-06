## What?
Dockerfile for building a GHC package for Debian/Ubuntu which supports
statically linking Haskell dependencies into dynamic (e.g. `.so`) libraries.

Supported GHC versions:
* 8.6.5

## How?
### If you're on a Debian-based system
Add my Debian repository to your sources, then install the package with `apt`:

```
echo deb https://deb.ekblad.cc/ubuntu disco main | sudo tee /etc/apt/sources.list.d/ekblad-cc-disco
wget -O - https://ekblad.cc/key.asc | sudo apt-key add -
sudo apt update
sudo apt install ghc-sd
```

### Otherwise
Install docker, run `make`, wait. When make is done, you'll find your package
in the `deb` subdirectory.

To build a shared library with all Haskell dependencies statically linked,
use the following GHC flags:
```
-fPIC -shared -optl-Wl,-Bstatic -lHSrts -lCffi -optl-Wl,-Bdynamic -lrt -lpthread
```
Unfortunately, `cabal` has its own ideas about what flags to pass to the linker,
which makes it unable to produce shared libraries with statically linked Haskell
dependencies even when properly setting `ld-options` and/or `ghc-options`.

## Why?
Because it's nice to be able to distribute Haskell .so files without having to
also distribute the roughly seven million `libHSwhatever-x.y.z.so` it ends
up depending on with dynamic linking.

With the right flags, this GHC build produces .so files that are only dependent
on the standard system libraries `libc`, `libm`, `librt` and `libpthread`,
plus `libgmp`.
