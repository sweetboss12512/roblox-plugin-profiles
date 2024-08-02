from cli import app
import commands.cli_main as _

@app.command()
def help():
    pass

if __name__ == "__main__":
    app()
