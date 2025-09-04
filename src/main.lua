-- In a perfect world, I would actually structure these requires like 
-- "real Lua" with returns and better encapsulation--instead of basically
-- just including them as globals. But alas, no matter what I try picotool
-- ends up taking a big shit when I try to require sibling/sister files so
-- I will leave as globals.

-- Global Utils
require("utils/log")

-- Global Entities: `Player` constructor, `Enemy` constructor
require("entities/player")
require("entities/enemy")


-- Main entry point for the game
function _init()
    log.print("=== Game Started ===")

    -- Create a player instance
    player = Player.new({
        x = 64,
        y = 64,
        speed = 2,
        hp = 10,
        max_hp = 10
    })

    -- Create a couple of enemies
    inky = Enemy.new({
        x = 32,
        y = 32,
        speed = 0.5,
        axis = 'x',
        direction = 1
    })
    blinky = Enemy.new({
        x = 96,
        y = 96,
        speed = 1.5,
        axis = 'y',
        direction = -1
    })
    clyde = Enemy.new({
        x = 60,
        y = 80,
        speed = 1,
        axis = 'x',
        direction = -1
    })
end

function _update()
    -- Update the player
    player:update()

    -- Update the enemies
    inky:update()
    blinky:update()
    clyde:update()
end

function _draw()
    -- Clear the screen
    cls(1)
    
    -- Draw the player
    player:draw()

    -- Draw the enemies
    inky:draw()
    blinky:draw()
    clyde:draw()
end
