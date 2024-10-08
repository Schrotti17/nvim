return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- import lualine plugin safely
        local status, lualine = pcall(require, "lualine")
        if not status then
            return
        end

        -- get lualine nightfly theme
        local lualine_nightfly = require("lualine.themes.nightfly")

        -- new colors for theme
        local new_colors = {
            blue = "#65D1FF",
            green = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            black = "#000000",
        }

        -- change nightlfy theme colors
        lualine_nightfly.normal.a.bg = new_colors.blue
        lualine_nightfly.insert.a.bg = new_colors.green
        lualine_nightfly.visual.a.bg = new_colors.violet
        lualine_nightfly.command = {
            a = {
                bg = new_colors.yellow,
                fg = new_colors.black, -- black
            },
        }
        lualine.setup {
            options = {
                theme = "auto",
                icons_enabled = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'buffers' },
                lualine_x = { 'tabs' },
                lualine_y = { 'progress' },
                lualine_z = {
                    { 'diagnostics',
                        sources = { 'nvim_diagnostic', 'nvim_lsp' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = 'DiagnosticError', -- Changes diagnostics' error color.
                            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                        },
                        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                        colored = true,           -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false,   -- Show diagnostics even if there are none.
                    }
                }
            }
        }
    end
}
