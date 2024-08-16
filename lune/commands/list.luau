local stdio = require("@lune/stdio")
local config = require("@src/config")

return function()
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
