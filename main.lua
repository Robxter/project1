
require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function love.load()

    --[[ a table for objects we want to allocate
    objects = {}]]

    gTextures = {
        ['mario'] = love.graphics.newImage('textures/mario.png'),
        ['sonic'] = love.graphics.newImage('textures/sonicF.png'),
        ['red'] = love.graphics.newImage('textures/red.png'),
        ['bird'] = love.graphics.newImage('textures/bird.png'),
        ['character'] = love.graphics.newImage('textures/character.png'),
        ['arrows'] = love.graphics.newImage('textures/arrows.png'),
        ['control'] = love.graphics.newImage('textures/controller.png'),
        ['locked'] = love.graphics.newImage('textures/locked.png'),
        ['fireball'] = love.graphics.newImage('textures/fireball.png'),
        ['meteor'] = love.graphics.newImage('textures/meteor.png'),
        ['ball'] = love.graphics.newImage('textures/ball.png'),
        ['clouds'] = love.graphics.newImage('textures/clouds.png'),
        ['ground'] = love.graphics.newImage('textures/ground.png'),
        ['lobby'] = love.graphics.newImage('textures/background.png')
    }

    gFrames = {
        ['arrows'] = GenerateQuads(gTextures['arrows'], 24, 24),
        ['cloud'] = GenerateQuads(gTextures['clouds'], 48, 96)
    }

    gFonts = {
        ['game'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf'),
        ['bigFont'] = love.graphics.newFont('fonts/font.ttf')
    }

    gStateMachine = StateMachine{
        ['title'] = function() return TitleState() end,
        ['select'] = function() return SelectState() end,
        ['play'] = function() return PlayState() end
    }

    love.window.setTitle('Fisica en Videojuegos2D')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        rezisable = false,
        fullscreen = false,
        vsync = true
    })

    love.keyboard.keysPressed = {}

    gCollisions = setupGlobalCollisions() -- not working and useless for now - 12/28/21

    --table.insert(objects, object(gTextures['character'], false, WINDOW_WIDTH / 2 - 5, WINDOW_HEIGHT / 2 - 5, nil, nil, true, 'god', 5))
    -- table.insert(objects, object(nil, true, WINDOW_WIDTH / 2 - 5, WINDOW_HEIGHT / 2 - 5, 10, 10, false))
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
    
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
        --love.graphics.clear(0, 150, 50, 255)

        gStateMachine:render()
        --[[for k, object in pairs(objects) do
            object:render()
        end]]
    push:finish()
end