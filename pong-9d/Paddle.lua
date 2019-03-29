--[[
    -- Paddle Class --
    Represents a paddle which will move between top and bottom of the screen
    controled by players
]]
-- define the paddle class
Paddle = Class{}
--[[
    first function - init - for paddle, similar as for ball will reference the 
    paddles size, position and velocity
]]
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = dy
end

--[[
    update function for paddle - using math.max and min to ensure that the
    paddle position will not cross over the screen edge
]]
function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy*dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy*dt)
    end
end

--[[
    render function for the paddle - drawing rectangle with the 'fill' mode,
    postion and size
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
