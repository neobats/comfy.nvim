local M = {}

function M.setup()
  local catppuccino = require("catppuccino")

  catppuccino.before_loading = function()
  end

  -- configure it
  catppuccino.setup({
    colorscheme = "neon_latte",
    transparency = false,
    term_colors = false,
    styles = {
      comments = "italic",
      functions = "italic",
      keywords = "italic",
      strings = "NONE",
      variables = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        }
      },
      lsp_trouble = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = false,
      neogit = true,
      vim_sneak = false,
      fern = false,
      barbar = true,
      bufferline = false,
      markdown = false,
      lightspeed = true,
      ts_rainbow = true,
      hop = false,
    }
  }
  )

  vim.cmd[[colorscheme catppuccino]]
end

return M
