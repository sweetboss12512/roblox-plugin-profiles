local stdio = require("@lune/stdio")
local config = require("@src/config")
local util = require("./util")

local function listProfiles()
    print("Profiles:")

    for name, info in config.profileData.profiles do
        stdio.write(`{name} `)

        if info.description then
            stdio.write(stdio.style("bold"))
            stdio.write(`# {info.description}`)
        end

        stdio.write("\n")
        stdio.write(stdio.style("reset"))
    end
end

local function listPlugins()
    print("Plugins:")

    for pluginIndex in config.profileData.plugins do
        local path = util.getPluginFilePath(pluginIndex)

        if path then
            print(`- {pluginIndex} ({path})`)
        else
            print(`- {pluginIndex} [{stdio.color("red")}Not Found{stdio.color("reset")}]`)
        end
    end
end

return function(arguments: util.ParsedArguments)
    if arguments.options.plugins or arguments.options.p then
        listPlugins()
    else
        listProfiles()
    end
end
