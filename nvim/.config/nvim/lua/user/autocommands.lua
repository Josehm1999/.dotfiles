-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Format on save
vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")

-- Manually format solidity files
vim.cmd("autocmd BufWritePost *.sol silent !yarn prettier --write '**/*.sol'")

-- Change syntax for .cshtml to html
vim.cmd("autocmd BufNewFile,BufRead *.cshtml set ft=html")

vim.cmd("autocmd ColorScheme * hi Normal ctermbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi NormalNC ctermbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi NonText ctermbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi NvimTreeNormal cterbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi SignColumn  guibg=none")
vim.cmd("autocmd ColorScheme * hi TabLineFill ctermbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi TabLine ctermbg=none guibg=none")
vim.cmd("autocmd ColorScheme * hi TabLineSel ctermbg=none guibg=none")
-- vim.cmd("autocmd ColorScheme * hi Title ctermbg=none guibg=none")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- vim.api.nvim_create_autocmd({"FixRazorFiles"}, {
--   callback =function()
--       vim.cmd[[
--           autocmd BufNewFile,BufRead *.cshtml set ft=html
--       ]]
--   end,
-- })
