SaveManager = Class {}

function SaveManager:SaveGame(params)
    if not params then
        self.money = money or 0
    else
        self.money = params.money
    end
    local file = love.filesystem.newFile("data.sav")
    file:open("w")
    file:write(self.money .. "\n")
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
