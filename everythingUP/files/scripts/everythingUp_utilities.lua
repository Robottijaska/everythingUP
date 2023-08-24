dofile_once("data/scripts/lib/utilities.lua")

postfx = {
    append = function(code, insert_after_line, file)
        if(insert_after_line ~= nil)then
            if(type(code) ~= "string")then
                error("append argument has to be a string!")
            else
                local post_final = ModTextFileGetContent(file)
                if(post_final ~= nil)then
        
                    lines = {}
                    for s in post_final:gmatch("[^\r\n]+") do
                        table.insert(lines, s)
                    end
                
                    content = ""

                    for i, line in ipairs(lines) do

                        if(string.match(line, insert_after_line))then
                            line = line..string.char(10)..code
                        end
                        content = content..line..string.char(10)
                    end
                    ModTextFileSetContent(file, content)
                end
                
            end
        else
            error("no insert line given!")
        end
    end,
    replace = function(to_replace, replacement, file)
        if(to_replace ~= nil)then
            if(type(replacement) ~= "string")then
                error("replacement text has to be a string!")
            else
                local post_final = ModTextFileGetContent(file)
                if(post_final ~= nil)then
        
                    content = post_final:gsub(to_replace, replacement)

                    ModTextFileSetContent(file, content)
                end
                
            end
        else
            error("no replace line given!")
        end
    end,
}

function world_to_shader_pos(x, y)
  local _x, _y, width, height = GameGetCameraBounds()
  local cam_x, cam_y = GameGetCameraPos() -- top left?
  local screen_x = (x - cam_x + width / 2) / width
  local screen_y = (y - cam_y + height / 2) / height

  -- Invert sy to account for flipped Y axis
  screen_y = 1 - screen_y

  return screen_x, screen_y
end

local shaderEffects = {}

local function makeShaderEntry(param1, param2, param3, name, id)
    table.insert(shaderEffects, { param1 = param1, param2 = param2, param3 = param3, name = name, id = id })
end

function newShaderEffect(name, max_num)
	for i = 1, max_num do
		postfx.append(
		"uniform vec4 " .. name .. i .. ";",
			"//extra_define0",
			"data/shaders/post_final.frag"
		)
	end
	
	for i = 1, max_num do makeShaderEntry(0, 0, 0, name, 0) end
	for i = 1, max_num do 
		GameSetPostFxParameter( name .. i, 0.0, 0.0, 0.0, 0.0 ) 
		print("completed " .. name .. i)
	end
	
	for i = 1, max_num do
		local currentUniform = name .. i
		postfx.append(
		[[
		if (]].. currentUniform ..[[.w > 0.0) {
			]] .. name .. [[(]].. currentUniform ..[[.x, ]].. currentUniform ..[[.y, ]].. currentUniform ..[[.z); //THE FUNCTION THAT RETURNS AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		}
		]],
			"// various debug visualizations================================================================================",
			"data/shaders/post_final.frag"
		)
	end
end

local function findFreeShaderLocation(name)
	for index, value in pairs(shaderEffects) do
		if value.id > 0 and value.name == name then
			return index
		end
	end
	return 0
end

function spawnShader(x, y, param3, name, lifetime)
	local index = findFreeShaderLocation(name)
	if index > 0 then
		local id = EntityLoad("mods/everythingUP/files/entities/projectiles/shaderProjectile.xml", x, y)
		
		local shader_x, shader_y = world_to_shader_pos(x, y)
		shaderEffects[index] = {shader_x, shader_y, param3, id}
		return id
	end
	return 0
end

function deleteShader(id)
	for index, value in pairs(shaderEffects) do
		if value.id == id then
			shaderEffects[index].id = 0
		end
	end
	print("Could not find the shader to delete")
end
























