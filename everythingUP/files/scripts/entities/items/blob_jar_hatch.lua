dofile_once("data/scripts/lib/utilities.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local x, y = EntityGetTransform( GetUpdatedEntityID() )
	
    local times = 2 + math.random(1, 2)

    for i = 1, times do
        EntityLoad("mods/everythingUP/files/entities/enemies/miniblob_angry.xml", x, y)
    end
end