Enemy = Class {}

function Enemy:init(type, x, y, size, r, g, b, distX, distY)
    self.type = type
    if self.type == 1 then
        self.size = size or math.random(10, 25)
        self.x = x or math.random(10 + self.size, 391 - self.size)
        self.y = y or math.random(10 + self.size, 862 - self.size)
        self.health = 50
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
    elseif self.type == 3 then
        self.size = size or 50
        self.x = x or math.random(10 + self.size, 391 - self.size)
        self.y = y or math.random(10 + self.size, 862 - self.size)
        self.r, self.g, self.b = 146 / 255, 95 / 255, 227 / 255
        self.health = health or 200
        self.gunX = self.x + 32 / 2
        self.gunY = self.y + 32 / 2
        self.gunEndX = self.gunX
        self.gunEndY = self.gunY
        self.fireable = false
        self.BULLET_SPEED = 400
        self.COOLDOWN_TIME = 1.23
        self.COOLDOWN = self.COOLDOWN_TIME
        self.bullets = {}
        self.angle = 0
    elseif self.type == 4 then
        self.size = size or 45
        self.x = x or math.random(10 + self.size, 391 - self.size)
        self.y = y or math.random(10 + self.size, 862 - self.size)
        self.r, self.g, self.b = 29 / 255, 198 / 255, 224 / 255
        self.health = health or 100
        self.dx, self.dy = 100, 100
        self.angle = 0
    end
    self.marked = false
end

function Enemy:update(dt, player)
    if self.type == 3 then
        self.fireable = false
        self.oldAngle = self.angle
        self.angle = GetAngle(self.gunX, self.gunY, player.x + player.size / 2, player.y + player.size / 2)
        self.gunX = self.x + (self.size / 2)
        self.gunY = self.y + (self.size / 2)
        self.gunEndX = self.gunX + 35 * math.cos(self.angle)
        self.gunEndY = self.gunY + 35 * math.sin(self.angle)
        if math.abs(self.oldAngle - self.angle) < 0.05 then
            self.fireable = true
        end
        for i, v in ipairs(self.bullets) do
            if v.y >= 1000 then
                table.remove(self.bullets, i)
            end
            v.x = v.x + (v.dx * dt)
            v.y = v.y + (v.dy * dt)
            if v.y > player.y and v.y < player.y + player.size and v.x > player.x and v.x < player.x + player.size then
                player.health.value = player.health.value - 20
                v.x = v.x * 1000
                v.y = v.y * 1000
                v.x = v.x + 1000000
            end
            if cWalls then
                for o, p in ipairs(cWalls) do
                    if p.y + p.height > v.y and p.y < v.y + 6 and p.x + p.width > v.x and p.x < v.x + 6 then
                        v.x = v.x + 1000000
                    end
                end
            end
        end
        if self.fired then
            self.COOLDOWN = self.COOLDOWN - dt
            if self.COOLDOWN <= 0 then
                self.fired = false
                self.COOLDOWN = self.COOLDOWN_TIME
            end
        end
        -- if not CheckRayCollisionWithWall(self, player.x, player.y) then
        self:Fire()
        -- end
    elseif self.type == 4 then
        self.angle = GetAngle(self.x, self.y, player.x, player.y)
        self.dx = math.cos(self.angle) * 75
        self.dy = math.sin(self.angle) * 75
        self.x = math.min(math.max(0, self.x + self.dx * dt), 391 - self.size)
        self.y = math.min(math.max(0, self.y + self.dy * dt), 862 - self.size)
        if self.x + self.size > player.x and self.x < player.x + self.size and self.y + self.size > player.y and self.y <
            player.y + player.size then
            player.health.value = player.health.value - 25
            self.x = self.x - math.cos(self.angle) * 75
            self.y = self.y - math.sin(self.angle) * 75
        end
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
    end
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
    elseif self.type == 3 then
        if self.marked then
            love.graphics.setColor(0.87, 0.13, 0.12, 0.5)
            love.graphics.rectangle("fill", self.x - 5, self.y - 5, self.size + 10, self.size + 10)
        end
        love.graphics.setColor(self.r, self.g, self.b)
        love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)

        -- GUN
        love.graphics.setLineWidth(6)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.line(self.gunX, self.gunY, self.gunEndX, self.gunEndY)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
        for i, v in ipairs(self.bullets) do
            love.graphics.setColor(0.79, 0.8, 0, 1)
            love.graphics.circle("fill", v.x, v.y, 6)
            love.graphics.setColor(1, 1, 1, 1)
        end
    elseif self.type == 4 then
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
    if self.health <= 0 then
        if self.type == 1 then
            money = money + 1
        elseif self.type == 2 then
            money = money + 3
        elseif self.type == 3 then
            money = money + 5
        end
    end
end
function Enemy:Fire()
    if self.COOLDOWN >= self.COOLDOWN_TIME then
        self.fired = true
        bulletStartX = self.gunEndX
        bulletStartY = self.gunEndY
        bulletDX = BULLET_SPEED * math.cos(self.angle)
        bulletDY = BULLET_SPEED * math.sin(self.angle)
        table.insert(self.bullets, {
            x = bulletStartX,
            y = bulletStartY,
            dx = bulletDX,
            dy = bulletDY
        })
    end
end

function CheckRayCollisionWithWall(self, playerX, playerY)
    if cWalls then
        if #cWalls > 0 then
            for i = 1, GetDistance(self.x, self.y, playerX, playerY) / 20 do
                i = i * 20
                local pointX = self.gunX + i * math.cos(self.angle)
                local pointY = self.gunY + i * math.sin(self.angle)
                for j, v in ipairs(cWalls) do
                    if pointX > v.x and pointX < v.x + v.width and pointY > v.y and pointY < v.y + v.height then
                        return true
                    end
                end
            end
        end
    end
    return false
end
