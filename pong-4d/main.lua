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


--                  Game 4 update - ball move update


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
    --[[
        math.randomseed(num) - lua function for random number generation, takes
        some inital value and takes then some math operation to get different
        number every time (it's then passed to random generator)
    ]]
    --[[
        os.time - a lua function that returns a current time in unix epoch time
        format (seconds, starting from 00:00:00 UTC Jan 1, 1970)
    ]]
    -- calling randomseed function, passing the current time in seconds
    math.randomseed(os.time())
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

    -- initialize the position of a ball
    ballX = VIRTUAL_WIDTH/2 - 2
    ballY = VIRTUAL_HEIGHT/2 - 2

    --[[
        math.random(min, max) - a lua function that returns a random number,
        dependent on the seeded random number generator, between min and max 
        (inlcusively)
    ]]
    --[[
        initialize ball speed with change and math.random function - for
        velocity in X direction there is additional ternary if operation - 
        if math.random(2) is equal to 1 then the value is 100 and if not then
        the value is -100
    ]] 
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

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
        --[[ 
            add negative paddle speed to current Y (scaled by dt) - adjusted
            for the screen bounds with math.max function (returns grater of two
            values) 
        ]]
        player1Y = math.max(0, player1Y + -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown('s') then
        --[[ 
            add positive paddle speed to current Y (scaled by dt) - adjusted
            for the screen bounds with math.min function (taken into account
            also the size of the paddle)
        ]]
        player1Y = math.min(VIRTUAL_HEIGHT-20, player1Y + PADDLE_SPEED*dt)
    end

    -- the same movement setup for player 2 (up and down keys)
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y (scaled by dt) - similar to P1
        player2Y = math.max(0, player2Y + -PADDLE_SPEED*dt)
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y (scaled by dt) - similar to P1
        player2Y = math.min(VIRTUAL_HEIGHT-20, player2Y + PADDLE_SPEED*dt)
    end

    --[[
        update ball based on its DX and DY only in play state - velocity is
        scaled based on dt so movement is framerate-independet
    ]]
    if gameState == 'play' then
        ballX = ballX + ballDX*dt
        ballY = ballY + ballDY*dt
    end
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
            -- set ball's starting position - middle of the screen
            ballX = VIRTUAL_WIDTH/2 - 2
            ballY = VIRTUAL_HEIGHT/2 - 2
            --[[
                set ball's initial velocity in X and Y direction using the
                math.random and using the same ternary operation as in load 
                function
            ]]
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50)
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
            'Hello Start!',          -- text to wright
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

    -- render 1st paddle - left side - now with player "Y" variable
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    -- render 2nd paddle - right side - now with player "Y" variable
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10, player2Y, 5, 20)
    -- render ball (at center) - use the new ball X and Y coordinates
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    -- end rendering at virtual resolution
    push:apply('end')
    -- set up background color - grey
    love.graphics.setBackgroundColor(.157,.176,.204)
end