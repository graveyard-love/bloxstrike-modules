-- game.ReplicatedStorage.Interface

local v_u1 = {}
v_u1.__index = v_u1
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_startergui = game:GetService("StarterGui")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u2 = require(v_replicatedstorage.Classes.Sound)
local v_u3 = require(v_replicatedstorage.Database.Security.Router)
local v_u4 = require(v_replicatedstorage.Shared.Promise)
local v_u5 = require(v_replicatedstorage.Controllers.DataController)
local v_u6 = require(script.MenuState)
local v_u_screens = script:WaitForChild("Screens")
local v_u_maingui = v_replicatedstorage.Assets.UI.MainGui
v_u_maingui.Parent = v_u_playergui
local function v_u7(self)
	-- upvalues: (copy) v_u4
	debug.setmemorycategory((("%*"):format(self.Name)))
	return v_u4.try(function()
		-- upvalues: (copy) self
		return require(self)
	end):catch(warn)
end
local function v_u8(arg1, arg2)
	-- upvalues: (copy) v_u8, (copy) v_u7, (copy) v_u4, (copy) v_u_maingui
	if arg2 then
		for _, v1 in ipairs(arg1:GetChildren()) do
			local v_u2 = arg2:FindFirstChild(v1.Name)
			if v1:IsA("Folder") then
				if v_u2 then
					v_u8(v1, v_u2)
				else
					warn((("Missing corresponding interface folder : \"%*\""):format((string.lower(v1:GetFullName())))))
				end
			elseif v1:IsA("ModuleScript") then
				if v_u2 then
					v_u7(v1):andThen(function(arg1)
						-- upvalues: (ref) v_u4, (ref) v_u_maingui, (copy) v_u2
						v_u4.try(arg1.Initialize, v_u_maingui, v_u2):andThen(arg1.Start):catch(warn)
					end)
				else
					warn((("Missing corresponding interface module for : \"%*\""):format((string.lower(v1:GetFullName())))))
				end
			end
		end
	else
		warn((("Pointer: \"%*\" is not apart of interface."):format(arg1.Name)))
	end
end
function v_u1.guarantee(arg1)
	for _ = 1, 15 do
		if pcall(arg1) then
			break
		end
	end
end
function v_u1.Initialize()
	-- upvalues: (copy) v_u6, (copy) v_u_maingui, (copy) v_u1, (copy) v_u_startergui, (copy) v_u5, (copy) v_u_localplayer, (copy) v_u3, (copy) v_u2, (copy) v_u_playergui
	v_u6.Initialize(v_u_maingui)
	v_u1.guarantee(function()
		-- upvalues: (ref) v_u_startergui
		v_u_startergui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		v_u_startergui:SetCore("ResetButtonCallback", false)
	end)
	local v_u_bottom = v_u_maingui:WaitForChild("Gameplay"):WaitForChild("Bottom")
	local v_u1 = nil
	local v_u2 = nil
	local v_u3 = nil
	local v_u4 = nil
	local v_u5 = nil
	task.spawn(function()
		-- upvalues: (copy) v_u_bottom, (ref) v_u1, (ref) v_u2, (ref) v_u3, (ref) v_u4, (ref) v_u5, (ref) v_u5, (ref) v_u_localplayer
		task.wait(0.1)
		local v_ammo = v_u_bottom:FindFirstChild("Ammo")
		if v_ammo then
			local v_uiscale = v_ammo:FindFirstChild("UIScale")
			if v_uiscale then
				v_u1 = v_uiscale
			else
				local v_uiscale = Instance.new("UIScale")
				v_uiscale.Name = "HUDScale"
				v_uiscale.Parent = v_ammo
				v_u1 = v_uiscale
			end
		end
		local v_armor = v_u_bottom:FindFirstChild("Armor")
		if v_armor then
			local v_uiscale = v_armor:FindFirstChild("UIScale")
			if v_uiscale then
				v_u2 = v_uiscale
			else
				local v_uiscale = Instance.new("UIScale")
				v_uiscale.Name = "HUDScale"
				v_uiscale.Parent = v_armor
				v_u2 = v_uiscale
			end
		end
		local v_health = v_u_bottom:FindFirstChild("Health")
		if v_health then
			local v_uiscale = v_health:FindFirstChild("UIScale")
			if v_uiscale then
				v_u3 = v_uiscale
			else
				local v_uiscale = Instance.new("UIScale")
				v_uiscale.Name = "HUDScale"
				v_uiscale.Parent = v_health
				v_u3 = v_uiscale
			end
		end
		local v_inventory = v_u_bottom:FindFirstChild("Inventory")
		if v_inventory then
			local v_uiscale = v_inventory:FindFirstChild("UIScale")
			if v_uiscale then
				v_u4 = v_uiscale
			else
				local v_uiscale = Instance.new("UIScale")
				v_uiscale.Name = "HUDScale"
				v_uiscale.Parent = v_inventory
				v_u4 = v_uiscale
			end
		end
		local v_money = v_u_bottom:FindFirstChild("Money")
		if v_money then
			local v_uiscale = v_money:FindFirstChild("UIScale")
			if v_uiscale then
				v_u5 = v_uiscale
			else
				local v_uiscale = Instance.new("UIScale")
				v_uiscale.Name = "HUDScale"
				v_uiscale.Parent = v_money
				v_u5 = v_uiscale
			end
		end
		local v1 = v_u5.Get(v_u_localplayer, "Settings.Game.HUD.Scale") or 1
		if v_u1 then
			v_u1.Scale = v1
		end
		if v_u2 then
			v_u2.Scale = v1
		end
		if v_u3 then
			v_u3.Scale = v1
		end
		if v_u4 then
			v_u4.Scale = v1
		end
		if v_u5 then
			v_u5.Scale = v1
		end
	end)
	v_u5.CreateListener(v_u_localplayer, "Settings.Game.HUD.Scale", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u2, (ref) v_u3, (ref) v_u4, (ref) v_u5
		if v_u1 and (v_u2 and (v_u3 and (v_u4 and v_u5))) then
			local v1 = arg1 or 1
			if v_u1 then
				v_u1.Scale = v1
			end
			if v_u2 then
				v_u2.Scale = v1
			end
			if v_u3 then
				v_u3.Scale = v1
			end
			if v_u4 then
				v_u4.Scale = v1
			end
			if v_u5 then
				v_u5.Scale = v1
			end
		end
	end)
	v_u3.observerRouter("RunInterfaceSound", function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u_localplayer, (ref) v_u2, (ref) v_u_playergui
		local v1 = (v_u5.Get(v_u_localplayer, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
		if v1 > 0 then
			v_u2.new("Interface"):playOneTime({
				["Parent"] = v_u_playergui,
				["Name"] = arg1
			}, v1)
		end
	end)
	v_u3.observerRouter("RunStoreSound", function(arg1)
		-- upvalues: (ref) v_u5, (ref) v_u_localplayer, (ref) v_u2, (ref) v_u_playergui
		local v1 = (v_u5.Get(v_u_localplayer, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
		if v1 > 0 then
			v_u2.new("Store"):playOneTime({
				["Parent"] = v_u_playergui,
				["Name"] = arg1
			}, v1)
		end
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u8, (copy) v_u_screens, (copy) v_u_maingui
	v_u8(v_u_screens, v_u_maingui)
end
return v_u1