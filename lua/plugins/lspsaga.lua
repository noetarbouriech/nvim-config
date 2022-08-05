require("lspsaga").init_lsp_saga({
    border_style = "rounded",
    code_action_icon = " ",
    code_action_lightbulb = {
        enable = true,
        sign = false,
        enable_in_insert = true,
        sign_priority = 20,
        virtual_text = true,
    },
    diagnostic_header = { " ", " ", " ", "ﴞ " },
})