local ok, snacks = pcall(require, "snacks")
if ok then
	snacks.setup({
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = true },
		picker = {
			enabled = true,
			actions = {
				opencode_send = function(...)
					return require("opencode").snacks_picker_send(...)
				end,
			},
			win = {
				input = {
					keys = {
						["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
					},
				},
			},
		},
		input = {},
	})
end
