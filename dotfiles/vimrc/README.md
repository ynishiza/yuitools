# Overview

The numerical prefix in the filename indicates load order.
Small numbers are loaded first.
e.g. `00_0debug.vim` is loaded first.
e.g. `99_info.vim` is loaded last.

A selection of vimrcs are loaded through entry point `init.vim`.
vimrc files to be loaded are symlinked in `~/.vim/vimrc.d/conf.d`

# Tips

## Usage: set custom LSP settings in a project

Call `yt_lsp_update_settings(<LSP server name>, <LSP settings>)` in a project `.vimrc`.

e.g. custom `hls` settings

```
-- <project>/.vimrc
lua<<EOF
local nvim_lsp = require("lspconfig")
yt_lsp_update_settings("hls", {
  filetypes={"haskell", "lhaskell" },
  cmd={ "haskell-language-server-wrapper", "--logfile", "/tmp/hls2.log", "--lsp" },
  root_dir = function (filepath)
     return (
       nvim_lsp.util.root_pattern("hie.yaml", "stack.yaml", "cabal.project")(filepath)
    )
  end,
  settings = {
    haskell = {
      formattingProvider = "ormolu"
    }
  }
})
EOF
```


