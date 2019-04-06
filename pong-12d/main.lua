
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

function love.update(dt)
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    elseif gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5
            if ball.dy < 0 then
                ball.dy = -math.random(30,140)
            else
                ball.dy = math.random(30, 140)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4
            if ball.dy < 0 then
                ball.dy = -math.random(30,140)
            else
                ball.dy = math.random(30, 140)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y > VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end

        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            if player2Score == 10 then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            if player1Score == 10 then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end
    end

    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end
    
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'
            ball:reset()
            player1Score = 0
            player2Score = 0
            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

function love.draw()

    push:apply('start')
    displayScore()
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf("Hello, Welcome to Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to start!", 0, 25, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to serve!", 0, 25, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf("Good luck!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Player " .. tostring(winningPlayer) .. "wins!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press Enter to start over", 0, 30, VIRTUAL_WIDTH, 'center')
    end

    player1:render()
    player2:render()
    ball:render()

    push:apply('end')
    
    love.graphics.setBackgroundColor(.157,.176,.204)
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50,
        VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 50,
        VIRTUAL_HEIGHT/3)
end