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


--                  Game 1 update - update to graphics settings


-- setup the window width and height for the pong game
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    to get a library import use the "require" command in lua and name of the
    library
    push - it is a library that will allow to draw the game at a virtual
    resolution but a the window size that was already defined above

    https://github.com/Ulydev/push
]]
push = require 'push'

-- set up virtual resolution width and height
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    love.load() - is used for initializing the love2d game at the very 
    beginning of progrma execution
]]
function love.load()
    --[[
        in order to make the graphics look more "retro" there is a way to set some
        default filter - it sets the texture scaling filter when minimizing and
        magnifying textures and fonts; default setting is bilinear (causes 
        blurriness) and the setting to get more retro look is "nearest"
    ]]
    --[[
        virtual resulotion is now used to initialize game window with the push
        library function already imported
    ]]
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })




--[[
    keypressed(key) is a callback love2d function that executes whenever the
    key is pressed - has to be implemented in at least one of the main
    functions: load, update, draw
]]

-- event.quit - a simple function that terminates application

