GameManager = Class {}
require 'GameManager/maps'

require 'Levels/DemoLevel'
require 'Levels/DemoLevel2'

current_level = nil
gameState = nil

function GameManager:init()
    gameState = 'playing'
    current_level = DemoLevel()
end

function GameManager:update(dt)
    if gameState == 'playing' then
        if #enemies == 0 then
            current_level.walls = {}
            current_level = DemoLevel2()
        end
        current_level:update(dt)
    end
end

function GameManager:Render()
    if gameState == 'playing' then
        current_level:Render()
    end
end
