-- Registering some dummy items and recipes for the crafting tests

freecraft.register_craftitem("unittests:torch", {
	description = "Crafting Test Item: Torch",
	inventory_image = "unittests_torch.png",

	groups = { dummy = 1 },
})
freecraft.register_craftitem("unittests:coal_lump", {
	description = "Crafting Test Item: Coal Lump",
	inventory_image = "unittests_coal_lump.png",

	groups = { dummy = 1 },
})
freecraft.register_craftitem("unittests:stick", {
	description = "Crafting Test Item: Stick",
	inventory_image = "unittests_stick.png",

	groups = { dummy = 1 },
})
freecraft.register_craftitem("unittests:iron_lump", {
	description = "Crafting Test Item: Iron Lump",
	inventory_image = "unittests_iron_lump.png",

	groups = { dummy = 1 },
})
freecraft.register_craftitem("unittests:steel_ingot", {
	description = "Crafting Test Item: Steel Ingot",
	inventory_image = "unittests_steel_ingot.png",

	groups = { dummy = 1 },
})

-- Use aliases in recipes for more complete testing

freecraft.register_alias("unittests:steel_ingot_alias", "unittests:steel_ingot")
freecraft.register_alias("unittests:coal_lump_alias", "unittests:coal_lump")
freecraft.register_alias("unittests:iron_lump_alias", "unittests:iron_lump")

-- Recipes for tests: Normal crafting, cooking and fuel

freecraft.register_craft({
	output = 'unittests:torch 4',
	recipe = {
		{'unittests:coal_lump_alias'},
		{'unittests:stick'},
	}
})

freecraft.register_craft({
	type = "cooking",
	output = "unittests:steel_ingot_alias",
	recipe = "unittests:iron_lump_alias",
})

freecraft.register_craft({
	type = "fuel",
	recipe = "unittests:coal_lump_alias",
	burntime = 40,
})

-- Test tool repair
freecraft.register_craft({
	type = "toolrepair",
	additional_wear = -0.05,
})

-- Test the disable_repair=1 group
freecraft.register_tool("unittests:unrepairable_tool", {
	description = "Crafting Test Item: Unrepairable Tool",
	inventory_image = "unittests_unrepairable_tool.png",
	tool_capabilities = {
		groupcaps = {
			cracky = {
				times = {3, 2, 1},
			}
		}
	},
	groups = { disable_repair = 1, dummy = 1 }
})

freecraft.register_tool("unittests:repairable_tool", {
	description = "Crafting Test Item: Repairable Tool",
	inventory_image = "unittests_repairable_tool.png",
	tool_capabilities = {
		groupcaps = {
			cracky = {
				times = {3, 2, 1},
			}
		}
	},

	groups = { dummy = 1 },
})
