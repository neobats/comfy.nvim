local present, packer = pcall(require, "comfy.plugins.packer_init")
local pd = "comfy/plugins/"

if not present then
  return false
end

pcall(require, "impatient")

return packer.startup(function(use)
  -- ---- --
  -- Core --
  -- ---- --

  -- The Bear Essentials
  use { "lewis6991/impatient.nvim", rocks = "mpack" } -- I can haz speed?
  use "nathom/filetype.nvim" -- Faster FT
  use { "wbthomason/packer.nvim", event = "VimEnter" } -- Le Package Manager
  use { "nvim-lua/plenary.nvim", event = "BufRead", } -- Boilerplater
  use { "nvim-lua/popup.nvim", after = {"plenary.nvim"}, } -- Pop!

  -- -------------- --
  -- User Interface --
  -- -------------- --

  -- Aesthetic
  use {
    "mcchrish/zenbones.nvim", -- Like a colorscheme, but without colors...
    requires = {
      {
        "rktjmp/lush.nvim", opt = true,
        cmd = {"Lushify", "LushImport", "LushRunTutorial", "LushRnQuickstart"}
      }
    },
    config = "vim.cmd('colorscheme zenwritten')"
  }

  use {
    "nvim-lualine/lualine.nvim", -- Statusline, but in Lua
    requires = {"kyazdani42/nvim-web-devicons"},
    after = {"zenbones.nvim"},
    config = "require'lualine-config'"
  }

  use {
    "kyazdani42/nvim-web-devicons", -- Icons, but not the Catholic sort
    opt = true,
  }

  use{
    "lukas-reineke/indent-blankline.nvim", -- Make indents visible
    after = {"zenbones.nvim"},
    config = "require'indent-blankline-config'"
  }

  -- Editor Features
  use {
    "numToStr/Comment.nvim", -- Comment stuff out
    config = "require('Comment').setup()",
  }

  use {
    "folke/todo-comments.nvim", -- Highlight & Search for TODO keywords in src files
    config = "require('todo-comments').setup{}",
  }

  use {
    "norcalli/nvim-colorizer.lua", -- Highlight colorcodes with the color the reference
    event = "BufRead",
    config = "require('colorizer').setup()",
  }

  use {
    "jghauser/mkdir.nvim", -- mkdir on save if dir doesn"t exist
    config = "require('mkdir')",
  }

  use {
    "blackCauldron7/surround.nvim", -- like tpope"s surround, but Luafied
    config = "require('surround').setup({ mapping_style = 'surround' })",
    event = "InsertEnter",
  }

  use {
    "ggandor/lightspeed.nvim", -- vim-sneak w/ a jetpack
    config = "require('lightspeed')",
  }

  use {
    "nacro90/numb.nvim", -- peek at lines with :123
    config = "require('numb').setup()",
  }

  use { "sbulav/nredir.nvim" } -- redirect command output to buffer

  -- Buffers and Windows and Tabs, Oh My!
  use {
    "akinsho/bufferline.nvim", 
    after = "nvim-web-devicons",
  }

  use { "famiu/bufdelete.nvim" }
  use { "ojroques/nvim-bufdel" }
  use { "beauwilliams/focus.nvim" }

  -- -------- --
  -- Wizardry --
  -- -------- --

  -- Treesitter and Friends
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    -- config = "require'treesitter-config'",
    requires = {
      -- TODO setup textobjects
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter", opt = true },
       -- Treesitter go-to definitions and such
      { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter", opt = true },
      -- Sets comment strings based on what treesitter says the lang at the cursor is
      { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter", opt = true },
      -- Keeps context of current pos at top of file
      { "romgrk/nvim-treesitter-context", after = "nvim-treesitter", opt = true },
    },
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig", -- Language Server Protocol stuff
    config = "require'lsp-config'",
    requires = {
      -- Language Server Protocol installer
      { "williamboman/nvim-lsp-installer", opt = false },
      -- Better quickfix and diagnostic window
      { "folke/trouble.nvim", opt = false },
      -- LSP powered function signatures
      { "ray-x/lsp_signature.nvim",  opt = false },
    },
  }

  use {
    "ray-x/navigator.lua", -- We use this to manage LSP setup
    requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
  } -- branch = "nvim-lsp-installer" ?

  -- Completion
  use {
    "hrsh7th/nvim-cmp", -- Peak laziness.
    opt = true,
    event = "InsertEnter", -- InsertCharPre
    after = {"LuaSnip"}, -- "nvim-snippy",
    requires = {
      {"hrsh7th/cmp-buffer", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-nvim-lua", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-calc", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-path", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-emoji", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-cmdline", after = {"nvim-cmp"}, opt = true},
      {"hrsh7th/cmp-nvim-lsp", after = {"nvim-cmp"}, opt = true},
      {"f3fora/cmp-spell", after = {"nvim-cmp"}, opt = true},
      {"octaltree/cmp-look", after = {"nvim-cmp"}, opt = true},
      {"saadparwaiz1/cmp_luasnip", after = {"nvim-cmp", "LuaSnip"}},
      {"windwp/nvim-autopairs", event = "InsertEnter", opt = true},
    },
    config = "require'cmp-config'"
}

  -- can not lazyload, it is also slow...
  use { -- need to be the first to load
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    requires = {"rafamadriz/friendly-snippets", event = "InsertEnter"}, -- , event = "InsertEnter"
    config = "require'luasnip-config'"
}

  -- --------- --
  -- Languages --
  -- --------- --

  -- JSON
  use { 'gennaro-tedesco/nvim-jqx',
        config = "require('nvim-jqx.config')",
  }

  -- Lua
  use {
    "folke/lua-dev.nvim",
    opt = true,
    ft = "lua",
  }

  use {
    "bfredl/nvim-luadev",
    opt = true,
    cmd = {"Luadev-Runline", "Luadev-Run", "Luadev-RunWord", "Luadev-Complete"},
  }

end)
