local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
    return
end

local tailwind_status_ok, tailwind = pcall(require, "tailwindcss-colorizer-cmp")
if not tailwind_status_ok then
    return
end

local icons = require("user.icons")

-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local compare = require("cmp.config.compare")

require("luasnip/loaders/from_vscode").lazy_load()

-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    formatting = {
        -- format = lspkind.cmp_format({
        --     with_text = true,
        --     menu = {
        --         buffer = "[buf]",
        --         nvim_lsp = "[LSP]",
        --         nvim_lua = "[api]",
        --         path = "[path]",
        --         luasnip = "[snip]",
        --         ["vim-dadbod-completion"] = "[DB]",
        --     },
        --     before = tailwind.formatter,
        -- }),
        format = function(entry, vim_item)
            local max_width = 0
            if max_width ~= 0 and #vim_item.abbr > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

            if entry.source.name == "copilot" then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            if entry.source.name == "crates" then
                vim_item.kind = icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end
            vim_item.menu = ({
                nvim_lsp = "(LSP)",
                emoji = "(Emoji)",
                path = "(Path)",
                calc = "(Calc)",
                vsnip = "(Snippet)",
                luasnip = "(Snippet)",
                buffer = "(Buffer)",
                tmux = "(TMUX)",
                copilot = "(Copilot)",
                treesitter = "(TreeSitter)",
            })[entry.source.name]
            vim_item.dup = ({
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            })[entry.source.name] or 0
            vim_item.before = tailwind.formatter
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "tmux" },
        { name = "calc" },
        { name = "nvim_lsp_signature_help" },
        {
            name = "buffer",
            keyword_length = 4,
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local bufnr = vim.api.nvim_win_get_buf(win)
                        if vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "terminal" then
                            bufs[bufnr] = true
                        end
                    end
                    return vim.tbl_keys(bufs)
                end,
            },
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    sorting = {
        priority_weight = 2,
        -- comparatos = {
        -- 	compare.kind,
        -- 	compare.sort_text,
        -- },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
})

cmp.setup.filetype({ "sql", "mysql", "plsql", "postgres" }, {
    sources = cmp.config.sources({
        { name = "vim-dadbod-completion" },
    }, {
        { name = "buffer" },
    }),
})
