" See :help fzf
if YT_PlugInstalled('fzf')
  nmap <leader>fz :FZF 

  let g:fzf_history_dir="~/.fzf.history.vim"
endif
