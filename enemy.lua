Enemy = Class {}

function Enemy:init(x, y, size, r, g, b)
    self.x, self.y, self.size, self.r, self.g, self.b = x, y, size, r, g, b
end

function Enemy:Render()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle("fill", self.x, self.y, self.size)
    love.graphics.setColor(1, 1, 1, 1)
end
