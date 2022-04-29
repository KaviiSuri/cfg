local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

-- Requires Server Specific LSP Config and embeds into options.
local function require_and_extend(server_name, opts)
    local status_ok, server_opts = pcall(require, "i.lsp.settings." .. server_name)
    if status_ok then
        return vim.tbl_deep_extend("force", server_opts, opts)
    end
    return opts
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("i.lsp.handlers").on_attach,
        capabilities = require("i.lsp.handlers").capabilities,
    }

    opts = require_and_extend(server.name, opts)

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
