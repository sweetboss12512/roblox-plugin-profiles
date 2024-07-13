from dataclasses import dataclass, field
import pathlib
import tomllib
import os

CONFIG_NAME = "profiles.toml"
CURRENT_DIRECTORY = pathlib.Path.cwd()
PLUGIN_DIR = pathlib.Path.home() / r"AppData/Local/Roblox/Plugins"
CONFIG_DIR = pathlib.Path(
    os.environ.get("XDG_CONFIG_HOME") or pathlib.Path.home() / ".config/rbx-profile"
)
DATA_DIR = pathlib.Path(
    os.environ.get("XDG_DATA_HOME") or pathlib.Path.home() / ".local/share/rbx-profile"
)
UNUSED_PLUGIN_DIR = (
    DATA_DIR / "disabled-plugins"
)  # This is where 'disabled' plugins are put.
GLOBAL_CONFIG = pathlib.Path(CONFIG_DIR / CONFIG_NAME)
LOCAL_CONFIG = CURRENT_DIRECTORY / CONFIG_NAME


@dataclass
class _Config:
    plugins: dict[str, int | str] = field()
    profiles: dict[str, dict[str, bool]] = field()


_config_dict: dict

if LOCAL_CONFIG.is_file():
    print("Using local config, ", LOCAL_CONFIG)
    _config_dict = tomllib.loads(LOCAL_CONFIG.read_text())
elif GLOBAL_CONFIG.is_file():
    print("Using global config", GLOBAL_CONFIG)
    _config_dict = tomllib.loads(GLOBAL_CONFIG.read_text())
else:
    print("Using default configuration")
    _config_dict = {"plugins": {}, "profiles": {}}

UNUSED_PLUGIN_DIR.mkdir(parents=True, exist_ok=True)
DATA_DIR.mkdir(parents=True, exist_ok=True)
CONFIG_DIR.mkdir(parents=True, exist_ok=True)
extension_config = _Config(**_config_dict)  # IDK why it's called this...

if __name__ == "__main__":
    from rich import print

    # print(extension_config)
    print(CONFIG_DIR)
    print(DATA_DIR)
