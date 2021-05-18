GameManager = Class {}
require 'GameManager/maps'
require 'Menus/Start'
require 'Menus/MainMenu'
require 'Menus/Options'
require 'Menus/Shop'
require 'Menus/LevelSelect'
require 'Menus/DeadScreen'
require 'Menus/PauseScreen'

require 'Levels/DemoLevel'
require 'Levels/DemoLevel2'
require 'GameManager/SaveManager'
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
    if SaveManager:CheckForSaveFile() then
        money = tonumber(SaveManager:LoadGame()[1])
    else
        money = 0
    end
    SaveManager:SaveGame()
    shopData = Shop:LoadData()
end

function GameManager:SetCurrentLevel(level)
    current_level = level()
end

function GameManager:update(dt)
    ReadUpgrades()
    SaveManager:SaveGame(money)
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
    elseif gameState == 'DeadScreen' then
        DeadScreen:update(dt)
    elseif gameState == 'Pause' then
        PauseScreen:Update(dt)
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
    elseif gameState == 'DeadScreen' then
        DeadScreen:Render()
    elseif gameState == 'LevelSelect' then
        LevelSelect:Render()
    elseif gameState == 'Playing' then
        current_level:Render()
    elseif gameState == 'Pause' then
        PauseScreen:Render()
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
        elseif gameState == 'DeadScreen' then
            DeadScreen:mousePressed(x, y)
        elseif gameState == 'Pause' then
            PauseScreen:mousePressed(x, y)
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        if gameState == 'Playing' then
            gameState = 'Pause'
        elseif gameState == 'Options' then
            Options:mousePressed(30, 800)
        elseif gameState == 'Shop' then
            Shop:mousePressed(30, 800)
        elseif gameState == 'LevelSelect' then
            LevelSelect:mousePressed(30, 800)
        else
            love.event.quit()
        end
    end
end

function ReadUpgrades()
    c1, c2, c3, c4, c5, c6, c7, c8 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)')
    if tonumber(c1) == 1 then
        upgradedHealth = true
    else
        upgradedHealth = false
    end
    if tonumber(c2) == 1 then
        upgradedRotationBoost = true
    else
        upgradedRotationBoost = false
    end
    if tonumber(c3) == 1 then
        upgradedDamage = true
    else
        upgradedDamage = false
    end
    if tonumber(c4) == 1 then
        fireRateBoost = true
    else
        fireRateBoost = false
    end
    if tonumber(c5) == 1 then
        movingFireBoost = true
    else
        movingFireBoost = false
    end
    if tonumber(c6) == 1 then
        instantGunBoost = true
    else
        instantGunBoost = false
    end
    if tonumber(c7) == 1 then
        nonStoppableBulletsBoost = true
    else
        nonStoppableBulletsBoost = false
    end
    if tonumber(c8) == 1 then
        speedBoost = true
    else
        speedBoost = false
    end

end
