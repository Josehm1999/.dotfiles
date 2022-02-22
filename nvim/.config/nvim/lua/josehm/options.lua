local options = {
          backup = false,
          clipboard = "unnamedplus",
          cmdheight = 2,
          completeopt = { "menu", "menuone", "noselect" },
          conceallevel = 0,
          fileencoding = "utf-8",
          hlsearch = false,
          mouse = "a",
          pumheight = 10,
          showmode = false,
          showtabline = 2,
          smartcase = true,
          smartindent = true,
          splitbelow = true,
          splitright = true,
          swapfile = false,
          termguicolors = true,
          timeoutlen = 1000,
          undofile = true,
          updatetime = 300,
          writebackup = true,
          cursorline = false,
          expandtab = true,
          shiftwidth = 2,
          tabstop = 2,
          number = true,
          relativenumber = true,
          numberwidth = 4,
          signcolumn = "yes",
          wrap = false,
          scrolloff = 8,
          sidescrolloff = 8,
}
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
