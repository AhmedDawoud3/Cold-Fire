Enemy = Class {}

function Enemy:init(x, y, size)
    self.x, self.y, self.size = x, y, size
end

function Enemy:Render()
    love.graphics.setColor(1, 0.3, 0.26, 1)
    love.graphics.circle("fill", self.x, self.y, self.size)
    love.graphics.setColor(1, 1, 1, 1)
end
