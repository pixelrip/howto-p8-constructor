# How to Create Class-Like Objects and Constructors in PICO-8

This cart demonstrates simple “class-like” objects in Lua/PICO-8 using constructors. 

Based on [p8-template](https://github.com/pixelrip/p8-template).

## Prerequisites

1. **PICO-8**: Install from [lexaloffle.com](https://www.lexaloffle.com/pico-8.php)
2. **Python 3.4+**: Required for `picotool`
3. **picotool**: Install from [GitHub](https://github.com/dansanderson/picotool)
4. **Git** (recommended): For version control

## Quick Start

```bash
./scripts/build.sh
```
Load `constructor.p8` in PICO-8 and run it.

## Project Structure

```
project/
├── src/
│   ├── main.lua            # Entry point with _init, _update, _draw
│   ├── entities/
│   │   ├── player.lua      # Player constructor (movement + draw)
│   │   └── enemy.lua       # Enemy constructor (patrol + draw)
│   └── utils/
│       └── log.lua         # Simple logging helper
├── assets/
│   ├── audio.p8            # SFX/Music
│   └── sprites.p8          # Sprites
├── build/                  # Generated dev/prod carts
├── scripts/
│   └── build.sh            # Build automation (uses picotool)
└── constructor.p8          # Final built cart (copied from prod)
```

## How it Works

This project demonstrates some basic Object-Oriented Programming (OOP) in PICO-8 and Lua. We create **classes** that act as blueprints for objects and **constructors** that act as factories for building those objects into **instances**.

### What is a Class?

A class as a blueprint. It's not the object itself, but it defines all the properties and abilities that a real object will have.

In our project, src/entities/enemy.lua defines the Enemy class. It's just a table that holds default values and functions (we call these methods) that all enemies will share:

```Lua
-- src/entities/enemy.lua

-- This is our "blueprint" table
Enemy = {}
Enemy.__index = Enemy

-- Default properties (constants)
Enemy.W = 10
Enemy.H = 9

-- Shared abilities (methods)
function Enemy:update()
   -- ... movement logic ...
end

function Enemy:draw()
    -- ... drawing logic ...
end
```

Every enemy we create will know how to update and draw because of this shared blueprint.

Lua doesn't have a built-in class system like many other programming languages. Lua uses tables and a special mechanism called **metatables** to achieve similar results. The `__index` metamethod is the key to this behavior. When you try to access a field or method on a table that doesn't exist (like calling `inky:update()`), `__index` tells Lua where to look next. By setting `__index` to the "class" table itself (e.g., `Enemy.__index = Enemy`), all instances created from that blueprint will share its functions, effectively simulating class-like method inheritance without duplicating code.

### What is a Constructor?

A **constructor** is like a factory function. Its job is to take a blueprint (our class table) and manufacture a new, unique object based on it (called an instance).

Our constructor is the `Enemy.new(opts)` function. It does three key things:

1. Creates a new, empty table that will become our object.
2. Sets its "blueprint" using `setmetatable({}, Enemy`). This is the magic that links our new object back to the `Enemy` class, giving it access to shared methods like `update()` and `draw()`.
3. Initializes its unique properties based on the opts (options) table we pass in, like x, y, and speed.

```Lua
-- src/entities/enemy.lua

-- The "factory" function
function Enemy.new(opts)
    -- 1. Create a new empty object
    -- 2. Link it to the Enemy blueprint
    local self = setmetatable({}, Enemy)

    -- 3. Set unique properties for this specific enemy
    self.x = opts.x or 0
    self.y = opts.y or 0
    self.speed = opts.speed or Enemy.SPEED
    -- ... and so on

    -- Return the finished object!
    return self
end
```

### What is an Instance?

An **instance** is the actual object that the constructor creates. Each instance is a unique copy with its own properties, but it shares the behavior defined in the class blueprint.

In `src/main.lua`, we use our `Enemy.new()` constructor to create three separate enemy instances: `inky`, `blinky`, and `clyde`.

```Lua
-- src/main.lua

-- Create a couple of enemies (instances)
inky = Enemy.new({
    x = 32,
    y = 32,
    speed = 0.5
})
blinky = Enemy.new({
    x = 96,
    y = 96,
    speed = 1.5
})
clyde = Enemy.new({
    x = 60,
    y = 80,
    speed = 1
})
```

Even though `inky`, `blinky`, and `clyde` all share the same `update()` and `draw()` functions from the `Enemy` blueprint, they each have their own unique `x`, `y`, and `speed` values. When we call `inky:update()`, it updates its own position, not `blinky`'s or `clyde`'s.

### What are the Benefits?

Using this pattern is powerful because it allows us to:

- **Stay Organized:** It groups all the logic for a type of object (like an enemy) in one place.
- **Reduce Repetition:** We can create hundreds of enemies without copying and pasting the update and draw code for each one.
- **Create Variety from a Single Blueprint:** We can easily create different kinds of enemies just by passing different options to the constructor, as we did with `inky`, `blinky`, and `clyde` who all have different speeds and starting positions.