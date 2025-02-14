-- Safeguard against too much optimization. This way the results cannot be optimized
-- away, but they can be garbage collected (due to __mode = "k").
_G._bench_content_ids_data = setmetatable({}, {__mode = "k"})

local function bench_name2content()
	local t = {}
	_G._bench_content_ids_data[t] = true

	local get_content_id = freecraft.get_content_id

	local start = freecraft.get_us_time()

	for i = 1, 200 do
		for name in pairs(freecraft.registered_nodes) do
			t[#t + 1] = get_content_id(name)
		end
	end

	local finish = freecraft.get_us_time()

	return (finish - start) / 1000
end

local function bench_content2name()
	local t = {}
	_G._bench_content_ids_data[t] = true

	-- Try to estimate the highest content ID that's used
	-- (not accurate but good enough for this test)
	local n = 0
	for _ in pairs(freecraft.registered_nodes) do
		n = n + 1
	end

	local get_name_from_content_id = freecraft.get_name_from_content_id

	local start = freecraft.get_us_time()

	for i = 1, 200 do
		for j = 0, n do
			t[#t + 1] = get_name_from_content_id(j)
		end
	end

	local finish = freecraft.get_us_time()

	return (finish - start) / 1000
end

freecraft.register_chatcommand("bench_name2content", {
	params = "",
	description = "Benchmark: Conversion from node names to content IDs",
	func = function(name, param)
		freecraft.chat_send_player(name, "Benchmarking freecraft.get_content_id. Warming up ...")
		bench_name2content()
		freecraft.chat_send_player(name, "Warming up finished, now benchmarking ...")
		local time = bench_name2content()
		return true, ("Time: %.2f ms"):format(time)
	end,
})

freecraft.register_chatcommand("bench_content2name", {
	params = "",
	description = "Benchmark: Conversion from content IDs to node names",
	func = function(name, param)
		freecraft.chat_send_player(name, "Benchmarking freecraft.get_name_from_content_id. Warming up ...")
		bench_content2name()
		freecraft.chat_send_player(name, "Warming up finished, now benchmarking ...")
		local time = bench_content2name()
		return true, ("Time: %.2f ms"):format(time)
	end,
})

freecraft.register_chatcommand("bench_bulk_set_node", {
	params = "",
	description = "Benchmark: Bulk-set 99×99×99 stone nodes",
	func = function(name, param)
		local player = freecraft.get_player_by_name(name)
		if not player then
			return false, "No player."
		end
		local pos_list = {}
		local ppos = player:get_pos()
		local i = 1
		for x=2,100 do
			for y=2,100 do
				for z=2,100 do
					pos_list[i] = {x=ppos.x + x,y = ppos.y + y,z = ppos.z + z}
					i = i + 1
				end
			end
		end

		freecraft.chat_send_player(name, "Benchmarking freecraft.bulk_set_node. Warming up ...");

		-- warm up with stone to prevent having different callbacks
		-- due to different node topology
		freecraft.bulk_set_node(pos_list, {name = "mapgen_stone"})

		freecraft.chat_send_player(name, "Warming up finished, now benchmarking ...");

		local start_time = freecraft.get_us_time()
		for i=1,#pos_list do
			freecraft.set_node(pos_list[i], {name = "mapgen_stone"})
		end
		local middle_time = freecraft.get_us_time()
		freecraft.bulk_set_node(pos_list, {name = "mapgen_stone"})
		local end_time = freecraft.get_us_time()
		local msg = string.format("Benchmark results: freecraft.set_node loop: %.2f ms; freecraft.bulk_set_node: %.2f ms",
			((middle_time - start_time)) / 1000,
			((end_time - middle_time)) / 1000
		)
		return true, msg
	end,
})


