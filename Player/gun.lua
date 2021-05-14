Gun = Class {}
smallestDistance = 999999999
gNearestEnemy = nil
BULLET_SPEED = 400
COOLDOWN_TIME = 0.7
COOLDOWN = COOLDOWN_TIME
local bullets = {}
function Gun:init(player)
    self.size = 35
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
    self.endX = self.centerX
    self.endY = self.centerY
    self.angle = 0
    self.fireable = false
    c1, c2, c3 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)')
    upgradedRotationSpeed = tonumber(c2)
    if upgradedRotationSpeed == 1 then
        self.gunTurningSpeed = 2
    else
        self.gunTurningSpeed = 1
    end
    c1, c2, c3 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)')
    upgradedDamage = tonumber(c3)
    if upgradedDamage == 1 then
        self.damage = 75
    else
        self.damage = 50
    end
end

function Gun:update(dt, player)
    for i, v in ipairs(enemies) do
        if v.type == 3 then
            v:update(dt, player)
        end
    end
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
    self.oldAngle = self.angle
    self.fireable = false
    if #enemies > 0 then
        if gNearestEnemy ~= GetnearestEnemy(self) and gNearestEnemy then
            gNearestEnemy.marked = false
        end
        gNearestEnemy = GetnearestEnemy(self)
        if gNearestEnemy then
            if gNearestEnemy.type == 1 then
                self.angle = GetAngle(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
            else
                self.angle = GetAngle(self.centerX, self.centerY, gNearestEnemy.x + gNearestEnemy.size / 2,
                                 gNearestEnemy.y + gNearestEnemy.size / 2)
            end
            gNearestEnemy.marked = true
        end
    else
        self.angle = self.angle + dt
    end
    if math.abs(self.oldAngle - self.angle) < 0.05 then
        self.fireable = true
    end

    if self.oldAngle > self.angle then
        self.angle = self.oldAngle - dt * self.gunTurningSpeed
    else
        self.angle = self.oldAngle + dt * self.gunTurningSpeed
    end
    -- print(self.fireable)
    -- print(math.deg(self.angle))
    self.endX = self.centerX + self.size * math.cos(self.angle)
    self.endY = self.centerY + self.size * math.sin(self.angle)
    cWalls = current_level.walls

    for i, v in ipairs(bullets) do
        v.x = v.x + (v.dx * dt)
        v.y = v.y + (v.dy * dt)
        if v.y >= 1000 then
            table.remove(bullets, i)
        end
        for i = #enemies, 1, -1 do
            if enemies[i].type == 1 then
                if v.y > enemies[i].y - enemies[i].size and v.y < enemies[i].y + enemies[i].size and v.x > enemies[i].x -
                    enemies[i].size and v.x < enemies[i].x + enemies[i].size then -- enemies[i].health = enemies[i].health - 20
                    v.x = v.x * 1000
                    v.y = v.y * 1000
                    v.x = v.x + 1000000
                    enemies[i]:hit()
                end
            elseif enemies[i].type == 2 then
                if v.y > enemies[i].y and v.y < enemies[i].y + enemies[i].size and v.x > enemies[i].x and v.x <
                    enemies[i].x + enemies[i].size then -- enemies[i].health = enemies[i].health - 20
                    v.x = v.x * 1000
                    v.y = v.y * 1000
                    v.x = v.x + 1000000
                    enemies[i]:hit()
                end
            elseif enemies[i].type == 3 then
                if v.y > enemies[i].y and v.y < enemies[i].y + enemies[i].size and v.x > enemies[i].x and v.x <
                    enemies[i].x + enemies[i].size then -- enemies[i].health = enemies[i].health - 20
                    v.x = v.x * 1000
                    v.y = v.y * 1000
                    v.x = v.x + 1000000
                    enemies[i]:hit()
                end
            end
            if cWalls then
                for o, p in ipairs(cWalls) do
                    if p.y + p.height > v.y and p.y < v.y + 6 and p.x + p.width > v.x and p.x < v.x + 6 then
                        v.x = v.x + 1000000
                    end
                end
            end
            if enemies[i].health <= 0 then
                table.remove(enemies, i)
            end
        end
    end

    if fired then
        COOLDOWN = COOLDOWN - dt
        if COOLDOWN <= 0 then
            fired = false
            COOLDOWN = COOLDOWN_TIME
        end
    end
    if #enemies > 0 and self.fireable and magnitude <= 5 then
        Fire(self)
    end
end

function Gun:Render()
    love.graphics.setLineWidth(1)
    if laser then
        love.graphics.setColor(1, 0, 0, 0.8)
        love.graphics.line(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
    end
    for i, v in ipairs(bullets) do
        love.graphics.setColor(0.79, 0.8, 0, 1)
        love.graphics.circle("fill", v.x, v.y, 6)
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.setLineWidth(6)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(self.centerX, self.centerY, self.endX, self.endY)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)

end

function Fire(self)
    if COOLDOWN >= COOLDOWN_TIME then
        fired = true
        bulletStartX = self.endX
        bulletStartY = self.endY
        angle = GetAngle(self.centerX, self.centerY, self.endX, self.endY)

        bulletDX = BULLET_SPEED * math.cos(angle)
        bulletDY = BULLET_SPEED * math.sin(angle)
        table.insert(bullets, {
            x = bulletStartX,
            y = bulletStartY,
            dx = bulletDX,
            dy = bulletDY
        })
    end
end

function GetnearestEnemy(self)
    nearestEnemy = nil
    distances = {}
    -- print(#enemies)
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        dist = GetDistance(self.centerX, self.centerY, enemy.x, enemy.y)
        enemy.self = enemies[i]
        enemy.dist = dist
        table.insert(distances, enemy)
    end

    table.sort(distances, function(a, b)
        return a.dist < b.dist
    end)
    return distances[1].self
end

function DistanceBetween(obj1, obj2)
    x1 = obj1.centerX
    y1 = obj1.centerY
    x2 = obj2.x
    y2 = obj2.y
    dist = GetDistance(x1, y1, x2, y2)
    return dist
end

function GetDistance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
end

function GetAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end
