local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Tmux 
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>")
map("n", "<c-\\>", "<cmd>:TmuxNavigatePrevious<cr>")

-- Harpoon
local harpoon = require("harpoon")

harpoon:setup()

map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<leader>f", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>4", function() harpoon:list():select(4) end)

map("n", "<leader>q", function() harpoon:list():prev() end)
map("n", "<leader>e", function() harpoon:list():next() end)

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader><Space>", builtin.find_files, {})
map("n", "<leader>g", builtin.live_grep, {})

-- LSP

-- Set keybinds when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf

    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Go to definition" }))
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show hover documentation" }))
    map("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show diagnostics" }))
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Next diagnostic" }))
    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Previous diagnostic" }))
    map("n", "<leader>rr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Find references" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Rename symbol" }))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Code action" }))
    map("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { buffer = bufnr, desc = "Show signature help" }))
  end,
})

-- Remaps -- 

-- Replace things without losing yank/paste register
map({"n", "x"}, "<leader>p", [["_dP]])

-- Center screen when using some motions
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", "<C-d>", "<C-d>zz")
map("v", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Open file explorer
map("n", "<leader>e", ":Ex<CR>")
-- Open terminal
map("n", "<leader>t", ":tab term<CR>i")

-- Less finger movement
map("n", "cC", "c$")
map("n", "dD", "d$")
map("n", "yY", "y$")

-- Splits
map("n", "-", ":sp<CR>")
map("n", "|", ":vsp<CR>")

-- Move selected text around
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor location
map("n", "J", "mzJ`z")

-- Keep paste buffer
map("n", "<leader>p", "\"_dP")

-- Make executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR><CR>")

-- Create a comment (C/C++)
map("n", "<leader>cm", "o/*<Space>*/<Esc>bi")

-- Create a comment block (C/C++)
map("n", "<leader>cb", "o/*<Space>*/<Esc>bi<CR><CR><BS><BS><Esc>kwa<Space>")
