Start = Class {}
local clickToStartOpacity = 1
local clickToStartOpacityRev = false
local overallOpacity = 1
local quittingStart = false
local nextScreenColors = {0.6, 0.44, 0.39}
local backgroundColor = {0.1, 0.5, 0.3}
function Start:Update(dt)
    if not quittingStart then
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
        for i = 1, 3, 1 do
            if not (math.abs(backgroundColor[i] - nextScreenColors[i]) < 0.01) then
                if backgroundColor[i] < nextScreenColors[i] then
                    backgroundColor[i] = backgroundColor[i] + dt
                else
                    backgroundColor[i] = backgroundColor[i] - dt
                end
            end
        end
    end

    if overallOpacity <= 0 then
        gameState = 'Playing'
    end
end

function Start:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setFont(Fonts['main'])
    -- love.graphics.print("Cold", 130, 200)
    -- love.graphics.print("Fire", 208, 200)
    love.graphics.setFont(Fonts['Big'])
    love.graphics.print("Cold", 117 - 20, 200)
    love.graphics.print("Fire", 123 - 20, 300)
    if quittingStart then
        love.graphics.setColor(1, 1, 1, overallOpacity)
    else
        love.graphics.setColor(1, 1, 1, clickToStartOpacity)
    end
    love.graphics.printf("Click  To  Start", Fonts['Secondary'], 100, 700, 200, 'center')
    love.graphics.setColor(1, 1, 1, overallOpacity)
    -- love.graphics.printf("Cold Fire", Fonts['main'], 100, 200, 200, 'center')
end

function Start:MosuePressed()
    quittingStart = true
end
