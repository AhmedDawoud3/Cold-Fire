Character = Class {}
require 'gun'

function Character:init()
    self.x, self.y, self.dx, self.dy, self.size = 10, 10, 0, 0, 50
    gun = Gun(self)
end

function Character:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Character:draw()
    love.graphics.setColor(1, 0.7, 0.1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Character:Move(x, y)
    self.dx = x
    self.dy = y
end
