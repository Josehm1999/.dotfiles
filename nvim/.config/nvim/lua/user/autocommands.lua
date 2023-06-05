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

-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = true})")

vim.cmd("autocmd BufWritePost *.sol silent !npx prettier --write $PWD")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

local s_clip = '/mnt/c/Windows/System32/clip.exe'  -- change this path according to your mount point
if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {

		group = vim.api.nvim_create_augroup("Yank", { clear = true }),

		callback = function()
			vim.fn.system(s_clip, vim.fn.getreg('"'))
		end,
	})
end

-- local s_clip = '/mnt/c/Windows/System32/clip.exe'  -- change this path according to your mount point
-- if vim.fn.executable(s_clip) then
--     vim.api.nvim_create_autocmd
--     --     augroup WSLYank
--     --     autocmd!
--     --     autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--     -- augroup END
-- end
