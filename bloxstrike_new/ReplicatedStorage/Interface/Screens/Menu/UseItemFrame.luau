-- game.ReplicatedStorage.Interface.Screens.Menu.UseItemFrame

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Collections)
local v_u6 = require(v_u_replicatedstorage.Database.Security.Router)
local v7 = require(v_u_replicatedstorage.Packages.Signal)
local v_u8 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u9 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u12 = require(script.Actions)
local v_u13 = nil
local v_u14 = nil
local v_u15 = nil
local v_u16 = false
local v_u17 = nil
local v_u18 = nil
local v_u19 = nil
local v_u20 = {}
local v_u21 = 0
local v_u22 = nil
local v_u23 = nil
local v_u24 = nil
local v_u25 = nil
local v_u26 = nil
local v_u27 = nil
v_u1.OnItemSelected = v7.new()
v_u1.OnClosed = v7.new()
local function v_u28(arg1, arg2)
	-- upvalues: (copy) v_u5, (ref) v_u18
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == arg2 then
			v1:Destroy()
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
end
local function v_u29(arg1, arg2, _, arg4, arg5, _)
	-- upvalues: (copy) v_u_tween, (copy) v_u6, (ref) v_u19, (copy) v_u1
	arg2.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg2
		v_u_tween:Create(arg2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 0.85
		}):Play()
	end)
	arg2.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg2
		v_u_tween:Create(arg2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		}):Play()
	end)
	arg2.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u6, (ref) v_u19, (copy) arg4, (ref) v_u1, (copy) arg5, (copy) arg1, (copy) arg2
		v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u19 = arg4
		v_u1.PopulateItems()
		arg5.Text = arg4
		for _, v1 in ipairs(arg1:GetChildren()) do
			if v1:IsA("TextButton") then
				v1.Frame.BackgroundTransparency = v1 == arg2 and 0 or 1
			end
		end
		arg1.Visible = false
	end)
end
local function v_u30(self)
	-- upvalues: (copy) v_u_tween
	local v_u_size = self.Size
	local v_button = self.Button
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 1, v2.X.Offset, v2.Y.Scale * 1, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	v_button.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.9, v2.X.Offset, v2.Y.Scale * 0.9, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	v_button.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
end
local function v_u31()
	-- upvalues: (ref) v_u23
	if not (v_u23 and v_u23.Visible) then
		return 50
	end
	local v_uigridlayout = v_u23:FindFirstChildOfClass("UIGridLayout")
	if not v_uigridlayout then
		return 50
	end
	local v_absolutesize = v_u23.AbsoluteSize
	local v_y = v_absolutesize.Y
	local v_x = v_absolutesize.X
	local v_cellsize = v_uigridlayout.CellSize
	local v_cellpadding = v_uigridlayout.CellPadding
	local v1 = v_cellsize.Y.Scale * v_y + v_cellsize.Y.Offset
	local v2 = v_cellpadding.Y.Scale * v_y + v_cellpadding.Y.Offset
	local v3 = v_cellsize.X.Scale * v_x + v_cellsize.X.Offset
	local v4 = v_cellpadding.X.Scale * v_x + v_cellpadding.X.Offset
	local v_uipadding = v_u23:FindFirstChildOfClass("UIPadding")
	local v5, v6, v7, v8
	if v_uipadding then
		v5 = v_uipadding.PaddingTop.Scale * v_y + v_uipadding.PaddingTop.Offset
		v6 = v_uipadding.PaddingBottom.Scale * v_y + v_uipadding.PaddingBottom.Offset
		v7 = v_uipadding.PaddingLeft.Scale * v_x + v_uipadding.PaddingLeft.Offset
		v8 = v_uipadding.PaddingRight.Scale * v_x + v_uipadding.PaddingRight.Offset
	else
		v5 = 0
		v6 = 0
		v7 = 0
		v8 = 0
	end
	local v9 = v_y - v5 - v6
	local v10 = v_x - v7 - v8
	local v11
	if v3 + v4 > 0 then
		local v_floor = math.floor((v10 + v4) / UNNAMED_2189145605656)
		v11 = math.max(1, v_floor)
	else
		v11 = 1
	end
	local v12
	if v1 + v2 > 0 then
		local v_floor = math.floor((v9 + v2) / UNNAMED_2189151819528)
		v12 = math.max(1, v_floor)
	else
		v12 = 1
	end
	return v12 * v11 + v11
end
local function v_u32()
	-- upvalues: (ref) v_u23, (ref) v_u13, (copy) v_u1, (copy) v_u5, (ref) v_u18, (ref) v_u21, (ref) v_u20
	if v_u23 then
		local function v1(arg1)
			-- upvalues: (ref) v_u13, (ref) v_u1
			if v_u13 then
				v_u1.OnItemSelected:Fire(arg1, v_u13)
				v_u1.Hide()
			end
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u18
			v_u18 = arg1
		end)
		local v_min = math.min(v_u21 + 25, #v_u20)
		for v2 = v_u21 + 1, v_min do
			local v3 = v_u20[v2]
			if v3 and not v_u23:FindFirstChild(v3._id) then
				v_u1.CreateItemTemplate(v3, v1)
			end
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u18
			v_u18 = arg1
		end)
		v_u21 = v_min
	end
end
local function v_u33()
	-- upvalues: (ref) v_u23, (ref) v_u21, (ref) v_u20, (copy) v_u32, (copy) v_u5, (ref) v_u18
	if v_u23 then
		local v1 = v_u23.AbsoluteCanvasSize.Y - v_u23.AbsoluteSize.Y
		if v1 > 0 and (v_u21 < #v_u20 and v1 - v_u23.CanvasPosition.Y < 200) then
			v_u32()
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u18
			v_u18 = arg1
		end)
	end
end
local function v_u34()
	-- upvalues: (ref) v_u16, (ref) v_u26, (copy) v_u_playergui, (ref) v_u22, (ref) v_u23, (ref) v_u27, (copy) v_u5, (ref) v_u18, (ref) v_u19, (copy) v_u6, (copy) v_u9, (copy) v_u29, (ref) v_u24, (ref) v_u25, (copy) v_u1, (ref) v_u13, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u8, (copy) v_u33
	if v_u16 then
		return true
	end
	print("Initializing")
	v_u26 = v_u_playergui:FindFirstChild("MainGui")
	if not v_u26 then
		warn("[UseItemFrame] MainGui not found")
		return false
	end
	local v_menu = v_u26:FindFirstChild("Menu")
	if not v_menu then
		warn("[UseItemFrame] Menu frame not found")
		return false
	end
	v_u22 = v_menu:FindFirstChild("UseItemFrame")
	if not v_u22 then
		warn("[UseItemFrame] UseItemFrame not found in Menu")
		return false
	end
	local v_tabs = v_u22:FindFirstChild("Tabs")
	local v1 = v_tabs and v_tabs:FindFirstChild("Inventory")
	if v1 then
		v_u23 = v1:FindFirstChild("Container")
		v_u27 = v1:FindFirstChild("Sort")
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	local v_u2 = v_u27 and v_u27:FindFirstChild("Button")
	if v_u2 then
		local v_textlabel = v_u2:FindFirstChild("Frame"):FindFirstChild("TextLabel")
		if v_textlabel then
			v_textlabel.Text = "Newest"
			v_u19 = "Newest"
		end
		v_u2.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u2, (ref) v_u6
			local v_options = v_u2:FindFirstChild("Options")
			if v_options then
				v_options.Visible = not v_options.Visible
				v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
			end
		end)
		local v_options = v_u2:FindFirstChild("Options")
		local v_textlabel = v_u2:FindFirstChild("Frame"):FindFirstChild("TextLabel")
		if v_options and v_textlabel then
			for v3, v4 in pairs(v_u9) do
				local v5 = v_options:FindFirstChild(v3)
				if v5 then
					v_u29(v_options, v5, v4, v3, v_textlabel, v_u23)
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	local v_top = v_u22:FindFirstChild("Top")
	if v_top then
		v_u24 = v_top:FindFirstChild("TextLabel")
		v_u25 = v_top:FindFirstChild("Close")
		if v_u25 then
			v_u25.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u6, (ref) v_u1, (ref) v_u13
				v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
				v_u1.OnClosed:Fire(v_u13)
				v_u1.Hide()
			end)
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	v_u2.CreateListener(v_u_localplayer, "Inventory", function(_)
		-- upvalues: (ref) v_u1
		if v_u1.IsVisible() then
			v_u1.PopulateItems()
		end
	end)
	v_u8.OnScreenChanged:Connect(function(_, _)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
	v_u8.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
	v_u8.OnCaseSceneStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
	if v_u23 then
		v_u23:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (ref) v_u33
			v_u33()
		end)
	end
	v_u16 = true
	return true
end
function v_u1.CreateItemTemplate(arg1, arg2)
	-- upvalues: (ref) v_u23, (copy) v_u4, (copy) v_u3, (copy) v_u10, (copy) v_u_replicatedstorage, (copy) v_u6, (ref) v_u15, (ref) v_u17, (copy) v_u30
	if not (arg1 and arg1._id) then
		return
	end
	if not v_u23 then
		return
	end
	local v1 = arg1.Type == "Case"
	local v2 = v1 and v_u4.GetCaseByName(arg1.Skin) or v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
	if not v2 then
		return
	end
	local v3 = v_u10[v1 and v2.caseRarity or v2.rarity]
	local v4 = nil
	if v1 then
		v4 = v2.imageAssetId or ""
	elseif arg1.Type == "Charm" then
		local v_pattern = arg1.Pattern
		if v_pattern and v2.charmImages then
			for _, v5 in ipairs(v2.charmImages) do
				if v5.pattern == v_pattern then
					v4 = v5.assetId
					break
				end
			end
		end
		if not v4 then
			v4 = v2.imageAssetId or ""
		end
	else
		v4 = v_u3.GetWearImageForFloat(v2, arg1.Float or 0.9999) or (v2.imageAssetId or "")
	end
	local v_u_clone = v_u_replicatedstorage.Assets.UI.Inventory.ItemTemplate:Clone()
	v_u_clone.Main.RarityFrame.UIGradient.Color = v3.ColorSequence
	v_u_clone.Main.Glow.UIGradient.Color = v3.ColorSequence
	v_u_clone.Parent = v_u23
	v_u_clone.Main.Icon.Image = v4
	v_u_clone.Name = arg1._id
	v_u_clone.Information.Weapon.Text = arg1.StatTrack and "KillTrak\226\132\162 " .. arg1.Name or arg1.Name
	v_u_clone.Information.Skin.Text = v1 and v2.skin or arg1.Skin
	if arg1.Type == "Charm" then
		v_u_clone.Button.MouseButton2Click:Connect(function()
			-- upvalues: (ref) v_u6, (copy) arg1
			v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
			v_u6.broadcastRouter("WeaponInspect", arg1.Name, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag, arg1.Charm, arg1.Stickers, arg1.Type, arg1.Pattern, arg1._id, arg1.Serial, arg1.IsTradeable)
		end)
	end
	v_u_clone.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u6, (copy) arg2, (copy) arg1
		v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
		arg2(arg1)
	end)
	v_u_clone.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u15, (copy) v_u_clone, (ref) v_u17
		v_u15 = v_u_clone
		v_u17 = tick()
	end)
	v_u_clone.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u15, (ref) v_u17
		v_u15 = nil
		v_u17 = nil
	end)
	v_u30(v_u_clone)
end
function v_u1.PopulateItems()
	-- upvalues: (ref) v_u23, (copy) v_u28, (ref) v_u21, (ref) v_u20, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u11, (ref) v_u14, (ref) v_u13, (copy) v_u5, (ref) v_u18, (ref) v_u19, (ref) v_u27, (copy) v_u9, (copy) v_u1, (copy) v_u31
	if v_u23 then
		v_u28(v_u23, "Frame")
		v_u21 = 0
		v_u20 = {}
		local v_get = v_u2.Get(v_u_localplayer, "Inventory")
		if v_get and type(v_get) == "table" then
			for _, v1 in ipairs(v_get) do
				local v2
				if v1 then
					v2 = v_u11[v1.Name]
				else
					v2 = v1
				end
				local v3
				if v1 then
					v3 = v1.Type == "Case"
				else
					v3 = v1
				end
				local v4 = v1 and (v1._id and v1.Name)
				if v4 then
					v4 = v3 or v1.Skin
				end
				if v4 and not (v2 or v3) and (not (v_u14 and v_u13) or v_u14(v1, v_u13)) then
					table.insert(v_u20, v1)
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u18
				v_u18 = arg1
			end)
			local v_getsortcomparisonfunction = v_u9.GetSortComparisonFunction(v_u19 or v_u27 and v_u27.Button.Frame.TextLabel.Text or "Newest", v_u_localplayer, function()
				-- upvalues: (ref) v_u18
				return v_u18
			end)
			if v_getsortcomparisonfunction then
				table.sort(v_u20, v_getsortcomparisonfunction)
			end
			local function v5(arg1)
				-- upvalues: (ref) v_u13, (ref) v_u1
				if v_u13 then
					v_u1.OnItemSelected:Fire(arg1, v_u13)
					v_u1.Hide()
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u18
				v_u18 = arg1
			end)
			local v6 = v_u31()
			local v_max = math.max(v6, 50)
			local v_min = math.min(v_max, #v_u20)
			for v7 = 1, v_min do
				local v8 = v_u20[v7]
				if v8 then
					v_u1.CreateItemTemplate(v8, v5)
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u18
				v_u18 = arg1
			end)
			v_u21 = v_min
		end
	else
		return
	end
end
function v_u1.Show(arg1, arg2)
	-- upvalues: (copy) v_u34, (ref) v_u22, (ref) v_u13, (ref) v_u14, (ref) v_u24, (copy) v_u5, (ref) v_u18, (copy) v_u1
	if v_u34() then
		if v_u22 then
			v_u13 = arg1
			v_u14 = arg2
			if v_u24 then
				if arg1.SourceItem then
					local v_sourceitem = arg1.SourceItem
					local v_name = v_sourceitem.Name
					if v_sourceitem.StatTrack then
						v_name = "KillTrak\226\132\162 " .. v_name
					end
					if v_sourceitem.Skin then
						v_name = v_name .. " | " .. v_sourceitem.Skin
					end
					v_u24.Text = ("Select an item to use with %*"):format(v_name)
				elseif arg1.Title then
					v_u24.Text = arg1.Title
				else
					v_u24.Text = "Select an item"
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u18
				v_u18 = arg1
			end)
			v_u1.PopulateItems()
			v_u22.Visible = true
		end
	else
		warn("[UseItemFrame] Failed to initialize")
		return
	end
end
function v_u1.Hide()
	-- upvalues: (ref) v_u22, (ref) v_u13, (ref) v_u14
	if v_u22 then
		v_u22.Visible = false
	end
	v_u13 = nil
	v_u14 = nil
end
function v_u1.IsVisible()
	-- upvalues: (ref) v_u22
	return v_u22 and v_u22.Visible or false
end
function v_u1.GetCurrentContext()
	-- upvalues: (ref) v_u13
	return v_u13
end
v_u1.Filters = {}
function v_u1.Filters.WeaponsWithoutCharm(arg1, _)
	if arg1.Type ~= "Weapon" then
		return false
	end
	local v1
	if arg1.Charm == nil or arg1.Charm == false then
		v1 = false
	else
		v1 = (type(arg1.Charm) == "string" or arg1.Charm == true) and true or type(arg1.Charm) == "table"
	end
	return not v1
end
local function v35(arg1, _)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u5, (ref) v_u18
	if arg1.Type ~= "Charm" then
		return false
	end
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if v_get then
		for _, v1 in ipairs(v_get) do
			if v1.Charm then
				local v2 = type(v1.Charm) == "table" and v1.Charm._id
				if not v2 then
					if type(v1.Charm) == "string" then
						v2 = v1.Charm
					else
						v2 = false
					end
				end
				if v2 == arg1._id then
					return false
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	return true
end
v_u1.Filters.AllCharms = v35
function v_u1.Filters.AllWeapons(arg1, _)
	return arg1.Type == "Weapon"
end
function v_u1.Filters.AllMelees(arg1, _)
	return arg1.Type == "Melee"
end
function v_u1.Filters.AllGloves(arg1, _)
	return arg1.Type == "Glove"
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u26, (ref) v_u22, (ref) v_u23, (ref) v_u27, (copy) v_u5, (ref) v_u18, (ref) v_u19, (copy) v_u6, (copy) v_u9, (copy) v_u29, (ref) v_u24, (ref) v_u25, (copy) v_u1, (ref) v_u13, (copy) v_u33, (ref) v_u16
	v_u26 = arg1
	v_u22 = arg2
	local v_tabs = arg2:FindFirstChild("Tabs")
	local v1 = v_tabs and v_tabs:FindFirstChild("Inventory")
	if v1 then
		v_u23 = v1:FindFirstChild("Container")
		v_u27 = v1:FindFirstChild("Sort")
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	if v_u27 then
		local v_u_button = v_u27:FindFirstChild("Button")
		if v_u_button then
			local v_textlabel = v_u_button:FindFirstChild("Frame"):FindFirstChild("TextLabel")
			if v_textlabel then
				v_textlabel.Text = "Newest"
				v_u19 = "Newest"
			end
			v_u_button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_button, (ref) v_u6
				local v_options = v_u_button:FindFirstChild("Options")
				if v_options then
					v_options.Visible = not v_options.Visible
					v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
				end
			end)
			local v_options = v_u_button:FindFirstChild("Options")
			local v_textlabel = v_u_button:FindFirstChild("Frame"):FindFirstChild("TextLabel")
			if v_options and v_textlabel then
				for v2, v3 in pairs(v_u9) do
					local v4 = v_options:FindFirstChild(v2)
					if v4 then
						v_u29(v_options, v4, v3, v2, v_textlabel, v_u23)
					end
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	local v_top = arg2:FindFirstChild("Top")
	if v_top then
		v_u24 = v_top:FindFirstChild("TextLabel")
		v_u25 = v_top:FindFirstChild("Close")
		if v_u25 then
			v_u25.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u6, (ref) v_u1, (ref) v_u13
				v_u6.broadcastRouter("RunInterfaceSound", "UI Click")
				v_u1.OnClosed:Fire(v_u13)
				v_u1.Hide()
			end)
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u18
		v_u18 = arg1
	end)
	if v_u23 then
		v_u23:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (ref) v_u33
			v_u33()
		end)
	end
	arg2.Visible = false
	v_u16 = true
end
function v_u1.Start()
	-- upvalues: (copy) v_u12, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u8, (ref) v_u13
	v_u12.InitializeAll()
	v_u2.CreateListener(v_u_localplayer, "Inventory", function(_)
		-- upvalues: (ref) v_u1
		if v_u1.IsVisible() then
			v_u1.PopulateItems()
		end
	end)
	v_u8.OnScreenChanged:Connect(function(_, _)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
	v_u8.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
	v_u8.OnCaseSceneStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u13
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u13)
			v_u1.Hide()
		end
	end)
end
function v_u1.TriggerAction(arg1, arg2)
	-- upvalues: (copy) v_u12, (copy) v_u1
	local v_get = v_u12.Get(arg1)
	if v_get then
		local v_getcontext = v_get.GetContext(arg2)
		local v_getfilter = v_get.GetFilter(arg2)
		v_u1.Show(v_getcontext, v_getfilter)
	else
		warn((("[UseItemFrame] Unknown action type: %*"):format(arg1)))
	end
end
function v_u1.GetActions()
	-- upvalues: (copy) v_u12
	return v_u12
end
return v_u1