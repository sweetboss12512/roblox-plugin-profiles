local net = require("@lune/net")

local pathfs = require("@pkg/lune-path")
local config = require("@src/config")

local utility = {}

export type ParsedArguments = {
	arguments: { any },
	options: { [string]: any },
}

-- This is annoying
local function attemptMove(path: pathfs.Path | string, newPath: pathfs.Path | string)
	if tostring(path) ~= tostring(newPath) then
		pathfs.move(path, newPath)
	end
end

--[[
    @return with a file extension, too.
]]
function getPluginFileName(pluginIndex: string): pathfs.Path
	local pluginValue = config.profileData.plugins[pluginIndex]
	local fileName: pathfs.Path

	if typeof(pluginValue) == "string" then
		fileName = pathfs.Path.from(pluginValue)
	else
		fileName = pathfs.Path.from(pluginIndex)
	end

	if not fileName:extension() then
		fileName = fileName:withExtension("rbxm")
	end

	return fileName
end

function utility.getPluginFilePath(pluginIndex: string): pathfs.Path?
	local fileName = getPluginFileName(pluginIndex)

	if not fileName:extension() then
		fileName = fileName:withExtension("rbxm")
	end

	local pluginPath = config.directories.enabledPlugins:join(fileName)

	if not pathfs.isFile(pluginPath) then
		pluginPath = config.directories.disabledPlugins:join(fileName)
	end

	if pathfs.isFile(pluginPath) then
		return pluginPath
	end

	return
end

function utility.setPluginEnabled(pluginIndex: string, enabled: boolean)
	local fileName = getPluginFileName(pluginIndex)
	local filePath = utility.getPluginFilePath(pluginIndex)

	if not filePath then
		error(`Failed to find file for '{pluginIndex}'`)
	end

	if enabled then
		attemptMove(filePath, config.directories.enabledPlugins:join(fileName))
	else
		attemptMove(filePath, config.directories.disabledPlugins:join(fileName))
	end
end

-- https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP/blob/refactor/.lune/generate/modules/Utility.luau#L105
function utility.parseArguments(arguments: { string }, ...: string): ParsedArguments
	local argumentedOptions = {}
	for index = 1, select("#", ...) do
		argumentedOptions[select(index, ...)] = true
	end

	local options: ParsedArguments = {
		arguments = {},
		options = {},
	}

	local index = 1
	while index <= #arguments do
		local argument = arguments[index]

		if argument:sub(1, 2) == "--" then
			local longOption = argument:sub(3)
			local option, value = longOption:match("^(.*)=(.*)$")
			if option and value then
				options.options[option] = value
			else
				options.options[longOption] = true
			end
		elseif argument:sub(1, 1) == "-" then
			local shortOptions = argument:sub(2)
			for shortOptionIndex = 1, #shortOptions do
				local option = shortOptions:sub(shortOptionIndex, shortOptionIndex)

				if argumentedOptions[option] then
					index += 1
					options.options[option] = arguments[index]
				else
					options.options[option] = true
				end
			end
		else
			table.insert(options.arguments, argument)
		end

		index += 1
	end

	return options
end

function utility.installPlugin(assetId: number, fileName: string): (boolean, net.FetchResponse)
	local response = net.request({
		url = `https://assetdelivery.roblox.com/v1/asset/?id={assetId}`,
		method = "GET",
	})

	local outputPath = pathfs.Path.from(`{config.directories.disabledPlugins}/{fileName}.rbxm`)

	if not response.ok then
		return false, response
	end

	pathfs.writeFile(outputPath, response.body)
	return true, response
end

return utility
