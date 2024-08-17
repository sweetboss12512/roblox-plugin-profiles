local net = require("@lune/net")
local stdio = require("@lune/stdio")

local Log = require("@vendor/lune-utils").Log
local config = require("@src/config")
local util = require("./util")
local pathfs = require("@vendor/lune-path")

return function()
	for pluginName, assetId in config.profileData.plugins do
		if typeof(assetId) == "string" then
			continue
		end

		if util.getPluginFilePath(pluginName) then
			print(`'{pluginName}' is already installed, skipping`)
			continue
		end

		local outputPath = pathfs.Path.from(`{config.directories.disabledPlugins}/{pluginName}.rbxm`)
		local response = net.request({
			url = `https://assetdelivery.roblox.com/v1/asset/?id={assetId}`,
			method = "GET",
		})

		if not response.ok then
			Log.Error(`Failed to install plugin '{pluginName}', GOT {response.statusCode}, {response.statusMessage}`)
			continue
		end

		pathfs.writeFile(outputPath, response.body)
		stdio.write(`Installed plugin {pluginName}.rbxm\n`)

		stdio.write(stdio.color("green"))
		stdio.write("Finished installing plugins\n")
		stdio.write(stdio.color("reset"))
	end
end
