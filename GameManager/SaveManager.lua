SaveManager = Class {}

function SaveManager:SaveGame(money, upgrades)
    if money ~= nil then
        self.money = money
    else
        if SaveManager:LoadGame()[1] then
            self.money = tonumber(SaveManager:LoadGame()[1])
        else
            self.money = 0
        end
    end
    if upgrades then
        self.upgrades = upgrades
    else
        if SaveManager:LoadGame()[2] then
            self.upgrades = SaveManager:LoadGame()[2]
        else
            self.upgrades = '00000000'
        end
    end
    -- if not params then
    --     if SaveManager:LoadGame() then
    --         self.money = SaveManager:LoadGame()[1]
    --         self.upgrades = SaveManager:LoadGame()[2]
    --     else
    --         self.money = 0
    --         self.upgrades = 000
    --     end
    -- else
    --     self.money = params.money or SaveManager:LoadGame()[1]
    --     self.upgrades = params.upgrades or SaveManager:LoadGame()[2]
    -- end
    local file = love.filesystem.newFile("data.sav")
    file:open("w")
    file:write(self.money .. "\n")
    file:write(self.upgrades .. "\n")
    file:close()
end

function SaveManager:LoadGame()
    local file = love.filesystem.newFile("data.sav")
    file:open("r")
    dataFile = file:read()
    file:close()
    if dataFile then
        data = {}
        for s in dataFile:gmatch("[^\r\n]+") do
            table.insert(data, s)
        end
    else
        data = {}
        table.insert(data, 0)
    end
    return data
end

function SaveManager:CheckForSaveFile()
    local file = love.filesystem.newFile("data.sav")
    file:open("r")
    data = file:read()
    file:close()
    if data then
        return true
    else
        return false
    end
end

function SaveManager:ChangeUpgrade(bit)
    data = SaveManager:LoadGame()[2]
    c1, c2, c3, c4, c5, c6, c7, c8 = SaveManager:LoadGame()[2]:match('(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)')
    t = {tonumber(c1), tonumber(c2), tonumber(c3), tonumber(c4), tonumber(c5), tonumber(c6), tonumber(c7), tonumber(c8)}
    if t[bit] == 0 then
        t[bit] = 1
    else
        t[bit] = 1
    end
    SaveManager:SaveGame(nil, tostring(t[1] .. t[2] .. t[3] .. t[4] .. t[5] .. t[6] .. t[7] .. t[8]))
end
