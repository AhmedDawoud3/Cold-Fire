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
end

function Gun:update(dt, player)
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
    if #enemies > 0 then
        if gNearestEnemy ~= GetnearestEnemy(self) and gNearestEnemy then
            gNearestEnemy.marked = false
        end
        gNearestEnemy = GetnearestEnemy(self)
        if gNearestEnemy then
            self.angle = GetAngle(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
            gNearestEnemy.marked = true
        end
    else
        self.angle = self.angle + dt
    end
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
            if v.y > enemies[i].y - enemies[i].size and v.y < enemies[i].y + enemies[i].size and v.x > enemies[i].x -
                enemies[i].size and v.x < enemies[i].x + enemies[i].size then -- enemies[i].health = enemies[i].health - 20
                v.x = v.x * 1000
                v.y = v.y * 1000
                v.x = v.x + 1000000
                table.remove(enemies, i)
            end

            for o, p in ipairs(cWalls) do
                if p.y + p.height > v.y and p.y < v.y + 6 and p.x + p.width > v.x and p.x < v.x + 6 then
                    v.x = v.x + 1000000
                end
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
    if #enemies > 0 then

        Gun:Fire(gNearestEnemy.x, gNearestEnemy.y, self.endX, self.endY)
    end
end

function Gun:Render()
    love.graphics.setLineWidth(1)
    if laser then
        love.graphics.setColor(1, 0, 0, 0.8)
        love.graphics.line(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
    end
    love.graphics.setLineWidth(6)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(self.centerX, self.centerY, self.endX, self.endY)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)

    for i, v in ipairs(bullets) do
        love.graphics.setColor(0.79, 0.8, 0, 1)
        love.graphics.circle("fill", v.x, v.y, 6)
        love.graphics.setColor(1, 1, 1, 1)
    end

end

function Gun:Fire(x, y, endX, endY)
    if COOLDOWN >= COOLDOWN_TIME then
        fired = true
        bulletStartX = endX
        bulletStartY = endY

        angle = GetAngle(endX, endY, x, y)

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
