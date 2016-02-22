"{{{Basic
" ======================
"        Basic
" ======================
sy on
set foldmethod=marker
set nonu
set ts=4 sts=4 sw=4 et
set expandtab
set ruler
set number
set hlsearch
set incsearch
set smartindent
set ignorecase
set noerrorbells
set spell
set spelllang=en,cjk
set pastetoggle=<C-a>

highlight SpecialKey ctermfg=237
set t_Co=256
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
set showmatch
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
set nowrapscan
set backspace=2

set encoding=utf-8
set fileencodings=utf-8

" show border of 80 character
if (exists('+colorcolumn'))
set colorcolumn=80
    highlight ColorColumn ctermbg=13
endif
"}}}Basic
"{{{Plguin
call plug#begin('~/.vim/plugged')
"Plug 'mattn/benchvimrc-vim'

" -------
"  Color
" -------
Plug 'altercation/vim-colors-solarized'

" -----------
"  Operation
" -----------
Plug 'yanktmp.vim'
Plug 'terryma/vim-expand-region'
Plug 'bronson/vim-trailing-whitespace'
" type ( out ()
Plug 'kana/vim-smartinput'
" show last git commit
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'vim-scripts/vim-auto-save'
Plug 'scrooloose/syntastic'

" --------
"  Search
" --------
Plug 'unite.vim'
" Unite
"   depend on vimproc
"   you have to go to .vim/plugin/vimproc.vim and do a ./make
Plug 'Shougo/vimproc.vim'
" You can clean trailing whitespace with :FixWhitespace.
Plug 'rking/ag.vim'

" ------
"  Jump
" ------
Plug 'gtags.vim'

" ----------
"  Language
" ----------
Plug 'tpope/vim-endwise'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'

" --------
"  Manual
" --------
Plug 'thinca/vim-ref'

" ----------
"  MyPlugin
" ----------
Plug 'delaemon/dec2bin.vim'
call plug#end()
:runtime! ftplugin/man.vim

" -------
"  Color
" -------
" color solarized
set background=dark
set rtp+=~/.vim/plugged/vim-colors-solarized
colorscheme solarized

" -----------
"  Operation
" -----------
" yank.vim
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>
" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
"vim-auto-save
"let g:auto_save = 1
"autocmd! bufwritepost .vimrc source %
" suck. the work to be left to task runner.
"autocmd! bufwritepost *.ts make %
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']

" --------
"  Search
" --------
" unite.vim
let g:unite_enable_start_insert=1
nmap <silent> ;um :<C-u>Unite file_mru<CR>
nmap <silent> ;ub :<C-u>Unite buffer<CR>
nmap <silent> ;uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> ;ur :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> ;uu :<C-u>Unite buffer file_mru<CR>
nmap <silent> ;ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nmap <silent> ;ug :<C-u>Unite grep:%:-iHRn<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" failed
let g:unite_source_history_yank_enable=1
if executable('ag')
    try
        let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
        let g:unite_source_grep_recursive_opt = ''
    catch
    endtry
endif
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)":nnoremap <space>r <Plug>(unite_restart)

" ag.vim
" The Silver Searcher
" type to search the word in all files in the current dir
nnoremap <space>a :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

" ------
"  Jump
" ------
" GTAGS
" close window
nnoremap <C-q> <C-w><C-w><C-w>q
" code grep
nnoremap <C-g> :Gtags -g
" funciton list in file
nnoremap <C-l> :Gtags -f %<CR>
" jump to definition
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" jump to collers
nnoremap <C-c> :Gtags -r <C-r><C-w><CR>
" next search result
nnoremap <C-n> :cn<CR>
" back search result
nnoremap <C-p> :cp<CR>

" ----------
"  Language
" ----------
" go
"Autocompletion is enabled by default via <C-x><C-o>
"set rtp+=$GOPATH/src/github.com/nsf/gocode/vim
let g:go_bin_path = expand("~/.go/bin")
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

set completeopt=menu,preview
if &filetype == "go"
    nnoremap <leader>i <Plug>(go-info)
    nnoremap <leader>gd <Plug>(go-doc)
    nnoremap <leader>gv <Plug>(go-doc-vertical)
    nnoremap <leader>gb <Plug>(go-doc-browser)
    nnoremap <leader>r <Plug>(go-run)
    nnoremap <leader>b <Plug>(go-build)
    nnoremap <leader>t <Plug>(go-test)
    nnoremap <leader>c <Plug>(go-coverage)
    nnoremap <leader>ds <Plug>(go-def-split)
    nnoremap <leader>dv <Plug>(go-def-vertical)
    nnoremap <leader>dt <Plug>(go-def-tab)
    nnoremap <leader>s <Plug>(go-implements)
    nnoremap <leader>e <Plug>(go-rename)
    "failed
    :highlight goErr cterm=bold ctermfg=214
    :match goErr /\<err\>/
endif

" -----------
"  MyPlugin
" -----------
" dec2bin.vim
nnoremap <silent> ;b    :call Dec2binPrint(<C-r><C-w>)<CR>
nnoremap <silent> ;bp   :call Dec2binPrintPad(<C-r><C-w>)<CR>
nnoremap <silent> ;bi   :call Dec2binReplace(<C-r><C-w>)<CR>
nnoremap <silent> ;bip  :call Dec2binReplacePad(<C-r><C-w>)<CR>
nnoremap <silent> ;d    :call Bin2decPrint("<C-r><C-w>")<CR>
nnoremap <silent> ;di   :call Bin2decReplace("<C-r><C-w>")<CR>
nnoremap <silent> ;t    :call Dec2binToggle("<C-r><C-w>")<CR>
"}}}Plugin
"{{{Method
" ======================
"        Method
" ======================
" syntax on/off
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

" align =
function! AlignAssignments ()
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        let left_width = match(linetext, '\s*' . ASSIGN_OP)
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])
            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
        endif
    endfor

    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
    \                                    max_op_width,  submatch(2))'

    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction

" C++ Run
function! CppRun()
    :w
    :!clear; g++ % -o %.compile && ./%.compile && rm %.compile;
endfunction

" Go Run
function! GoRun()
    :w
    :!clear; go run %
endfunction

" Java Run
function! JavaRun()
    :w
    let filename = expand('%')[:-6]
    ":echom filename
    "execute '!javac ' . filename . '.java && java ' . filename . ' && rm ' filename . '.class'
    execute '!clear; javac ' . filename . '.java && java ' . filename
endfunction

" TypeScript Run
function! TypeScriptRun()
    :w
    let filename = expand('%')[:-4]
    execute '!clear; tsc ' . filename . '.ts && node ' . filename . '.js && rm ' . filename . '.js'
endfunction

" Date
function! Date()
    let d = system('date')
    :echom d
endfunction

function! DateInsert()
  let d = system('date')
  :call setline('.', printf("%s", d))
endfunction

" Check Function
function! CheckFunction()
    :highlight goErr cterm=bold ctermfg=214
    :match goErr /\<err\>/
endfunction

function! HighLightErr()
    if exists("b:highlight_err")
        unlet b:highlight_err
        :highlight Normal cterm=None
        :match Normal /\<err\>/
    else
        let b:highlight_err = 1
        :highlight ColorErr cterm=bold ctermfg=214
        :match ColorErr /\<err\>/
    endif
endfunction

function! Add(a, b)
    :echom a:a + a:b
endfunction

function! GetLine()
    :echom getline('.')
endfunction

function! FileType()
    :echom &filetype
endfunction
"}}}Method
"{{{KeyMap
" ======================
"        Key Map
" ======================
let mapleader = " "
" reload .vimrc
nnoremap <silent>  ;re  :source ~/.vimrc<CR><Esc>
" edit .vimrc
nnoremap <silent>  ;v  :edit $MYVIMRC<CR><Esc>
" toggle display of line numbers
nnoremap <silent>  ;n  :set nu!<CR>
" change tab space
nnoremap t2 :set ts=2 sts=2 sw=2 et<CR><Esc>
nnoremap t4 :set ts=4 sts=4 sw=4 et<CR><Esc>
" paste mode
nnoremap <silent>  ;a  :set paste<CR><Esc>
" cancel search result high light
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" sort line in reverse order
nnoremap <silent>  ;rr  :g/^/m 0<CR><Esc>

" method call
nnoremap <silent>  ;s   :call ToggleSyntax()<CR>
nnoremap <silent>  ;=   :call AlignAssignments()<CR>
nnoremap <silent>  ;c   :call CppRun()<CR>
nnoremap <silent>  ;j   :call JavaRun()<CR>
nnoremap <silent>  ;g   :call GoRun()<CR>
nnoremap <silent>  ;cf  :call CheckFunction()<CR>
nnoremap <silent>  ;dt  :call Date()<CR>
nnoremap <silent>  ;dti :call DateInsert()<CR>
nnoremap <silent>  ;gl  :call GetLine()<CR>
nnoremap <silent>  ;ff  :call FileType()<CR>
nnoremap <silent>  ;he  :call HighLightErr()<CR>
nnoremap <silent>  ;t   :call TypeScriptRun()<CR>
"}}}KeyMap
