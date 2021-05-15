DeadScreen = Class {}
local backgroundColor = {0.1, 0.5, 0.3}
function DeadScreen:Render()
    love.graphics.clear(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("You're Dead :(", Fonts['main'], 00, 200, 400, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
