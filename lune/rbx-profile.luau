local process = require("@lune/process")
local util = require("./commands/util")

local VERSION = "v1.2.0"

local commands = {
	install = require("./commands/install"),
	list = require("./commands/list"),
	use = require("./commands/use"),
}

local parsedArguments = util.parseArguments(process.args)
local subcommand = parsedArguments.arguments[1]

if parsedArguments.options.version or parsedArguments.options.v then
	print(`rbx-profile {VERSION}`)
	return
end

table.remove(parsedArguments.arguments, 1)

if commands[subcommand] then
	return commands[subcommand](parsedArguments)
elseif not subcommand then
	print("No command provided")
else
	print(`Invalid command '{subcommand}'`)
end
