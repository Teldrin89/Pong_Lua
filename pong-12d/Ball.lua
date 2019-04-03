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
    self.dy = math.random(0, 2) == 1 and -100 or 100
    -- additional randomization introduced to velocity in x direction
    self.dx = math.random(0, 2) == 1 and math.random(-80, -100) or math.random(
        80, 100)
end

--[[
    additional function for aabb collision detection - checking if ball and 
    paddle rectangles overlap
]]
function Ball:collides(paddle)
    --[[ 
        check if left edge of either is farther to the right then the right edge
        of the other
    ]]
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    --[[
        check if the bottom edge of either pad or ball is lower than the top
        edge of the other
    ]]
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    -- if the above aren't true, paddle and ball are overlapping
    return true
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
