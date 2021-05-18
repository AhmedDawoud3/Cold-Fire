Options = Class {}
local backgroundColor = {0.13, 0.47, 0.32}
local globalX = 0
local leavingOptions = false
local resetGameButton = {
    x = 391 / 2 - Fonts['main']:getWidth("Reset Stats") / 2,
    y = 680,
    lineX = (391 / 2) - 160,
    lineY = 682,
    lineWidth = 320,
    lineHeight = Fonts['main']:getHeight("Reset Stats")
}

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

    -- Reset Game Button

    -- Word
    love.graphics.print("Reset Stats", resetGameButton.x + globalX, resetGameButton.y)
    -- Border 
    love.graphics.rectangle("line", resetGameButton.lineX + globalX, resetGameButton.lineY, resetGameButton.lineWidth,
        resetGameButton.lineHeight, 10, 10)
end

function Options:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) then
        leavingOptions = true
    elseif CheckMouseCollision(x, y, resetGameButton.lineX, resetGameButton.lineY, resetGameButton.lineWidth,
        resetGameButton.lineHeight) then
        SaveManager:ResetStats()
    end
end

function Options:Reset()
    globalX = 0
    leavingOptions = false
end
