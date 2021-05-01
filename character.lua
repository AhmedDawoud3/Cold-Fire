Character = Class {}
require 'gun'
speed = 100
function Character:init()
    self.x, self.y, self.dx, self.dy, self.size = 170, 700, 0, 0, 50
    gun = Gun(self)
end

function Character:update(dt)
    gun:update(dt, self)
    self.x = math.min(math.max(0, self.x + self.dx * dt), 391 - self.size)
    self.y = math.min(math.max(0, self.y + self.dy * dt), 862 - self.size)
end

function Character:draw()
    love.graphics.setColor(1, 0.7, 0.1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
    love.graphics.setColor(1, 1, 1, 1)
    gun:Render()
end

function Character:Move(x, y)
    x = math.min(50, x)
    y = math.min(50, y)
    self.angle = GetAngle(self.x, self.y, x, y)
    magmitude = math.sqrt(x * x + y * y)
    if x ~= 0 and y ~= 0 then
        self.dx = ((x / magmitude) * speed)
        self.dy = ((y / magmitude) * speed)
    else
        self.dx = 0
        self.dy = 0
    end
end
