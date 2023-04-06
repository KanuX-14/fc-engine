--
-- Mod channels experimental handlers
--
local mod_channel = freecraft.mod_channel_join("experimental_preview")

freecraft.register_on_modchannel_message(function(channel, sender, message)
	freecraft.log("action", "[modchannels] Server received message `" .. message
			.. "` on channel `" .. channel .. "` from sender `" .. sender .. "`")

	if mod_channel:is_writeable() then
		mod_channel:send_all("experimental answers to preview")
		mod_channel:leave()
	end
end)
