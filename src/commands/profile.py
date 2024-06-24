from os import path
import typer
import pathlib
from rich import print as rich_print
from config import extension_config
import config
from typing_extensions import Annotated

app = typer.Typer()

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
    print(file_path)

    if plugin_enabled:
        file_path.replace(config.PLUGIN_DIR / file_path.name)
    else:
        file_path.replace(config.UNUSED_PLUGIN_DIR / file_path.name)

def get_plugin_path(plugin_name: str | pathlib.Path) -> pathlib.Path | None:
    file_name = pathlib.Path(plugin_name).with_suffix(".rbxm")

    plugin_path = (config.UNUSED_PLUGIN_DIR / file_name)

    if not plugin_path.exists():
        # Search if it was moved the the plugins directory
        plugin_path = config.PLUGIN_DIR / file_name
    
    if not plugin_path.exists():
        return None

    return plugin_path

@app.command()
def list():
    print("Profiles:")

    for name, info in extension_config.profiles.items():
        description = info.get("_desc")

        if description:
            description = f"[bold]# {description}[/bold]"
        else:
            description = ""

        rich_print(name, description)

    print("")

@app.command()
def use(profile_name: Annotated[str, typer.Argument(help="The profile you want to use")]):
    '''
        This moves disabled plugins to {dir}
    '''

    state_all = None

    if profile_name == "all":
        state_all = True
    elif profile_name == "none":
        state_all = False

    if state_all != None:
        for plugin_name in extension_config.plugins.keys():
            path = get_plugin_path(get_plugin_file_name(plugin_name))

            if not path:
                print(plugin_name)
                continue

            move_plugin(path, state_all)

        typer.Exit()
        return

    info = extension_config.profiles.get(profile_name)

    if info == None:
        print(f"Profile '{profile_name}' is not defined")
        typer.Exit(1)
        return
    
    for plugin_name, plugin_enabled in info.items():
        if plugin_name.startswith("_"): # These values aren't plugins, like profile description
            continue

        file_name = pathlib.Path(get_plugin_file_name(plugin_name)).with_suffix(".rbxm")
        plugin_path = get_plugin_path(file_name)

        if plugin_path == None:
            print(f"Plugin '{plugin_name}' was not found locally.")
            typer.Exit()
            return
        
        move_plugin(plugin_path, plugin_enabled)
