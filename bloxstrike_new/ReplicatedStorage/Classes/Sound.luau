-- game.ReplicatedStorage.Classes.Sound

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_http = game:GetService("HttpService")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
require(script:WaitForChild("Types"))
local v_u3 = require(v_replicatedstorage.Shared.Janitor)
local v_u4 = v_replicatedstorage:FindFirstChild("Sounds") or Instance.new("Folder", v_replicatedstorage)
v_u4.Name = "Sounds"
local v_u_debris = workspace:WaitForChild("Debris")
local function v_u5(arg1)
	local v_split = string.split(arg1, ".")
	local v1 = game
	for v2, v3 in ipairs(v_split) do
		if v1 and v2 > 1 then
			v1 = v1:FindFirstChild(v3)
			if not v1 then
				error((("Path: \"%*\" does not exist"):format(arg1)))
			end
		end
	end
	return v1
end
local function v_u6(arg1, arg2, arg3)
	local v_sound = Instance.new("Sound")
	v_sound.RollOffMaxDistance = arg3.RollOffMaxDistance or 10000
	v_sound.RollOffMinDistance = arg3.RollOffMinDistance or 10
	v_sound.TimePosition = arg3.TimePosition or 0
	v_sound.RollOffMode = Enum.RollOffMode.Inverse
	v_sound.Looped = arg3.Looped or false
	v_sound.SoundId = ("rbxassetid://%*"):format(arg2)
	v_sound.Volume = arg3.Volume or 0.5
	v_sound.Name = arg1
	return v_sound
end
function v_u1.play(arg1, arg2, arg3)
	-- upvalues: (copy) v_u_http, (copy) v_u5, (copy) v_u2, (copy) v_u_localplayer
	local v_format = ("Sound couldn\'t locate sound parent for %*"):format(arg2.Name)
	assert(arg2.Parent or arg2.Path, v_format)
	if not arg1.Sounds then
		return nil
	end
	local v1 = arg1.Sounds:FindFirstChild(arg2.Name)
	if v1 then
		local v_generateguid = v_u_http:GenerateGUID(false)
		local v_parent = arg2.Parent
		if arg2.Path and not v_parent then
			v_parent = v_u5(arg2.Path)
		end
		if not v_parent then
			return nil
		end
		local v2 = (v_u2.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
		local v_getchildren = v1:GetChildren()
		local v_u_clone = v1:WaitForChild((math.random(1, #v_getchildren))):Clone()
		v_u_clone.Volume = v_u_clone.Volume * v2 * (arg3 or 1)
		v_u_clone.Parent = v_parent
		v_u_clone.Name = v_generateguid
		v_u_clone:Play()
		local v_u3 = v_u_clone.Volume / (v2 * (arg3 or 1))
		v_u_clone:SetAttribute("BaseVolume", v_u3)
		v_u_clone:SetAttribute("MasterVolumeMultiplier", v2)
		if arg3 then
			v_u_clone:SetAttribute("OtherVolumeMultiplier", arg3)
		end
		v_u2.CreateListener(v_u_localplayer, "Settings.Audio.Audio.Master Volume", function(arg1)
			-- upvalues: (copy) v_u_clone, (copy) v_u3, (copy) arg3
			if v_u_clone and v_u_clone.Parent then
				local v1 = (arg1 or 100) / 100
				v_u_clone.Volume = (v_u_clone:GetAttribute("BaseVolume") or v_u3) * v1 * (v_u_clone:GetAttribute("OtherVolumeMultiplier") or (arg3 or 1))
				v_u_clone:SetAttribute("MasterVolumeMultiplier", v1)
				if v1 == 0 then
					v_u_clone:Stop()
					v_u_clone:Destroy()
				end
			end
		end)
		v_u_clone.Ended:Once(function()
			-- upvalues: (copy) v_u_clone
			v_u_clone:Destroy()
		end)
		return v_u_clone
	end
end
function v_u1.playOneTime(arg1, arg2, arg3)
	return arg1:play(arg2, arg3 or 1)
end
function v_u1.PlaySoundAtPosition(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u_debris, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u_http
	if arg1.IsDestroyed then
		return
	elseif arg1.Sounds then
		local v1 = arg1.Sounds:FindFirstChild(arg2.Name)
		if v1 then
			local v_add = arg1.Janitor:Add(Instance.new("Part"))
			v_add.Size = Vector3.new(1, 1, 1)
			v_add.Position = arg2.Position
			v_add.CollisionGroup = "Debris"
			v_add.CanCollide = false
			v_add.CanTouch = false
			v_add.CanQuery = false
			v_add.Anchored = true
			v_add.Transparency = 1
			v_add.Parent = v_u_debris
			v_add.Name = "Sound"
			local v2 = (v_u2.Get(v_u_localplayer, "Settings.Audio.Audio.Master Volume") or 100) / 100
			local v_getchildren = v1:GetChildren()
			local v_u_add = arg1.Janitor:Add((v1:WaitForChild((math.random(1, #v_getchildren))):Clone()))
			v_u_add.Volume = v_u_add.Volume * v2 * (arg4 or 1)
			v_u_add.Name = v_u_http:GenerateGUID(false)
			v_u_add.Parent = v_add
			if (arg2.Name == "Headshot" and true or arg2.Name == "Helmet Headshot") and arg5 then
				v_u_add.RollOffMode = Enum.RollOffMode.InverseTapered
				v_u_add.RollOffMaxDistance = 6767
				v_u_add.RollOffMinDistance = 6767
			end
			v_u_add:Play()
			local v_u3 = v_u_add.Volume / (v2 * (arg4 or 1))
			v_u_add:SetAttribute("BaseVolume", v_u3)
			v_u_add:SetAttribute("MasterVolumeMultiplier", v2)
			if arg4 then
				v_u_add:SetAttribute("OtherVolumeMultiplier", arg4)
			end
			v_u2.CreateListener(v_u_localplayer, "Settings.Audio.Audio.Master Volume", function(arg1)
				-- upvalues: (copy) v_u_add, (copy) arg1, (copy) v_u3, (copy) arg4
				if v_u_add and (v_u_add.Parent and not arg1.IsDestroyed) then
					local v1 = (arg1 or 100) / 100
					v_u_add.Volume = (v_u_add:GetAttribute("BaseVolume") or v_u3) * v1 * (v_u_add:GetAttribute("OtherVolumeMultiplier") or (arg4 or 1))
					v_u_add:SetAttribute("MasterVolumeMultiplier", v1)
					if v1 == 0 then
						v_u_add:Stop()
						arg1:destroy()
					end
				end
			end)
			if v_u_add.Looped and arg3 then
				arg1.Janitor:Add(task.delay(arg3, function()
					-- upvalues: (copy) arg1
					arg1:destroy()
				end), true)
			else
				arg1.Janitor:Add(v_u_add.Ended:Once(function()
					-- upvalues: (copy) arg1
					arg1:destroy()
				end))
			end
			arg1.Janitor:Add(v_u_add.AncestryChanged:Connect(function()
				-- upvalues: (copy) v_u_add, (copy) arg1
				if not v_u_add.Parent then
					arg1:destroy()
				end
			end))
		else
			arg1:destroy()
		end
	else
		arg1:destroy()
		return
	end
end
function v_u1.createSoundGroup(arg1)
	-- upvalues: (ref) v_u4, (copy) v_u6
	local v1 = require(arg1)
	local v_folder = Instance.new("Folder", v_u4)
	v_folder.Name = arg1.Name
	for v2, v3 in pairs(v1) do
		local v_folder = Instance.new("Folder", v_folder)
		v_folder.Name = v2
		for v4, v5 in ipairs(v3.Identifiers) do
			v_u6(v4, v5, v3.Properties).Parent = v_folder
		end
	end
end
function v_u1.new(arg1)
	-- upvalues: (copy) v_u1, (copy) v_u3, (ref) v_u4
	local v1 = setmetatable({}, v_u1)
	v1.Janitor = v_u3.new()
	v1.IsDestroyed = false
	v1.SoundGroupName = arg1
	v1.Sounds = v_u4:WaitForChild(arg1, 10)
	return v1
end
function v_u1.destroy(arg1)
	if not arg1.IsDestroyed then
		arg1.IsDestroyed = true
		arg1.Janitor:Destroy()
		arg1.SoundGroupName = nil
		arg1.Janitor = nil
		arg1.Sounds = nil
	end
end
return v_u1