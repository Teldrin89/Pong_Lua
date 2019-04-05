
-- Game 12 update - prepare for release

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    gameState = 'start'

end

function love.draw()

    if gameState == 'start' then
        love.graphics.printf("Hello, Welcome to start!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.printf("Hello, Welcome to serve!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf("Hello, Welcome to play!", 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.printf("Hello, Welcome to done!", 0, 10, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setBackgroundColor(.157,.176,.204)
end