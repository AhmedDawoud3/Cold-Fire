GameManager = Class {}
require 'maps'

require 'Levels\\DemoLevel'
require 'Levels\\DemoLevel2'

current_level = nil

function GameManager:init()
    current_level = DemoLevel()
end

function GameManager:update(dt)
    -- if #enemies == 0 then
    --     current_level.walls = {}
    --     current_level = DemoLevel2()
    -- end
    current_level:update(dt)
end

function GameManager:Render()
    current_level:Render()
end
