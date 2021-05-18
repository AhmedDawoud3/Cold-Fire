PauseScreen = Class {}
local backgroundColor = {0.1, 0.5, 0.3}
local clickToStartOpacity = 1
local clickToStartOpacityRev = false

function PauseScreen:Update(dt)
    if clickToStartOpacity >= 1 then
        clickToStartOpacityRev = true
    elseif clickToStartOpacity <= 0.3 then
        clickToStartOpacityRev = false
    end
    if clickToStartOpacityRev then
        clickToStartOpacity = clickToStartOpacity - dt
    else
        clickToStartOpacity = clickToStartOpacity + dt
    end
end

function PauseScreen:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Game Paused", Fonts['main'], 00, 200, 400, 'center')
    love.graphics.printf("Current Money :" .. money, Fonts['small'], 00, 400, 400, 'center')
    love.graphics.setColor(1, 1, 1, clickToStartOpacity)
    love.graphics.printf("Click To Continue", Fonts['Secondary'], 0, 700, 400, 'center')
end
function PauseScreen:mousePressed(x, y)
    gameState = 'Playing'
end
