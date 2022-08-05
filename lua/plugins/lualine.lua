require("lualine").setup({
    options = {
        extensions = { "fzf", "quickfix" },
        theme = "kanagawa"
    },
    tabline = {
        lualine_a = { "buffers"}
    },

})
