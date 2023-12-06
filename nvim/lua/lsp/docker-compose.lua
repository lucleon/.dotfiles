

local M = {
    setup = function(on_attach, capabilities, settings)
        require('lspconfig').docker_compose_language_service.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            fileytpes = {"yaml.docker-compose", "yml.docker-compose"},
        })
    end,
}

return M
