GameManager = Class {}
require 'GameManager/maps'
require 'Menus/Start'

require 'Levels/DemoLevel'
require 'Levels/DemoLevel2'

current_level = nil
gameState = nil

function GameManager:init()
    gameState = 'Start'
    current_level = DemoLevel()
end

function GameManager:update(dt)
    if gameState == 'Start' then
        Start:Update(dt)
    elseif gameState == 'Playing' then
        if #enemies == 0 then
            current_level.walls = {}
            current_level = DemoLevel2()
        end
        current_level:update(dt)
    end
end

function GameManager:Render()
    if gameState == 'Start' then
        Start:Render()
    elseif gameState == 'Playing' then
        current_level:Render()
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        if gameState == 'Start' then
            Start:MosuePressed()
        elseif gameState == 'Playing' then
            mousePressed = true
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
