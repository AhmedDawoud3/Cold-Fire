EGen = Class {}
require 'Enemy/enemy'
enemies = {}
function EGen:NewEnemy(type, x, y, size, r, g, b)
    r = r or 1
    g = g or 0.3
    b = b or 0.26
    enemy = Enemy(type, x, y, size, r, g, b)
    table.insert(enemies, enemy)
end

function EGen:GenerateRandom(numberOfEnemies1)
    if numberOfEnemies1 then
        for i = 1, numberOfEnemies1 do
            eSize = math.random(10, 25)
            eX = math.random(10 + eSize, 391 - eSize)
            eY = math.random(10 + eSize, 862 - eSize)
            eR = math.random(9000, 10000) / 10000
            eG = math.random(2000, 4000) / 10000
            eB = math.random(2000, 4000) / 10000
            EGen:NewEnemy(1, eX, eY, eSize, eR, eG, eB)
        end
    end
end

function EGen:Render()
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:Render()
    end
end
