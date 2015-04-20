local Enemy = require("Enemy")
local Robot = require("Robot")
local Bullet = require("Bullet")
local BoxCollider = require("BoxCollider")

local Commander = class("Commander", Robot)

function Commander:initialize(x, y)
	Enemy.initialize(self, x, y, 0, Robot.static.MASS, Robot.static.SOLID, -17)
	self:setName("commander")
	
	self.animator = Animator(Resources.getAnimator("commander.lua"))
	self.collider = BoxCollider(20, 32, 0, -16)

	self.state = Robot.static.STATE_IDLE
	self.time = love.math.random() * 2

	self.cooldown = Robot.static.COOLDOWN
end

function Commander:shoot(dir)
	self.scene:add(Bullet(self.x, self.y+0.01, dir-0.2))
	self.scene:add(Bullet(self.x, self.y+0.01, dir))
	self.scene:add(Bullet(self.x, self.y+0.01, dir+0.2))
	self.animator:setProperty("fire", true)
end

return Commander
