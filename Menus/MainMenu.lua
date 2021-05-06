MainMenu = Class {}

local backgroundColor = {0.13, 0.47, 0.32}
local nextScreenColors = {0.6, 0.44, 0.39}
local quittingMainMenu = false
local xCold = -200
local xFire = 200
local overallOpacity = 1
local options = {
    optionsOpacity = 0,
    x = 10,
    y = 15,
    lineX = 5,
    lineY = 10,
    lineWidth = 60,
    lineHeight = 60
}
local playButton = {
    x = 391 / 2 - Fonts['main']:getWidth("Play") / 2,
    y = 730,
    lineX = (391 / 2 - Fonts['main']:getWidth("Play") / 2) - 60,
    lineY = 732,
    lineWidth = Fonts['main']:getWidth("Play") + 120,
    lineHeight = Fonts['main']:getHeight("Play")
}
local optionsOpacity = 0
function MainMenu:Update(dt)
    xCold = math.min(0, xCold + 350 * dt)
    xFire = math.max(0, xFire - 350 * dt)
    optionsOpacity = math.min(1, optionsOpacity + dt)
    if quittingMainMenu then
        overallOpacity = overallOpacity - dt / 2
        for i = 1, 3, 1 do
            if not (math.abs(backgroundColor[i] - nextScreenColors[i]) < 0.01) then
                if backgroundColor[i] < nextScreenColors[i] then
                    backgroundColor[i] = backgroundColor[i] + dt / 4
                else
                    backgroundColor[i] = backgroundColor[i] - dt / 4
                end
            end
        end
    end
    if overallOpacity <= 0 then
        gameState = 'Playing'
    end
end

function MainMenu:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, overallOpacity)
    love.graphics.printf("Cold", Fonts['main'], 45 + xCold, 7, 200, 'center')
    love.graphics.printf("Fire", Fonts['main'], 155 + xFire, 7, 200, 'center')
    if quittingMainMenu then
        love.graphics.setColor(1, 1, 1, overallOpacity)
    else
        love.graphics.setColor(1, 1, 1, optionsOpacity)
    end
    love.graphics.draw(images['options'], options.x, options.y, 0, 0.1, 0.1)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", options.lineX, options.lineY, options.lineWidth, options.lineHeight, 10, 10)
    love.graphics.setFont(Fonts['main'])
    love.graphics.print("Play", playButton.x, playButton.y)
    love.graphics.rectangle("line", playButton.lineX, playButton.lineY, playButton.lineWidth, playButton.lineHeight, 10,
        10)
end

function MainMenu:mousePressed(x, y)
    if CheckMouseCollision(x, y, playButton.lineX, playButton.lineY, playButton.lineWidth, playButton.lineHeight) then
        quittingMainMenu = true
    end
end

function CheckMouseCollision(x, y, x2, y2, width, height)
    if x < x2 + width and x > x2 and y < y2 + height and y > y2 then
        return true
    end
    return false
end
