
-- Game 12 update - prepare for release

push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong replica')
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2, 4, 4)

    servingPlayer = 1
    gameState = 'start'

end

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

function love.draw()

    push:apply('start')
    displayScore()
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf("Hello, Welcome to start!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.printf("Hello, Welcome to serve!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf("Hello, Welcome to play!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.printf("Hello, Welcome to done!", 0, 10, VIRTUAL_WIDTH, 'center')
    end

    push:apply('end')
    
    love.graphics.setBackgroundColor(.157,.176,.204)
end

function displayScore()
    -- draw score on the left and right center of the screen
    --change font to score font
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50,
        VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 50,
        VIRTUAL_HEIGHT/3)
end