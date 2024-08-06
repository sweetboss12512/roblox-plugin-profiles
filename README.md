# Roblox Plugin Profiles
Enable/disable plugins based on a "profile", the plugins are installed locally
Roblox Studio place will have to close for the plugins

## Installation
The releases or something

## Build from source
```bash
git clone https://github.com/sweetboss12512/roblox-plugin-profiles.git rbx-plugin-profiles
cd rbx-plugin-profiles
./build.sh
```
The executable will be in dist/rbx-profile.exe

Example profiles in `~/.config/rbx-profiles/profiles.toml`
```toml
[plugins]
jolemtools = 7555657789
mbtools = 6724254977
mbreflect = 11973409942
rojo = "RojoManagedPlugin"

[profiles.default]
enabled = [
    "rojo"
]

[profiles.wos]
description = "Waste of space model building"
enabled = [
    "mbtools",
    "mbreflect",
]

[profiles.ss]
description = "Scarlet skies building"
enabled = [
    "jolemtools"
]
```
XDG variables will be used if they are set

To install plugins provided in the file, use `rbx-profile install`

To switch to a profile such as `wos`, use `rbx-profile use wos`

To enable all managed plugins, use `rbx-profile use all`

To disable all managed plugins, use `rbx-profile use none`

`rbx-profile list` will list all your profiles and their descriptions if provided

`rbx-profile all/none` will enable/disable all plugins`

Disabled plugins are stored in `~/.local/share/rbx-profile/disabled-plugins`

I'd like a better solution than what I made since I don't really like this...
