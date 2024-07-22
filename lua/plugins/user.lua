---@type LazySpec
return {
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts)
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
          :with_pair(cond.not_after_regex "%%")
          :with_pair(cond.not_before_regex("xxx", 3))
          :with_move(cond.none())
          :with_del(cond.not_after_regex "xx")
          :with_cr(cond.none()),
      }, Rule("a", "a", "-vim"))
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    init = function() vim.keymap.set("n", "<leader>a", "<cmd>NoNeckPain<CR>", { desc = "Center buffer" }) end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        aerial = true,
        dap = true,
        dap_ui = true,
        mason = true,
        neotree = true,
        notify = true,
        nvimtree = false,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        rainbow_delimiters = true,
        which_key = true,
      },
      transparent_background = false,
      color_overrides = {
        frappe = {
          base = "#1e1e1e",
          mantle = "#1e1e1e",
          crust = "#1e1e1e",
        },
      },
      -- custom_highlights = function(colors) end,
    },
  },
  {
    "cbochs/grapple.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "AstroNvim/astroui", opts = { icons = { Grapple = "󰛢" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader><Leader>"
          maps.n[prefix] = { desc = require("astroui").get_icon("Grapple", 1, true) .. "Grapple" }
          maps.n[prefix .. "a"] = { "<Cmd>Grapple tag<CR>", desc = "Add file" }
          maps.n[prefix .. "d"] = { "<Cmd>Grapple untag<CR>", desc = "Remove file" }
          maps.n[prefix .. "t"] = { "<Cmd>Grapple toggle_tags<CR>", desc = "Toggle a file" }
          maps.n[prefix .. "e"] = { "<Cmd>Grapple toggle_scopes<CR>", desc = "Select from tags" }
          maps.n[prefix .. "s"] = { "<Cmd>Grapple toggle_loaded<CR>", desc = "Select a project scope" }
          maps.n[prefix .. "x"] = { "<Cmd>Grapple reset<CR>", desc = "Clear tags from current project" }
          maps.n["<C-n>"] = { "<Cmd>Grapple cycle forward<CR>", desc = "Select next tag" }
          maps.n["<C-p>"] = { "<Cmd>Grapple cycle backward<CR>", desc = "Select previous tag" }

          for i = 1, 9 do
            maps.n["<leader>" .. i] = { "<Cmd> Grapple select index=" .. i .. "<CR>", desc = "Select index " .. i }
          end
        end,
      },
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    cmd = { "Grapple" },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>x"
          maps.n[prefix] = { desc = require("astroui").get_icon("Trouble", 1, true) .. "Trouble" }
          maps.n[prefix .. "X"] = { "<Cmd>Trouble diagnostics toggle<CR>", desc = "Workspace Diagnostics (Trouble)" }
          maps.n[prefix .. "x"] =
            { "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document Diagnostics (Trouble)" }
          maps.n[prefix .. "l"] = { "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" }
          maps.n[prefix .. "q"] = { "<Cmd>Trouble quickfix toggle<CR>", desc = "Quickfix List (Trouble)" }
          if require("astrocore").is_available "todo-comments.nvim" then
            maps.n[prefix .. "t"] = {
              "<cmd>Trouble todo<cr>",
              desc = "Todo (Trouble)",
            }
            maps.n[prefix .. "T"] = {
              "<cmd>Trouble todo filter={tag={TODO,FIX,FIXME}}<cr>",
              desc = "Todo/Fix/Fixme (Trouble)",
            }
          end
          maps.n[prefix .. "r"] = { "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>" }
        end,
      },
    },
    opts = function()
      local get_icon = require("astroui").get_icon
      local lspkind_avail, lspkind = pcall(require, "lspkind")
      return {
        keys = {
          ["<ESC>"] = "close",
          ["q"] = "close",
          ["<C-E>"] = "close",
        },
        icons = {
          indent = {
            fold_open = get_icon "FoldOpened",
            fold_closed = get_icon "FoldClosed",
          },
          folder_closed = get_icon "FolderClosed",
          folder_open = get_icon "FolderOpen",
          kinds = lspkind_avail and lspkind.symbol_map,
        },
      }
    end,
  },
  { "lewis6991/gitsigns.nvim", opts = { trouble = true } },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, "Trouble")
    end,
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { lsp_trouble = true } },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    init = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_dim_inactive_windows = 0
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.cmd.colorscheme "gruvbox-material"
    end,
  },
}
