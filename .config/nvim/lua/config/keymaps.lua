--sclose and switch tabs
vim.keymap.set("n", "<leader>wd", [[<Cmd>w | bd | bn<CR>]], { desc = "Save, close, and switch to next buffer" })

--start of the line improved
vim.keymap.set("n", "0", [[b^]], { desc = "Go to first letter of line" })

--start of previous word
vim.keymap.set("n", "e", [[b]], { desc = "Go to first letter of previous word" })

--select entire page
vim.keymap.set("n", "V", [[ggVG]], { desc = "Select entire page" })

--select a line
vim.keymap.set("n", "vv", [[V]], { desc = "Select current line" })

--switch to next buffer
vim.keymap.set("n", "<Tab>", [[<Cmd>bn<CR>]], { desc = "Next Buffer" })

--insert 4 spaces
vim.keymap.set("i", "<Tab>", [[<Cmd>execute "normal i    "<CR>]], { desc = "Insert 4 Spaces" })

--Tmux
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "window left" })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { desc = "window right" })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { desc = "window up" })
