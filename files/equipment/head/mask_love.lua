dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

function shot( entity_id )

	local damageCoef = (tonumber(GlobalsGetValue("MASK_LOVE_COUNTER")) + 1) ^ (1/3) --cbrt(x + 1)

	if damageCoef > 1.5 then
		EntityLoadToEntity("data/entities/particles/charm.xml", entity_id)
	end
	
	local comps = EntityGetComponent( entity_id, "ProjectileComponent" )
	for _ ,comp in ipairs(comps) do
		local damage = ComponentGetValue2( comp, "damage" )
		if damage ~= nil then
			ComponentSetValue2( comp, "damage", damageCoef * damage )
		end
	end
end