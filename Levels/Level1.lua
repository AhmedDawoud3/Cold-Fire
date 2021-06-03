Level1 = Class {}

function Level1:init()
    p1 = Character(168, 673)
    wall0 = Maps:CreateWall(80, 460, 400, 40, 0.4, 0.5, 0.6)
    wall1 = Maps:CreateWall(00, 360, 300, 40, 0.4, 0.5, 0.6)

    self.walls = {}
    table.insert(self.walls, wall0)
    table.insert(self.walls, wall1)
    EGen:NewEnemy(1, 50, 100, 10)
    EGen:NewEnemy(1, 391-50, 100, 10)
    EGen:NewEnemy(1, 195, 50, 10)
    EGen:NewEnemy(1, 195, 100, 10)

end

function Level1:update(dt)
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

function Level1:Render()
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
