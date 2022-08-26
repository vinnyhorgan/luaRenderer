application = {}

function application:line(x0, y0, x1, y1, color)
	local inverted0 = self.resolution.height - y0
	local inverted1 = self.resolution.height - y1

	if color[4] then
		lg.setColor(color[1]/255, color[2]/255, color[3]/255, color[4]/255)
	else
		lg.setColor(color[1]/255, color[2]/255, color[3]/255, 255)
	end

	lg.line(x0, inverted0, x1, inverted1)
end

function application:triangle(v0, v1, v2, color, z)
	local inverted0 = self.resolution.height - v0.y
	local inverted1 = self.resolution.height - v1.y
	local inverted2 = self.resolution.height - v2.y

	table.insert(self.drawQueue, {
		z = z,
		color = color,
		x0 = v0.x,
		y0 = inverted0,
		x1 = v1.x,
		y1 = inverted1,
		x2 = v2.x,
		y2 = inverted2
	})
end

function application:renderWireframe(model)
	for _, face in pairs(model.f) do
		for i = 1, 3 do
			local v0 = model.v[face[i].v]
			local v1

			if i == 3 then
				v1 = model.v[face[1].v]
			else
				v1 = model.v[face[i + 1].v]
			end

			local x0 = (v0.x + 1) * self.resolution.width / 2
			local y0 = (v0.y + 1) * self.resolution.height / 2
			local x1 = (v1.x + 1) * self.resolution.width / 2
			local y1 = (v1.y + 1) * self.resolution.height / 2

			self:line(x0, y0, x1, y1, {255, 255, 255, 255})
		end
	end
end

function application:render(model, light)
	for _, face in pairs(model.f) do
		local screenCoords = {}
		local worldCoords = {}

		for i = 1, 3 do
			local v = model.v[face[i].v]

			screenCoords[i] = Vector2(
				(v.x + 1) * self.resolution.width / 2,
				(v.y + 1) * self.resolution.height /2
			)

			worldCoords[i] = Vector3(v.x, v.y, v.z)
		end

		local n = worldCoords[3]:sub(worldCoords[1]):cross(worldCoords[2]:sub(worldCoords[1]))

		n = n:norm()

		local intensity = n:dot(light)

		if intensity > 0 then
			self:triangle(screenCoords[1], screenCoords[2], screenCoords[3], {intensity * 255, intensity * 255, intensity * 255}, worldCoords[1].z)
		end
	end

	table.sort(self.drawQueue, function(k1, k2) return k1.z < k2.z end)

	for _, drawCall in pairs(self.drawQueue) do
		lg.setColor(drawCall.color[1]/255, drawCall.color[2]/255, drawCall.color[3]/255)

		lg.polygon("fill", drawCall.x0, drawCall.y0, drawCall.x1, drawCall.y1, drawCall.x2, drawCall.y2)
	end
end

function application:enter()
	self.resolution = {
		width = 1000,
		height = 1000
	}

	self.headModel = obj.load("assets/head.obj")

	push:setupScreen(self.resolution.width, self.resolution.height, lg.getWidth(), lg.getHeight(), {fullscreen = false, resizable = true})

	push:setBorderColor(159/255, 197/255, 230/255)

	self.light = Vector3(0, 0, -1)

	self.drawQueue = {}
end

function application:update(dt)

end

function application:draw()
	push:start()

	lg.clear(0, 0, 0)

	lg.print("FPS " .. lt.getFPS(), 10, 10)
	lg.print("TRIANGLES " .. #self.headModel.f, 10, 50)

	if lk.isDown("space") then
		self:renderWireframe(self.headModel)
	else
		self:render(self.headModel, self.light)
	end

	push:finish()
end

function application:resize(w, h)
	return push:resize(w, h)
end