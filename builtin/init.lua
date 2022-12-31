--
-- This file contains built-in stuff in FreeCraft implemented in Lua.
--
-- It is always loaded and executed after registration of the C API,
-- before loading and running any mods.
--

-- Initialize some very basic things
do
	local function concat_args(...)
		local n, t = select("#", ...), {...}
		for i = 1, n do
			t[i] = tostring(t[i])
		end
		return table.concat(t, "\t")
	end
	function core.debug(...) core.log(concat_args(...)) end
	if core.print then
		local core_print = core.print
		-- Override native print and use
		-- terminal if that's turned on
		function print(...) core_print(concat_args(...)) end
		core.print = nil -- don't pollute our namespace
	end
end
math.randomseed(os.time())

-- Load other files
local scriptdir = core.get_builtin_path()
local gamepath = scriptdir .. "game" .. DIR_DELIM
local clientpath = scriptdir .. "client" .. DIR_DELIM
local commonpath = scriptdir .. "common" .. DIR_DELIM
local asyncpath = scriptdir .. "async" .. DIR_DELIM

-- Check if user directory is already set
local mt_compatibility = core.settings:get_bool("mt_compatibility")
if mt_compatibility then
	minetest = core
	core.settings:set("modding_api", "minetest")
else
	local userdir = core.settings:get("user_directory")
	if (userdir == "") then core.settings:set("user_directory", core.get_user_path() .. DIR_DELIM) end

	-- -- Get configuration file and apply based on the engine
	local game_name = core.settings:get("menu_last_game")
	local conf_path = userdir .. "games" .. DIR_DELIM .. game_name .. DIR_DELIM .. "freecraft.conf"

	if (core.check_file(conf_path)) then
		freecraft = core
		core.settings:set("modding_api", "freecraft")
	else
		minetest = core
		core.settings:set("modding_api", "minetest")
	end
end

dofile(commonpath .. "vector.lua")
dofile(commonpath .. "strict.lua")
dofile(commonpath .. "serialize.lua")
dofile(commonpath .. "misc_helpers.lua")

if INIT == "game" then
	dofile(gamepath .. "init.lua")
	assert(not core.get_http_api)
elseif INIT == "mainmenu" then
	local mm_script = core.settings:get("main_menu_script")
	local custom_loaded = false
	if mm_script and mm_script ~= "" then
		local testfile = io.open(mm_script, "r")
		if testfile then
			testfile:close()
			dofile(mm_script)
			custom_loaded = true
			core.log("info", "Loaded custom main menu script: "..mm_script)
		else
			core.log("error", "Failed to load custom main menu script: "..mm_script)
			core.log("info", "Falling back to default main menu script")
		end
	end
	if not custom_loaded then
		dofile(core.get_mainmenu_path() .. DIR_DELIM .. "init.lua")
	end
elseif INIT == "async"  then
	dofile(asyncpath .. "mainmenu.lua")
elseif INIT == "async_game" then
	dofile(asyncpath .. "game.lua")
elseif INIT == "client" then
	dofile(clientpath .. "init.lua")
else
	error(("Unrecognized builtin initialization type %s!"):format(tostring(INIT)))
end
