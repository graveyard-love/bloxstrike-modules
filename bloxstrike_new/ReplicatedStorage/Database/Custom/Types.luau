-- game.ReplicatedStorage.Database.Custom.Types

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_shared = v_replicatedstorage:WaitForChild("Shared")
require(v_shared:WaitForChild("Janitor"))
require(v_shared:WaitForChild("Promise"))
require(v_replicatedstorage.Database.Custom.GameStats.NumberSlots)
return {}