Character = Class {}
require 'Player/gun'
speed = 1
collided = false
function Character:init(x, y)
    self.x, self.y, self.dx, self.dy, self.size = x, y, 0, 0, 50
    c1, c2, c3 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)')
    upgradedHealth = tonumber(c1)
    if upgradedHealth == 1 then
        self.maxHealth = 150
    else
        self.maxHealth = 100
    end
    self.health = {
        value = self.maxHealth,
        opacity = 1
    }
    gun = Gun(self)
    xAmountIn = 0
    yAmountIn = 0
end

function Character:update(dt)
    self.health.value = math.max(0, self.health.value)
    gun:update(dt, self)
    if self.health.value <= 0 then
        gameState = 'DeadScreen'
    end
    self.x = math.min(math.max(0, self.x + self.dx * dt), 391 - self.size)
    self.y = math.min(math.max(0, self.y + self.dy * dt), 862 - self.size)
    cWalls = current_level.walls
    if cWalls then
        for i, v in ipairs(cWalls) do
            collided = false
            if Collides(cWalls[i], {
                x = self.x,
                y = self.y,
                width = self.size,
                height = self.size
            }) then
                collided = true
            end

            if collided then
                if self.dx > 0 then
                    xAmountIn = self.x + self.size - (cWalls[i].x - self.size)
                elseif self.dx < 0 then
                    xAmountIn = (cWalls[i].x + cWalls[i].width) - self.x
                end

                if self.dy > 0 then
                    yAmountIn = self.y + self.size - (cWalls[i].y - self.size)
                elseif self.dy < 0 then
                    yAmountIn = (cWalls[i].y + cWalls[i].height) - self.y
                end
                if xAmountIn < yAmountIn then
                    if self.dx ~= 0 then
                        if self.dx > 0 then
                            self.x = cWalls[i].x - self.size
                        else
                            self.x = cWalls[i].x + cWalls[i].width
                        end
                    end
                else
                    if self.dy ~= 0 then
                        if self.dy > 0 then
                            self.y = cWalls[i].y - self.size
                        else
                            self.y = cWalls[i].y + cWalls[i].height
                        end
                    end
                end

            end
        end
    end

    for i = #enemies, 1, -1 do
        if enemies[i].type == 2 then
            if (self.y < enemies[i].y + enemies[i].size and self.y > enemies[i].y + self.size and self.x < enemies[i].x +
                enemies[i].size and self.x > enemies[i].x + self.size) or
                (self.y > enemies[i].y - self.size and self.y < enemies[i].y + enemies[i].size and self.x > enemies[i].x -
                    self.size and self.x < enemies[i].x + enemies[i].size) then
                print("Collides")
                self.health.value = self.health.value - 1
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
    x = math.max(math.min(50, x), -50)
    y = math.max(math.min(50, y), -50)
    angleC = GetAngle(0, 0, x, y)
    magnitude = math.min(math.sqrt(x * x + y * y), 50)
    if x ~= 0 and y ~= 0 then
        self.dx = math.cos(angleC) * magnitude * speed * 3
        self.dy = math.sin(angleC) * magnitude * speed * 3
    else
        self.dx = 0
        self.dy = 0
    end
end
