call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }             " Color scheme
Plug 'vim-airline/vim-airline'                      " Bottom status bar
Plug 'preservim/nerdtree'                           " File explorer
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " IntelliSense
Plug 'ryanoasis/vim-devicons'                       " Unicode icons
Plug 'chrisbra/Colorizer'                           " Colorize hex colors
Plug 'tpope/vim-fugitive'                           " git integration
Plug 'turbio/bracey.vim'                            " HTML5 live editing
Plug 'sheerun/vim-polyglot'                         " Language packs
Plug 'zivyangll/git-blame.vim'                      " Inline git blame
Plug 'tpope/vim-surround'                           " Surround quotes
Plug 'jiangmiao/auto-pairs'                         " Insert or delete braces
Plug 'airblade/vim-gitgutter'                       " git gutter icons
Plug 'Xuyuanp/nerdtree-git-plugin'                  " git integration to NERDTree
Plug 'vim-scripts/taglist.vim'                      " Tag list
Plug 'mileszs/ack.vim'                              " Global search
Plug 'mhinz/vim-startify'                           " Fancy start screen
Plug 'luochen1990/rainbow'                          " Rainbow braces
Plug 'Shougo/vimproc.vim', {'do' : 'make'}          " Async program execution
Plug 'jackguo380/vim-lsp-cxx-highlight'             " Sematic highlighting
Plug 'rbgrouleff/bclose.vim'                        " Dependency for ranger.vim
Plug 'francoiscabrol/ranger.vim'                    " Ranger integration
Plug 'junegunn/fzf.vim'                             " Fuzzy search
Plug 'puremourning/vimspector'						" Debugger
Plug 'vim-scripts/ShaderHighLight'                  " Shader language syntax
Plug 'TaDaa/vimade'                                 " Fade inactive buffers
Plug 'rhysd/git-messenger.vim'                      " Show commit message under cursor
Plug 'brooth/far.vim'                               " Global find and replace
Plug 'liuchengxu/vim-which-key'                     " List keybinds in a popup

call plug#end()

" -------------------- "
" |   VIM SETTINGS   | "
" -------------------- "

colorscheme dracula
colors dracula
hi Normal ctermbg=NONE guibg=NONE

set t_Co=256                " term color mode
set termguicolors           " required for dracula
set undofile                " turn on persistent undo history
set cursorline              " highlight current line
set undodir=$HOME/.vim/undo " set undo path
set encoding=UTF-8          " unicode enconding
set number                  " line numbers
set mouse=a                 " enable full mouse support
set clipboard=unnamedplus   " use system clipboard
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
set smarttab

" -------------- "
" |   COLORS   | "
" -------------- "

" breakpoint line from vim-vebugger
hi ColorColumn guibg=darkred

" ----------------------- "
" |   PLUGIN SETTINGS   | "
" ----------------------- "

" airline settings
let g:airline#extensions#tabline#enabled = 1   " always show tabs at top
let g:airline_powerline_fonts = 1              " user powerline fonts

" vim-rainbow
let g:rainbow_active = 1                       " enable rainbow braces everywhere
let g:rainbow_conf = {
\		'guifgs':  ['#e8ba36', '#54a857', '#359ff4', '#5060bb', '#179387'],
\		'separately': {
\			'html': 0,
\			'xml': 0
\		},
\}

" Vimade

let g:vimade = {
  \ "fadelevel": 0.6,
\}

" Ranger + NERDTree 
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

" Coc
let g:coc_snippet_next = '<Tab>'
autocmd CursorHold * silent call CocActionAsync('highlight')

" auto-pairs
let g:AutoPairsShortcutToggle = '<C-p>'

" startify
let s:header = [
			\ '             ▗                  ▗            ▖  ',
			\ '  ▗           ▌      ▚           ▌ ▄     ▚   ▐  ',
			\ '   ▀▀▛▘      ▐       ▐ ▗▞▀▙    ▚▄▛▀      ▐ ▖ ▐▄▖',
			\ '    ▝        ▌       ▞   ▝      ▗▘       ▐ ▝▀▜  ',
			\ '            ▐▞▚      ▌          ▐▄▀▀▖    ▌   ▐  ',
			\ ' ▐          ▛ ▐      ▌ ▗        ▛   ▐    ▌   ▐  ',
			\ ' ▝▖   ▗    ▐  ▐  ▞   ▌▖▝▖           ▞    ▙▘▞▀▜▄ ',
			\ '  ▝▀▀▀▘    ▌   ▚▞    ▐  ▝▀▀      ▄▄▀     ▐ ▚▄▞ ▘'] " TODO something else here, probably some ascii art

" function that centers the header, taken from ThinkVim
function! Startify_center(lines) abort
	let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
	let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
	return centered_lines
endfunction

let g:startify_custom_header = Startify_center(s:header)

let g:startify_session_dir = "~/.vim/sessions/"

let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Files']           },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ ]

" ----------------------------- "
" |    FUNCTIONS & ALIASES    | "
" ----------------------------- "

cnoreabbrev EnableSpell set spell spelllang=en_us
cnoreabbrev DisableSpell set nospell

" ------------------- "
" |    KEYBINDS     | "
" ------------------- "

" Vim

" Map leader key to space
let mapleader = "\<Space>"

source ~/.config/nvim/monkeyterminal.vim

" which key popup
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Clang switch between header and source with leader s
nnoremap <Leader>s :CocCommand clangd.switchSourceHeader<CR>

" Format selection
xnoremap <Leader>i  <Plug>(coc-format-selected)
nnoremap <Leader>i  <Plug>(coc-format-selected)
vnoremap <Leader>i  <Plug>(coc-format-selected)

" Refactor word under cursor
nnoremap <Leader>rn <Plug>(coc-rename)

" Perform code action under cursor
nnoremap <Leader>a :call CocActionAsync('codeAction', '')<CR>

" Format entire file
nnoremap <A-l>            :call CocAction('format')<CR>
command! -nargs=0 Format  :call CocAction('format')

" Organize imports
nnoremap <A-o>            :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
command! -nargs=0 Imports :call CocAction('runCommand', 'editor.action.organizeImport')

" Paste file template
nnoremap <Leader>ya       :call CocAction('runCommand', 'template.templateTop')<CR>
nnoremap <Leader>yas      :CocList templates<CR>

" Toggle color highlights
nnoremap <Leader>c :CololorHighlight<CR>

" Documentation popup
nnoremap <silent>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Explore
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-t> :TlistToggle<CR>
nnoremap <Leader>e :Files<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <leader>f :Rg<CR>

let g:ranger_map_keys = 0
nnoremap <A-e> :Ranger<CR>

" Saving
inoremap <C-s> <esc>:w<CR>
nnoremap <C-s> :w<CR>

" Buffer
nmap <S-Right> :bn<CR>
nmap <S-Left> :bp<CR>

" Debugger
nnoremap <C-d> :call vimspector#ToggleBreakpoint()<CR>

map <F5>        :make<CR>
map <F6>        :call vimspector#RunToCursor()<CR>
map <Leader>F6  :call vimspector#StepOut()<CR>
map <F7>        :call vimspector#StepInto()<CR>
map <F8>        :call vimspector#StepOver()<CR>

map <F9>        :call vimspector#Continue()<CR>
map <F10>       :call vimspector#Pause()<CR>
map <F11>       :call vimspector#ClearBreakpoints()<CR>
map <F12>       :call vimspector#Stop()<CR>
map <Leader>F12 :VimspectorReset<CR>
