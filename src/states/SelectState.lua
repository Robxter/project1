--[[
    SELECT STATE FOR PHYSICS IN VIDEOGAME
    Author: Robxter

    2021 Robxter
]]


SelectState = Class{__includes = BaseState}

local selected = false

function SelectState:init()
    self.movable = true
    self.movement = nil
    self.image = nil
end

function SelectState:update(dt)
    if selected == false then
        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then
            self.movable = self.movable == false and true or false
        elseif love.keyboard.wasPressed('enter') then
            selected = true
        end
        
        if love.keyboard.wasPressed('escape') then
            gStateMachine:change('title')
        end
    else
        -- local variables just to keep track of the 4 types of movements that could be selected in the moment
        local m, b = 1, 1

        -- if ESC is pressed then go back to last selection
        if love.keyboard.wasPressed('escape') then
            selected = false
        end

        if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then
            if self.movable == true then
                m = m == 1 and 2 or 1
            else
                b = b == 1 and 2 or 1
            end
        end
        
        -- keeping track of movements and selected arrows
        if m == 1 then
            self.movement = 'god'
            self.image = gTextures['bird']
        else
            self.movement = 'mario'
            self.image = gTextures['character']
        end

        if b == 1 then
            self.movement = 'free fall'
            self.image = gTextures['ball']
        else
            self.movement = 'parabolic throw'
            self.image = gTextures['ball']
        end
        -- temporal double condition for checking that parabolic throw is not selected else it'll throw an error cause it's not
        -- declared yet.
        if love.keyboard.wasPressed('enter') and self.movement ~= 'parabolic throw' then
            gStateMachine:change('play', {
                movable = self.movable,
                movement = self.movement,
                image = self.image
            })
        end
    end
end

function SelectState:render()
    if selected == false then
        if self.movable == true then
            love.graphics.draw(gTextures['control'], VIRTUAL_WIDTH / 2 - 17,  VIRTUAL_HEIGHT / 2 - 10)
            love.graphics.printf('MOVIBLE', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
        else
            love.graphics.draw(gTextures['locked'], VIRTUAL_WIDTH / 2 - 17, VIRTUAL_HEIGHT / 2 - 10)
            love.graphics.printf('INAMOVIBLE', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
        end
    else
        if self.movable == true then
            if self.movement == 'god' then
                love.graphics.draw(gTextures['bird'], VIRTUAL_WIDTH / 2 - 19, VIRTUAL_HEIGHT - 12)
                love.graphics.printf('Bird', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
            elseif self.movement == 'mario' then
                love.graphics.draw(gTextures['mario'], VIRTUAL_WIDTH / 2 - 15, VIRTUAL_HEIGHT / 2 - 14)
                love.graphics.printf('Mario', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
            end
        else
            if self.movement == 'free fall' then
                love.graphics.draw(gTextures['fireball'], VIRTUAL_WIDTH / 2 - 16, VIRTUAL_HEIGHT / 2 - 23)
                love.graphics.printf('Caida Libre', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
            elseif self.movement == 'parabolic throw' then
                love.graphics.draw(gTextures['meteor'], VIRTUAL_WIDTH / 2 - 16, VIRTUAL_HEIGHT / 2 - 16)
                love.graphics.printf('NO DISPONIBLE', 0, VIRTUAL_HEIGHT / 2 + 25, VIRTUAL_WIDTH, 'center')
            end
        end
    end

    -- left arrow
    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][1], VIRTUAL_WIDTH / 4 - 12, VIRTUAL_HEIGHT / 2 - 14)
    -- right arrow
    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][2], VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 4) - 12, VIRTUAL_HEIGHT / 2 - 14)

    -- reset color
    love.graphics.setColor(255, 255, 255, 255)
end