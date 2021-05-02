DemoLevel = Class {}

function DemoLevel:init()
    p1 = Character(100, 710)
    EGen:GenerateRandom(10)
    wall0 = Maps:CreateWall(200, 500, 100, 40, 0.4, 0.5, 0.6)
    wall1 = Maps:CreateWall(200, 600, 150, 40, 0.4, 0.5, 0.6)
    self.walls = {}
    table.insert(self.walls, wall0)
    table.insert(self.walls, wall1)
end

function DemoLevel:update(dt)
    p1:update(dt)
    FPS = 1 / dt
    mouseX, mouseY = TouchContralls:GetMotion()
    p1:Move(mouseX, mouseY)
end

function DemoLevel:Render()
    love.graphics.clear(0.6, 0.44, 0.39, 1)
    love.graphics.setColor(1, 1, 1, 1)
    Maps:Render()
    EGen:Render()
    p1:draw()
    TouchContralls:Draw()

end
