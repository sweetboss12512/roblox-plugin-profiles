local util = require("./util")

return function(arguments: util.ParsedArguments)
	local updateAll = false

	if arguments.options.all or arguments.options.a then
		updateAll = true
	end

	if #arguments.arguments == 0 and not updateAll then
		print("No plugins to update specified")
		return
	end
end
