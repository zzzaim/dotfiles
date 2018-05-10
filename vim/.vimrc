runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
filetype plugin indent on

set autoindent
set background=dark
set backspace=2
set backupdir=~/.vim/backup/,.
set breakindent
set breakindentopt=sbr
set colorcolumn=79
set cpoptions+=n
set directory=~/.vim/swap//,.
set expandtab
set hlsearch
set laststatus=2
set linebreak
set list
set listchars=tab:▸\ ,trail:·
set modeline
set nofoldenable
set relativenumber
set shiftwidth=2
set showbreak=\ \ ▸
set showcmd
set showmatch
set scrolloff=10
set softtabstop=2
set tabstop=4
set undodir=~/.vim/undo
set undofile
set viminfo+=n~/.vim/viminfo

" Status line (left)
" ' filename [type][+][ro]'
set statusline=\ %f\ %y%m%r

" Status line (midddle)
" Syntastic error messages
if exists('SyntasticStatuslineFlag')
  set statusline+=\ %#Error#
  set statusline+=\ %{SyntasticStatuslineFlag()}\ 
endif

" Status line (right)
" 'Col:n Line:n/N (n%)'
set statusline+=%=%*
set statusline+=\ Col:%c
set statusline+=\ Line:%l/%L
set statusline+=\ (%P)\ 

" Color settings
set t_Co=256
set t_AB=[48;5;%dm
set t_AF=[38;5;%dm

" Use Base16 shell helper script
" https://github.com/chriskempson/base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Change cursor according to mode
let &t_SI = "\e[6 q"    " insert mode: vertical line cursor
let &t_EI = "\e[2 q"    " normal mode: block cursor

" Syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']

" Javascript
let g:javascript_plugin_jsdoc = 1

" Change map leader
let mapleader = ','

" Key bindings
nmap          <Leader><Space>  :noh<CR>
nmap <silent> <Leader><Leader> <Plug>(CommandT)

" Autocommands
augroup vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.njs,*.njk set ft=jinja
augroup END

" CommandT
let g:CommandTAcceptSelectionMap = '<C-o>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
let g:CommandTWildIgnore = &wildignore . ",*/node_modules"

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Syntax hiligh customization
hi! link makeStatement makeCommands
hi! link htmlTag htmlTagName
hi! link htmlEndTag htmlTag
