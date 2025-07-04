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
        virtual_text = false, -- No inline diagnostic text
        signs = false, -- No gutter signs
        underline = false, -- No underlines for diagnostics
        update_in_insert = false, -- No diagnostics in insert mode
        float = { border = "none" }, -- No borders for any diagnostic float
      })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- Leave empty for dynamic installation
        automatic_installation = true, -- Auto-install LSP servers
      })

      -- Default handler for LSP servers
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
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
              lspconfig[server_name].setup({})
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
}
