lua << EOF
require("config.theme")("material", "deep ocean")
require("plugins") -- base uses things loaded by plugins
EOF


nnoremap <SPACE> <Nop>
let mapleader = " "


augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

augroup AutoSave
  autocmd CursorHold,CursorHoldI,FocusLost,BufLeave * silent! wall
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
map <PageUp> <Nop>
map <PageDown> <Nop>


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
"  |                     EDITOR                      |
"  +-------------------------------------------------+
"
" -- built in
nnoremap <silent> <leader>bk <cmd>bd<cr>
" move line up/down
noremap <C-k> <cmd>m -2<cr>
noremap <C-j> <cmd>m +1<cr>
" move selection up/down
vnoremap J :m '>+2<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ts-hint-object
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>


"  +-------------------------------------------------+
"  |                        GIT                      |
"  +-------------------------------------------------+
"
nnoremap <leader>gd <cmd>Gitsigns diffthis<cr>


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
"  |                     JUMPWIRE                    |
"  +-------------------------------------------------+
noremap <leader>jt :lua require('jumpwire').jump('test')<CR>
noremap <leader>ji :lua require('jumpwire').jump('implementation')<CR>
noremap <leader>jm :lua require('jumpwire').jump('markup')<CR>
noremap <leader>js :lua require('jumpwire').jump('style')<CR>


"  +-------------------------------------------------+
"  |                      PACKER                     |
"  +-------------------------------------------------+
"
nnoremap <leader>ps <cmd>PackerSync<cr>
nnoremap <leader>pc <cmd>PackerCompile<cr>


"  +-------------------------------------------------+
"  |                      REMAPS                     |
"  +-------------------------------------------------+
"
" yank to end of line
nnoremap Y y$
" centre screen while navigating searches etc: zz:centre; zv:open folds;  
nnoremap n nzzzv
nnoremap N Nzzzv
" keep cursor in same place while joining lines: mz:mark z; J; `z: jump to z;
nnoremap J mzJ`z
" undo break points: C-g:set undo break point.
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ; ;<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
" fix relative jumps history off-by-one issue
" if the jump is greater than 5 lines, add it to the jump history (m')
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'


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
