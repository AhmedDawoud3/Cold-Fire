Shop = Class {}

local backgroundColor = {0.13, 0.47, 0.32}
local globalX = 0
local leavingShop = false
local inShop = true
local globalOpacity = 1
local selectedUpgrade = nil
local YesButton = {
    x = 40,
    y = 650,
    width = 150,
    height = 50
}
local NoButton = {
    x = 10 + 391 / 2,
    y = 650,
    width = 145,
    height = 50
}
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
            available = false,
            selected = false,
            code = ''
        })
    end
end
function Shop:Update(dt)
    if selectedUpgrade then
        globalOpacity = 0.1
        inShop = false
    else
        inShop = true
        globalOpacity = 1
    end
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
    upgradeData = SaveManager:LoadGame()[2]
    c1, c2, c3, c4, c5, c6, c7, c8 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)')
    upgradeData = {tonumber(c1), tonumber(c2), tonumber(c3), tonumber(c4), tonumber(c5), tonumber(c6), tonumber(c7),
                   tonumber(c8)}
    for i, v in ipairs(upgradeData) do
        if v == 1 then
            upgrades[i].owned = true
        end
    end
end

function Shop:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, globalOpacity)
    love.graphics.printf("Shop", Fonts['main'], 100 + globalX, 7, 200, 'center')
    love.graphics.draw(images['back'], 25 + globalX, 775, 0, 0.1, 0.1)
    love.graphics.printf("Current Moeny: " .. tonumber(money), Fonts['small'], 100 + globalX, 100, 200, 'center')
    love.graphics.printf("Available Upgrades", Fonts['SecondarySmall'], 100 + globalX, 150, 200, 'center')
    for i, v in ipairs(upgrades) do
        love.graphics.setColor(1, (v.owned and 0.7 ) or 1, (v.owned and 0.7 ) or 1,
            (v.owned and globalOpacity / 2) or (not v.available and globalOpacity / 2) or
                (v.upgradable and globalOpacity) or globalOpacity / 2)
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
    if selectedUpgrade then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle('line', 30, 190, 330, 560, 10, 10)
        love.graphics.printf(selectedUpgrade.title, Fonts['Secondary'], 0, 210, 400, 'center')
        love.graphics.printf(selectedUpgrade.discription, Fonts['small'], 40, 270, 310, 'center')
        love.graphics.printf("Costs :" .. selectedUpgrade.price, Fonts['main'], 70, 380, 270, 'center')
        love.graphics.printf("Are You Sure You Want To Buy ?", Fonts['small'], 40, 610, 310, 'center')
        love.graphics.rectangle('line', YesButton.x, YesButton.y, YesButton.width, YesButton.height, 10, 10)
        love.graphics.printf("Yes", Fonts['Secondary'], -40, 660, 310, 'center')
        love.graphics.rectangle('line', NoButton.x, NoButton.y, NoButton.width, NoButton.height, 10, 10)
        love.graphics.printf("No", Fonts['Secondary'], 120, 660, 310, 'center')
    end
end

function Shop:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) and inShop then
        leavingShop = true
    end
    if selectedUpgrade then
        if CheckMouseCollision(x, y, YesButton.x, YesButton.y, YesButton.width, YesButton.height) then
            for i, v in ipairs(upgrades) do
                if v == selectedUpgrade then
                    SaveManager:ChangeUpgrade(i)
                end
            end
            money = money - selectedUpgrade.price
            selectedUpgrade.owned = true
            selectedUpgrade = false
        elseif CheckMouseCollision(x, y, NoButton.x, NoButton.y, NoButton.width, NoButton.height) then
            selectedUpgrade = false
        end
    else
        for i, v in ipairs(upgrades) do
            if CheckMouseCollision(x, y, v.x, v.y, v.width, v.height) and v.upgradable and not v.owned then
                selectedUpgrade = v
            end
        end
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
