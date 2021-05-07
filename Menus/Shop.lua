Shop = Class {}

local backgroundColor = {0.13, 0.47, 0.32}
local globalX = 0
local leavingShop = false

function Shop:Update(dt)
    if leavingShop then
        globalX = globalX + 800 * dt
    end
    if globalX >= 391 then
        gameState = 'MainMenu'
        Shop:Reset()
    end
end

function Shop:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Shop", Fonts['main'], 100 + globalX, 7, 200, 'center')
    love.graphics.draw(images['back'], 25 + globalX, 775, 0, 0.1, 0.1)

    love.graphics.printf("Available Upgrades", Fonts['SecondarySmall'], 100 + globalX, 100, 200, 'center')

end

function Shop:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) then
        leavingShop = true
    end
end

function Shop:Reset()
    globalX = 0
    leavingShop = false
end
