--[[
    -- Ball Class --
    Represents a ball which will bounce back and forth between paddles and 
    walls until it passes a left or right boundary of the screen, scoring
    a point for the opponent
]]
-- define the name of the class object using the class library
Ball = Class {}
--[[
    start defining functions for the ball class - first one is the init (starter
    function) the will define the size and position of a ball
]]
function Ball:init(x, y, width, height)
    --[[
        whenever the .self is mentioned in a function it refers to the class
        that the function has been built in
    ]]
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    -- additional information in initialization function - velocity
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    define the reset function for a ball - putting the ball in center of the
    screen on both axes
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    update function to appply the velocity and position to the ball, scaled
    by delta time
]]
function Ball:update(dt)
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
end

--[[
    render function - done for a ball individually here
]]
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
