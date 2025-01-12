local stdio = require("@lune/stdio")

local Log = require("@vendor/log")
local config = require("@src/config")
local util = require("./util")

return function()
    for pluginName, assetId in config.profileData.plugins do
        if typeof(assetId) == "string" then
            continue
        end

        if util.getPluginFilePath(pluginName) then
            print(`'{pluginName}' is already installed, skipping`)
            continue
        end

        local success, response = util.installPlugin(assetId, pluginName)

        if not success then
            Log.Error(`Failed to install plugin '{pluginName}', GOT {response.statusCode}, {response.statusMessage}`)
            continue
        end

        print(`{pluginName} [{stdio.color("green")}Installed{stdio.color("reset")}]`)
    end

    stdio.write(stdio.color("green"))
    stdio.write("\nFinished installing plugins!\n")
    stdio.write(stdio.color("reset"))
end
