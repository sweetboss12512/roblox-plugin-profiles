local process = require("@lune/process")

type ValidInputType = "string" | "boolean" | "number"

type Flag = {
	aliases: { string },
	type: ValidInputType?,
	default: (string | number | boolean)?,
	help: string?,
}

type ParseInput = {
	[string]: Flag,
}

local function getFlagValue(args: { string }, matchString: string): any
	for _, v in ipairs(args) do
		local value = v:match(matchString)

		if value then
			return value
		end
	end

	return
end

local function parseFlags(input: ParseInput, args: { string }): { [Flag]: any }
	local output: { [Flag]: any } = {}

	for _, flag in input do
		for _, alias in ipairs(flag.aliases) do
			-- Transforming the alias into a valid search string...
			local escapedAlias = alias:gsub("%-", "%%-")
			local matchString: string

			if flag.type then
				matchString = `{escapedAlias}=(.+)`
				-- matchString = `([%{escapedAlias}%-_]+)=(.+)`
			else
				matchString = escapedAlias
			end

			local value = getFlagValue(args, matchString)

			if value then
				if not input.default then
					value = true
				end

				output[flag] = value
				break
			end
		end
	end

	return output
end
--
-- local testFlags = {
-- 	version = {
-- 		aliases = { "--version", "-v" },
-- 		help = "Prints out the version of the program.",
-- 	},
--
-- 	test = {
-- 		aliases = { "-t" },
-- 		default = "Default Value",
-- 	},
-- }
--
-- local values = parseFlags(testFlags, table.clone(process.args))

return parseFlags
