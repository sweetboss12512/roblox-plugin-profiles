if [ ! -d .venv ]; then
  python -m venv .venv
  pip install -r requirements.txt
fi

source .venv/Scripts/activate
pyinstaller -F src/main.py -p .venv/Lib/site-packages/