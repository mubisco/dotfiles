set nocompatible
set background=dark

syntax on
set number
set list
set expandtab
set tabstop=2
set showtabline=2
set shiftwidth=2
set showcmd
"nnoremap <SPACE> <Nop>
"let mapleader =
let mapleader = '\'
set colorcolumn=80
set splitbelow

autocmd FileType php :setlocal sw=4 ts=4 sts=4
filetype off

if exists('py2') && has('python')
elseif has('python3')
endif

" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" PLUGINS
call plug#begin()
"Linting
Plug 'w0rp/ale'

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-vdebug/vdebug'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'TaDaa/vimade'
Plug 'SirVer/ultisnips'

"Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" PHP Development
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'lumiliet/vim-twig'
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'vim-vdebug/vdebug'

" Javascript Development
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'

" Uuid Generator
Plug 'kburdett/vim-nuuid'

" Csv Files
Plug 'chrisbra/csv.vim'

" Pug
Plug 'digitaltoad/vim-pug'

" Themes
Plug 'k4yt3x/ayu-vim-darker'
Plug 'Siphalor/vim-atomified'
Plug 'tomasiser/vim-code-dark'
Plug 'trusktr/seti.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'nanotech/jellybeans.vim' , {'as': 'jellybeans'}
Plug 'chuling/vim-equinusocio-material'

"Tags
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

filetype plugin indent on

"THEMING
" colorscheme jellybeans
let g:airline_theme='codedark'
let g:equinusocio_material_darker = 1

" make vertsplit invisible
" let g:equinusocio_material_hide_vertsplit = 1

set termguicolors

colorscheme codedark

"ALE
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_php_phpcbf_standard='PSR12'
let g:ale_php_phpcs_standard='PSR12'
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'php': ['phpcs', 'php', 'psalm'],
\ 'python': ['pylint'],
\ 'vue': ['eslint', 'vls'],
\ 'typescript': ['tsserver', 'eslint']
\}
let g:ale_fixers = {
  \ 'php': ['phpcbf', 'remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['black', 'add_blank_lines_for_python_control_statements', 'isort', 'remove_trailing_lines', 'reorder-python-imports', 'trim_whitespace', 'yapf']
  \}

let g:ale_fix_on_save = 0
" Allow JSX in normal JS files
let g:jsx_ext_required = 0


let Vimphpcs_Standard='PSR12'"

let g:vdebug_options = {
\    "break_on_open" : 0,
\}
let g:vdebug_keymap = {
\    "eval_under_cursor" : "<Leader>ee"
\}

" NEWTR
" let g:netrw_liststyle = 3
let g:netrw_banner = 0

"AIRLINE
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set statusline+=%{gutentags#statusline()}
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" CUSTOM FUNCTIONS
:command JsonFormat :%!python -m json.tool
command RemoveTrail execute "%s/\s\+$//"
inoremap <Leader>rt :RemoveTrail<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! XmlFormat call DoPrettyXML()

function! ConfigVdebug(project, branch, webfolder)
  VdebugOpt ide_key PHPSTORM
  let g:vdebug_options.path_maps = {"/var/www/html": "/home/mubisco/Projects/Bahia/" . a:project . "/svn/" . a:branch . "/" . a:webfolder . "/src/main/php"}
endfunction

command! VdbgCorpuDevelop call ConfigVdebug('Corpu', 'branches/develop', 'corpu-web')
command! VdbgCorpuNext call ConfigVdebug('Corpu', 'branches/corpu-next', 'corpu-web')
command! VdbgCorpuTrunk call ConfigVdebug('Corpu', 'trunk', 'corpu-web')
command! VdbgXorforSimplificacion call ConfigVdebug('Xorfor', 'branches/simplificacion', 'xorfor-web')

"REMAPS
"map <Leader>a :NERDTreeToggle<CR>
"map <Leader>s :NERDTreeFocus<CR>

map <Leader>a :vs .<CR>

" Disable Nuuid mappings - conflic with PhpActor
let g:nuuid_no_mappings = 1

inoremap jj <Esc>
noremap <C-l> gt
noremap <C-h> gT
noremap <S-l> <C-w>l
noremap <S-h> <C-w>h
noremap <S-j> <C-w>j
noremap <S-k> <C-w>k
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>eem :<C-U>call phpactor#ExtractMethod()<CR>
"
" Extract constant from selection
vmap <silent><Leader>eec :<C-U>call phpactor#ExtractConstant()<CR>

" Shortcut for :Files command
nmap <Leader>f :Files<CR>
"nmap <Leader>fv :vnew<CR>:Files<CR>
"nmap <Leader>fh :new<CR>:Files<CR>
"nmap <Leader>ft :tabnew<CR>:Files<CR>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.vue 0r ~/.config/nvim/templates/skeleton.vue
  augroup END
endif

" imap cll console.log()<Esc>==f(a
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
nmap <S-F4> :execute "silent grep! -R " . expand("<cword>") . " ./**" <Bar> cw<CR>
"
" Extract expression (normal mode)
nmap <silent><Leader>ef :CocCommand eslint.executeAutofix<CR>
" UltiSnips Configuration
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
