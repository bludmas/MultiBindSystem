-- CLIENT

if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Module = require(ReplicatedStorage:FindFirstChild("Multi-Bind") or ReplicatedStorage:WaitForChild("Multi-Bind"))
local KeyCode = Enum.KeyCode

local MultiBind = Module.new(
    { -- Keycodes, The numbers are necessary
        [1] = KeyCode.LeftControl,
        [2] = KeyCode.X,
        [3] = KeyCode.C,
    }, 
    function() -- Function to call on call
        -- Do something
        print("UwU")
    end,
    { -- Optional Settings Override
        FunctionCallDelay = 1; -- Set this to any number you want.
    }
)

MultiBind:Enable()

--[[ Extra Methods/Functions:
    :Disable() -> Disables any input
    :Destroy() -> Removes the multibind. Aka sets the metatable to nil
--]]
