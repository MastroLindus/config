call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'xolox/vim-misc'
Plug 'Raimondi/delimitMate'
Plug 'leafgarland/typescript-vim'
Plug 'altercation/vim-colors-solarized'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
call plug#end()

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

set background=dark
colorscheme solarized

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set number

nnoremap \\ :noh<return>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>
map <F9> :so $MYVIMRC<CR>
nmap <F8> :TagbarToggle<CR>
let g:deoplete#enable_at_startup = 1

" <CR>: If popup menu visible, expand snippet or close popup with selection,
"       Otherwise, check if within empty pair and use delimitMate.
imap <silent><expr><CR> pumvisible() ?
	\ deoplete#mappings#close_popup()
		\ : (delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" : "\<CR>")

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : deoplete#mappings#manual_complete())

smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : deoplete#mappings#manual_complete())

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}
