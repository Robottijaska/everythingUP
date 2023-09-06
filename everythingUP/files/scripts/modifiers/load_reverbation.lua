dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local damage = 0.5

if comp ~= nil then
	damage = ComponentObjectGetValue2( comp, "config_explosion", "damage" )
end

if damage == 0 then damage = 0.5 end

local new_entity_id = EntityLoad("mods/everythingUP/files/entities/projectiles/reverbation.xml", x, y)

spawnShader(60, "everythingUP_ShockWave_Med_COLOR", x, y, new_entity_id);
spawnShader(60, "everythingUP_ShockWave_Med_WARP", x, y, new_entity_id);

comp = EntityGetFirstComponent( new_entity_id, "ProjectileComponent")

ComponentObjectSetValue2(comp, "config_explosion", "damage", damage * 0.40)