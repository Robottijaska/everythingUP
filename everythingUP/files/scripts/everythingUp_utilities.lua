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

function getShaderEffects()
    local input = ModSettingGet("everythingUP_shaderEffects")
    --print("getShaderEffects input: " .. input )
    local result = {}

    --hell
    for number, string, number2 in input:gmatch("{(%d+),%s*([%w_]+),%s*(%d+)}") do
        table.insert(result, {id = tonumber(number), name = string, projID = tonumber(number2)})
    end

    for _, entry in ipairs(result) do
        local number = entry.id
        local string = entry.name
        --print("getShaderEffects output: Number: " .. number .. ", String: " .. string)
    end

    return result
end

function setShaderEffects(input)
    local result = {}

    for _, entry in ipairs(input) do
        local number = entry.id
        local string = entry.name
        local projID = entry.projID
        --print ("setShaderEffects InputValues: " .. number .. ", " .. string)
        table.insert(result, "{" .. number .. "," .. string .. "," .. projID .. "}")
    end

    ModSettingSet("everythingUP_shaderEffects", table.concat(result, ","))
    --print ("setShaderEffects: " .. ModSettingGet("everythingUP_shaderEffects"))
end

function insertShaderEffect(id, name, projID)
    local shaders = getShaderEffects()

    print("inserting {" .. id .. ", " .. name .. ", " .. projID .. "}")
    table.insert(shaders, 1, {id = id, name = name, projID = projID})

    for _, value in ipairs(shaders) do
        id1 = value.id
        name1 = value.name
        --print ("insertShaderEffect OutputValue: " .. id1 .. ", " .. name1)
    end

    setShaderEffects(shaders)
end

function freeShaderEffect(index)
    local shaders = getShaderEffects()
    shaders[index].id = 0

    setShaderEffects(shaders)
end

function loadShaderEffect(index, id, projID)
    local shaders = getShaderEffects()
    shaders[index].id = id
    shaders[index].projID = projID

    setShaderEffects(shaders)
end

function world_to_shader_pos(x, y)
  local _x, _y, width, height = GameGetCameraBounds()
  local cam_x, cam_y = GameGetCameraPos() -- top left?
  local screen_x = (x - cam_x + width / 2) / width
  local screen_y = (y - cam_y + height / 2) / height

  -- Invert sy to account for flipped Y axis
  screen_y = 1 - screen_y

  return screen_x, screen_y
end

local function makeShaderEntry(id, name, projID)
    local shaderEffects = getShaderEffects()

    insertShaderEffect(id, name, projID)

    --print("!!!!!!!!!!newlength: " .. #shaderEffects + 1)
end

function getBaseName(name)
    return name:gsub("%d+$", "")
end

function newShaderEffect(name, max_num, shadersetting)

	for i = 1, max_num do
		postfx.append(
		"uniform vec4 " .. name .. i .. ";",
			"//extra_define0",
			"data/shaders/post_final.frag"
		)
	end
	
	for i = 1, max_num do makeShaderEntry(0, name .. i, 0) end
	for i = 1, max_num do
		GameSetPostFxParameter(name .. i, 0.0, 0.0, 0.0, 0.0 )
		--print("completed " .. name .. i)
	end
	
	for i = 1, max_num do
		local currentUniform = name .. i

		if shadersetting == "w" then
            postfx.append(
		    [[
		        if (]].. currentUniform ..[[.w > 0.0) {
		    	    tex_coord.xy = ]] .. name .. [[(]].. currentUniform ..[[.x, ]].. currentUniform ..[[.y, ]].. currentUniform ..[[.z, tex_coord.xy);
	    	    }
		    ]],
			    "// sample the original color =================================================================================",
			    "data/shaders/post_final.frag"
            )
        else
            postfx.append(
		    [[
		        if (]].. currentUniform ..[[.w > 0.0) {
		    	    color += ]] .. name .. [[(]].. currentUniform ..[[.x, ]].. currentUniform ..[[.y, ]].. currentUniform ..[[.z, tex_coord.xy);
	    	    }
		    ]],
			    "// various debug visualizations================================================================================",
			    "data/shaders/post_final.frag"
		    )
        end
	end
end

local function findFreeShaderLocation(baseName)
    local shaderEffects = getShaderEffects()

	for index, value in ipairs(shaderEffects) do
		if value.id == 0 and getBaseName(value.name) == baseName then
			return index
		end
	end
    print("no free shader effect named " .. baseName)
	return 0
end

function findNameOfShaderLocation(index, baseName)
    local shaderEffects = getShaderEffects()

    local recCount = 1;
	for i, value in pairs(shaderEffects) do
		if getBaseName(value.name) == baseName then
            if i == index then return baseName .. recCount end
            recCount = recCount + 1
		end
	end
end

function findShader(name)
    local shaderEffects = getShaderEffects()

	for index, value in ipairs(shaderEffects) do
		if value.name == name then
			return index
		end
	end
	return 0
end

function hasShaderWithIDandBaseName(id, baseName)
    local shaderEffects = getShaderEffects()

	for index, value in ipairs(shaderEffects) do
		if value.id == id and getBaseName(value.name) == baseName then
			return true
		end
	end
	return false
end

function getShaderWithIDandBaseName(id, baseName)
    local shaderEffects = getShaderEffects()

	for index, value in ipairs(shaderEffects) do
		if value.id == id and getBaseName(value.name) == baseName then
			return value
		end
	end
	return nil
end

function spawnShader(lifetime, paramNum, baseName, x, y, id, isStackable, isBound)

    if isStackable == false then
        if hasShaderWithIDandBaseName(id, baseName) then return id end
    end

	local index = findFreeShaderLocation(baseName)
	if index > 0 then
		local entity_id = EntityLoad("mods/everythingUP/files/entities/projectiles/shaderProjectile.xml", x, y)

        --60 frames = one second
        local comp;

		comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_id")
        comp = ComponentSetValue2( comp, "value_int", id)

        comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_paramNum")
        comp = ComponentSetValue2( comp, "value_float", paramNum)

        comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_name")
        comp = ComponentSetValue2( comp, "value_string", findNameOfShaderLocation(index, baseName))

        comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
        comp = ComponentSetValue2( comp, "lifetime", lifetime)

        if isBound == true then
            comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "shaderProjectile_isBound")
            comp = ComponentSetValue2( comp, "value_bool", true)
        end

		local shader_x, shader_y = world_to_shader_pos(x, y)

        GameSetPostFxParameter( findNameOfShaderLocation(index, baseName), shader_x, shader_y, paramNum, id )

        loadShaderEffect(index, id, entity_id)
        print("new shader loaded with id " .. entity_id)
		return entity_id
	end
    --GamePrint("ERROR: " .. baseName)
	return 0
end

function deleteShader(name)
    local shaderEffects = getShaderEffects()

	for _, value in ipairs(shaderEffects) do
		if value.name == name then
            GameSetPostFxParameter( value.name, 0.0, 0.0, 0.0, 0.0 )
            value.id = 0;
            setShaderEffects(shaderEffects)
            return
		end
	end
    --GamePrint("could not find shader named "..name)
end
























