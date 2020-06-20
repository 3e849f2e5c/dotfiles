call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }             " Color scheme
Plug 'vim-airline/vim-airline'                      " Bottom status bar
Plug 'preservim/nerdtree'                           " File explorer
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " IntelliSense
Plug 'arakashic/chromatica.nvim'                    " Clangd based syntax highlighting
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
Plug 'idanarye/vim-vebugger'                        " Debugger
Plug 'Shougo/vimproc.vim', {'do' : 'make'}          " Async program execution

call plug#end()

colorscheme dracula
colors dracula

" --------------------
" |   VIM SETTINGS   |
" --------------------

set t_Co=256                " term color mode
set termguicolors           " required for dracula
set undofile                " turn on persistent undo history
set cursorline              " highlight current line
set undodir=$HOME/.vim/undo " set undo path
set encoding=UTF-8	        " unicode enconding
set number                  " line numbers
set mouse=a                 " enable full mouse support
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
set smarttab

" -------------- "
" |   COLORS   | "
" -------------- "

hi ColorColumn guibg=darkred 

" ----------------------- "
" |   PLUGIN SETTINGS   | "
" ----------------------- "

" airline settings
let g:airline#extensions#tabline#enabled = 1   " always show tabs at top
let g:airline_powerline_fonts = 1              " user powerline fonts

"asddd chromatica
" let g:chromatica#enable_at_startup=1         " auto start - disabled due to issues

" vim-rainbow
let g:rainbow_active = 1                       " enable rainbow braces everywhere

let g:rainbow_conf = { 'guifgs':  ['#e8ba36', '#54a857', '#359ff4', '#5060bb', '#179387'] }

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

" ----------------------------- "
" |    FUNCTIONS & ALIASES    | "
" ----------------------------- "

cnoreabbrev EnableSpell set spell spelllang=en_us
cnoreabbrev DisableSpell set nospell

" ------------------- "
" |    KEYBINDS     | "
" ------------------- "

" Explore
nnoremap <C-e> :NERDTreeToggle<CR>
nmap <C-t> :TlistToggle<CR>

" Saving
inoremap <C-s> <esc>:w<CR>
nnoremap <C-s> :w<CR>

" Buffer
nmap <S-Right> :bn<CR>
nmap <S-Left> :bp<CR>

" Debugger
nnoremap <C-d> :VBGtoggleBreakpointThisLine<CR>
map <F8> :VBGstepOver<CR>
map <F9> :VBGcontinue<CR>
map <F5> :make --always-make<CR>
map <F10> :VBGstartGDB ./a.out<CR>
map <F7> :VBGevalWordUnderCursor<CR>
map <S-F7> :VBGeval 
