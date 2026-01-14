-- game.ReplicatedStorage.Components.Common.UserInput.EquipInventorySlot

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
return function(arg1)
	-- upvalues: (copy) v_u1
	local v_getcurrentequipped = v_u1.getCurrentEquipped()
	local v_getinventoryslot = v_u1.getInventorySlot(arg1)
	if not v_getinventoryslot then
		::l2::
		return
	end
	if not v_getcurrentequipped then
		if #v_getinventoryslot._items > 0 then
			v_u1.equip(arg1, 1)
		end
		goto l2
	end
	if (v_getcurrentequipped.Slot or 1) ~= arg1 then
		v_u1.equip(arg1, 1)
		return
	end
	local v_identifier = v_getcurrentequipped.Identifier
	for v3, v2 in ipairs(v_getinventoryslot._items) do
		if v2.Identifier == v_identifier then
			goto l10
		end
	end
	local v3 = 0
	::l10::
	local v4 = v3 + 1
	v_u1.equip(arg1, #v_getinventoryslot._items < v4 and 1 or v4)
end