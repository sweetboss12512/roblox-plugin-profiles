local stdio = require("@lune/stdio")

local Log = require("@vendor/log")
local config = require("@src/config")
local util = require("./util")

return function(profileName)
	local profile = config.profileData.profiles[profileName]

	if not profile then
		Log.Error(`Invalid profile '{profileName}'`)
	end

	local enabledPlugins = {}
	local disabledPlugins = {}

	for pluginName in config.profileData.plugins do
		local pluginEnabled = table.find(profile.enabled, pluginName) ~= nil
		local success, message = util.setPluginEnabled(pluginName, pluginEnabled)

		if not success then
			Log.Error(message :: any)
			continue
		end

		if pluginEnabled then
			-- print(`Enabled plugin '{pluginName}'`)
			table.insert(enabledPlugins, pluginName)
		else
			-- print(`Disabled plugin '{pluginName}'`)
			table.insert(disabledPlugins, pluginName)
		end
	end

	print("\nEnabled Plugins:")
	stdio.write(stdio.color("green"))
	for _, name in enabledPlugins do
		stdio.write(`- {name}\n`)
	end
	stdio.write(stdio.color("reset"))

	print("\nDisabled Plugins:")
	stdio.write(stdio.color("red"))
	for _, name in disabledPlugins do
		stdio.write(`- {name}\n`)
	end
	stdio.write(stdio.color("reset"))
end
