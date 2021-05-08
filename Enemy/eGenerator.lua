EGen = Class {}
require 'Enemy/enemy'
enemies = {}
function EGen:NewEnemy(type, x, y, size, r, g, b)
    r = r
    g = g
    b = b
    enemy = Enemy(type, x, y, size, r, g, b)
    table.insert(enemies, enemy)
end

function EGen:GenerateRandom(numberOfEnemies1)
    if numberOfEnemies1 then
        for i = 1, numberOfEnemies1 do
            EGen:NewEnemy(1)
        end
    end
end

function EGen:Render()
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:Render()
    end
end
