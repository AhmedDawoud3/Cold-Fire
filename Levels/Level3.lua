Level3 = Class {}

function Level3:init()
    enemies = {}
    p1 = Character(168, 673)
    self.walls = {}

    EGen:NewEnemy(4, 10, 100)
    EGen:NewEnemy(4, 391 - 55, 100)

    EGen:NewEnemy(4, 10, 200)
    EGen:NewEnemy(4, 391 - 55, 200)

    EGen:NewEnemy(4, 391 / 2, 100)
    EGen:NewEnemy(4, 391 / 2 - 55, 100)

    EGen:NewEnemy(4, 10, 330)
    EGen:NewEnemy(4, 391 - 55, 240)

    EGen:NewEnemy(4,  391/2, 390)
    EGen:NewEnemy(4, 340, 400)

    EGen:NewEnemy(4, 110, 500)
    EGen:NewEnemy(4, 391 -150, 340)
    EGen:NewEnemy(4)
    EGen:NewEnemy(4)
    EGen:NewEnemy(4)
    EGen:NewEnemy(4)
    EGen:NewEnemy(4)
    EGen:NewEnemy(4)

end

function Level3:update(dt)
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

function Level3:Render()
    love.graphics.clear(0.6, 0.44, 0.39, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(Fonts['small'])
    love.graphics.print("Money :" .. money, 255, 20)
    love.graphics.print("HP :" .. p1.health.value, 20, 20)
    Maps:Render()
    EGen:Render()
    p1:draw()
    TouchContralls:Draw()

end
