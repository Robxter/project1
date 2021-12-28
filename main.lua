push = require 'push'

Class = require 'class'

require 'object'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1920
VIRTUAL_HEIGHT = 1080

--[[rectangle = {
    width = 10,
    height = 10,
    x = WINDOW_WIDTH / 2 - (rectangle.width / 2),
    y = WINDOW_HEIGHT / 2 - (rectangle.height / 2)
}]]


function love.load()

    -- a table for objects we want to allocate
    objects = {}

    love.window.setTitle('Gravedad a (Mano)')

    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        rezisable = false,
        fullscreen = false,
        vsync = true
    })

    love.keyboard.keysPressed = {}

    table.insert(objects, Object(nil, true, WINDOW_WIDTH / 2 - 5, WINDOW_HEIGHT / 2 - 5, 10, 10, true))
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    for k, v in pairs(objects) do
        object:update(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
        love.graphics.clear(0, 150, 50, 255)

        for k, v in pairs(objects) do
            object:render()
        end
        -- love.graphics.rectangle('fill', rectangle.x, rectangle.y, rectangle.width, rectangle.height, 4)
    push:finish()
end