dofile_once("data/scripts/lib/utilities.lua")
local nxml = dofile_once("mods/everythingUP/lib/nxml.lua")

local content;
local xml;

--ANIMALS

--drone_physics
content = ModTextFileGetContent("data/entities/animals/drone_physics.xml")
xml = nxml.parse(content)
xml:add_child(nxml.parse([[
<LuaComponent
    _enabled="1"
    execute_every_n_frame="-1"
    execute_on_removed="1"
    script_source_file="mods/everythingUP/files/scripts/entities/items/shield_orb_drop.lua">
</LuaComponent>
]]))
ModTextFileSetContent("data/entities/animals/drone_physics.xml", tostring(xml))

--PROJECTILES