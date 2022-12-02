-- https://github.com/glacambre/firenvim#understanding-firenvims-configuration-object
--
--   cmdline    =   neovim|firenvim|none
--
--   priority   =   #
--      Priority when multiple settings match
--
--   content    =   text|html
--      How to fetch content
--
--   selector   =   <CSS selector>
--
--   takeover   =   always|empty|never|nonempty|once
--      When to take over elements
--      empty/nonempty = take over only if empty/nonempty
--
--
vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        -- Disable in github file content
        ["github.com.*/blob/.*"] = {
          priority = 0,
          takeover = "never"
        },
        ["jsonlint"] = {
          priority = 1,
          takeover = "never"
        },
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
        -- Disable in google meet's chat
        -- Text area is too small
        ["meet.google.com"] = {
            priority = 1,
            takeover = "never"
        },
        -- Disable in google's search text box
        -- Too small
        ["www.google.com"] = {
            priority = 1,
            takeover = "never"
        },
        ["www.google.co.jp"] = {
            priority = 1,
            takeover = "never"
        },
        ["app.lokalise.com"] = {
          priority = 0,
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

