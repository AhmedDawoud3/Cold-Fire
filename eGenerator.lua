EGen = Class {}
require 'enemy'
enemies = {}
function EGen:NewEnemy(x, y, size, r, g, b)
    r = r or 1
    g = g or 0.3
    b = b or 0.26
    enemy = Enemy(x, y, size, r, g, b)
    table.insert(enemies, enemy)
end

function EGen:GenerateRandom(numberOfEnemies)
    numberOfEnemies = numberOfEnemies or 1
    for i = 1, numberOfEnemies do
        eSize = math.random(10, 25)
        eX = math.random(20, WIDTH - eSize - 10)
        eY = math.random(20, HEIGHT - 20)
        eR = math.random(9000, 10000) / 10000
        eG = math.random(2000, 4000) / 10000
        eB = math.random(2000, 4000) / 10000
        EGen:NewEnemy(eX, eY, eSize, eR, eG, eB)
    end
end

function EGen:Render()
    for i = #enemies, 1, -1 do
        local enemy = enemies[i]
        enemy:Render()
    end
end
