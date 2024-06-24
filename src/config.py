from dataclasses import dataclass, field
import pathlib
import tomllib

CONFIG_NAME = "profiles.toml"
CURRENT_DIRECTORY = pathlib.Path.cwd()
LOCAL_CONFIG = pathlib.Path(CURRENT_DIRECTORY / CONFIG_NAME)
PLUGIN_DIR = pathlib.Path.home() / r"AppData/Local/Roblox/Plugins"
UNUSED_PLUGIN_DIR = CURRENT_DIRECTORY / "disabled-plugins"  # This is where 'disabled' plugins are put.

@dataclass
class _Config:
    plugins: dict[str, int] = field()
    profiles: dict[str, dict[str, False]] = field()

config_dict: dict

if LOCAL_CONFIG.is_file():
    _config_dict = tomllib.loads(LOCAL_CONFIG.read_text())
else:
    print("Using default configuration")
    _config_dict = {}

extension_config = _Config(**_config_dict) # IDK why it's called this...

UNUSED_PLUGIN_DIR.mkdir(parents=True, exist_ok=True)

if __name__ == "__main__":
    from rich import print
    print(extension_config)