Vector3 = Object:extend()

function Vector3:new(x, y, z)
	self.x = x
	self.y = y
	self.z = z
end

function Vector3:add(vector)
	return Vector3(
		self.x + vector.x,
		self.y + vector.y,
		self.z + vector.z
	)
end

function Vector3:sub(vector)
	return Vector3(
		self.x - vector.x,
		self.y - vector.y,
		self.z - vector.z
	)
end

function Vector3:mul(vector)
	return Vector3(
		self.x * vector.x,
		self.y * vector.y,
		self.z * vector.z
	)
end

function Vector3:div(vector)
	return Vector3(
		self.x / vector.x,
		self.y / vector.y,
		self.z / vector.z
	)
end

function Vector3:dot(vector)
	return self.x * vector.x + self.y * vector.y + self.z * vector.z
end

function Vector3:cross(vector)
	return Vector3(
		self.y * vector.z - self.z * vector.y,
		self.z * vector.x - self.x * vector.z,
		self.x * vector.y - self.y * vector.x
	)
end

function Vector3:mag()
	return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2) + math.pow(self.z, 2))
end

function Vector3:norm()
	local mag = self:mag()

	return Vector3(self.x/mag, self.y/mag, self.z/mag)
end

Vector2 = Object:extend()

function Vector2:new(x, y)
	self.x = x
	self.y = y
end

function Vector2:add(vector)
	return Vector2(
		self.x + vector.x,
		self.y + vector.y
	)
end

function Vector2:sub(vector)
	return Vector2(
		self.x - vector.x,
		self.y - vector.y
	)
end

function Vector2:mul(vector)
	return Vector2(
		self.x * vector.x,
		self.y * vector.y
	)
end

function Vector2:div(vector)
	return Vector2(
		self.x / vector.x,
		self.y / vector.y
	)
end

function Vector2:dot(vector)
	return self.x * vector.x + self.y * vector.y
end

function Vector2:mag()
	return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2))
end

function Vector2:norm()
	local mag = self:mag()

	return Vector2(self.x/mag, self.y/mag)
end