from dataclasses import dataclass, field
import pathlib
import tomllib
import os

VERSION = "v1.1.1"

_XDG_CONFIG_HOME = os.environ.get("XDG_CONFIG_HOME")
_XDG_DATA_HOME = os.environ.get("XDG_DATA_HOME")

CONFIG_DIR: pathlib.Path
DATA_DIR: pathlib.Path

if _XDG_CONFIG_HOME != None:
    CONFIG_DIR = pathlib.Path(_XDG_CONFIG_HOME) / "rbx-profile"
else:
    CONFIG_DIR = pathlib.Path.home() / ".config/rbx-profile"

if _XDG_DATA_HOME != None:
    DATA_DIR = pathlib.Path(_XDG_DATA_HOME) / "rbx-profile"
else:
    DATA_DIR = pathlib.Path.home() / ".local/share/rbx-profile"

CONFIG_NAME = "profiles.toml"
CURRENT_DIRECTORY = pathlib.Path.cwd()
PLUGIN_DIR = pathlib.Path.home() / r"AppData/Local/Roblox/Plugins"
CONFIG_DIR: pathlib.Path
DATA_DIR: pathlib.Path
UNUSED_PLUGIN_DIR = (
    DATA_DIR / "disabled-plugins"
)  # This is where 'disabled' plugins are put.
GLOBAL_CONFIG = pathlib.Path(CONFIG_DIR / CONFIG_NAME)
LOCAL_CONFIG = CURRENT_DIRECTORY / CONFIG_NAME

@dataclass
class _Config:
    plugins: dict[str, int | str] = field()
    profiles: dict = field()
    config_file: pathlib.Path

_config_dict: dict

if LOCAL_CONFIG.is_file():
    # print("Using local config, ", LOCAL_CONFIG)
    _config_dict = tomllib.loads(LOCAL_CONFIG.read_text())
    _config_dict["config_file"] = LOCAL_CONFIG
elif GLOBAL_CONFIG.is_file():
    # print("Using global config", GLOBAL_CONFIG)
    _config_dict = tomllib.loads(GLOBAL_CONFIG.read_text())
    _config_dict["config_file"] = GLOBAL_CONFIG
else:
    print("Using default configuration")
    _config_dict = {"plugins": {}, "profiles": {}}

UNUSED_PLUGIN_DIR.mkdir(parents=True, exist_ok=True)
DATA_DIR.mkdir(parents=True, exist_ok=True)
CONFIG_DIR.mkdir(parents=True, exist_ok=True)
extension_config = _Config(**_config_dict)  # IDK why it's called this...

if __name__ == "__main__":
    from rich import print

    print(extension_config)
    print(CONFIG_DIR)
    print(DATA_DIR)
