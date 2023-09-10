dofile_once("mods/everythingUP/files/scripts/everythingUp_utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")
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
end

]]--
function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
end
--[[

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )
end

-- This code runs when all mods' filesystems are registered

--globals

ModSettingSet("everythingUP_shaderEffects", "")

newShaderEffect("everythingUP_ShockWave_WARP", 15, "w");
newShaderEffect("everythingUP_ShockWave_COLOR", 15, "c");

newShaderEffect("everythingUP_Magnet", 20, "w");

--appends

function AppendAll()

	----SCRIPT----
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/everythingUP/files/actions.lua" )

	dofile_once("mods/everythingUP/files/scripts/materials/init_materials.lua")

	dofile_once("mods/everythingUP/files/scripts/gun/starting_wand.lua")

	dofile_once("mods/everythingUP/files/scripts/biomes/append_biomes.lua")

	dofile_once("mods/everythingUP/files/scripts/entity_appends.lua")

	ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/everythingUP/files/scripts/effects/effects.lua" )
	dofile_once("mods/everythingUP/files/scripts/effects/effects_translations.lua")

	--constants
	postfx.append(
	[[
	]],
		"//extra_define0",
		"data/shaders/post_final.frag"
	)
	--shader !!!!WARP!!!! functions
	postfx.append(
		[[
		vec2 everythingUP_ShockWave_WARP(float x, float y, float radius, vec2 uv){
			// Normalized pixel coordinates (from 0 to 1)

			vec2 position = vec2(x, y);
			vec2 uvTemp = uv;

			uvTemp.x *= window_size.x/window_size.y;
			position.x *= window_size.x/window_size.y;
			float dist = length(abs(uvTemp - position));
			float uppercircbound = radius;
			float lowercircbound = radius*2.0/1.5;
				
			return uv + (normalize(uvTemp - position) * -1.0 * smoothstep(radius, 0.0, dist) * (smoothstep(lowercircbound-0.2, lowercircbound, dist) - smoothstep(uppercircbound, uppercircbound, dist)));
		}

		vec2 everythingUP_Magnet(float x, float y, float radius, vec2 uv){
			// Normalized pixel coordinates (from 0 to 1)
			
			vec2 position = vec2(x, y);
			vec2 tempUV = uv;
			tempUV.x *= window_size.x/window_size.y;
			position.x *= window_size.x/window_size.y;
			float dist = length(abs(tempUV - position));

			float uppercircbound = radius;
			float lowercircbound = uppercircbound/1.2;
			
			return uv + normalize(tempUV - position) * ( 0.1 * smoothstep(radius*0.4, radius, dist) * smoothstep(radius, radius*0.4, dist));
		}
		]],
			"// utilities",
			"data/shaders/post_final.frag"
	)
	--shader !!!!COLOR!!!! functions
	postfx.append(
	[[
	vec3 everythingUP_ShockWave_COLOR(float x, float y, float radius, vec2 uv){
		// Normalized pixel coordinates (from 0 to 1)
		
		vec2 position = vec2(x, y);
		uv.x *= window_size.x/window_size.y;
		position.x *= window_size.x/window_size.y;
		float dist = length(abs(uv - position));
		float uppercircbound = radius;
		float lowercircbound = radius*2.0/1.5;
		
		float medcircbound = (uppercircbound+lowercircbound)/2.0;
		
		return 0.25 * vec3(smoothstep(radius, 0.0, dist) * (smoothstep(lowercircbound-0.5, lowercircbound, dist) - smoothstep(uppercircbound, uppercircbound, dist)));
	}
	]],
		"// utilities",
		"data/shaders/post_final.frag"
	)

	dofile_once("mods/everythingUP/files/scripts/entity_appends.lua")
	
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

ModTextFileSetContent("data/translations/common.csv", ModTextFileGetContent("data/translations/common.csv") .. [[
action_reverbation,Reverberation,,,,,,,,,,,,,
actiondesc_reverbation, converts 40% of explosive energy to a huge shockwave,,,,,,,,,,,,,
]])