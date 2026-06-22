return {
	{
		"RRethy/base16-nvim",
		priority = 2000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#21222c',
				base01 = '#21222c',
				base02 = '#9a95a1',
				base03 = '#9a95a1',
				base04 = '#f6efff',
				base05 = '#fbf8ff',
				base06 = '#fbf8ff',
				base07 = '#fbf8ff',
				base08 = '#ff9fb1',
				base09 = '#ff9fb1',
				base0A = '#caa6ff',
				base0B = '#a5ffb9',
				base0C = '#e3cfff',
				base0D = '#caa6ff',
				base0E = '#d3b5ff',
				base0F = '#d3b5ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9a95a1',
				fg = '#fbf8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#caa6ff',
				fg = '#21222c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9a95a1' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e3cfff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d3b5ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#caa6ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#caa6ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#e3cfff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb9',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#f6efff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#f6efff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9a95a1',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/appearance/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
