return {
	"mfussenegger/nvim-jdtls",
	opts = {
		jdtls = function(opts)
			opts.settings = {
				java = {
					format = {
						enabled = true,
						settings = {
							url = vim.fn.expand("~/.config/nvim/format/curly-nextline.xml"),
							profile = "CurlyNextline",
						},
					},
					inlayHints = {
						parameterNames = {
							enabled = "none",
						},
					},
				},
			}

			return opts
		end,
	},
}
