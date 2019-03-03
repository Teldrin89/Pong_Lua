-- first game devloped in lua with GD50 course using love framework
-- before running this simple example in case of 1st run with LOVE framework
-- remember to add love dictionary to PATH
-- lua is a lightweight scripting language focused around "tables" (sort of like
-- dictionaries in Python)
-- LOVE2D is a game development framework written in c++; it uses lua as its
-- scripting language

-- PONG game - replica of 1970s game


--                  Game 0 update - initial game window setup


-- setup the window width and height for the pong game - constant variables
-- that will be avialable throughout the application
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- love2d only expects a "main.lua" file to start game - other scripts can
-- be referenced from main
-- love.load() - is used for initializing the love2d game at the very beginning
-- of progrma execution

-- in this update the love.load function is filled with setMode function 
-- setting up the window for game with prviously set up the window size and 
-- adding some additional prameters with table (that is defined in "{}"): 
-- fullscreen, resaizable and vsync options
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,     -- not fullscreen window
        resizable = false,      -- not resaizable window
        vsync = true            -- synced to monitor refreshrate
    })
end

-- love.update(dt) - is function called each frame by love2d, dt will be the
-- elpased time in seconds since the last frame

-- love.draw() - is a function called each frame by love2d after update for
-- drawing things to the screen once the've changed
function love.draw()
    -- in this case the draw function will run the printf function that is used
    -- to printout msg on game window (not consol) with additional parameters:
    love.graphics.printf(
        'Hello Pong!',          -- text to wright - default font = 12px
        0,                      -- starting at x=0 (centered based on width)
        WINDOW_HEIGHT / 2-6,    -- starting y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center with
        'center'                -- alignment mode (can be "left", etc.)
    )
end

-- the 3 main functions: load, update and draw are expected in main.lua file
-- for love2d framework to run the game (the framework will still work but at
-- least the load and draw are necessary to see anthing happen)