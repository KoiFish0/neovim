return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason-LSPConfig for automatic LSP installation
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- Disable all diagnostic visuals
      vim.diagnostic.config({
        virtual_text = true, -- Inline diagnostic text
        signs = false, -- Gutter signs
        underline = true, -- Underlines for diagnostics
        update_in_insert = false, -- Diagnostics in insert mode
        float = { border = "none" }, -- Borders for any diagnostic float
      })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- Leave empty for dynamic installation
        automatic_installation = true, -- Auto-install LSP servers
      })

      -- Default handler for LSP servers
      local lspconfig = require("lspconfig")
      -- Attach LSP capabilities for autocomplete
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities, -- Enable autocomplete capabilities
          })
        end,
      })

      -- Auto-install LSP server based on filetype
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          local filetype_to_server = {
            python = "pyright",
            lua = "lua_ls",
            javascript = "tsserver",
            typescript = "tsserver",
            go = "gopls",
            rust = "rust_analyzer",
            java = "jdtls",
          }
          local server_name = filetype_to_server[filetype]
          if server_name and not vim.tbl_contains(require("mason-lspconfig").get_installed_servers(), server_name) then
            vim.notify("Installing LSP server for " .. filetype .. ": " .. server_name, vim.log.levels.INFO)
            vim.fn.system({ "MasonInstall", server_name })
            vim.schedule(function()
              lspconfig[server_name].setup({
                capabilities = capabilities, -- Enable autocomplete for new servers
              })
              vim.notify("LSP server " .. server_name .. " installed and configured", vim.log.levels.INFO)
            end)
          end
        end,
      })
    end,
  },
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },
  -- Autocomplete with nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer", -- Buffer completions
      "hrsh7th/cmp-path", -- Path completions
      "hrsh7th/cmp-cmdline", -- Cmdline completions
      "L3MON4D3/LuaSnip", -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For LuaSnip snippet expansion
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completions
          { name = "luasnip" }, -- Snippet completions
          { name = "buffer" }, -- Buffer completions
          { name = "path" }, -- Path completions
        }),
      })

      -- Setup search completion
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
}
