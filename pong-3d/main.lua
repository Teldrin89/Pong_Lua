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


--                  Game 3 update - paddle move update


-- setup the window width and height for the pong game
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    push - it is a library that will allow to draw the game at a virtual
    resolution but a the window size that was already defined above
    https://github.com/Ulydev/push
]]
push = require 'push'

-- set up virtual resolution width and height
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    keyboard.isDown(key) - a function that returns true or false depending on
    whether the specified key is currently held down (different from 
    keypressed(key) function as that one only fire its code once)
]]
-- setup the pad speed variable - 200 (arbitrary value)
PADDLE_SPEED = 200

-- game init
function love.load()
    -- retro graphic setting
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- new font object import - has to be in the same directory
    smallFont = love.graphics.newFont('font.ttf', 8)
    -- larger font setup for score
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set love2d active font to the new one
    love.graphics.setFont(smallFont)

    -- push setupScreen function for game window settings
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize scroe variables for both players (used later for rendering)
    player1Score = 0
    player2Score = 0

    -- initial position of paddles on Y axis
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end
