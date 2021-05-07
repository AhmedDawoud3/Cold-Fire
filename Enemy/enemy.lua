Enemy = Class {}

function Enemy:init(type, x, y, size, r, g, b)
    self.x, self.y, self.size = x, y, size
    self.type = type
    if self.type == 1 then
        self.health = 100
        self.r, self.g, self.b = r, g, b
    end
    self.marked = false
end

function Enemy:Render()
    if self.type == 1 then
        if self.marked then
            love.graphics.setColor(0.87, 0.13, 0.12, 0.5)
            love.graphics.circle("fill", self.x, self.y, self.size + 5)
        end
        love.graphics.setColor(self.r, self.g, self.b)
        love.graphics.circle("fill", self.x, self.y, self.size)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Enemy:hit()
    self.health = self.health - gun.damage
end
