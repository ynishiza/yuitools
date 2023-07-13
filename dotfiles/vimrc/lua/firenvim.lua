-- https://github.com/glacambre/firenvim#understanding-firenvims-configuration-object
vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        -- Disable in google chat
        -- Breaks @mentions
        ["mail.google.com/chat"] = {
            priority = 1,
            takeover = "never"
        },
        -- Disable in google docs
        -- e.g. can't edit spreadsheet
        ["docs.google.com"] = {
            priority = 1,
            takeover = "never"
        },
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "always"
        }
    }
}
