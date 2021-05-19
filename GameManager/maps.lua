Maps = Class {}

-- Initializing empty walls table
walls = {}

-- Function to create new wall
function Maps:CreateWall(x, y, width, height, r, g, b)
    -- Making a local wall table and adding the parameters to it
    local wall = {}
    wall.x = x
    wall.y = y
    wall.width = width
    wall.height = height
    wall.r = r
    wall.g = g
    wall.b = b
    -- Adding the wall the 'walls' table
    table.insert(walls, wall)
    return wall
end

-- Function fore rendering walls
function Maps:Render()
    -- looping through the walls
    for i, v in ipairs(walls) do
        -- Setting the r, g and b value the same as the wall
        love.graphics.setColor(v.r, v.g, v.b, 1)
        -- Draw the wall
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
        -- Resseting the colors
        love.graphics.setColor(1, 1, 1, 1)
    end
end

-- Function to check if a wall collided with a square using AABB collision detection
function Collides(wall, params)
    -- Setting object table with parameters valua
    obj = {}
    obj.x = params.x
    obj.y = params.y
    obj.width = params.width
    obj.height = params.height
    -- Checking for AABB collision 
    if obj.y < wall.y + wall.height and obj.y > wall.y + obj.height then
        if obj.x < wall.x + wall.width and obj.x > wall.x + obj.width then
            return true
        end
        if obj.x > wall.x - obj.width and obj.x < wall.x + wall.width then
            return true
        end
    end
    if obj.y > wall.y - obj.height and obj.y < wall.y + wall.height then
        if obj.x > wall.x - obj.width and obj.x < wall.x + wall.width then
            return true
        end
        if obj.x < wall.x + wall.width and obj.x > wall.x + obj.width then
            return true
        end
    end
    return false
end
