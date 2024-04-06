-- snippets_buttons/src/btn_sprite.lua
-- Ladder-like texture display
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-only

local S = minetest.get_translator("snippets_buttons")
local use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true

local variants = {
    info = S("Information sign (round)"),
    info_sq = S("Information sign (square)"),

    question = S("Question mark (round)"),
    question_sq = S("Question mark (square)"),

    warning = S("Warning sign (round)"),
    warning_sq = S("Warning sign (square)"),
}

for name, desc in pairs(variants) do
    minetest.register_node("snippets_buttons:sprite_" .. name, {
        description = S("Snippet button: @1", desc),
        drawtype = "signlike",
        tiles = { "snippets_buttons_sprite_" .. name .. ".png" },
        inventory_image = "snippets_buttons_sprite_" .. name .. ".png",
        wield_image = "snippets_buttons_sprite_" .. name .. ".png",
        use_texture_alpha = use_texture_alpha,
        paramtype = "light",
        paramtype2 = "wallmounted",
        is_ground_content = false,
        legacy_wallmounted = true,
        walkable = false,
        sunlight_propagates = true,
        selection_box = {
            type = "wallmounted",
        },
        groups = { dig_immediate = 2, not_in_creative_inventory = 1, },
        drop = "",

        on_construct = snippets_buttons.on_construct,
        on_receive_fields = snippets_buttons.on_receive_fields,
        on_rightclick = snippets_buttons.on_rightclick,
    })
end
