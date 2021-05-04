Enemy = Class {}

function Enemy:init(x, y, size, r, g, b)
    self.x, self.y, self.size, self.r, self.g, self.b = x, y, size, r, g, b
    self.marked = false
end

function Enemy:Render()
    if self.marked then
        love.graphics.setColor(0.87, 0.13, 0.12, 0.5)
        love.graphics.circle("fill", self.x, self.y, self.size + 5)
    end
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle("fill", self.x, self.y, self.size)
    love.graphics.setColor(1, 1, 1, 1)
end
