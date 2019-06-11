"
" Taglist
"
" See the ctags file.
let tlist_markdown_settings="markdown;h:header"
let tlist_r_settings = "r;f:function;c:class"
let tlist_php_settings="php;f:function;d:constant;a:class"
let tlist_javascript_settings_base = "javascript;e:class;d:class_property;q:constant;r:@module;n:@property;t:@class;o:@method;u:@construct;j:describe;k:it"
let tlist_javascript_settings = tlist_javascript_settings_base . ";f:function"

" Experiment: simplenote
let tlist_smplnt_settings = "smplnt;k:keyword;h:header"

map <F8> :TlistToggle<CR>
