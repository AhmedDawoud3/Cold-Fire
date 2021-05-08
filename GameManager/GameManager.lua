GameManager = Class {}
require 'GameManager/maps'
require 'Menus/Start'
require 'Menus/MainMenu'
require 'Menus/Options'
require 'Menus/Shop'
require 'Menus/LevelSelect'

require 'Levels/DemoLevel'
require 'Levels/DemoLevel2'

current_level = nil
gameState = nil

function GameManager:init()
    gameState = 'Start'
    LevelSelect:AddNewLevel("Level 1", DemoLevel)
    LevelSelect:AddNewLevel("Level 2", DemoLevel2)
    levels[1].opened = true
    levels[2].opened = true
    images = {
        ['options'] = love.graphics.newImage('Graphics/MainMenuGraphics/options.png'),
        ['back'] = love.graphics.newImage('Graphics/Global/back.png'),
        ['lock'] = love.graphics.newImage('Graphics/LevelSelect/lock.png')
    }
end

function GameManager:SetCurrentLevel(level)
    current_level = level()
end

function GameManager:update(dt)
    if gameState == 'Start' then
        Start:Update(dt)
    elseif gameState == 'MainMenu' then
        MainMenu:Update(dt)
    elseif gameState == 'Options' then
        Options:Update(dt)
    elseif gameState == 'Shop' then
        Shop:Update(dt)
    elseif gameState == 'LevelSelect' then
        LevelSelect:Update(dt)
    elseif gameState == 'Playing' then
        current_level:update(dt)
    end
end

function GameManager:Render()
    if gameState == 'Start' then
        Start:Render()
    elseif gameState == 'MainMenu' then
        MainMenu:Render()
    elseif gameState == 'Options' then
        Options:Render()
    elseif gameState == 'Shop' then
        Shop:Render()
    elseif gameState == 'LevelSelect' then
        LevelSelect:Render()
    elseif gameState == 'Playing' then
        current_level:Render()
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        if gameState == 'Start' then
            Start:MosuePressed()
        elseif gameState == 'MainMenu' then
            MainMenu:mousePressed(x, y)
        elseif gameState == 'Options' then
            Options:mousePressed(x, y)
        elseif gameState == 'Shop' then
            Shop:mousePressed(x, y)
        elseif gameState == 'LevelSelect' then
            LevelSelect:mousePressed(x, y)
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
