LevelCompleted = Class {}
local clickToStartOpacity = 1
local clickToStartOpacityRev = false
local backgroundColor = {0.1, 0.5, 0.3}
local quittingLevelCompleted =false
local overallOpacity = 1
function LevelCompleted:update(dt)
    for k in pairs(enemies) do
        enemies[k] = nil
    end
    if not quittingLevelCompleted  then
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
        gameState = 'LevelSelect'
        quittingLevelCompleted = false
        overallOpacity = 1
    end
end

function LevelCompleted:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, overallOpacity)
    love.graphics.printf("Level Completed", Fonts['Secondary'], 00, 200, 400, 'center')
    love.graphics.setColor(1, 1, 1, (quittingLevelCompleted  and overallOpacity) or clickToStartOpacity)
    love.graphics.printf("Click  To  Continue", Fonts['Secondary'], 0, 700, 400, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end

function LevelCompleted:mousePressed(x, y)
    quittingLevelCompleted= true
end
