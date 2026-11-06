require "nvchad.mappings"

local map = vim.keymap.set

-- escapse terminal mode
map("t", "jk", "<C-\\><C-n>")

map("n", ";", ":")
map("n", "q", "<nop>")
map("n", "qq", ":q!<cr>")
map("n", "QQ", function() vim.cmd "qall!" end)
map("n", "<leader>q", function() require("nvchad.tabufline").closeAllBufs() end)
map("n", "<leader>s", ":w!<cr>", { desc = "save" })
map("n", "<C-v>", ":vs!<cr>", { desc = "vertical split" })
map("n", "<C-x>", ":sp!<cr>", { desc = "horizontal split" })
map("n", "FF", ":Format<cr>", { desc = "format" })
-- map("n", "<C-d>", "<C-d>zz", { desc = "move 1/2 down keep cursor" })
-- map("n", "<C-u>", "<C-u>zz", { desc = "move 1/2 up keep cursor" })
-- map("n", "<C-f>", "<C-f>zz", { desc = "move down keep cursor" })
-- map("n", "<C-b>", "<C-b>zz", { desc = "move up keep cursor" })
-- map("n", "n", "nzz", { desc = "search keep cusor" })
-- map("n", "N", "Nzz", { desc = "search keep cusor" })
map("n", "<space><space>", ":Trouble diagnostics toggle focus=true<cr>", { desc = "trouble toggle" })
map("n", "<space>]", ":Trouble diagnostics next<cr>", { desc = "trouble next" })
map("n", "<space>[", ":Trouble diagnostics prev<cr>", { desc = "trouble prev" })
map("n", "<leader>FF", ":execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>", { desc = "Find cursor" })
map("n", "<leader>fk", ":execute 'Telescope keymaps'<cr>", { desc = "Find key map" })
map("n", "<leader>fd", ":execute 'Telescope diagnostics'<cr>", { desc = "Find diagnostics" })
map("n", "<leader>fr", ":execute 'Telescope lsp_references'<cr>", { desc = "Find lsp references" })
map("n", "<A-1>", function() vim.api.nvim_set_current_buf(vim.t.bufs[1]) end, { desc = "go to tab01" })
map("n", "<A-2>", function() vim.api.nvim_set_current_buf(vim.t.bufs[2]) end, { desc = "go to tab02" })
map("n", "<A-3>", function() vim.api.nvim_set_current_buf(vim.t.bufs[3]) end, { desc = "go to tab03" })
map("n", "<A-4>", function() vim.api.nvim_set_current_buf(vim.t.bufs[4]) end, { desc = "go to tab04" })
map("n", "<A-5>", function() vim.api.nvim_set_current_buf(vim.t.bufs[5]) end, { desc = "go to tab05" })
map("n", "<A-6>", function() vim.api.nvim_set_current_buf(vim.t.bufs[6]) end, { desc = "go to tab06" })
map("n", "<A-7>", function() vim.api.nvim_set_current_buf(vim.t.bufs[7]) end, { desc = "go to tab07" })
map("n", "<A-8>", function() vim.api.nvim_set_current_buf(vim.t.bufs[8]) end, { desc = "go to tab08" })
map("n", "<A-9>", function() vim.api.nvim_set_current_buf(vim.t.bufs[9]) end, { desc = "go to tab09" })
map("n", "<A-0>", function() vim.api.nvim_set_current_buf(vim.t.bufs[10]) end, { desc = "go to tab10" })
map("n", "<M-F>", ":vertical resize +10<cr>", { desc = "resize window with width+10 (alacritty hack)" })
map("n", "<M-B>", ":vertical resize -10<cr>", { desc = "resize window with width-10 (alacritty hack)" })
map("n", "<M-Right>", ":vertical resize +10<cr>", { desc = "resize window with width+10" })
map("n", "<M-Left>", ":vertical resize -10<cr>", { desc = "resize window with width-10" })
map("n", "<M-Up>", ":resize -5<cr>", { desc = "resize window with height-5" })
map("n", "<M-Down>", ":resize +5<cr>", { desc = "resize window with height+5" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.4 }
end, { desc = "terminal toggleable vertical term with custom size as 0.4 screen width" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.4 }
end, { desc = "terminal new horizontal term with custom size as 0.4 screen height" })


map("v", "qq", "<esc>:q!<cr>")
map("v", "FF", ":Format<CR>", { desc = "format selection" })

map("i", "jk", "<esc>")
