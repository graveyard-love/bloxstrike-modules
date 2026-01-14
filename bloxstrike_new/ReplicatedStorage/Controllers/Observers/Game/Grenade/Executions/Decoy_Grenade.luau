-- game.ReplicatedStorage.Controllers.Observers.Game.Grenade.Executions.Decoy Grenade

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
return function(_, _, arg3)
	for _, v1 in ipairs(arg3:GetDescendants()) do
		if v1:IsA("BasePart") then
			v1.CollisionGroup = "Debris"
			v1.Transparency = 1
			v1.CanCollide = false
			v1.CanTouch = false
			v1.CanQuery = false
		end
	end
	task.delay(0.5, function()
		-- upvalues: (copy) arg3
		if arg3 and arg3.Parent then
			arg3:Destroy()
		end
	end)
end