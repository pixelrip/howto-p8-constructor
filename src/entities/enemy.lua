-- Enemy Class
Enemy = {}
Enemy.__index = Enemy


-- Enemy Constants
Enemy.W = 10
Enemy.H = 9
Enemy.SPEED = 1
Enemy.SPRITE_SX = 25
Enemy.SPRITE_SY = 0
Enemy.SPRITE_T = 11

-- Enemy Constructor
function Enemy.new(opts)
    local self = setmetatable({}, Enemy)

    -- Postion
    self.x = opts.x or 0
    self.y = opts.y or 0

    -- Transform
    self.w = Enemy.W
    self.h = Enemy.H

    -- Spritesheet
    self.sx = Enemy.SPRITE_SX
    self.sy = Enemy.SPRITE_SY

    -- Movement
    self.speed = opts.speed or Enemy.SPEED
    self.axis = opts.axis or 'x'
    self.direction = opts.direction or 1

    -- Starting velocities
    if self.axis == 'x' then
        self.dx = self.direction * self.speed
        self.dy = 0
    else
        self.dx = 0
        self.dy = self.direction * self.speed
    end

    return self
end

function Enemy:update()
    -- Patrol on the x or y axis
   self.x += self.dx * self.speed
   self.y += self.dy * self.speed

    -- Change direction at the edge of screen
    if self.x <= 0 or self.x >= 128 - self.w then
        self.dx = -self.dx
    end
    if self.y <= 0 or self.y >= 128 - self.h then
        self.dy = -self.dy
    end
end

function Enemy:draw()
    -- Draw the sprite
    palt(0,false)
    palt(11,true)
    sspr(self.sx, self.sy, self.w, self.h, self.x, self.y)
    pal()
end
