﻿--[[Code check 29.2.20
removed old comments
--]]
if not modmash or not modmash.util then require("prototypes.scripts.util") end

local get_name_for = modmash.util.get_name_for


local create_regenerative_technology = function(level,count)
	return  
	{
		{
			type = "technology",
			name = "enhance-regenerative-speed-"..level,
			icon = "__base__/graphics/technology/demo/analyse-ship.png",
			icon_size = 128,
			localised_name = {"",{"technology-name.enhance-regenerative-speed-1"}," ",level},
			localised_description =  {"technology-description.enhance-regenerative-speed-1"},
			effects =
			{
			},
			prerequisites =
			{
				"enhance-regenerative-speed-"..(level-1)
			},
			unit =
			{
				count = count,
				ingredients =
				{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},	
				{"military-science-pack",1}
				},
				time = 45
			},
			upgrade = true,
			order = "a-b-d",
		}
	}
end

data:extend(
{
{
			type = "technology",
			name = "enhance-regenerative-speed-1",
			icon = "__base__/graphics/technology/demo/analyse-ship.png",
			icon_size = 128,
			localised_name = {"technology-name.enhance-regenerative-speed-1"},
			localised_description =  {"technology-description.enhance-regenerative-speed-1"},
			effects =
			{
			},
			prerequisites =
			{
				"logistics-5"
			},
			unit =
			{
				count = 200,
				ingredients =
				{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},	
				{"military-science-pack",1}
				},
				time = 45
			},
			upgrade = true,
			order = "a-b-d",
		}
})
local count = 250

for k=2, 6 do
	data:extend(create_regenerative_technology(k,count))
	count = count + 50
end