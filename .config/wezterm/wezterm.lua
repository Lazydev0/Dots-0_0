local wezterm = require("wezterm")

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

	colors = {
		foreground = "#B8C0E0",
		background = "#11111B",

		selection_fg = "#B8C0E0",
		selection_bg = "#2A2C3A",

		cursor_bg = "#B8C0E0",
		cursor_fg = "#11111B",
		cursor_border = "#B8C0E0",

		ansi = {
			"#2F3142",
			"#C96A84",
			"#7FBF8A",
			"#D0B47C",
			"#6F95D6",
			"#C89BCF",
			"#6FBFB4",
			"#8F96B3",
		},

		brights = {
			"#3C3F55",
			"#D1738C",
			"#86C894",
			"#D9BE86",
			"#7DA2E8",
			"#D3A3DA",
			"#78C9BE",
			"#A8B0CC",
		},
	},

	keys = {
		{ key = "]", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "[", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "LeftArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	},

	warn_about_missing_glyphs = false,
}
