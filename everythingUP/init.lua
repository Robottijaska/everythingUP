dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")

-- all functions below are optional and can be left out

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )
end

-- This code runs when all mods' filesystems are registered

--appends

function AppendAll()

	function AppendBiomes()
		ModLuaFileAppend( "data/scripts/biomes/coalmine.lua", "mods/everythingUP/files/scripts/biomes/coalmine.lua" )
	end

	----SCRIPT----
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/everythingUP/files/actions.lua" )
	dofile("mods/everythingUP/files/scripts/gun/starting_wand.lua")

	AppendBiomes()

	--constants
	postfx.append(
	[[
	]],
		"//extra_define0",
		"data/shaders/post_final.frag"
	)
	newShaderEffect("everythingUP_ShockWave", 20);
	--shader functions
	postfx.append(
	[[
	vec3 everythingUP_ShockWave(float x, float y, float radius){
		// Normalized pixel coordinates (from 0 to 1)
		
		vec2 position = vec2(x, y);
		vec2 uv = tex_coord_.xy / window_size.xy;
		uv.x *= window_size.x/window_size.y;
		float dist = length(abs(uv - position));
		float uppercircbound = time*2.0;
		float lowercircbound = (uppercircbound + time)/1.5;
    
		float medcircbound = (uppercircbound+lowercircbound)/2.0;
    
		return vec3(smoothstep(radius, 0.0, dist) * (smoothstep(lowercircbound-0.5, lowercircbound, dist) - smoothstep(uppercircbound, uppercircbound, dist)));
	}
	]],
		"// utilities",
		"data/shaders/post_final.frag"
	)
	
		--shader execution
	postfx.append(
	[[
		color += everythingUP_ShockWave(0.5, 0.5, 1.0);
	]],
		"// various debug visualizations================================================================================",
		"data/shaders/post_final.frag"
	)

	print("everythingUP: Finished appending files!")
end
AppendAll()

--translations

--projectiles

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_summon_battery,Summon Battery,,,,,,,,,,,,,
actiondesc_summon_battery,Summons an unstable battery,,,,,,,,,,,,,
]])

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_summon_boomerang,Boomerang,,,,,,,,,,,,,
actiondesc_summon_boomerang,Fires a returning boomerang,,,,,,,,,,,,,
]])

--modifiers

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_fuel_to_power,Fuel to Power,,,,,,,,,,,,,
actiondesc_fuel_to_power,Uses nearby flammables to generate power,,,,,,,,,,,,,
]])

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_magnet_shot_attract,Magnet Shot (attract),,,,,,,,,,,,,
actiondesc_magnet_shot_attract, Moves towards other magnetic projectiles,,,,,,,,,,,,,
]])

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_magnet_shot_repulse,Magnet Shot (repulse),,,,,,,,,,,,,
actiondesc_magnet_shot_repulse, Moves away from other magnetic projectiles,,,,,,,,,,,,,
]])