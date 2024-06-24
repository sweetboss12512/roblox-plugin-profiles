# Roblox Plugin Profiles
Enable/disable plugins based on a "profile", the plugins are installed locally
Roblox Studio place will have to close for the plugins

Example profile in `~/.config/rbx-profiles/profiles.toml`
```toml
[plugins]
jolemtools = 7555657789
mbtools = 6724254977
mbreflect = 11973409942
rojo = "RojoManagedPlugin" # The name of the file. This allows you to manage these plugins if they weren't installed from the asset ID. It assumes it's an rbxm

[profiles.default]
_desc = "Just silly things"
rojo = true
jolemtools = false
mbtools = false
mbreflect = false

[profiles.wos]
_desc = "Waste of space model building"
mbtools = true
jolemtools = false
rojo = false
mbreflect = true

[profiles.ss]
_desc = "Scarlet skies building"
rojo = false
mbtools = false
mbreflect = false
jolemtools = true
```

To install plugins provided in the file, use `rbx-profile install`

To switch to a profile such as `wos`, use `rbx-profile profile use wos` ~~why is it so long~~

`rbx-profile list` will list all your profiles and their descriptions if provided

`rbx-profile all/none` will enable/disable all plugins`

Disabled plugins are stored in `~/.local/share/rbx-profile/disabled-plugins`

I'd like a better solution than what I made since I don't really like this...
