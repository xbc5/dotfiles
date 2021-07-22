" it's probably best practice to load the theme first, since other
"  modules will depend on it (e.g. vim.g.colors_value prop), but it doesn't
"  seem to affect lualine.
lua require("config.theme")("material", "deep ocean")
lua require("plugins")


nnoremap <SPACE> <Nop>
let mapleader = " "


augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END


augroup AutoSave
  autocmd CursorHold,CursorHoldI <buffer> silent write
augroup END


"  +-------------------------------------------------+
"  |                    TRAINING                     |
"  +-------------------------------------------------+
"
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Delete> <Nop>


"  +-------------------------------------------------+
"  |                    BUILT IN                     |
"  +-------------------------------------------------+
"
set cursorline
" get rid of 'INSERT' etc below status line
set noshowmode
" hybrid line numbers on
set number relativenumber
set nu rnu
" tabs, eww
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
" folding
""set foldmethod=expr
""set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=2
" text display
set nowrap

" replace visual selection with paste, sending the deletion
"  to a void register.
vnoremap <leader>p "_dP


"  +-------------------------------------------------+
"  |                    CHEATSHEET                   |
"  +-------------------------------------------------+
"
nnoremap <leader>? <cmd>Cheatsheet<cr>


"  +-------------------------------------------------+
"  |                    COMPLETION                   |
"  +-------------------------------------------------+
"
" -- setup
" remap <C-Space> from the default <C-@>
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
" -- keys
" tab to cycle
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <C-Space> <Plug>(completion_trigger)
" -- options
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" -- completion-nvim
" " LSP hover for completion items
" let g:completion_enable_auto_hover = 1
" let g:completion_enable_auto_signature = 1
" " in order of priority: high => low
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" let g:completion_matching_smart_case = 1
" " in addition to trigger chars set by lang server
" let g:completion_trigger_character = ['.', '::']
" let g:completion_trigger_on_delete = 1
" let g:completion_timer_cycle = 200

" -- nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


"  +-------------------------------------------------+
"  |                     EDITOR                      |
"  +-------------------------------------------------+
"
" -- built in
nnoremap <leader>bk <cmd>q<cr>
" move line up/down
noremap <C-k> <cmd>m -2<cr>
noremap <C-j> <cmd>m +1<cr>

" ts-hint-object
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>


"  +-------------------------------------------------+
"  |                        GIT                      |
"  +-------------------------------------------------+
"
nnoremap <leader>gd <cmd>Gitsigns diffthis<cr>
"nnoremap <leader>gg <cmd>Neogit<cr>
nnoremap <silent> <leader>gg <cmd>lua require('lspsaga.floaterm').open_float_terminal("lazygit")<CR>


"  +-------------------------------------------------+
"  |                    FORMATTER                    |
"  +-------------------------------------------------+
"
nnoremap <silent> <leader>fd :Format<CR>


"  +-------------------------------------------------+
"  |                        HOP                      |
"  +-------------------------------------------------+
"
nnoremap <leader>hw <cmd>HopWord<cr>


"  +-------------------------------------------------+
"  |                        LSP                      |
"  +-------------------------------------------------+
"
" -- lspsaga
nnoremap <silent><leader>lf <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>lca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
nnoremap <silent><leader>lr <cmd>lua require('lspsaga.rename').rename()<CR>
" visual mode == range
vnoremap <silent><leader>lca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" scroll in previews
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" previews
nnoremap <silent><leader>ls <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent><leader>lpd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent><leader>ld <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" diagnostics
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
" terminal
tnoremap <silent> <Esc><Esc> <cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>
" jumps
nnoremap <silent>ljd <cmd>lua vim.lsp.buf.definition()<CR>


"  +-------------------------------------------------+
"  |                      PACKER                     |
"  +-------------------------------------------------+
"
nnoremap <leader>ps <cmd>PackerSync<cr>
nnoremap <leader>pc <cmd>PackerCompile<cr>


"  +-------------------------------------------------+
"  |                   TODO-COMMENTS                 |
"  +-------------------------------------------------+
"
nnoremap <leader>td <cmd>TodoTelescope<cr>


"  +-------------------------------------------------+
"  |                      TROUBLE                    |
"  +-------------------------------------------------+
"
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>Trouble lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>Trouble lsp_document_diagnostics<cr>
