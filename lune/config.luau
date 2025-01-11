local serde = require("@lune/serde")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local pathfs = require("@pkg/lune-path")

local CONFIG_DIR: pathfs.Path
local DATA_DIR: pathfs.Path
local DIR_NAME = "rbx-profile"
local CURRENT_DIRECTORY = pathfs.cwd

if process.env["XDG_CONFIG_HOME"] then
	CONFIG_DIR = pathfs.Path.from(`{process.env["XDG_CONFIG_HOME"]}/{DIR_NAME}`)
else
	CONFIG_DIR = pathfs.Path.from(`{process.env["HOME"]}/.config/{DIR_NAME}`)
end

if process.env["XDG_DATA_HOME"] then
	DATA_DIR = pathfs.Path.from(`{process.env["XDG_DATA_HOME"]}/{DIR_NAME}`)
else
	DATA_DIR = pathfs.Path.from(`{process.env["HOME"]}/.local/share/{DIR_NAME}`)
end

local CONFIG_NAME = "profiles.toml"
local DISABLED_PLUGIN_DIR = DATA_DIR:join("disabled-plugins")
local LOCAL_CONFIG = CURRENT_DIRECTORY:join(CONFIG_NAME)
local GLOBAL_CONFIG = CONFIG_DIR:join(CONFIG_NAME)
local PLUGIN_DIR = pathfs.Path.from(`{process.env["HOME"]}/AppData/Local/Roblox/Plugins`)

type ProfileData = {
	config: {
		pluginsFolder: string?,
	},
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
profileData.config = profileData.config or {}

if profileData.config.pluginsFolder then
	PLUGIN_DIR = pathfs.Path.from(profileData.config.pluginsFolder)
end

pathfs.writeDir(DISABLED_PLUGIN_DIR)
pathfs.writeDir(DATA_DIR)
pathfs.writeDir(CONFIG_DIR)

if process.os == "linux" and not profileData.config.pluginsFolder then
	stdio.write(stdio.color("red"))
	stdio.write(
		"On linux, you have to define the plugins folder for studio. With the vinegar flatpak, it should be '/home/$USER/.var/app/org.vinegarhq.Vinegar/data/vinegar/prefixes/studio/drive_c/users/sweet/AppData/Local/Roblox/Plugins/'.\n"
	)

	stdio.write(stdio.color("reset"))
	-- process.exit(1) -- This isn't working??
	error("")
end

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
