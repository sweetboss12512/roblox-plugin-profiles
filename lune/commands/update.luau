local stdio = require("@lune/stdio")
local net = require("@lune/net")

local util = require("./util")
local config = require("@src/config")
local Log = require("@vendor/log")
local pathfs = require("@vendor/lune-path")

local function updatePlugin(pluginName: string, forceUpdate: boolean)
	local assetId = config.profileData.plugins[pluginName]
	local filePath = util.getPluginFilePath(pluginName)

	if typeof(assetId) ~= "number" then
		Log.Error(`{pluginName} has an invalid assetId`)
		return
	end

	if not filePath then
		print(`{pluginName} [{stdio.color("red")}Not Found{stdio.color("reset")}]`)
		return
	end

	local response = net.request({
		url = `https://assetdelivery.roblox.com/v1/asset/?id={assetId}`,
		method = "GET",
	})

	if not response.ok then
		print(`- {pluginName} [{stdio.color("red")}Request Failed{stdio.color("reset")}]`)
		return
	end

	if response.body == pathfs.readFile(filePath) and not forceUpdate then
		print(`- {pluginName} [{stdio.color("yellow")}Up To Date{stdio.color("reset")}]`)
		return
	end

	local outputPath = pathfs.Path.from(`{config.directories.disabledPlugins}/{pluginName}.rbxm`)
	pathfs.writeFile(outputPath, response.body)
	print(`- {pluginName} [{stdio.color("green")}Updated{stdio.color("reset")}]`)
end

return function(arguments: util.ParsedArguments)
	local updateAll = arguments.options.all or arguments.options.a
	local forceUpdate = arguments.options.force or arguments.options.f

	if #arguments.arguments == 0 and not updateAll then
		print("No plugins to update specified")
		return
	end

	local plugins: { string }

	if updateAll then
		plugins = {}
		for k in pairs(config.profileData.plugins) do
			table.insert(plugins, k)
		end
	else
		plugins = arguments.arguments
	end

	for _, pluginName in ipairs(plugins) do
		updatePlugin(pluginName, forceUpdate)
	end
end
