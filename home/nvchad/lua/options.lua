require "nvchad.options"

vim.o.cursorlineopt = "both"
vim.opt.colorcolumn = "100"
vim.o.relativenumber = true

vim.wo.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", extends = "→", precedes = "←" }

if vim.fn.executable "zsh" == 1 then
  vim.o.shell = "zsh"
end

-- auto save
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand "%" ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command "silent update"
    end
  end,
})

-- replace quickfix by trouble
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd [[cclose]]
        vim.cmd [[Trouble qflist open focus=true]]
      end)
    end
  end,
})
