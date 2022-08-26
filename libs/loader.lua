local loader = {}

function loader.enumerate(folder, tab)
	local items = love.filesystem.getDirectoryItems(folder)

	for _, item in ipairs(items) do
		local file = folder .. "/" .. item

		if love.filesystem.getInfo(file).type == "file" then
			table.insert(tab, file)
		elseif love.filesystem.getInfo(file).type == "directory" then
			loader.enumerate(file, tab)
		end
	end
end

function loader.require(folder)
	local files = {}

	loader.enumerate(folder, files)

	for _, file in ipairs(files) do
		local file = file:sub(1, -5)
		require(file)
	end
end

return loader