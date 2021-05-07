Class = require 'Utils/class'
Fonts = {
    ["main"] = love.graphics.newFont('Fonts/font0.ttf', 50),
    ["Big"] = love.graphics.newFont('Fonts/font0.ttf', 100),
    ["Secondary"] = love.graphics.newFont('Fonts/Font1.ttf', 40),
    ["SecondarySmall"] = love.graphics.newFont('Fonts/Font1.ttf', 35)
}
require 'Player/TouchContralls'
require 'Player/character'
require 'Enemy/eGenerator'
require 'GameManager/GameManager'
WIDTH = 391
HEIGHT = 862

function love.load()
    math.randomseed(os.time())
    love.window.setMode(391, 862)
    love.window.setTitle("Cold Fire")
    GameManager = GameManager()
end

function love.update(dt)
    GameManager:update(dt)
end

function love.draw()
    GameManager:Render()
end
