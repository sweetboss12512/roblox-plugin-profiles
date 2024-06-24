from cli import app
import commands.install as _

@app.command()
def help():
    pass

if __name__ == "__main__":
    app()
