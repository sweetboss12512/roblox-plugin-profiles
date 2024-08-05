from cli import app
import commands.cli_main as _
import config

# This sucks
@app.command()
def version():
    print(f"rbx-profile", config.VERSION)

if __name__ == "__main__":
    app()
