import typer
import pathlib
from rich import print as rich_print
from config import extension_config
import config
from util import get_plugin_path, get_plugin_file_name
from typing_extensions import Annotated

app = typer.Typer()

def move_plugin(file_path: pathlib.Path, plugin_enabled: bool):
    if plugin_enabled:
        file_path.replace(config.PLUGIN_DIR / file_path.name)
    else:
        file_path.replace(config.UNUSED_PLUGIN_DIR / file_path.name)

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
