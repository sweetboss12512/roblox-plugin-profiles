import pathlib
import requests
import config
from config import extension_config
from cli import app

# ASSET_DELIVERY_URL = "https://assetdelivery.roblox.com/v1/asset/?id=6724254977"

def download_extension(asset_id: int, output_path: pathlib.Path):
    response = requests.get(f"https://assetdelivery.roblox.com/v1/asset/?id={asset_id}")
    output_path.write_bytes(response.content)

def clean_removed_extension():
    pass

@app.command()
def install():
    for plugin_name, asset_id in extension_config.plugins.items():
        output_path = config.UNUSED_PLUGIN_DIR / f"{plugin_name}.rbxm"

        if output_path.exists():
            print(f"Plugin '{plugin_name}' is already installed")
        else:
            print(f"Installing plugin '{plugin_name}'")
            download_extension(asset_id, output_path)
            print(f"'{plugin_name}' successfully installed")