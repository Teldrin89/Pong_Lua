-- first game devloped in lua with GD50 course
-- before running this simple example in case of 1st run with LOVE framework
-- remember to add love dictionary to PATH
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    love.graphics.printf(
        'Hello Pong!',
        0,
        WINDOW_HEIGHT / 2-6,
        WINDOW_WIDTH,
        'center'
    )
end
