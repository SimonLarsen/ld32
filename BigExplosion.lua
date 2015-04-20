local BoxCollider = require("BoxCollider")

local BigExplosion = class("BigExplosion", Entity)

function BigExplosion:initialize(x, y, damage)
	Entity.initialize(self, x, y, 0)
	self:setName("bigexplosion")

	self.animation = Animation(Resources.getImage("bigexplosion.png"), 88, 88, 0.1)
	self.time = 0.7
	camera:setScreenShake(8, 0.5)

	if damage == true then
		self.collider = BoxCollider(88, 88, 0, 0)
	end
end

function BigExplosion:update(dt)
	self.animation:update(dt)

	self.time = self.time - dt
	if self.time <= 0 then
		self:kill()
	end
end

function BigExplosion:draw()
	self.animation:draw(self.x, self.y-35, 0, 1, 1, 44, 44)
end

return BigExplosion
