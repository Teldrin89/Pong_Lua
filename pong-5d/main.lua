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

-- game init
function love.load()
    -- calling randomseed function, passing the current time in seconds
    math.randomseed(os.time())
    -- retro graphic setting
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- new font object import - has to be in the same directory
    smallFont = love.graphics.newFont('font.ttf', 8)
    -- larger font setup for score
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- push setupScreen function for game window settings (resizable - true)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- initialize scroe variables for both players (used later for rendering)
    player1Score = 0
    player2Score = 0

    --[[
        initialize players paddles - making them global so that other functions 
        and modules can see them - with new Paddle class
    ]] 
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- initialize the ball in the middle of the screen using ball class
    ball = Ball(VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2, 4, 4)

    --[[
        define game state variable that then will be used to transition between
        different parts of the game - used to determine behavior during render
        and update state
    ]] 
    gameState = 'start'
end

-- update(dt) is an update function that runs every frame
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- applying the paddle speed using the paddle class functions
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        -- added the case with no key pressed
        player1.dy = 0
    end

    -- the same movement setup for player 2 (up and down keys)
    if love.keyboard.isDown('up') then
        -- applying the paddle speed using the paddle class functions
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        -- added the case with no key pressed
        player2.dy = 0
    end
    
    -- update ball using the ball class 
    if gameState == 'play' then
        ball:update(dt)
    end

    -- update both players
    player1:update(dt)
    player2:update(dt)
end

-- keypress function - expanded for game state definition
function love.keypressed(key)
    -- defining quit game key - escape
    if key == 'escape' then
        -- event.quit - a simple function that terminates application
        love.event.quit()
    -- defining start game key - enter/return - changes state to "play"
    elseif key == 'enter' or key == 'return' then
        -- if the game state is 'start' then set it to 'play'
        if gameState == 'start' then
            gameState = 'play'
        -- otherwise set game state to start and set initial values
        else
            gameState = 'start'
            -- reseting ball's position using the new class approach
            ball:reset()
        end
    end
end

-- call draw function
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    -- draw welcome text with small font
    love.graphics.setFont(smallFont)
    -- printf function with game title - depending on the game state
    if gameState == 'start' then
        love.graphics.printf(
            'Hello Start!',         -- text to wright
            0,                      -- starting at x=0 (centered based on width)
            20,                     -- starting y - slightly off the top
            VIRTUAL_WIDTH,          -- number of pixels to center with
            'center'                -- alignment mode (can be "left", etc.)
                )
    else
        love.graphics.printf(
            'Hello Play!',          -- text to wright
            0,                      -- starting at x=0 (centered based on width)
            20,                     -- starting y - slightly off the top
            VIRTUAL_WIDTH,          -- number of pixels to center with
            'center'                -- alignment mode (can be "left", etc.)
                )
    end
    -- setup the larger font for score
    love.graphics.setFont(scoreFont) 
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
    
    -- render paddles using their class's reder functions
    player1:render()
    player2:render()
    -- render ball - similar to paddles
    ball:render()
    -- end rendering at virtual resolution
    push:apply('end')
    -- set up background color - grey
    love.graphics.setBackgroundColor(.157,.176,.204)
end
