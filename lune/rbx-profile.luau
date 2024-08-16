local process = require("@lune/process")

-- local ParseArgs = require("@vendor/lune-utils").ParseArgs
-- local config = require("./config")
-- print(config)

local commands = {
	install = require("./commands/install"),
	list = require("./commands/list"),
}

local subcommand = process.args[1]

if commands[subcommand] then
	return commands[subcommand](unpack(process.args, 2))
else
	print(`Invalid command '{subcommand}'`)
end
