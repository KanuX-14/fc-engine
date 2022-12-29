-- Register stuff with empty definitions to test if FreeCraft fallback options
-- for these things work properly.

-- The itemstrings are deliberately kept descriptive to keep them easy to
-- recognize.

freecraft.register_node("broken:node_with_empty_definition", {})
freecraft.register_tool("broken:tool_with_empty_definition", {})
freecraft.register_craftitem("broken:craftitem_with_empty_definition", {})

freecraft.register_entity("broken:entity_with_empty_definition", {})
