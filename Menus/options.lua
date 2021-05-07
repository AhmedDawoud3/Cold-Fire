Options = Class {}
local backgroundColor = {0.13, 0.47, 0.32}
local globalX = 0
local leavingOptions = false

function Options:Update(dt)
    if leavingOptions then
        globalX = globalX + 800 * dt
    end
    if globalX >= 391 then
        gameState = 'MainMenu'
        Options:Reset()
    end
end

function Options:Render()
    -- Change background Color
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])

    -- Reset The Colors
    love.graphics.setColor(1, 1, 1, 1)

    -- Print "Options" in The Top
    love.graphics.printf("Options", Fonts['main'], 100 + globalX, 7, 200, 'center')

    -- Back Button
    love.graphics.draw(images['back'], 25 + globalX, 775, 0, 0.1, 0.1)
end

function Options:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) then
        leavingOptions = true
    end
end

function Options:Reset()
    globalX = 0
    leavingOptions = false
end
