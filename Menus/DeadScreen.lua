DeadScreen = Class {}
local clickToStartOpacity = 1
local clickToStartOpacityRev = false
local backgroundColor = {0.1, 0.5, 0.3}
local quittingDeadScreen = true
local overallOpacity = 1
function DeadScreen:update(dt)
    for k in pairs(enemies) do
        enemies[k] = nil
    end
    if not quittingDeadScreen then
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
    else
        overallOpacity = overallOpacity - dt / 2
    end
    if overallOpacity <= 0 then
        gameState = 'MainMenu'
        quittingDeadScreen = false
        overallOpacity = 1
    end
end

function DeadScreen:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, overallOpacity)
    love.graphics.printf("You're Dead :(", Fonts['main'], 00, 200, 400, 'center')
    love.graphics.setColor(1, 1, 1, (quittingDeadScreen and overallOpacity) or clickToStartOpacity)
    love.graphics.printf("Click  To  Start Again", Fonts['Secondary'], 100, 700, 200, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end

function DeadScreen:mousePressed(x, y)
    quittingDeadScreen = true
end
