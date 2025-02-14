
local S = freecraft.get_translator("testtools")

local function get_func(is_place)
	return function(itemstack, user, pointed_thing)
		local pos
		if is_place then
			pos = pointed_thing.under
		else
			pos = pointed_thing.above
		end
		if pointed_thing.type ~= "node" or not pos then
			return
		end

		local node = freecraft.get_node(pos)
		local pstr = freecraft.pos_to_string(pos)
		local time = freecraft.get_timeofday()
		local sunlight = freecraft.get_natural_light(pos)
		local artificial = freecraft.get_artificial_light(node.param1)
		local message = ("pos=%s | param1=0x%02x | " ..
				"sunlight=%d | artificial=%d | timeofday=%.5f" )
				:format(pstr, node.param1, sunlight, artificial, time)
		freecraft.chat_send_player(user:get_player_name(), message)
	end
end

freecraft.register_tool("testtools:lighttool", {
	description = S("Light Tool") .. "\n" ..
		S("Show light values of node") .. "\n" ..
		S("Punch: Light of node above touched node") .. "\n" ..
		S("Place: Light of touched node itself"),
	inventory_image = "testtools_lighttool.png",
	groups = { testtool = 1, disable_repair = 1 },
	on_use = get_func(false),
	on_place = get_func(true),
})
