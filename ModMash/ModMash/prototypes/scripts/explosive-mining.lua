﻿if not util then require("prototypes.scripts.util") end

local init = function()	
	if global.modmash.grenade_targets == nil then global.modmash.grenade_targets = {} end	
	if not global.modmash.grenade then global.modmash.grenade = nil end	
	return nil end

local local_check_resource = function()
	if init ~= nil then init = init() end	
	for i, v in ipairs(global.modmash.grenade_targets) do
		if v.ticks > 400 then
			table.remove(global.modmash.grenade_targets, i)
		else
			v.ticks = v.ticks + 1
			local entities = v.target.surface.find_entities_filtered{area = {{v.target.position.x-0.5, v.target.position.y-0.5}, {v.target.position.x-1, v.target.position.y+1}}}
			for i, ent in pairs(entities) do
				if ent.name == "small-scorchmark" then
					if util.is_valid(v.target) then
						v.target.surface.spill_item_stack(ent.position, {name=v.target.name, count=50})
						local r = v.target.amount - math.min(50,v.target.amount);
						if r == 0 then
							v.target.destroy()
						else
							v.target.amount = r
						end
					end
					table.remove(global.modmash.grenade_targets, i)
				end
			end
		end
	end
end

local local_action_mining =function (event)
	if init ~= nil then init = init() end	
	player = game.players[event.player_index];
	if player ~= nil and player.cursor_stack.valid_for_read then
		if player.cursor_stack.name == "grenade" or player.cursor_stack.name == "cluster-grenade" then
			if grenade ~= nil and player.cursor_stack.count < grenade.count and player.selected ~= nil then
				if player.selected.type == "resource" then
					table.insert(global.modmash.grenade_targets,{target = player.selected,ticks = 0, grenage = {name = player.cursor_stack.name, count = player.cursor_stack.count}})
				end
			end
			grenade = {name = player.cursor_stack.name, count = player.cursor_stack.count}			
		end
	else
	
	if grenade~=nil and player.selected ~= nil then
			if player.selected.type == "resource" then
				table.insert(global.modmash.grenade_targets,{target = player.selected,ticks = 0, grenage = {name = grenade.name, count = grenade.count}})
			end
		end
		grenade = nil
	end
end

if modmash.ticks ~= nil then

	table.insert(modmash.on_player_cursor_stack_changed,local_action_mining)
	table.insert(modmash.ticks,local_check_resource)
end