require("src/globals")
require("src/utils")

function love.load()
	math.randomseed(os.time())

	lg.setDefaultFilter("nearest", "nearest")
	lg.setLineStyle("rough")

	loader.require("src/objects")
	loader.require("src/states")

	state.registerEvents()
	state.switch(application)
end