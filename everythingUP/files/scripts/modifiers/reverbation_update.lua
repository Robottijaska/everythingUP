dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "reverbation_parent")
local parent_id = ComponentGetValue2( comp, "value_int")

comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
local lifetime = ComponentGetValue2( comp, "lifetime")

local projID
local newRadius = ((60 - lifetime) / 60)/4 --60 is the max lifetime of reverbation

projID = getShaderWithIDandBaseName(parent_id, "everythingUP_ShockWave_WARP").projID
comp = EntityGetFirstComponentIncludingDisabled(projID, "VariableStorageComponent", "shaderProjectile_paramNum")
ComponentSetValue2(comp, "value_float", newRadius)

projID = getShaderWithIDandBaseName(parent_id, "everythingUP_ShockWave_COLOR").projID
comp = EntityGetFirstComponentIncludingDisabled(projID, "VariableStorageComponent", "shaderProjectile_paramNum")
ComponentSetValue2(comp, "value_float", newRadius)

--GamePrint("newRad: " .. newRadius)