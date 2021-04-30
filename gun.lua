Gun = Class {}
smallestDistance = 999999999
gNearestEnemy = nil
function Gun:init(player)
    self.size = 35
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
    self.endX = self.centerX
    self.endY = self.centerY
end

function Gun:update(player)
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
    gNearestEnemy = GetnearestEnemy(self)
    if gNearestEnemy then
        self.angle = GetAngle(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
    else
        self.angle = 1.5708
    end
    -- print(math.deg(self.angle))
    self.endX = self.centerX + self.size * math.cos(self.angle)
    self.endY = self.centerY + self.size * math.sin(self.angle)
end

function Gun:Render()
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 0, 0, 0.8)
    love.graphics.line(self.centerX, self.centerY, gNearestEnemy.x, gNearestEnemy.y)
    love.graphics.setLineWidth(6)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(self.centerX, self.centerY, self.endX, self.endY)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)
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
