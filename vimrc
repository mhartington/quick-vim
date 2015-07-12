" If neobundle is not installed, do it first
let bundleExists = 1
if (!isdirectory(expand("$HOME/.vim/bundle/neobundle.vim")))
  call system(expand("mkdir -p $HOME/.vim/bundle"))
  call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim"))
  let bundleExists = 0
endif

" Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if has('vim_starting')
   if &compatible
      " Be iMproved
      set nocompatible
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

 " start with a theme
  NeoBundle 'nanotech/jellybeans.vim'

 " add some async to your life
  NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

" syntax highlighting
  NeoBundleLazy 'othree/yajs.vim',{'autoload':{'filetypes':['javascript']}}
  NeoBundleLazy '1995eaton/vim-better-javascript-completion',{'autoload':{'filetypes':['javascript']}}
  NeoBundleLazy 'tpope/vim-markdown',{'autoload':{'filetypes':['markdown']}}
  NeoBundleLazy 'leafgarland/typescript-vim',{'autoload':{'filetypes':['typescript']}}
  NeoBundleLazy 'othree/html5.vim',{'autoload':{'filetypes':['html']}}
  NeoBundleLazy 'JulesWang/css.vim',{'autoload':{'filetypes':['css']}}

" better js completion
  NeoBundle 'marijnh/tern_for_vim', {
  \ 'autoload' : { 'filetypes' : 'javascript' },
  \   'build': {
  \     'windows': 'npm install',
  \     'mac': 'npm install',
  \     'unix': 'npm install',
  \   },
  \ }

" Utils
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'bling/vim-airline'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tomtom/tcomment_vim'
 call neobundle#end()

" Required:
  filetype plugin indent on

" this will conveniently prompt you to install them.
" If there are uninstalled bundles found on startup,
  NeoBundleCheck

  syntax on
  set nofoldenable
  set nocompatible
  set nobackup
  set nowb
  set noswapfile
  set ic
  set mouse=a
  set number
" 2 space softabs default
  set expandtab
  set ts=2
  set sw=2
  set wildmenu
  set laststatus=2
  set lazyredraw
" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1

  syntax enable
  set background=light
  colorscheme jellybeans

" Be lazy, map ; to : for a better life
  nnoremap ; :

" Map leader to ,
  let mapleader = ','
  set wrap linebreak nolist
  set virtualedit=
  set display+=lastline

" Navigate between display lines
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> k gk
  noremap  <silent> j gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Up>   <C-o>gk
  inoremap <silent> <Down> <C-o>gj
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>

" Toggle nerdtree with ctrl-\
  map <C-\> :NERDTreeToggle<CR>
" Enable nerdtree at start if no file is specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" show hidden files in nerdtree
  let NERDTreeShowHidden=1

" enable completion for css,html, & js
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" Emmet
" Enable Emmet in all modes
  let g:user_emmet_mode='a'
" Map emmet expand to tab, like sublime and atom
" This is a good example of some simple viml
" Remapping <C-y>, just doesn't cut it.
  function! s:expand_html_tab()
" try to determine if we're within quotes or tags.
" if so, assume we're in an emmet fill area.
   let line = getline('.')
   if col('.') < len(line)
     let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
     if len(line) >= 2
       return "\<C-y>n"
     endif
   endif
" expand anything emmet thinks is expandable.
  if emmet#isExpandable()
    return "\<C-y>,"
  endif
" return a regular tab character
   return "\<tab>"
   endfunction
   autocmd FileType html,ejs imap <buffer><expr><tab> <sid>expand_html_tab()

  let g:use_emmet_complete_tag = 1
  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall

" vim-airline
" disable powerline fonts, change to 1 if you want them
" download them here https://github.com/powerline/fonts
  let g:airline_powerline_fonts = 0
  let g:airline_theme='jellybeans'
" make sure to escape the spaces in the name properly
" Tabline part of vim-airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
  nmap <leader>x :bp <BAR> bd #<CR>
" This replaes :tabnew which I used to bind to this mapping
  nmap <leader>n :enew<cr>
" Move to the next buffer
  nmap <leader>, :bnext<CR>
" Move to the previous buffer
  nmap <leader>. :bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1
" leader+number for tab switching
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9

" Syntastic
" custimize the warning message
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
" install your favorite linter here, my vote is for eslint
" then create a .eslintrc file in your $HOME or project dir
" umcomment this if you have eslint install
" let g:syntastic_javascript_checkers = ['eslint']
" disable checking on open
  let g:syntastic_check_on_open = 0
" show multiple checerks at the same time
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '!'
  let g:syntastic_style_error_symbol = '✗'
  let g:syntastic_style_warning_symbol = '!'
" no need to check any sass, scss, or html
  let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss','html'] }
  map <Leader>e :lnext<CR>
  map <Leader>E :lprev<CR>
