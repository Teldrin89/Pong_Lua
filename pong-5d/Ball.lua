--[[
    -- Ball Class --
    Represents a ball which will bounce back and forth between paddles and 
    walls until it passes a left or right boundary of the screen, scoring
    a point for the opponent
]]

-- define the name of the class object using the class library
Ball = Class{}
-- start defining functions for the ball class - first one is the init
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
