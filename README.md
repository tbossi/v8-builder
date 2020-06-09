# V8 Builder
#### An automatic [V8 engine](https://v8.dev) builder via [Github Actions](https://github.com/features/actions)

![Get latest V8 stable version](https://github.com/tbossi/v8-builder/workflows/Get%20latest%20V8%20stable%20version/badge.svg?branch=master)
![Build V8](https://github.com/tbossi/v8-builder/workflows/Build%20V8/badge.svg?branch=master)

## Why an automatic builder?
Despite extensive research on the web, I have not found anyone who provides the V8 binaries already compiled for the various platforms (at least not recent versions).

Moreover, despite the documentation provided by the developers, compiling V8 is complicated and heavy. V8 repository is huge and the time required for downloading and compiling is quite a lot.
This repository leverages Github Actions to obtain the library binaries for the various platforms in humanly acceptable time.

The **main purposes** are:
- Ability to compile for all platforms supported by V8
- Compilation in short times
- Generation of V8 documentation
- Ease to keep up to date with future versions of V8
- Automatically rebuild when new versions are pushed to V8 official repo

## Is this production ready?
Not yet.

Although the workflows structure is now almost correct and compilation takes place for all platforms, I have not yet checked that the generated binaries are all correct and fully functional.

So, **use at your own risk**.

## Building info
**V8 is compiled as is**, without patches or changes of any kind.
The version used to compile is the most recent stable shown at https://omahaproxy.appspot.com (as described [here](https://v8.dev/docs/source-code#source-code-branches)). Checking for updates is done every 12 hours.

V8 binaries are built for the following platforms:
- Linux (x64)
- Android (x86, x86-64, arm v7, arm v8)
- macOS (x64)
- Windows (x64)

Headers and documentation are included!

## Releases
See [release](https://github.com/tbossi/v8-builder/releases) for available versions to download.
