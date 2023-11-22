dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = getPlayer()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local entities = EntityGetInRadius( x, y, 200)

local counter = 0
for _, id in ipairs(entities) do
	if (GameGetGameEffectCount(id, "CHARM") > 0) then counter = counter + 1 end
end

GlobalsSetValue("MASK_LOVE_COUNTER", tostring(counter))