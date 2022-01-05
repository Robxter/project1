
PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.movable = params.movable
    self.movement = params.movement
    self.image = params.image

    self.paused = false
    self.objects = {}

    table.insert(self.objects, object(self.image, false,        -- image or rectangle
        VIRTUAL_WIDTH / 2 - self.image:getWidth(),              -- x
        VIRTUAL_HEIGHT / 2 - self.image:getHeight(),            -- y
        self.image:getWidth(),                                  -- width
        self.image:getHeight(),                                 -- height
        self.movable,                                           -- movable
        self.movement                                           -- mode
    ))
end

function PlayState:update(dt)
    if self.paused == false then
        if love.keyboard.wasPressed('escape') then
            self.paused = true
        end
    
        for k, object in pairs(self.objects) do
            object:update(dt)
        end
    else
        if love.keyboard.wasPressed('escape') then
            self.paused = false
        end

        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
            -- play a rough sound of no option available for now
        elseif love.keyboard.wasPressed('enter') then
            gStateMachine:change('select')
        end
    end
end

function PlayState:render()
    if self.movement == 'god' then
        love.graphics.draw(gTextures['sky'], 0, 0)
    elseif self.movement == 'mario' then
        love.graphics.draw(gTextures['lobby'], 0, 0)
        love.graphics.draw(gTextures['ground'], 0, VIRTUAL_HEIGHT - 16)
    end

    for k, object in pairs(self.objects) do
        object:render()
    end
end