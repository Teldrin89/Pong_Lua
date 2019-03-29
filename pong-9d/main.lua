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


--                  Game 9 update - state machine


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
    the "class" library allows to represent a class in a similar way as in for
    example java or python (classes are a lua native feature but this
    additional library makes using an object oriented programming approach
    easier in lua)
    https://github.com/vrld/hump/blob/master/class.lua
]]
Class = require 'class'

-- add paddle class
require 'Paddle'
-- add ball class
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

    --[[
        to setup the window in which the game will be opened use window.setTitle
        function 
    ]]
    love.window.setTitle('Pong replica')

    -- new font object import - has to be in the same directory
    smallFont = love.graphics.newFont('font.ttf', 8)
    -- medium font
    mediumFont = love.graphics.newFont('font.ttf', 12)
    -- larger font setup for score
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- push setupScreen function for game window settings (resizable - true)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- initialize score variables for both players (incremented per score)
    player1Score = 0
    player2Score = 0

    -- initialize player's paddles 
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
    --[[
        adding a 3rd game state 'serve' that allows after each player scores
        to reset and the other player to serve the ball (determine x direction
        of velocity)
    ]]
    -- TODO: finished at 1:22:00 -> move to pong-10d
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    
    elseif gameState == 'play' then
        --[[
            adding ball collision detection with paddles for both players,
            reversing the speed in x direction, giving it a small increase and
            altering speed in y direction based on position of collision
        ]]
        if ball:collides(player1) then
            -- reverse speed and increase by 3%
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5
            -- change in sign of velocity in y direction to represent bounce
            if ball.dy < 0 then
                -- randomize y velocity
                ball.dy = -math.random(30,140)
            else
                -- randomize y velocity
                ball.dy = math.random(30, 140)
            end
        end
        --[[ 
            the same collision detection pattern for player2
            todo: consider some updates
        ]]
        if ball:collides(player2) then
            -- reverse speed and increase by 3%
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4
            -- change in sign of velocity in y direction to represent bounce
            if ball.dy < 0 then
                ball.dy = -math.random(30,140)
            else
                ball.dy = math.random(30, 140)
            end
        end
        -- collision detection with bottom of the screen
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end
        --[[ 
            collision detection with top of the screen (-4 to take into account
            the ball height)
        ]]
        if ball.y > VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end
    end

    -- player2 scoring scenario
    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1
        ball:reset()
        -- goes to "serve" state
        gameState = 'serve'
    end
    -- player1 scoring scenario
    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1
        ball:reset()
        -- goes to "serve" state
        gameState = 'serve'
    end
    
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
    -- defining start game key - enter/return
    elseif key == 'enter' or key == 'return' then
        -- if the game state is 'start' then set it to 'serve'
        if gameState == 'start' then
            gameState = 'serve'
        -- otherwise set game state to play
        elseif gameState == 'serve' then
            gameState = 'play'
        end
    end
end

-- call draw function
function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    -- draw welcome text with small font
    love.graphics.setFont(mediumFont)
    --[[
        printf function with game title - depending on the game state with 3 in
        option: start, serve and play
    ]] 
    if gameState == 'start' then
        love.graphics.printf(
            'Hello, Welcome to pong!', -- text to wright
            0,                      -- starting at x=0 (centered based on width)
            10,                     -- starting y - slightly off the top
            VIRTUAL_WIDTH,          -- number of pixels to center with
            'center'                -- alignment mode (can be "left", etc.)
            )
        -- 2nd line of text in start state
        love.graphics.printf(
            'Press Enter to start!',  -- text to wright
            0,                        -- starting at x = 0 (center)
            25,                       -- 2nd line from the top
            VIRTUAL_WIDTH,            -- number of pixels to center with
            'center'                  -- alignment mode
            )
    elseif gameState == 'serve' then
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. 
        "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 25, VIRTUAL_WIDTH,
        'center')
    elseif gameState == 'play' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Good luck!', 0, 10, VIRTUAL_WIDTH, 'center')
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
    -- use new FPS function do display FPS number
    displayFPS()
    -- end rendering at virtual resolution
    push:apply('end')
    -- set up background color - grey
    love.graphics.setBackgroundColor(.157,.176,.204)
end

--[[
    additional functio to display FPS on the screen - using love rendering
    color and built in FPS timer
]]
function displayFPS()
    -- use the small font for display
    love.graphics.setFont(smallFont)
    -- set color to red
    love.graphics.setColor(1, 0, 0, 1)
    --[[
        printout the FPS in top left corner (slightly off) using the 'print'
        function text and timer.getFPS function (first translated to string and
        then concatenated with text using '..' operator)
    ]]
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
