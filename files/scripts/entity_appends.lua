dofile_once("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/everythingUP/lib/nxml.lua")

local function addToRaw(filename, input)
    local content = ModTextFileGetContent(filename)
    local xml = nxml.parse(content)
    xml:add_child(nxml.parse(input))
    ModTextFileSetContent(filename, tostring(xml))
end

--ANIMALS

--drone_physics
addToRaw("data/entities/animals/drone_physics.xml",[[
    <LuaComponent
        _enabled="1"
        execute_every_n_frame="-1"
        execute_on_removed="1"
        script_source_file="mods/everythingUP/files/scripts/entities/items/shield_orb_drop.lua">
    </LuaComponent>
]])

--PROJECTILES