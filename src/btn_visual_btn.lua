-- snippets_buttons/src/btn_visual_btn.lua
-- cf. mesecons/mesecons_button/init.lua
-- An actual button
-- Copyright (C) 2011-2016  Mesecons Mod Developer Team and contributors
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-only

local S = minetest.get_translator("snippets_buttons")
local use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "opaque" or nil

minetest.register_node("snippets_buttons:visual_btn_off", {
    description = S("Snippet button: @1", S("Visual Button")),
    drawtype = "nodebox",
    tiles = {
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn.png"
    },
    use_texture_alpha = use_texture_alpha,
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = false,
    legacy_wallmounted = true,
    walkable = false,
    sunlight_propagates = true,
    selection_box = {
        type = "fixed",
        fixed = { -6 / 16, -6 / 16, 5 / 16, 6 / 16, 6 / 16, 8 / 16 }
    },
    node_box = {
        type = "fixed",
        fixed = {
            { -6 / 16, -6 / 16, 6 / 16, 6 / 16, 6 / 16, 8 / 16 }, -- the thin plate behind the button
            { -4 / 16, -2 / 16, 4 / 16, 4 / 16, 2 / 16, 6 / 16 }  -- the button itself
        }
    },
    groups = { dig_immediate = 2, not_in_creative_inventory = 1, },
    drop = "",

    on_construct = snippets_buttons.on_construct,
    on_receive_fields = snippets_buttons.on_receive_fields,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local _, status = snippets_buttons.on_rightclick(pos, node, clicker, itemstack, pointed_thing)

        if status then
            node.name = "snippets_buttons:visual_btn_on"
            minetest.swap_node(pos, node)
            minetest.get_node_timer(pos):start(1)
        end

        return itemstack, status
    end,
})

minetest.register_node("snippets_buttons:visual_btn_on", {
    drawtype = "nodebox",
    tiles = {
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn_sides.png",
        "sinppets_buttons_visual_btn.png"
    },
    use_texture_alpha = use_texture_alpha,
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = false,
    legacy_wallmounted = true,
    walkable = false,
    sunlight_propagates = true,
    selection_box = {
        type = "fixed",
        fixed = { -6 / 16, -6 / 16, 5 / 16, 6 / 16, 6 / 16, 8 / 16 }
    },
    node_box = {
        type = "fixed",
        fixed = {
            { -6 / 16, -6 / 16, 6 / 16,  6 / 16, 6 / 16, 8 / 16 },
            { -4 / 16, -2 / 16, 11 / 32, 4 / 16, 2 / 16, 6 / 16 }
        }
    },
    groups = { dig_immediate = 2, not_in_creative_inventory = 1, },
    drop = "",

    on_timer = function(pos)
        local node = minetest.get_node(pos)
        if node.name ~= "snippets_buttons:visual_btn_on" then
            return
        end

        node.name = "snippets_buttons:visual_btn_off"
        minetest.swap_node(pos, node)
    end,
})
