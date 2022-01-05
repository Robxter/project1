
TitleState = Class{__includes = BaseState}

local selected = 1
local backgroundX, groundX = 0, 0
local birdX, birdY = 512, 288 - 25
local birdDX, birdDY = 0, -50
local flappyX, flappyY = -38, 288 / 2 - 50
local flappyDX, flappyDY = 0, 0

local GRAVITY = 20
local jumptimer = 0

function TitleState:init()
    -- nothing here
end

function TitleState:update(dt)    
    -- keyboard input for selecting
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        selected = selected == 1 and 2 or 1
    elseif love.keyboard.wasPressed('enter') then
        if selected == 1 then
            gStateMachine:change('select')
        else
            love.event.quit()
        end
    end

    jumptimer = jumptimer + dt

    flappyDX, flappyX = flappyDX + 30 * dt, flappyX + flappyDX
    flappyDY, flappyY = flappyDY + GRAVITY * dt, flappyY + flappyDY

    if jumptimer >= math.random(2, 3) then
        flappyDY = -5
        jumptimer = 0
    end

    if flappyX > VIRTUAL_WIDTH + 60 or flappyY > VIRTUAL_HEIGHT then
        flappyX = -40
        flappyY = VIRTUAL_HEIGHT / 2 - math.random(50)
    end

    birdDX, birdX = birdDX + 60 * dt, birdX - birdDX
    birdDY, birdY = birdDY + GRAVITY * dt, birdY + birdDY

    if birdX < -16 or birdY > VIRTUAL_HEIGHT then
        birdX = VIRTUAL_WIDTH
        birdY = VIRTUAL_HEIGHT - math.random(16, 40)
        birdDY = -math.random(25, 100)
    end

    backgroundX = (backgroundX + 20 * dt) % 413 -- the modulo value is the looping point
    groundX = (groundX + 50 * dt) % VIRTUAL_WIDTH
    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function TitleState:render(dt)
    love.graphics.draw(gTextures['lobby'], backgroundX, 0)

    love.graphics.draw(gTextures['red'], birdX + gTextures['red']:getWidth(), birdY, 0, -1, 1)
    love.graphics.draw(gTextures['bird'], flappyX, flappyY)

    love.graphics.draw(gTextures['ground'], groundX, VIRTUAL_HEIGHT - 16)
    
    love.graphics.printf('VIDEOGAME', 0, VIRTUAL_HEIGHT / 3 - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('PHYSICS', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    if selected == 1 then
        -- a palid yellow for highlighting
        love.graphics.setColor(255, 244, 78, 255)
    end
    love.graphics.printf('PLAY', 0, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT / 3) - 15, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    
    if selected == 2 then
        love.graphics.setColor(255, 244, 78, 255)
    end
    love.graphics.printf('EXIT', 0, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT / 3), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
end