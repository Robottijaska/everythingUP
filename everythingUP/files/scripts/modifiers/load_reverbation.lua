dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
	
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local damage = 0
	
if comp ~= nil then
	damage = ComponentObjectGetValue2( comp, "config_explosion", "damage" )
end
	
local new_entity_id = EntityLoad("mods/everythingUP/files/entities/projectiles/reverbation.xml", x, y)

spawnShader(x, y, 1.0f, everythingUP_ShockWave, 60);

comp = EntityGetFirstComponent( new_entity_id, "ProjectileComponent")
	
ComponentObjectSetValue2(comp, "config_explosion", "damage", damage)
GamePrint(damage)