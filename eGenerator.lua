EGen = Class {}
require 'enemy'
enemies = {}
function EGen:NewEnemy(x, y, size)
    enemy = Enemy(x, y, size)
    table.insert(enemies, enemy)
end

function EGen:GenerateRandom(numberOfEnemies)
    numberOfEnemies = numberOfEnemies or 1
    for i = 1, numberOfEnemies do
        eSize = math.random(10, 25)
        eX = math.random(20, WIDTH - eSize - 10)
        eY = math.random(20, HEIGHT - 20)
        EGen:NewEnemy(eX, eY, eSize)
    end
end

function EGen:Render()
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:Render()
    end
end
