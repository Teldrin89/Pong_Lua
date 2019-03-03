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

    --[[
        graphics.newFont(path, size) is the functio that will load a new font
        into memory to then use it globally inside the game script with
        graphics.setFont(font) function
    ]]
    -- new font object import - has to be in the same directory
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- set love2d active font to the new one
    love.graphics.setFont(smallFont)

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

    --[[
        graphics.clear() clears the screen and set it up to background color
        graphics.setBackgroundColor(r,g,b) sets up the background color
        changed in v11 (in previous versions the clear functio had option to
        set up background color)
    ]]
    -- set up background color - grey
    love.graphics.setBackgroundColor(.5,.5,0,1)
    -- clear the screen with a previously defined background color
    -- love.graphics.clear()

    -- printf function with game title updated
        love.graphics.printf(
            'Hello Pong!',          -- text to wright
            0,                      -- starting at x=0 (centered based on width)
            20,                     -- starting y - slightly off the top
            VIRTUAL_WIDTH,          -- number of pixels to center with
            'center'                -- alignment mode (can be "left", etc.)
            )

    --[[
        graphics.rectangle(mode, x, y, width, height) is a function used to
        build blocks of rectangles that will represent paddles and ball
    ]]
    -- render 1st paddle - left side
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    -- render 2nd paddle - right side
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-50, 5, 20)
    -- render ball (at center) - there is "-2" as the ball is 4x4 size
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 -2, VIRTUAL_HEIGHT/2 -2, 
    4, 4)
    love.graphics.setBackgroundColor(.5,.5,0,1)
    push:apply('end')
end
