Gun = Class {}

function Gun:init(player)
    self.centerX = player.x + (player.size / 2)
    self.centerY = player.y + (player.size / 2)
end
