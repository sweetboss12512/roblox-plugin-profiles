local pathfs = require("@vendor/lune-path")
local config = require("@src/config")

local function attemptMove(path: pathfs.Path | string, newPath: pathfs.Path | string)
	if tostring(path) ~= tostring(newPath) then
		pathfs.move(path, newPath)
	end
end

--[[
    @return with a file extension, too.
]]
local function getPluginFileName(pluginIndex: string): pathfs.Path
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

local function getPluginFilePath(pluginIndex: string): pathfs.Path?
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

local function setPluginEnabled(pluginIndex: string, enabled: boolean): (boolean, string?)
	local fileName = getPluginFileName(pluginIndex)
	local filePath = getPluginFilePath(pluginIndex)

	if not filePath then
		return false, `Failed to find file for '{pluginIndex}'`
	end

	if enabled then
		attemptMove(filePath, config.directories.enabledPlugins:join(fileName))
	else
		attemptMove(filePath, config.directories.disabledPlugins:join(fileName))
	end

	return true
end

return {
	setPluginEnabled = setPluginEnabled,
	getPluginFilePath = getPluginFilePath,
}
