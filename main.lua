Class = require 'class'
require 'TouchContralls'
require 'character'
require 'eGenerator'
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

function love.load()
    math.randomseed(os.time())
    love.window.setMode(391, 862)
    p1 = Character()
    EGen:GenerateRandom(10)
end

function love.update(dt)
    p1:update(dt)
    FPS = 1 / dt
    mouseX, mouseY = TouchContralls:GetMotion()
    p1:Move(mouseX, mouseY)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.clear(0.6, 0.44, 0.39, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("MouseX: " .. tostring(mouseX), 100, 100)
    love.graphics.print("MouseY: " .. tostring(mouseY), 100, 130)
    EGen:Render()
    p1:draw()
    TouchContralls:Draw()
end
