local stdio = require("@lune/stdio")

local Log = require("@vendor/log")
local config = require("@src/config")
local util = require("./util")

return function(arguments: util.ParsedArguments)
	local stateAll = nil
	local profileName: "all" | "none" | string = arguments.arguments[1]

	if profileName == "all" then
		stateAll = true
	elseif profileName == "none" then
		stateAll = false
	end

	local profile = config.profileData.profiles[profileName]

	if not profile and stateAll == nil then
		Log.Error(`Invalid profile '{profileName}'`)
		return
	end

	local enabledPlugins = {}
	local disabledPlugins = {}

	for pluginName in config.profileData.plugins do
		local pluginEnabled: boolean

		if stateAll ~= nil then
			pluginEnabled = stateAll
		else
			pluginEnabled = table.find((profile :: any).enabled, pluginName) ~= nil
		end

		local success, message = util.setPluginEnabled(pluginName, pluginEnabled)

		if not success then
			Log.Error(message :: any)
			continue
		end

		if pluginEnabled then
			table.insert(enabledPlugins, pluginName)
		else
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
