Gun = Class {}

function Gun:init(player)
    self.size = 10
end

function Gun:update()
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
end

function getAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end
