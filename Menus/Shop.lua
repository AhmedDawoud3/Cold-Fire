Shop = Class {}

local backgroundColor = {0.13, 0.47, 0.32}
local globalX = 0
local leavingShop = false
upgrades = {}
for j = 0, 3, 1 do
    for i = 0, 2, 1 do
        xRect = 35 + i * 120
        yRect = 200 + j * 140
        table.insert(upgrades, {
            title = "",
            discription = "",
            price = 0,
            x = xRect,
            y = yRect,
            width = 80,
            height = 110,
            owned = false,
            upgradable = false,
            available = false
        })
    end
end
function Shop:Update(dt)
    for i, v in ipairs(upgrades) do
        if v.price <= money then
            v.upgradable = true
        else
            v.upgradable = false
        end
    end
    if leavingShop then
        globalX = globalX + 800 * dt
    end
    if globalX >= 391 then
        gameState = 'MainMenu'
        Shop:Reset()
    end
end

function Shop:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Shop", Fonts['main'], 100 + globalX, 7, 200, 'center')
    love.graphics.draw(images['back'], 25 + globalX, 775, 0, 0.1, 0.1)
    love.graphics.printf("Current Moeny :" .. tonumber(money), Fonts['small'], 100 + globalX, 100, 200, 'center')
    love.graphics.printf("Available Upgrades", Fonts['SecondarySmall'], 100 + globalX, 150, 200, 'center')
    for i, v in ipairs(upgrades) do
        love.graphics.setColor(1, 1, 1, (not v.available and 0.5) or (v.upgradable and 1) or (v.owned and 0.5) or 0.5)
        love.graphics.rectangle('line', v.x + globalX, v.y, v.width, v.height, 10, 10)
        if not v.available then
            love.graphics.setFont(Fonts['small'])
            love.graphics.print("Coming\n Soon", v.x + 7 + globalX, v.y + 25)
        else
            love.graphics.setFont(Fonts["smallest"])
            love.graphics.printf(v.title, v.x + globalX, v.y, v.width, 'center', 0, 1, 1, 0, 0)
            love.graphics.printf(v.price, v.x + globalX, v.y, v.width, 'center', 0, 1, 1, 0, -80)
        end
    end
end

function Shop:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) then
        leavingShop = true
    end
end

function Shop:Reset()
    globalX = 0
    leavingShop = false
end

function Shop:LoadData()
    shopData = {}
    for line in love.filesystem.lines("Menus/shop.txt") do
        one, two, three = line:match("([^,]+),([^,]+),([^,]+)")
        table.insert(shopData, {
            ['name'] = one,
            ['price'] = two,
            ['description'] = three
        })
    end
    for i, v in ipairs(shopData) do
        upgrades[i].title = v['name']
        upgrades[i].price = tonumber(v['price'])
        upgrades[i].discription = v['description']
        upgrades[i].available = true
    end
    return shopData
end
