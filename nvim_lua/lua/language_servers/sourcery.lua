local M = {}

function M.start_server()
    vim.lsp.start({
        name = "sourcery",
        cmd = {"sourcery",  "lsp"},
        init_options = {
            extension_version = 'nvim_lsp',
            editor_version = 'neovim',
        },
    })
end

return M
