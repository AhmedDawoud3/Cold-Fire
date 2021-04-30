TouchContralls = Class {}
-- love.mouse.getPosition( )

centerX = 391 / 2
centerY = 862 - 75
mosuePressed = false
function TouchContralls:GetMotion()
    if not love.mouse.isDown(1) and not mousePressed then
        return 0, 0
    end

    mouseX, mouseY = love.mouse.getPosition()

    if mouseY > centerY - 75 and mouseX > 100 and mouseX < 300 then
        mosuePressed = true
    end
    return mouseX - 391 / 2, mouseY - 712 - 75
end
function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        mosuePressed = true
    end
end
function TouchContralls:Draw()
    x, y = TouchContralls:GetMotion()
    x = math.Clamp(x, -100, 100)
    y = math.Clamp(y, -100, 100)
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.circle("line", centerX, centerY, 50)
    love.graphics.circle("fill", centerX + x, centerY + y, 35)
end
function math.Clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then
        lower, upper = upper, lower
    end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end
