local map = vim.keymap.set

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
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})

-- Remaps -- 

-- Center screen when using some motions
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Open file explorer
vim.keymap.set("n", "<leader>e", ":Ex<CR>")

-- Less finger movement
vim.keymap.set("n", "dD", "d$")
vim.keymap.set("n", "cC", "c$")
