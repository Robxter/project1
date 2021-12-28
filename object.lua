--[[
    OBJECT CLASS for Gravity Simulator V1
    Author: Robxter

    Notes: 
        -- Code for register the max height or y in Parabolic Throw
        self.maxY = self.dy == 0 and self.y

]]

-- Declaring this file as Class
Object = Class{}

-- const value
local VELOCITY = 100

function object:init(img, rectangle, x, y, width, height, movable, mode)
    -- object optional image
    self.image = img or nil
    
    self.width = width or self.image:getWidth()
    self.height = height or self.image:getHeight()

    self.x = x
    self.y = y

    self.dx = 0
    self.dy = 0

    -- flags
    self.movable = movable or false
    self.rectangle = rectangle or false
    self.mode = mode or 'free fall'
end

function object:update(dt)
    if self.movable then
        -- X Axis Movement
        -- left movement
        if love.keyboard.wasPressed('a') or love.keyboard.wasPressed('left') then
            self.dx = self.dx + VELOCITY * dt 
            self.x = self.x - self.dx

        -- right movement
        elseif love.keyboard.wasPressed('d') or love.keyboard.wasPressed('right') then
            self.dx = self.dx + VELOCITY * dt
            self.x = self.x + self.dx
        end

        -- Y Axis Movement
        if love.keyboard.wasPressed('w') or love.keyboard.wasPressed('up') then
            self.dy = self.dy + VELOCITY * dt
            self.y = self.y - self.dy
        elseif love.keyboard.wasPressed('s') or love.keyboard.wasPressed('down') then
            self.dy = self.dy + VELOCITY * dt
            self.y = self.y + self.dy
        end
        -- reset all delta X and delta Y values for not flushing the velocity of movement each frame passed
        self.dx = 0
        self.dy = 0
    else
        if self.mode == 'free fall' or 'caida libre' then
            self.dy = self.dy + VELOCITY * dt
            self.y = self.y  + self.dy
        --[[elseif self.mode == 'parabolic throw' or 'tiro parabolico' then

        else]]
        
        end    
    end
end


function object:render()
    if self.rectangle then
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    else
       love.graphics.draw(self.image, self.x, self.y)
    end
end
