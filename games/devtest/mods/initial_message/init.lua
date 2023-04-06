freecraft.register_on_joinplayer(function(player)
	local cb = function(player)
		if not player or not player:is_player() then
			return
		end
		freecraft.chat_send_player(player:get_player_name(), "This is the \"Development Test\" [devtest], meant only for testing and development. Use freecraft Game for the real thing.")
	end
	freecraft.after(2.0, cb, player)
end)
