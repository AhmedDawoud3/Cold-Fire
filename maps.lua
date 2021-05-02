Maps = Class {}

walls = {}

function CreateMap(params)
    self.params = params
    self.walls = params.walls
    self.enemies = params.enemies
end

function Maps:CreateWall(x, y, width, height, r, g, b)
    local wall = {}
    wall.x = x
    wall.y = y
    wall.width = width
    wall.height = height
    wall.r = r
    wall.g = g
    wall.b = b
    table.insert(walls, wall)
    return wall
end

function Maps:Render()
    for i, v in ipairs(walls) do
        love.graphics.setColor(v.r, v.g, v.b, 1)
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end
