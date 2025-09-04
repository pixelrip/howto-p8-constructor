-- Player Class
Player = {}
Player.__index = Player

-- Player Constants
Player.W = 17
Player.H = 13
Player.SPEED = 2
Player.SPRITE_SX = 8
Player.SPRITE_SY = 0
Player.SPRITE_T = 11

-- Constructor for Player
function Player.new(opts)
    local self = setmetatable({}, Player)

    -- Position
    self.x = opts.x or 0
    self.y = opts.y or 0

    -- Transform
    self.w = Player.W
    self.h = Player.H

    -- Spritesheet
    self.sx = Player.SPRITE_SX
    self.sy = Player.SPRITE_SY

    -- Movement
    self.speed = opts.speed or Player.SPEED

    -- Return the new player instance
    return self
end

function Player:update()
    -- Simple button controls for player movement
    if btn(0) then self.x -= 1 * self.speed end
    if btn(1) then self.x += 1 * self.speed end
    if btn(2) then self.y -= 1 * self.speed end
    if btn(3) then self.y += 1 * self.speed end
end

function Player:draw()
    -- Draw the sprite
    palt(0,false)
    palt(11,true)
    sspr(self.sx, self.sy, self.w, self.h, self.x, self.y)
    pal()
end

