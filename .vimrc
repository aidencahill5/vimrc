call plug#begin()
Plug 'junegunn/seoul256.vim'
"Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'vim-latex/vim-latex'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

"Dart/Flutter
call plug#end()

filetype plugin on
filetype indent on

" vim-latex stuff
let g:tex_flavor='latex'
let g:Tex_FoldedSections = 'preamble'
let g:Tex_ViewRule_pdf = 'skim'
"let g:Tex_GotoError=0
set wrap

" rust stuff
let g:rustfmt_autosave = 1


"set foldmethod=indent"
inoremap {<CR> {<CR><CR><CR>}<Esc>kO
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap <C-e> <C-o>A
map <Leader>c :w<CR><Leader>ll
map <Leader>v :w<CR><Leader>ll<Leader>lv
map <Leader>h :noh<CR>
map <Leader>p <Plug>(pydocstring)

"map <Leader>v :call ZathuraOpenPdf()<CR>

let g:seoul256_background = 235
colo seoul256

set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

set modeline
set statusline=%f%m%r%h\ [%L]\ [%{&ff}]\ %y%=[%p%%]\ [line:%05l,col:%02v]

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" coc stuff
set updatetime=300
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = ['coc-json']
