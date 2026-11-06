vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      analyses = {
        unusedvariable = true,
        -- shadow = true,
        useany = true,
      },
    },
  },
})

vim.lsp.enable "pyrefly"
vim.lsp.enable "clangd"
vim.lsp.enable "ts_ls"
vim.lsp.enable "gopls"
vim.lsp.enable "pbls"
vim.lsp.enable "docker_compose_language_service"
vim.lsp.enable "dockerls"
vim.lsp.enable "bashls"
vim.lsp.enable "postgres_lsp"
vim.lsp.enable "terraformls"

vim.lsp.enable "gdscript"
