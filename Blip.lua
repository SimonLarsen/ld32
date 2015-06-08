local BoxCollider = require("BoxCollider")
local Blip = class("Blip", Entity)

Blip.static.SPEED = 400
Blip.static.RANGE = 75
Blip.static.LIFETIME = 2

function Blip:initialize(x, y, xspeed, yspeed)
	Entity.initialize(self, x, y)
	self:setName("blip")

	self.xspeed = xspeed or 0
	self.yspeed = yspeed or 0
	self.follow = false
	self.time = Blip.static.LIFETIME

	self.animation = Animation(Resources.getImage("blip.png"), 8, 8, 0.1)
	self.collider = BoxCollider(2, 2)
end

function Blip:enter()
	self.player = self.scene:find("player")
end

function Blip:update(dt)
	self.time = self.time - dt
	if self.time <= 0 then
		self:kill()
	end

	if self.xspeed^2 + self.yspeed^2 < 5 then
		self.follow = true
	end

	if self.follow then
		local dx = self.player.x - self.x
		local dy = self.player.y - self.y
		local dist = vector.length(dx, dy)

		if dist < Blip.static.RANGE then
			self.xspeed = dx / dist * Blip.static.SPEED
			self.yspeed = dy / dist * Blip.static.SPEED
		end
	end

	self.xspeed = math.movetowards(self.xspeed, 0, 500*dt)
	self.yspeed = math.movetowards(self.yspeed, 0, 500*dt)

	self.x = self.x + self.xspeed * dt
	self.y = self.y + self.yspeed * dt

	self.animation:update(dt)
end

function Blip:draw()
	self.animation:draw(self.x, self.y)
end

return Blip
