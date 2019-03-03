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
        in order to make the graphics look more "retro" there is a way to set 
        some default filter - it sets the texture scaling filter when minimizing
        and magnifying textures and fonts; default setting is bilinear (causes 
        blurriness) and the setting to get more retro look is "nearest"
    ]]
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --[[
        virtual resulotion is now used to initialize game window with the push
        library function - "setupScreen" - already imported
    ]]
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
--[[
    keypressed(key) is a callback love2d function that executes whenever the
    key is pressed - it is called for each frame
]]
function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- event.quit - a simple function that terminates application
        love.event.quit()
    end
end

--[[
    after calling initialization or each update the script will now deliver
    the update to the screen with draw function
]]
function love.draw()
    --[[
        begin rendering at virtual resolution - the rendering will be done for
        everything in between 'start' and 'end'
    ]]
    push:apply('start')
    --[[
        in this case the draw function will run the printf function that is 
        used to printout msg on game window (not consol) with additional 
        parameters but using the virtual resolution:
    ]]
    love.graphics.printf(
        'Hello Pong!',          -- text to wright - default font = 12px
        0,                      -- starting at x=0 (centered based on width)
        VIRTUAL_HEIGHT / 2-6,    -- starting y (halfway down the virt screen)
        VIRTUAL_WIDTH,           -- number of pixels to center with
        'center'                -- alignment mode (can be "left", etc.)
        )
    push:apply('end')
end
