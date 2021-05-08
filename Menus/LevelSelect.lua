LevelSelect = Class {}

local backgroundColor = {0.13, 0.47, 0.32}
local nextScreenColor = {0.6, 0.44, 0.39}
local globalX = 0
local leavingLevelSelect = false
local goingPlay = false
local goingMainMenu = false
levelSelected = false
selectedLevel = nil
levels = {}

for j = 0, 3, 1 do
    for i = 0, 2, 1 do
        xRect = 35 + i * 120
        yRect = 100 + j * 150
        table.insert(levels, {
            title = "",
            dist = nil,
            x = xRect,
            y = yRect,
            width = 80,
            height = 120,
            opened = false,
            selected = false,
            available = false
        })
    end
end

function LevelSelect:Update(dt)
    if leavingLevelSelect then
        if goingPlay then
            globalX = globalX - 800 * dt
        elseif goingMainMenu then
            globalX = globalX - 800 * dt
        end
    end
    if globalX >= 391 or globalX <= -400 then
        if goingMainMenu then
            gameState = 'MainMenu'
        elseif goingPlay then
            GameManager:SetCurrentLevel(selectedLevel)
            gameState = 'Playing'
        end
        LevelSelect:Reset()
    end
    if leavingLevelSelect then
        for i = 1, 3, 1 do
            if not (math.abs(backgroundColor[i] - nextScreenColor[i]) < 0.01) then
                if backgroundColor[i] < nextScreenColor[i] then
                    backgroundColor[i] = backgroundColor[i] + dt
                else
                    backgroundColor[i] = backgroundColor[i] - dt
                end
            end
        end
    end
end

function LevelSelect:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Level Select", Fonts['Secondary'], 100 + globalX, 17, 200, 'center')
    love.graphics.draw(images['back'], 25 + globalX, 775, 0, 0.1, 0.1)
    -- print(love.mouse.getX(), love.mouse.getY(), Fonts['main']:getWidth("Start"), Fonts['main']:getHeight("Start"))
    love.graphics.setColor(1, 1, 1, (levelSelected and 1) or 0.5)
    love.graphics.printf("Start", Fonts['main'], 210 + globalX, 760, 200, 'center')

    for i, v in ipairs(levels) do
        love.graphics.setColor(1, (v.selected and 0.1) or 1, (v.selected and 0.14) or 1, (v.opened and 1) or 0.5)
        love.graphics.rectangle('line', v.x + globalX, v.y, v.width, v.height, 10, 10)
        if not v.available then
            love.graphics.setFont(Fonts['small'])
            love.graphics.print("Coming\n Soon", v.x + 7 + globalX, v.y + 25)
        elseif not v.opened then
            love.graphics.draw(images['lock'], v.x + v.width / 2 - 25 + globalX, v.y + v.height / 2 - 25, 0, 0.1, 0.1)
        else
            love.graphics.setFont(Fonts["small"])
            -- love.graphics.rectangle("line", v.x, v.y, Fonts["small"]:getWidth(v.title),
            --     Fonts["small"]:getHeight(v.title))
            love.graphics.printf(v.title, v.x + globalX, v.y, v.width, 'center', 0, 1, 1, 0, -40)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)

end

function LevelSelect:mousePressed(x, y)
    if CheckMouseCollision(x, y, 25, 775, 50, 50) then
        goingMainMenu = true
        leavingLevelSelect = true
    elseif CheckMouseCollision(x, y, 240, 770, Fonts['main']:getWidth("Start") + 10,
        Fonts['main']:getHeight("Start") - 10) then
        if levelSelected then
            goingPlay = true
            leavingLevelSelect = true
        end
    end
    for i, v in ipairs(levels) do
        if CheckMouseCollision(x, y, v.x, v.y, v.width, v.height) and v.available then
            v.selected = true
            selectedLevel = v.dist
            levelSelected = true
            for j, p in ipairs(levels) do
                if not (v == p) then
                    p.selected = false
                end
            end
        end
    end
end

function LevelSelect:Reset()
    globalX = 0
    leavingLevelSelect = false
    for i, v in ipairs(levels) do
        v.selected = false
    end
    levelSelected = false
end

function LevelSelect:AddNewLevel(title, dist)
    for i = 1, #levels do
        if not levels[i].available then
            levels[i].title = title
            levels[i].dist = dist
            levels[i].available = true
            break
        end
    end
end
