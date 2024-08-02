import pathlib
import requests
import config
from config import extension_config
import typer
from cli import app
from rich import print as rich_print
from typing_extensions import Annotated
from util import get_plugin_file_name, get_plugin_path, move_plugin

def download_plugin(asset_id: int, output_path: pathlib.Path):
    response = requests.get(f"https://assetdelivery.roblox.com/v1/asset/?id={asset_id}")

    if not response.ok:
        raise Exception(f"Failed to download plugin, GOT {response.status_code} {response.text}")

    output_path.write_bytes(response.content)

@app.command()
def install():
    for plugin_name, asset_id in extension_config.plugins.items():
        plugin_name = get_plugin_file_name(plugin_name)
        output_path = config.UNUSED_PLUGIN_DIR / f"{plugin_name}.rbxm"

        if get_plugin_path(plugin_name) != None:
            print(f"Plugin '{plugin_name}' is already installed")
        elif type(asset_id) == int:
            print(f"Installing plugin '{plugin_name}'")
            download_plugin(asset_id, output_path)
            print(f"'{plugin_name}' successfully installed")

@app.command()
def managed():
    for plugin_name in extension_config.plugins.keys():
        plugin_name = get_plugin_file_name(plugin_name)

        print(f"{plugin_name}: {get_plugin_path(plugin_name) or 'Not Found'}")

@app.command()
def use(profile_name: Annotated[str, typer.Argument(help="The profile you want to use")]):
    '''
        This moves disabled plugins to $XDG_DATA_HOME(~/.config)/rbx-profile/disabled-plugins
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
