EGen = Class {}
require 'Enemy/enemy'
-- Setting up an empty enemies table
enemies = {}

-- Function to create a new enemy
function EGen:NewEnemy(type, x, y, size, r, g, b)
    -- Creating a new enemy 
    enemy = Enemy(type, x, y, size, r, g, b)

    -- Adding the created enemy to 'enemies' table
    table.insert(enemies, enemy)
end

-- Function to create random enemies from type 1
function EGen:GenerateRandom(numberOfEnemies1)

    -- Checking if number of enemies parameter is giving
    if numberOfEnemies1 then
        -- Looping 'number of enemies' time
        for i = 1, numberOfEnemies1 do
            -- Creating random enemy of type 1
            EGen:NewEnemy(1)
        end
    else
        -- If not given number of enemies parameter then creating one random enemy
        EGen:NewEnemy(1)
    end

end

-- Function for rendering enemies
function EGen:Render()
    -- Looping 'number of enemies' time]
    for i = #enemies, 1, -1 do
        -- Setting local variable enemy to the enemy number i
        local enemy = enemies[i]
        -- Calling the render function for the enemy
        enemy:Render()
    end
end
