#!/usr/bin/env bash

mkdir -p build
rm build/**

darklua process lune/rbx-profile.luau build/out.luau

lune build build/out.luau -o build/rbx-profile.exe
