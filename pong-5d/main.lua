--[[ 
    first game devloped in lua with GD50 course using love framework
    before running this simple example in case of 1st run with LOVE framework
    remember to add love dictionary to PATH
    lua is a lightweight scripting language focused around "tables" (sort of 
    like dictionaries in Python)
    LOVE2D is a game development framework written in c++; it uses lua as its
    scripting language
]]
-- PONG game - replica of 1970s game


--                  Game 5 update - class update


-- setup the window width and height for the pong game
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    push - it is a library that will allow to draw the game at a virtual
    resolution but a the window size that was already defined above
    https://github.com/Ulydev/push
]]
push = require 'push'
--[[
    class is a sort of blueprint for object (for example a car) with 2 
    distinguished properties: methods (e.g. refuel) and attributes (e.g. color);
    defined class owns it's methods and properties so there is no need to define
    seprate functions; the perfect simple cases for classes in pong will be a
    paddle and ball as a class - put in seprate files (usually starting with
    capital letters)
]]
--[[
    the "class" library allows to represent a class in a similar way as in for
    example java or python (classes are a lua native feature but this
    additional library makes using an object oriented programming approach
    easier in lua)
    https://github.com/vrld/hump/blob/master/class.lua
]]
Class = require 'class'

--[[
    added the Paddle class with position, dimensions and the logic for rendering
    of each paddle
]]
require 'Paddle'
--[[
    added the Ball class with similar atributes and functions as paddle but for 
    the ball movement
]]
require 'Ball'
-- set up virtual resolution width and height
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- setup the pad speed variable - 200 (arbitrary value)
PADDLE_SPEED = 200