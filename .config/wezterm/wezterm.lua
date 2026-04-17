local wezterm = require("wezterm")
local theme = require("colors.catppuccin")
local keymaps = require("keymaps")

return {

	font = wezterm.font({
		family = "Lilex Nerd Font",
		weight = "Medium",
	}),
	font_size = 11,
	line_height = 1,

	default_cursor_style = "SteadyBar",
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	enable_scroll_bar = false,
	window_padding = {
		left = 20,
		right = 20,
		top = 14,
		bottom = 14,
	},
	adjust_window_size_when_changing_font_size = false,
	enable_tab_bar = false,
	colors = theme,
	keys = keymaps,
	warn_about_missing_glyphs = false,
}
