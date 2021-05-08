Enemy = Class {}

function Enemy:init(type, x, y, size, r, g, b, distX, distY)
    self.type = type
    if self.type == 1 then
        self.size = size or math.random(10, 25)
        self.x = x or math.random(10 + self.size, 391 - self.size)
        self.y = y or math.random(10 + self.size, 862 - self.size)
        self.health = 100
        self.r = r or math.random(9000, 10000) / 10000
        self.g = g or math.random(2000, 4000) / 10000
        self.b = b or math.random(2000, 4000) / 10000
    elseif self.type == 2 then
        self.size = size or math.random(25, 45)
        self.x = x or math.random(10 + self.size, 381 - self.size)
        self.y = y or math.random(10 + self.size, 852 - self.size)
        self.originalX = self.x
        self.originalY = self.y
        self.health = 150
        self.r = r or math.random(2000, 4000) / 10000
        self.g = g or math.random(8000, 9000) / 10000
        self.b = b or math.random(2000, 4000) / 10000
        self.distX = distX or math.random(100, 150)
        self.distY = distY or 0
        self.dx = 100
        self.dy = 0
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
    elseif self.type == 2 then
        if self.marked then
            love.graphics.setColor(0.87, 0.13, 0.12, 0.5)
            love.graphics.rectangle("fill", self.x - 5, self.y - 5, self.size + 10, self.size + 10)
        end
        love.graphics.setColor(self.r, self.g, self.b)
        love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Enemy:hit()
    self.health = self.health - gun.damage
end
