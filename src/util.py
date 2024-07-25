import config, pathlib
from config import extension_config

def get_plugin_path(plugin_name: str | pathlib.Path) -> pathlib.Path | None:
    file_name = pathlib.Path(plugin_name)

    if file_name.suffix == "":
        file_name = file_name.with_suffix(".rbxm")

    plugin_path = config.UNUSED_PLUGIN_DIR / file_name

    if not plugin_path.exists():
        # Search if it was moved the the plugins directory
        plugin_path = config.PLUGIN_DIR / file_name
    
    if not plugin_path.exists():
        return None

    return plugin_path

def get_plugin_file_name(plugin_name: str) -> str:
    '''
        This **NEEDS** a better name.
        The assetID can be a string which is the name of the file...
        This checks that and returns the file name if it's a string
    '''
    value = extension_config.plugins[plugin_name]
    if type(value) == str:
        return value
    else:
        return plugin_name

def move_plugin(file_path: pathlib.Path, plugin_enabled: bool):
    if plugin_enabled:
        file_path.replace(config.PLUGIN_DIR / file_path.name)
    else:
        file_path.replace(config.UNUSED_PLUGIN_DIR / file_path.name)


