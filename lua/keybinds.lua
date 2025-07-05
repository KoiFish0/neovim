local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tmux 
vim.keymap.set("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>:TmuxNavigatePrevious<cr>")

-- Harpoon
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>f", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>q", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>e", function() harpoon:list():next() end)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><Space>", builtin.find_files, {})
vim.keymap.set("n", "<leader>G", builtin.live_grep, {})

-- Zen-mode
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 120,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
end)

-- LSP

-- Set keybinds when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf

    -- Go to definition
    map("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Go to definition" }))

    -- Go to declaration
    map("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Go to declaration" }))

    -- Go to implementation
    map("n", "<leader>gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Go to implementation" }))

    -- Go to type definition
    map("n", "<leader>gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Go to type definition" }))

    -- Show hover information
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show hover documentation" }))

    -- Show signature help
    map("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show signature help" }))

    -- Find references
    map("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Find references" }))

    -- Rename symbol
    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Rename symbol" }))

    -- Code action
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Code action" }))

    -- Format buffer
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Format buffer" }))

    -- Show diagnostics for the current line
    map("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show diagnostics" }))

    -- Go to next diagnostic
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Next diagnostic" }))

    -- Go to previous diagnostic
    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Previous diagnostic" }))

    -- Show diagnostic under cursor
    map("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show diagnostic under cursor" }))
  end,
})

-- Remaps -- 

-- Replace things without losing yank/paste register
vim.keymap.set({"n", "x"}, "<leader>p", [["_dP]])

-- Center screen when using some motions
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<C-d>", "<C-d>zz")
vim.keymap.set("v", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Open file explorer
vim.keymap.set("n", "<leader>e", ":Ex<CR>")
-- Open terminal
vim.keymap.set("n", "<leader>t", ":tab term<CR>i")

-- Less finger movement
vim.keymap.set("n", "cC", "c$")
vim.keymap.set("n", "dD", "d$")
vim.keymap.set("n", "yY", "y$")

-- Splits
vim.keymap.set("n", "-", ":sp<CR>")
vim.keymap.set("n", "|", ":vsp<CR>")

-- Formatting
vim.keymap.set("n", "Q", "gqq")

-- Case-insensitive commands
-- Probably a better way to do this
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
