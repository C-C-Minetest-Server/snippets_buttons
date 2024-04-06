-- snippets_buttons/src/api.lua
-- cf. snippets/nodes.lua
-- Common functions of buttons
-- Copyright (C) 2019-2024  luk3x
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-onlyr AND MIT

local S = minetest.get_translator("snippets_buttons")
local FS = function(...) return minetest.formspec_escape(S(...)) end

snippets_buttons.on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("infotext", S("Unconfigured snippets button"))
    meta:set_string("formspec", "field[snippet;" .. FS("Snippet to run:") .. ";]")
end

snippets_buttons.on_receive_fields = function(pos, formname, fields, sender)
    if not fields.snippet or fields.snippet == "" then return end

    local name = sender:get_player_name()
    if not minetest.check_player_privs(name, { server = true }) then
        minetest.chat_send_player(name, S("Insufficient privileges!"))
        return
    end

    local snippet = fields.snippet
    if not snippets.registered_snippets[snippet] or
        snippet:sub(1, 9) == "snippets:" then
        minetest.chat_send_player(name, S("Unknown snippet!"))
    else
        local meta = minetest.get_meta(pos)
        meta:set_string("snippet", snippet)
        meta:set_string("infotext", S("Snippet: @1", fields.snippet))
        meta:set_string("formspec", "")
    end
end

snippets_buttons.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    local meta, name = minetest.get_meta(pos), clicker:get_player_name()
    local snippet = meta:get_string("snippet")
    if not snippet or snippet == "" then return itemstack, false end
    if snippets.registered_snippets[snippet] then
        snippets.run(snippet, name)
        return itemstack, true
    else
        minetest.chat_send_player(name, S("Invalid snippet: ", snippet))
        return itemstack, false
    end
end
