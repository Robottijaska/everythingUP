dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( GetUpdatedEntityID() )
x = math.floor((x*10)+0.5)
y = math.floor((y*10)+0.5)
local current_coordinate = x * y

--created because of shitty API (normal delete projectile on low velocity does not work)

--value_string: amount of frames proj needs to stay still before deletion
--value_int: last coordinate (x * y)
--name: amount of frames the proj has stayed still for (keep at 0 in file)

local storage_state = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "kill_if_stuck")

local max_repetitions = tonumber(ComponentGetValue2(storage_state, "value_string"))
local current_repetitions = tonumber(ComponentGetValue2(storage_state, "name"))
local last_coordinate = ComponentGetValue2(storage_state, "value_int")

if (current_coordinate == last_coordinate) then
	ComponentSetValue2(storage_state, "name", tostring(current_repetitions + 1))
	if (current_repetitions + 1 >= max_repetitions) then
		EntityKill(entity_id)
	end
else
	ComponentSetValue2(storage_state, "name", "0")
end
ComponentSetValue2(storage_state, "value_int", current_coordinate)