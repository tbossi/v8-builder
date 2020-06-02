# V8 Builder
### An automatic [V8 engine](https://v8.dev) builder via Github Actions

Despite the documentation provided by the developers, compiling V8 is complicated and heavy. V8 repository is huge and the time required for downloading and compiling is quite a lot.
This repository leverages Github Actions to obtain the library binaries for the various platforms in humanly acceptable time.

The main purposes are:
- Ability to compile for all platforms supported by V8
- Compilation in short times
- Generation of V8 documentation
- Ease to keep up to date with future versions of V8

For these reasons, V8 is compiled as is, without patches or changes of any kind.
