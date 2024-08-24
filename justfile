OUT_FILE := "lune/rbx-profile.luau"
SOURCE_FILE := "lune/main.luau"

default:
    just --list

build-clean:
    rm {{OUT_FILE}}

process:
    darklua process {{SOURCE_FILE}} {{OUT_FILE}}

# I don't know how to get lune to run scripts that aren't in the lune folder.
process-watch: build-clean
    darklua process {{SOURCE_FILE}} {{OUT_FILE}} --watch
