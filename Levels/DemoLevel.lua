DemoLevel = Class {}

function DemoLevel:init()
    p1 = Character(100, 110)
    EGen:GenerateRandom(10)
    wall0 = Maps:CreateWall(200, 500, 100, 40, 0.4, 0.5, 0.6)
    wall1 = Maps:CreateWall(200, 400, 150, 40, 0.4, 0.5, 0.6)
    EGen:NewEnemy(2)
    EGen:NewEnemy(3)
    EGen:NewEnemy(4)
    self.walls = {}
    table.insert(self.walls, wall0)
    table.insert(self.walls, wall1)
end

function DemoLevel:update(dt)
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

function DemoLevel:Render()
    love.graphics.clear(0.6, 0.44, 0.39, 1)
    love.graphics.setColor(1, 1, 1, 1)
    Maps:Render()
    EGen:Render()
    p1:draw()
    TouchContralls:Draw()

end
