from cli import app
import commands.install as _
import commands.profile

app.add_typer(commands.profile.app, name="profile")

@app.command()
def help():
    pass

if __name__ == "__main__":
    app()