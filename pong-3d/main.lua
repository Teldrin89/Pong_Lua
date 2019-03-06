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

--[[
    update(dt) is an update function that runs every frame, with dt passed in -
    delta time in second since the last frame
]]
function love.update(dt)
    --[[
    keyboard.isDown(key) - a function that returns true or false depending on
    whether the specified key is currently held down (different from 
    keypressed(key) function as that one only fire its code once)
    ]]
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y (scaled by dt)
        player1Y = player1Y + -PADDLE_SPEED*dt
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y (scaled by dt)
        player1Y = player1Y + PADDLE_SPEED*dt
    end

    -- the same movement setup for player 2 (up and down keys)
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y (scaled by dt)
        player2Y = player2Y + -PADDLE_SPEED*dt
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y (scaled by dt)
        player2Y = player2Y + PADDLE_SPEED*dt
    end
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

    -- draw welcome text with small font
    love.graphics.setFont(smallFont)
    -- printf function with game title
        love.graphics.printf(
            'Hello Pong!',          -- text to wright
            0,                      -- starting at x=0 (centered based on width)
            20,                     -- starting y - slightly off the top
            VIRTUAL_WIDTH,          -- number of pixels to center with
            'center'                -- alignment mode (can be "left", etc.)
            )
    
    -- setup the larger font for score
    love.graphics.setFont(scoreFont)
    --[[
        printout the score for both players using print function and
        changing the variable type to string
    ]] 
    -- score for player 1
    love.graphics.print(
        tostring(player1Score),
        VIRTUAL_WIDTH/2 - 50,
        VIRTUAL_HEIGHT/3
                    )
    -- score for player 2
    love.graphics.print(
        tostring(player2Score),
        VIRTUAL_WIDTH/2 + 30,
        VIRTUAL_HEIGHT/3
                    )

    -- render 1st paddle - left side
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    -- render 2nd paddle - right side
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-50, 5, 20)
    -- render ball (at center) - there is "-2" as the ball is 4x4 size
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 -2, VIRTUAL_HEIGHT/2 -2, 
    4, 4)

    push:apply('end')
    -- set up background color - grey
    love.graphics.setBackgroundColor(.157,.176,.204)
end