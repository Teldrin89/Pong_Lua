
-- Game 12 update - prepare for release

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
--[[ 
    TODO: next thing to check is to update push library to reference the config
    lua file and use it to change window settings of width and height
]]
PADDLE_SPEED = 200

function love.load()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, 
    WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gameState = 'start'

end

function love.draw()

    push:apply('start')

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