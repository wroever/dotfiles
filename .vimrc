" Largely borrowed from:
" Doug Black: https://dougblack.io/words/a-good-vimrc.html
" Mathias Bynens: https://github.com/mathiasbynens/dotfiles/
" Joe Nelson: https://github.com/begriffs
"
"------------------------------------------------------------

" Protect against crash-during-write
set writebackup
" ...but do not persist backup after successful write
set nobackup
" Use rename-and-write-new method whenever safe
set backupcopy=auto
" Persist the undo tree for each file
set undofile

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Color scheme
colorscheme nord
set background=light " Required for papercolor nvim compatibility

" Required for nord
if (has("termguicolors"))
  set termguicolors
endif

" Display line numbers on the left
set number

" Always display the status line, even if only one window is displayed
set laststatus=2

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Highlight current line
set cursorline

" Render placeholder chars for tabs, trailing space, eol, nbsp
set list
set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_

" Enable syntax highlighting
syntax enable

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Mouse
set mouse=

" Splits
set splitbelow
set splitright
set fillchars+=vert:\│

" Open diffs in vertial splits
set diffopt+=vertical

" Folds
let g:vimsyn_folding = 'af' " augroups + functions

" Better command-line completion - provides a graphical menu of matches you
" can cycle through
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=longest,list,full

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Set the command window height to 2 lines, to avoid many cases of having to
" 'press <Enter> to continue'
" set cmdheight=2

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" tabstop is the number of spaces a tab counts for. So, when Vim opens a file
" and reads a <TAB> character, it uses that many spaces to visually show the
" <TAB>.
set tabstop=2
" softabstop is the number of spaces a tab counts for when editing. So this
" value is the number of spaces that is inserted when you hit <TAB> and also
" the number of spaces that are removed when you backspace.
set softtabstop=2
" expandtab turns <TAB>s into spaces. That's it. So <TAB> just becomes a
" shortcut for 'insert four spaces'.
set expandtab
" shiftwidth controls how many columns text is indented with the reindent
" operations
set shiftwidth=2
" Allows you to move the cursor anywhere in the window. If you enter characters
" or insert a visual block, Vim will add whatever spaces are required to the
" left of the inserted characters to keep them in place.
" set virtualedit=all

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Netrw tree settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    exec 'Vexplore ' . getcwd()
    let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Airline
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" CtrlP settings
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0

if executable('rg')
  " Use rg over ag and grep
  set grepprg=rg\ --vimgrep\ --color=never
  let grepformat="%f:%l:%m"
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|metadata|project)|build|node_modules)$',
    \ 'file': '\v\.(exe|so|dll|pyc|class)$',
    \ }
endif

" editorconfig recommended
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Set shorter updatetime
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Don't open new buffers in quickfix windows
set switchbuf+=usetab

" Don't list quickfix windows in buffer list (and don't navigate to them on
" bnext, bprev), also disallow opening ordinary buffers in quickfix windows
augroup qf
  autocmd!
  autocmd FileType qf call SetQuickfixOptions()
augroup END

function SetQuickfixOptions()
  set nobuflisted
  nnoremap <buffer> <C-H> <Nop>
  nnoremap <buffer> <C-L> <Nop>
endfunction

" Close quickfix windows on :bd in main nbuffer
" cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'cclose\|bdelete' : 'bd')<CR>

" EJS file-handling
autocmd FileType ejs setlocal shiftwidth=4 tabstop=4 syntax=html

" Running progs
autocmd FileType python set makeprg=python\ %

"------------------------------------------------------------
" Mappings
"
let mapleader = ","

nnoremap <silent> <C-X> :make<CR>

" Folds
let b:folded = 0
function! ToggleFolds()
  if( !exists('b:folded') || b:folded == 0 )
    setlocal foldmethod=syntax
    exec "normal! zM"
    let b:folded = 1
  else
    exec "normal! zR"
    let b:folded = 0
  endif
endfunction
nnoremap <silent> <leader>f :call ToggleFolds()<CR>

" Splits
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Tabs
nnoremap <silent> <C-H> :bprevious<CR>
nnoremap <silent> <C-L> :bnext<CR>
nnoremap <silent> <C-T> :enew<CR>

" Location lists
function! s:BufferCount() abort
    return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
endfunction

function! s:LListToggle() abort
    let buffer_count_before = s:BufferCount()
    " Location list can't be closed if there's cursor in it, so we need
    " to call lclose twice to move cursor to the main pane
    silent! lclose
    silent! lclose

    if s:BufferCount() == buffer_count_before
        execute "silent! lopen"
    endif
endfunction

command! LToggle call s:LListToggle()
nnoremap <silent> <leader>l :LToggle<CR>

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" CtrlP
if !empty($WS_ROOT)
  noremap <C-P> :CtrlP $WS_ROOT<CR>
endif

" Commentary
xmap <C-_> <Plug>Commentary
nmap <C-_> <Plug>Commentary
omap <C-_> <Plug>Commentary
nmap <C-_> <Plug>CommentaryLine

command -nargs=+ -complete=file -bar FindInFiles silent! grep! <args>|cwindow|redraw!
" bind \ (backward slash) to grep shortcut
nnoremap \ :FindInFiles<SPACE>
" bind Ctrl-G to grep word under cursor
nnoremap <C-G> :FindInFiles <cword><CR>

" Force usage of HJKL
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

function! ToggleMarkup() abort
  let l:padding = wincol() - virtcol('.')
  if l:padding == 0
    set list
    set signcolumn=yes
    set number
  else
    set nolist
    set signcolumn=no
    set foldcolumn=0
    set nonumber
  endif
endfunction
nnoremap <silent> <leader>m :call ToggleMarkup()<CR>

" Fugitive shortcuts
nnoremap <silent> <leader>ga :Git add %:p<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gl :Git log -- %<CR>

"------------------------------------------------------------
" Host-specific configs
"
if filereadable(".vimrc.local")
  source .vimrc.local
endif
