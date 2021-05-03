Class = require 'class'
require 'TouchContralls'
require 'character'
require 'eGenerator'
require 'GameManager'
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

function love.load()
    math.randomseed(os.time())
    love.window.setMode(391, 862)
    Fonts = {
        ["main"] = love.graphics.newFont('Fonts\\font0.ttf'),
        ["Secondary"] = love.graphics.newFont('Fonts\\font1.ttf')
    }
    GameManager = GameManager()
end

function love.update(dt)
    GameManager:update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    GameManager:Render()
end
