TouchContralls = Class {}
-- love.mouse.getPosition( )

centerX = 391 / 2
centerY = 862 - 75
mousePressed = false
function TouchContralls:GetMotion()
    if not love.mouse.isDown(1) and not mousePressed then
        centerX = 391 / 2
        centerY = 862 - 75
        return 0, 0
    end
    mouseX, mouseY = love.mouse.getPosition()

    if mousePressed then
        mousePressed = false
        centerX = mouseX
        centerY = mouseY
    end

    return mouseX - centerX, mouseY - (centerY)
end

function TouchContralls:Draw()
    x, y = TouchContralls:GetMotion()
    x = math.Clamp(x, -50, 50)
    y = math.Clamp(y, -50, 50)
    ang = GetAngle(0, 0, x, y)
    x = math.cos(ang) * math.min(50, GetDistance(0, 0, x, y))
    y = math.sin(ang) * math.min(50, GetDistance(0, 0, x, y))
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
