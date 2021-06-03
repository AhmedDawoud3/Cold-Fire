BaseLevel = Class {}

function BaseLevel:init()
    p1 = Character(168, 673)


    self.walls = {}
end

function BaseLevel:update(dt)
    p1:update(dt)
    FPS = 1 / dt
    mouseX, mouseY = TouchContralls:GetMotion()
    p1:Move(mouseX, mouseY)
    for i = #enemies, 1, -1 do
        if enemies[i].type == 2 then
            enemies[i].x = enemies[i].x + enemies[i].dx * dt
            if (enemies[i].x > enemies[i].originalX + enemies[i].distX) or (enemies[i].x < enemies[i].originalX) then
                enemies[i].dx = -enemies[i].dx
            end
        end
    end
end

function BaseLevel:Render()
    love.graphics.clear(0.6, 0.44, 0.39, 1)
    love.graphics.setColor(1, 1, 1, 1)
    Maps:Render()
    EGen:Render()
    p1:draw()
    TouchContralls:Draw()

end
