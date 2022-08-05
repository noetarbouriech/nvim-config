local lspconfig = require("lspconfig")

lspconfig.tsserver.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.gopls.setup{}
lspconfig.gdscript.setup{}
lspconfig.rnix.setup{}
lspconfig.ccls.setup{
    cmd = {
        'ccls',
        '--init={"cache": {"directory": "/tmp/ccls-cache"}}'
    };
    capabilities = capabilities
} -- c language
