return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- Themes
  -- "folke/tokyonight.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- Lualine
  ["rebelot/heirline.nvim"] = { disable = true },
  {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup {
        options = {
          theme = "tokyonight"
        }
      }
    end,
  },
  -- Harpoon
  { "ThePrimeagen/harpoon", lazy = false },
  { "machakann/vim-sandwich", lazy = false },
  -- Markdown
  { "ellisonleao/glow.nvim", ft = "md" },
  { "jghauser/follow-md-links.nvim", ft = "md" },
  -- Java
  { "mfussenegger/nvim-jdtls", ft = "java" },
  -- Julia
  -- Lean
  "nvim-treesitter/nvim-treesitter-textobjects",
  "andrewradev/switch.vim",
  {
    "Julian/lean.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("lean").setup {
        abbreviations = { builtin = true },
        lsp = { on_attach = astronvim.lsp.on_attach },
        lsp3 = { on_attach = astronvim.lsp.on_attach },
        mappings = true,
      }
    end
  },
  { "jpalardy/vim-slime", ft = "julia" },
  -- Rust
  "simrat39/rust-tools.nvim",
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  -- Better cmp with floating types
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot-cmp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "kdheepak/cmp-latex-symbols",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end
      local cmp = require"cmp"
      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Add tab support
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          })
        },
        -- Installed sources:
        sources = {
          { name = "path" }, -- file paths
          { name = "copilot" },
          { name = "nvim_lsp", keyword_length = 3 }, -- from language server
          { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
          { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
          { name = "latex_symbols", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
          { name = "buffer", keyword_length = 2 }, -- source current buffer
          { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
          { name = "luasnip" },
          { name = "calc" }, -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "λ",
              vsnip = "⋗",
              buffer = "Ω",
              path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
      })
    end
  }
}
