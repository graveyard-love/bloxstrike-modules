-- game.ReplicatedStorage.Interface.Screens.Gameplay.Bottom.Inventory

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_tween = game:GetService("TweenService")
local v_u_players = game:GetService("Players")
require(v_replicatedstorage.Database.Custom.Types)
local v_u_localplayer = v_u_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.InventoryController)
local v_u3 = require(v_replicatedstorage.Controllers.DataController)
local v_u4 = require(v_replicatedstorage.Controllers.SpectateController)
local v5 = require(v_replicatedstorage.Components.Common.GetUserPlatform)
local v_u6 = require(v_replicatedstorage.Components.Common.GetPreferenceColor)
local v_u7 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u8 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u9 = require(v_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u10 = nil
local v_u11 = 0
local v_u12 = nil
local v_u13 = {}
local v_u_find = table.find(v5(), "Console")
if v_u_find then
	v_u_find = #v5() <= 1
end
local v_u14 = {
	{
		["type"] = "Primary",
		["space"] = 1
	},
	{
		["type"] = "Secondary",
		["space"] = 1
	},
	{
		["type"] = "Melee",
		["space"] = 1
	},
	{
		["type"] = "Grenade",
		["space"] = 4
	},
	{
		["type"] = "C4",
		["space"] = 1
	}
}
local v_u15 = nil
local function v_u16()
	-- upvalues: (ref) v_u12, (copy) v_u13, (ref) v_u15
	if v_u12 then
		task.cancel(v_u12)
		v_u12 = nil
	end
	for _, v1 in pairs(v_u13) do
		v1:Cancel()
	end
	table.clear(v_u13)
	local v2 = v_u15 and { v_u15.Primary, v_u15.Secondary, v_u15.Melee } or nil
	if v2 then
		for _, v3 in ipairs(v2) do
			if v3:IsA("Frame") then
				local v_equip = v3:FindFirstChild("Equip")
				if v_equip and v_equip:IsA("Frame") then
					v_equip.BackgroundTransparency = 0
				end
				for _, v4 in ipairs(v3:GetDescendants()) do
					if v4:IsA("ImageLabel") then
						v4.ImageTransparency = 0
					elseif v4:IsA("TextLabel") then
						v4.TextTransparency = 0
					end
				end
			end
		end
	end
end
local function v_u17()
	-- upvalues: (copy) v_u3, (copy) v_u_localplayer, (copy) v_u16, (ref) v_u15, (copy) v_u_tween, (copy) v_u13, (ref) v_u12
	if v_u3.Get(v_u_localplayer, "Settings.Game.Item.Always Show Inventory") ~= false then
		v_u16()
		return
	end
	v_u16()
	local v1 = v_u15 and { v_u15.Primary, v_u15.Secondary, v_u15.Melee } or nil
	if not v1 then
		return
	end
	for _, v2 in ipairs(v1) do
		if v2:IsA("Frame") then
			local v_equip = v2:FindFirstChild("Equip")
			if v_equip and v_equip:IsA("Frame") then
				local v_create = v_u_tween:Create(v_equip, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
					["BackgroundTransparency"] = 1
				})
				v_u13[v2.Name .. "_Equip"] = v_create
				v_create:Play()
			end
			for _, v3 in ipairs(v2:GetDescendants()) do
				local v4
				if v3:IsA("ImageLabel") then
					v4 = {
						["ImageTransparency"] = 1
					}
					::l21::
					local v_create = v_u_tween:Create(v3, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), v4)
					v_u13[v2.Name .. "_" .. v3:GetFullName()] = v_create
					v_create:Play()
				elseif v3:IsA("TextLabel") then
					v4 = {
						["TextTransparency"] = 1
					}
					goto l21
				end
			end
		end
	end
	v_u12 = task.delay(5, function()
		-- upvalues: (ref) v_u12
		v_u12 = nil
	end)
end
local function v_u18(arg1)
	-- upvalues: (copy) v_u6, (copy) v_u3, (copy) v_u_localplayer, (copy) v_u8, (copy) v_u9
	if arg1 then
		if v_u3.Get(v_u_localplayer, "Settings.Game.HUD.Glow Weapon with Rarity Color") == true then
			local v_getskininformation = v_u8.GetSkinInformation(arg1.Name, arg1.Skin)
			if v_getskininformation and v_getskininformation.rarity then
				local v1 = v_u9[v_getskininformation.rarity]
				if v1 then
					return v1.Color
				else
					return v_u6()
				end
			else
				return v_u6()
			end
		else
			return v_u6()
		end
	else
		return v_u6()
	end
end
local function v_u19(arg1, arg2)
	-- upvalues: (ref) v_u10, (ref) v_u11, (copy) v_u_tween, (ref) v_u15, (copy) v_u6, (copy) v_u18, (copy) v_u_find
	if v_u10 then
		if v_u10.Name == "Grenade" then
			local v1 = v_u10:WaitForChild("Grenades"):FindFirstChild((tostring(v_u11)))
			if v1 then
				local v_grenade = v1:FindFirstChild("Grenade")
				v_u_tween:Create(v_grenade, TweenInfo.new(0.1), {
					["Size"] = v_grenade:GetAttribute("DefaultSize")
				}):Play()
			end
		else
			local v_imagelabel = v_u10.Weapon:FindFirstChildOfClass("ImageLabel")
			v_u10.Weapon.WeaponName.Visible = false
			v_u10.Equip.Visible = false
			v_u_tween:Create(v_imagelabel, TweenInfo.new(0.1), {
				["Size"] = v_imagelabel:GetAttribute("DefaultSize")
			}):Play()
		end
	end
	local v2 = v_u15:FindFirstChild((tostring(arg2.Properties.Slot)))
	v_u10 = v2
	if v2 then
		if v2.Name == "Grenade" then
			local v3 = v2.Grenades:FindFirstChild((tostring(arg1)))
			v_u11 = arg1
			if v3 then
				local v_grenade = v3:FindFirstChild("Grenade")
				v_grenade.ImageColor3 = v_u6()
				v_u_tween:Create(v_grenade, TweenInfo.new(0.1), {
					["Size"] = v_grenade:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
				}):Play()
			end
		else
			local v_imagelabel = v2.Weapon:FindFirstChildOfClass("ImageLabel")
			v_imagelabel.ImageColor3 = v_u18(arg2)
			v2.Weapon.WeaponName.Visible = true
			v2.Equip.Visible = true
			v_u_tween:Create(v_imagelabel, TweenInfo.new(0.1), {
				["Size"] = v_imagelabel:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
			}):Play()
		end
	end
	if v2 then
		v2 = v2:FindFirstChild("CycleWeaponsIcons")
	end
	if v_u_find then
		if not v2 then
			v2.Visible = v_u_find
		end
	else
		return
	end
end
local function v_u20(arg1)
	-- upvalues: (copy) v_u14
	local v1 = {}
	if not arg1 or #arg1 == 0 then
		return nil
	end
	for v2 = 1, 5 do
		local v3 = arg1[v2]
		if v3 then
			local v4 = {
				["_items"] = {},
				["_settings"] = {
					["_strict_slot_space"] = v3._settings._strict_slot_space,
					["_strict_type"] = v3._settings._strict_type
				}
			}
			v1[v2] = v4
			for _, v5 in ipairs(v3._items) do
				table.insert(v1[v2]._items, v5)
			end
		else
			local v6 = {
				["_items"] = {},
				["_settings"] = {
					["_strict_slot_space"] = v_u14[v2].space,
					["_strict_type"] = v_u14[v2].type
				}
			}
			v1[v2] = v6
		end
	end
	return v1
end
local function v_u21(arg1)
	-- upvalues: (copy) v_u6, (ref) v_u15, (copy) v_u_localplayer, (copy) v_u18
	local v1 = v_u6()
	v_u15.Grenade.DefuseKit.ImageColor3 = v1
	v_u15.Grenade.Bomb.ImageColor3 = v1
	if workspace:GetAttribute("Gamemode") == "Hostage Rescue" then
		v_u15.Grenade.Bomb.Visible = false
	end
	for _, v2 in ipairs(arg1) do
		if v2._settings._strict_slot_space == 1 then
			local v3 = v_u15:FindFirstChild(v2._settings._strict_type)
			if v3 then
				local v4 = v2._items[1]
				if v4 then
					local v_weapon = v3:FindFirstChild("Weapon")
					v3:SetAttribute("Slot", v4.Slot)
					v3.Keybind.Text = v4.Slot
					if v_weapon then
						local v5 = v3.Weapon:FindFirstChild(v4.Properties.Class)
						local v6 = (v2._settings._strict_type == "Melee" and "\226\152\133 " or "") .. v4.Name
						if v4.Skin then
							local v_skin = v4.Skin
							v6 = v6 .. (v_skin == "Vanilla" and "" or (" | " .. v_skin or ""))
						end
						local v7 = (v4.Name == "T Knife" or v4.Name == "CT Knife") and "Knife" or v6
						if v4.NameTag then
							v7 = ("\"%*\""):format(v4.NameTag)
						end
						local v_originalowner = v4.OriginalOwner
						if v_originalowner and (v_originalowner ~= "" and v_originalowner ~= v_u_localplayer.Name) then
							v7 = ("\"%*\'s %*\""):format(v_originalowner, v7)
						end
						v3.Weapon.WeaponName.TextColor3 = v_u18(v4)
						v3.Weapon.WeaponName.Text = v7
						if v5 then
							v5.Image = v4.Properties.Icon
							v5.ImageColor3 = v_u18(v4)
						end
					end
				end
			elseif v2._settings._strict_type == "C4" then
				v_u15.Grenade.Bomb.Visible = v2._items[1]
			end
		elseif v2._settings._strict_type == "Grenade" then
			for v8 = 1, 4 do
				local v9 = v_u15.Grenade.Grenades:FindFirstChild((tostring(v8)))
				if v9 then
					local v10 = v2._items[v8]
					if v10 then
						v9.Grenade.ImageColor3 = v1
						v9.Grenade.Visible = true
						v9.Dot.Visible = false
						if v10.Properties and v10.Properties.Icon then
							v9.Grenade.Image = v10.Properties.Icon
						end
					else
						v9.Grenade.Visible = false
						v9.Dot.Visible = true
					end
				end
			end
		end
	end
	for _, v11 in ipairs(v_u15:GetChildren()) do
		if v11:IsA("Frame") then
			local v12 = v11.Name == "Grenade" and true or v11.Name == "Melee"
			for _, v13 in ipairs(arg1) do
				if #v13._items > 0 and v13._settings._strict_type == v11.Name then
					v12 = true
					break
				end
			end
			v11.Visible = v12
		end
	end
end
function v1.Initialize(_, arg2)
	-- upvalues: (ref) v_u15, (copy) v_u2
	for _, v1 in ipairs(arg2:GetDescendants()) do
		if v1:IsA("ImageLabel") and (v1.Parent.Name == "Weapon" or v1.Name == "Grenade") then
			v1:SetAttribute("DefaultSize", v1.Size)
		end
	end
	for _, v_u2 in ipairs(v_u15:GetChildren()) do
		if v_u2:IsA("Frame") and v_u2:FindFirstChild("Button") then
			v_u2.Button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u2, (ref) v_u2
				local v_slot = v_u2:GetAttribute("Slot")
				v_u2.equip(v_slot, 1)
			end)
		end
	end
	for _, v_u3 in ipairs(v_u15.Grenade.Grenades:GetChildren()) do
		if v_u3:IsA("Frame") then
			v_u3:FindFirstChild("Button").MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u2, (copy) v_u3
				v_u2.equip(4, (tonumber(v_u3.Name)))
			end)
		end
	end
	local v_u_bomb = v_u15.Grenade.Bomb
	if v_u_bomb:IsA("ImageButton") then
		v_u_bomb.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_bomb, (ref) v_u2
			if v_u_bomb.Visible then
				v_u2.equip(5, 1)
			end
		end)
	end
end
function v1.Start()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u21, (copy) v_u19, (copy) v_u3, (copy) v_u16, (copy) v_u17, (ref) v_u15, (copy) v_u18, (copy) v_u4, (copy) v_u7, (copy) v_u20, (copy) v_u_players
	v_u2.OnInventoryChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u21
		if not v_u_localplayer:GetAttribute("IsSpectating") then
			v_u21(arg1)
		end
	end)
	v_u2.OnInventoryItemEquipped:Connect(function(arg1, arg2)
		-- upvalues: (ref) v_u19, (ref) v_u3, (ref) v_u_localplayer, (ref) v_u16, (ref) v_u17
		v_u19(arg1, arg2)
		if v_u3.Get(v_u_localplayer, "Settings.Game.Item.Always Show Inventory") == false then
			local v_slot = arg2.Properties.Slot
			if v_slot == "Primary" or (v_slot == "Secondary" or (v_slot == "Melee" or v_slot == "Grenade")) then
				v_u16()
				v_u17()
			end
		end
	end)
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.HUD.Glow Weapon with Rarity Color", function()
		-- upvalues: (ref) v_u2, (ref) v_u21, (ref) v_u15, (ref) v_u18
		local v_getcurrentinventory = v_u2.getCurrentInventory()
		if v_getcurrentinventory then
			v_u21(v_getcurrentinventory)
		end
		local v_getcurrentequipped = v_u2.getCurrentEquipped()
		if v_getcurrentequipped then
			local v1 = v_u15:FindFirstChild((tostring(v_getcurrentequipped.Properties.Slot)))
			if v1 and v1.Name ~= "Grenade" then
				local v2 = v_u18(v_getcurrentequipped)
				local v_imagelabel = v1.Weapon:FindFirstChildOfClass("ImageLabel")
				if v_imagelabel then
					v_imagelabel.ImageColor3 = v2
				end
				if v1.Weapon.WeaponName then
					v1.Weapon.WeaponName.TextColor3 = v2
				end
			end
		end
	end)
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.HUD.Color", function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u7, (ref) v_u2, (ref) v_u21
		if v_u_localplayer:GetAttribute("IsSpectating") == true then
			local v_getplayer = v_u4.GetPlayer()
			if v_getplayer then
				v_u7.Inventory.RequestSpectatedPlayerInventory.Send(v_getplayer)
				return
			end
		else
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				v_u21(v_getcurrentinventory)
			end
		end
	end)
	v_u_localplayer:GetAttributeChangedSignal("HasDefuseKit"):Connect(function()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u15
		if v_u_localplayer:GetAttribute("IsSpectating") then
			return
		else
			local v_team = v_u_localplayer:GetAttribute("Team")
			if v_u_localplayer:GetAttribute("HasDefuseKit") and v_team == "Counter-Terrorists" then
				v_u15.Grenade.DefuseKit.Visible = true
			else
				v_u15.Grenade.DefuseKit.Visible = false
			end
		end
	end)
	v_u7.Inventory.SpectatedPlayerInventory.Listen(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u20, (ref) v_u21
		if v_u_localplayer:GetAttribute("IsSpectating") == true then
			local v_getplayer = v_u4.GetPlayer()
			local v1 = v_getplayer and (arg1.Player == v_getplayer and v_u20(arg1.Inventory))
			if v1 then
				v_u21(v1)
			end
		end
	end)
	v_u4.ListenToSpectate:Connect(function(arg1)
		-- upvalues: (ref) v_u7, (ref) v_u15, (ref) v_u2, (ref) v_u21, (ref) v_u_localplayer
		if arg1 then
			v_u7.Inventory.RequestSpectatedPlayerInventory.Send(arg1)
			local v_team = arg1:GetAttribute("Team")
			if arg1:GetAttribute("HasDefuseKit") and v_team == "Counter-Terrorists" then
				v_u15.Grenade.DefuseKit.Visible = true
			else
				v_u15.Grenade.DefuseKit.Visible = false
			end
		else
			local v_getcurrentinventory = v_u2.getCurrentInventory()
			if v_getcurrentinventory then
				v_u21(v_getcurrentinventory)
			end
			local v_team = v_u_localplayer:GetAttribute("Team")
			if v_u_localplayer:GetAttribute("HasDefuseKit") and v_team == "Counter-Terrorists" then
				v_u15.Grenade.DefuseKit.Visible = true
			else
				v_u15.Grenade.DefuseKit.Visible = false
			end
		end
	end)
	local function v_u1()
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u15
		local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true and v_u4.GetPlayer()
		if v1 then
			local v_team = v1:GetAttribute("Team")
			if v1:GetAttribute("HasDefuseKit") and v_team == "Counter-Terrorists" then
				v_u15.Grenade.DefuseKit.Visible = true
				return
			end
			v_u15.Grenade.DefuseKit.Visible = false
		end
	end
	for _, v2 in ipairs(v_u_players:GetPlayers()) do
		if v2 ~= v_u_localplayer then
			v2:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u1)
		end
	end
	v_u_players.PlayerAdded:Connect(function(arg1)
		-- upvalues: (ref) v_u_localplayer, (copy) v_u1
		if arg1 ~= v_u_localplayer then
			arg1:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u1)
		end
	end)
	v_u7.Inventory.NewInventoryItem.Listen(function(_)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u7
		local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true and v_u4.GetPlayer()
		if v1 then
			v_u7.Inventory.RequestSpectatedPlayerInventory.Send(v1)
		end
	end)
	v_u7.Inventory.RemoveInventoryItem.Listen(function(_)
		-- upvalues: (ref) v_u_localplayer, (ref) v_u4, (ref) v_u7
		local v1 = v_u_localplayer:GetAttribute("IsSpectating") == true and v_u4.GetPlayer()
		if v1 then
			v_u7.Inventory.RequestSpectatedPlayerInventory.Send(v1)
		end
	end)
	v_u3.CreateListener(v_u_localplayer, "Settings.Game.Item.Always Show Inventory", function()
		-- upvalues: (ref) v_u3, (ref) v_u_localplayer, (ref) v_u16, (ref) v_u17
		v_u16()
		if v_u3.Get(v_u_localplayer, "Settings.Game.Item.Always Show Inventory") == false then
			v_u17()
		end
	end)
	task.wait(0.1)
	if v_u3.Get(v_u_localplayer, "Settings.Game.Item.Always Show Inventory") == false then
		v_u17()
	end
end
return v1