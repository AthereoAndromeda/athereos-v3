-- Lilac AMOLED Palette
-- "mPrimary": "#b58fff",
-- "mOnPrimary": "#000000",
-- "mSecondary": "#c79aff",
-- "mOnSecondary": "#000000",
-- "mTertiary": "#d8b4ff",
-- "mOnTertiary": "#000000",
-- "mError": "#ff6f9b",
-- "mOnError": "#000000",
-- "mSurface": "#000000",
-- "mOnSurface": "#e8d8ff",
-- "mSurfaceVariant": "#110d1a",
-- "mOnSurfaceVariant": "#b58fff",
-- "mOutline": "#4c3a70",
-- "mShadow": "#000000",
-- "mHover": "#d8b4ff",
-- "mOnHover": "#000000",

local primary   = "#b58fff"
local secondary = "#c79aff"
local tertiary  = "#d8b4ff"
local error     = "#ff6f9b"
local surface   = "#000000"
local outline   = "#4c3a80"
local hover     = "#d8b4ff"

require("easyjump"):setup()

require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}

require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	padding = { inner = 1, outer = 1 },

	style_a = {
		bg = outline,
		fg = tertiary,
		bg_mode = {
			normal = outline,
			select = "#086534",
			un_set = "#601134",
		},
	},
	-- style_b = { bg = "brightblack", fg = "brightwhite" },
	-- style_b = { bg = "black", fg = "brightwhite" },
	style_b = { bg = secondary, fg = surface },
	style_c = { bg = surface, fg = primary },

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "white",

	tab_width = 20,

	selected = { icon = "󰻭", fg = "yellow" },
	copied = { icon = "", fg = "green" },
	cut = { icon = "", fg = "red" },

	files = { icon = "", fg = "blue" },
	filtereds = { icon = "", fg = "magenta" },

	total = { icon = "󰮍", fg = "yellow" },
	success = { icon = "", fg = "green" },
	failed = { icon = "", fg = "red" },

	show_background = true,

	display_header_line = true,
	display_status_line = true,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = {
			section_a = {
				{ type = "line", name = "tabs" },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", name = "date", params = { "%a, %d %b %Y" } },
			},
			section_b = {
				{ type = "string", name = "date", params = { "%X" } },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "task_states" },
			},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", name = "tab_mode" },
			},
			section_b = {
				{ type = "string", name = "hovered_size" },
			},
			section_c = {
				{ type = "string",   name = "hovered_path" },
				{ type = "coloreds", name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", name = "cursor_position" },
			},
			section_b = {
				{ type = "string", name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string",   name = "hovered_file_extension", params = { true } },
				{ type = "string",   name = "hovered_ownership" },
				{ type = "coloreds", name = "permissions" },
			},
		},
	},
})
