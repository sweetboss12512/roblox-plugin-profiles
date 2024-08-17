local serde = require("@lune/serde")
local process = require("@lune/process")

local pathfs = require("@vendor/lune-path")

local CONFIG_DIR: pathfs.Path
local DATA_DIR: pathfs.Path
local DIR_NAME = "rbx-profile"
local CURRENT_DIRECTORY = pathfs.cwd

if process.env["XDG_CONFIG_HOME"] then
	CONFIG_DIR = pathfs.Path.from(`{process.env["XDG_CONFIG_HOME"]}/.config/{DIR_NAME}`)
else
	CONFIG_DIR = pathfs.Path.from(`{process.env["HOME"]}/.config/{DIR_NAME}`)
end

if process.env["XDG_DATA_HOME"] then
	DATA_DIR = pathfs.Path.from(`{process.env["XDG_DATA_HOME"]}/.config/{DIR_NAME}`)
else
	DATA_DIR = pathfs.Path.from(`{process.env["HOME"]}/.local/share/{DIR_NAME}`)
end

local CONFIG_NAME = "profiles.toml"
local DISABLED_PLUGIN_DIR = DATA_DIR:join("disabled-plugins")
local LOCAL_CONFIG = CURRENT_DIRECTORY:join(CONFIG_NAME)
local GLOBAL_CONFIG = CONFIG_DIR:join(CONFIG_NAME)
local PLUGIN_DIR = pathfs.Path.from(`{process.env["HOME"]}/AppData/Local/Roblox/Plugins`)

type ProfileData = {
	plugins: { [string]: string | number },
	profiles: {
		[string]: {
			enabled: { string },
			description: string?,
		},
	},
}

local profileData: ProfileData
local configFile: pathfs.Path

if pathfs.isFile(LOCAL_CONFIG) then
	profileData = serde.decode("toml", pathfs.readFile(LOCAL_CONFIG))
	configFile = LOCAL_CONFIG
else
	profileData = serde.decode("toml", pathfs.readFile(GLOBAL_CONFIG))
	configFile = GLOBAL_CONFIG
end

pathfs.writeDir(DISABLED_PLUGIN_DIR)
pathfs.writeDir(DATA_DIR)
pathfs.writeDir(CONFIG_DIR)

local config = {
	directories = {
		config = CONFIG_DIR,
		disabledPlugins = DISABLED_PLUGIN_DIR,
		enabledPlugins = PLUGIN_DIR,
	},
	profileData = profileData,
	configFile = configFile,
}

return table.freeze(config)
