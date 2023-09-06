dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_name")
local name = ComponentGetValue2( comp, "value_string")

deleteShader(name);