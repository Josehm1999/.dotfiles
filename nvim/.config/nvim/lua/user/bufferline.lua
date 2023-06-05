local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end
local colors = require("user.config.colors").colors

bufferline.setup({
      options = {
        indicator = {
          icon = " ",
        },
        close_command = "Bdelete! %d",
        tab_size = 0,
        max_name_length = 25,
        separator_style = "thin",
        offsets = {
          {
            filetype = "neo-tree",
            text = "  Project",
            highlight = "Directory",
            text_align = "left",
          },
        },
        modified_icon = "",
        custom_areas = {
            left = function()
                if vim.bo.filetype == "alpha" then
                    return {}
                end

                return {
                    { text = "    ", fg = colors.fg },
                }
            end,
        },
      },
      highlights = {
        fill = {
          bg = "",
        },
        background = {
          bg = "",
        },
        tab = {
          bg = "",
        },
        tab_close = {
          bg = "",
        },
        tab_separator = {
          fg = colors.bg,
          bg = "",
        },
        tab_separator_selected = {
          fg = colors.bg,
          bg = "",
          sp = colors.fg,
        },
        close_button = {
          bg = "",
          fg = colors.fg,
        },
        close_button_visible = {
          bg = "",
          fg = colors.fg,
        },
        close_button_selected = {
          fg = { attribute = "fg", highlight = "StatusLineNonText" },
        },
        buffer_visible = {
          bg = "",
        },
        modified = {
          bg = "",
        },
        modified_visible = {
          bg = "",
        },
        duplicate = {
          fg = colors.fg,
          bg = ""
        },
        duplicate_visible = {
          fg = colors.fg,
          bg = ""
        },
        separator = {
          fg = colors.bg,
          bg = ""
        },
        separator_selected = {
          fg = colors.bg,
          bg = ""
        },
        separator_visible = {
          fg = colors.bg,
          bg = ""
        },
        offset_separator = {
          fg = colors.bg,
          bg = ""
        },
      },
    })
