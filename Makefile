.PHONY: build
build:
	stack build --ghc-options -Lvender/sample-lib --ghc-options -lsample

.PHONY: exec
exec:
	DYLD_LIBRARY_PATH=vender/sample-lib stack exec haskell-ffi-example-exe

