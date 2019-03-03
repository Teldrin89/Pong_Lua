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


--                  Game 2 update - content update: paddles and ball


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

-- game init
function love.load()
    -- retro graphic setting
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- push setupScreen function for game window settings
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
-- keypress function for game quit
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- event.quit - a simple function that terminates application
        love.event.quit()
    end
end

-- call draw function
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    -- printf function with game title
    love.graphics.printf(
        'Hello Pong!',          -- text to wright - default font = 12px
        0,                      -- starting at x=0 (centered based on width)
        VIRTUAL_HEIGHT / 2-6,    -- starting y (halfway down the virt screen)
        VIRTUAL_WIDTH,           -- number of pixels to center with
        'center'                -- alignment mode (can be "left", etc.)
        )
    push:apply('end')
end
