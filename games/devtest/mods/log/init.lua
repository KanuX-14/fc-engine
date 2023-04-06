local modname = freecraft.get_current_modname()
local prefix = "["..modname.."] "

-- Startup info
freecraft.log("action", prefix.."modname="..dump(modname))
freecraft.log("action", prefix.."modpath="..dump(freecraft.get_modpath(modname)))
freecraft.log("action", prefix.."worldpath="..dump(freecraft.get_worldpath()))

-- Callback info
freecraft.register_on_mods_loaded(function()
	freecraft.log("action", prefix.."Callback: on_mods_loaded()")
end)

freecraft.register_on_chatcommand(function(name, command, params)
	freecraft.log("action", prefix.."Caught command '"..command.."', issued by '"..name.."'. Parameters: '"..params.."'")
end)
