Character = Class {}
require 'gun'
speed = 100
collided = false
function Character:init(x, y, maxHealth)
    self.x, self.y, self.dx, self.dy, self.size = x, y, 0, 0, 50
    self.maxHealth = maxHealth or 100
    self.health = {
        value = self.maxHealth,
        opacity = 1
    }
    gun = Gun(self)
end

function Character:update(dt)
    self.health.value = math.max(0, self.health.value)
    gun:update(dt, self)
    self.x = math.min(math.max(0, self.x + self.dx * dt), 391 - self.size)
    self.y = math.min(math.max(0, self.y + self.dy * dt), 862 - self.size)
    collided = false
    cWalls = current_level.walls
    if cWalls then
        for i, v in ipairs(cWalls) do
            -- Y
            if self.y < cWalls[i].y + cWalls[i].height and self.y > cWalls[i].y + self.size then
                if self.x < cWalls[i].x + cWalls[i].width and self.x > cWalls[i].x + self.size then
                    collided = true
                end
                if self.x > cWalls[i].x - self.size and self.x < cWalls[i].x + cWalls[i].width then
                    collided = true
                end
            end
            if self.y > cWalls[i].y - self.size and self.y < cWalls[i].y + cWalls[i].height then
                if self.x > cWalls[i].x - self.size and self.x < cWalls[i].x + cWalls[i].width then
                    collided = true
                    -- 
                end
                if self.x < cWalls[i].x + cWalls[i].width and self.x > cWalls[i].x + self.size then
                    collided = true
                end
            end

            -- if self.y < cWalls[i].y + cWalls[i].height and self.y > cWalls[i].y + self.size and collided then
            --     self.y = cWalls[i].y + cWalls[i].height
            -- end
            -- if self.y > cWalls[i].y - self.size and self.y < cWalls[i].y + cWalls[i].height and collided then
            --     self.y = cWalls[i].y - self.size
            -- end
            -- if self.x < cWalls[i].x + cWalls[i].width and self.x > cWalls[i].x + self.size and collided then
            --     self.x = cWalls[i].x + cWalls[i].width
            -- end
            -- if self.x > cWalls[i].x - self.size and self.x < cWalls[i].x + cWalls[i].width then
            --     self.x = cWalls[i].x - self.size
            -- end
            if collided then
                angleW = GetAngle(self.x + (self.size / 2), self.y + (self.size / 2),
                             cWalls[i].x + (cWalls[i].width / 2), cWalls[i].y + (cWalls[i].height / 2))
                xW = -math.cos(angleW)
                yW = -math.sin(angleW)
                self.x = self.x + xW / 10
                self.y = self.y + yW / 10
            end
        end

    end

end

function Character:draw()
    love.graphics.setColor(1, 0.7, 0.1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
    love.graphics.setColor(0.8, 0.11, 0.16, self.health.opacity)
    love.graphics.rectangle("fill", self.x, self.y - 20, self.size * (self.health.value / self.maxHealth), 10)
    love.graphics.setColor(0, 0, 0, self.health.opacity)
    love.graphics.rectangle("line", self.x, self.y - 20, self.size, 10)

    gun:Render()
end

function Character:Move(x, y)
    x = math.min(50, x)
    y = math.min(50, y)
    self.angle = GetAngle(self.x, self.y, x, y)
    magmitude = math.sqrt(x * x + y * y)
    if x ~= 0 and y ~= 0 and not collided then
        self.dx = ((x / magmitude) * speed)
        self.dy = ((y / magmitude) * speed)
    else
        self.dx = 0
        self.dy = 0
    end
end
