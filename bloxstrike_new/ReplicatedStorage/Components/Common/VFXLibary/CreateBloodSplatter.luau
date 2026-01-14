-- game.ReplicatedStorage.Components.Common.VFXLibary.CreateBloodSplatter

local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
game:GetService("Players")
local v_u_debris = game:GetService("Debris")
local v_u_debris = workspace:WaitForChild("Debris")
require(v_u_replicatedstorage.Components.Common.GetRayIgnore)
local v_new = RaycastParams.new()
v_new.FilterType = Enum.RaycastFilterType.Exclude
v_new.IgnoreWater = true
local v_u1 = {
	"rbxassetid://8635071092",
	"rbxassetid://8634747192",
	"rbxassetid://15067037717",
	"rbxassetid://18779968078"
}
local function _(arg1, arg2)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u_debris, (copy) v_u1, (copy) v_u_tween, (copy) v_u_debris
	local v_clone = v_u_replicatedstorage.Assets.Other.BloodSplatter:Clone()
	v_clone.CFrame = arg1
	v_clone.CollisionGroup = "Debris"
	v_clone.CanCollide = false
	v_clone.CanQuery = false
	v_clone.CanTouch = false
	v_clone.Anchored = true
	v_clone.Size = arg2
	v_clone.Parent = v_u_debris
	for _, v1 in ipairs(v_clone:GetDescendants()) do
		if v1:IsA("Decal") then
			v1.Texture = v_u1[math.random(1, #v_u1)]
			v1.Color3 = Color3.fromRGB(126, 16, 24)
			v_u_tween:Create(v1, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Color3"] = Color3.fromRGB(70, 10, 15),
				["Transparency"] = 1
			}):Play()
		end
	end
	v_u_debris:AddItem(v_clone, 15)
	return v_clone
end
return function(_, _) end