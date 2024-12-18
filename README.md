<div align="center">

<div>&nbsp;</div>

<h1> MULTI BIND SYSTEM [BETA] </h1>

[![Release Pages](https://img.shields.io/static/v1?label=Version&message=1.0.0&color=red)](https://github.com/bludmas/MultiBindSystem/releases "Releases")
[![Roblox Group](https://img.shields.io/badge/roblox-group-darkgreen?logo=roblox)](https://www.roblox.com/communities/34028520/Windows-Bloodshed-Studios#!/about "Our roblox group")
[![Roblox Model](https://img.shields.io/badge/roblox-model-green?logo=roblox)](https://create.roblox.com/store/asset/83292612930634/MultiBind "Link to module script.")

</div>

<h2> Info </h2>
A roblox module that helps you make key bindings, but multiple of them.
Like for example: You press CTRL+C and something happens.

<h3>⚠ THIS IS CURRENTLY IN ITS EARLY STAGES, SO IT MIGHT BE BUGGY. ⚠</h3>

If you find any error/bug, contact me about it.

<h2> Documentation </h2>

To start off, make a <b>client</b> script that will handle inputs.

Parent your client script to "ReplicatedFirst" or "StarterPlayerScripts" or anywhere else used for client.

In your client script, you can write something like this:
```lua
if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Module = require(ReplicatedStorage:FindFirstChild("PathToYourModule") or ReplicatedStorage:WaitForChild("PathToYourModule"))
local KeyCode = Enum.KeyCode

local MultiBind = Module.new(
    {
        [1] = KeyCode.LeftControl,
        [2] = KeyCode.X
    }, 
    function()
        -- Do something
    end
)

MultiBind:Enable()
```

REPLACE "PathToYourModule" WITH THE LOCATION OF THE MODULE SCRIPT.

In the constructor: you can see the 2 number keys:
```lua
        [1] = KeyCode.LeftControl,
        [2] = KeyCode.X
```

For every key, the player must press in their order, for example: CTRL+X to trigger/call the function in order for it to work.

And you can do something like this:
```lua
        [1] = KeyCode.LeftControl,
        [2] = KeyCode.LeftShift,
        [3] = KeyCode.Z,
        [4] = KeyCode.C,
```

And to be honest, im not sure if it works. In this order you have to press CTRl+SHIFT+Z+C to call the function.

NOTE: The player must hold down the keys too so that it works.

In your function you can do anything, returning anything might break the module though.

If you want to override the settings, you can do so by adding a third arg. Something like this should turn out:
```lua
local MultiBind = Module.new(
    {
        [1] = KeyCode.LeftControl,
        [2] = KeyCode.X
    }, 
    function()
        -- Do something
    end,
    { -- Optional Settings Override
        FunctionCallDelay = 1; -- Set this to any number you want.
    }
)
```

Change the "FunctionCallDelay" to anything you want, this variable is to add delay in the function calls, so you don't break it, possibly.

If you want, you can view this [example code](https://github.com/bludmas/MultiBindSystem/blob/main/code/Example.lua)

<h2>All Methods:</h2>

```lua
MultiBind:Enable() -- Enables Input.

MultiBind:Disable() -- Disables Input.

MultiBind:Destroy() -- Self Explanatory, just removes it, thats all.
```
