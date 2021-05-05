Class = require 'Utils/class'
require 'Player/TouchContralls'
require 'Player/character'
require 'Enemy/eGenerator'
require 'GameManager/GameManager'
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

function love.load()
    math.randomseed(os.time())
    love.window.setMode(391, 862)
    love.window.setTitle("Cold Fire")
    Fonts = {
        ["main"] = love.graphics.newFont('Fonts/font0.ttf', 32),
        ["Big"] = love.graphics.newFont('Fonts/font0.ttf', 100),
        ["Secondary"] = love.graphics.newFont('Fonts/Font1.ttf', 40)
    }
    GameManager = GameManager()
end

function love.update(dt)
    GameManager:update(dt)
end

function love.draw()
    GameManager:Render()
end
