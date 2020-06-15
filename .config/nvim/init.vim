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
Plug 'frazrepo/vim-rainbow'                         " Rainbow braces
Plug 'vim-scripts/taglist.vim'                      " Tag list
Plug 'mileszs/ack.vim'                              " Global search
Plug 'mhinz/vim-startify'                           " Fancy start screen

call plug#end()

colorscheme dracula
colors dracula

" --------------------
" |   VIM SETTINGS   |
" --------------------

set t_Co=256        " term colors
set termguicolors   " required for dracula
set encoding=UTF-8  " unicode enconding
set number          " line numbers
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
set smarttab

" ----------------------- "
" |   PLUGIN SETTINGS   | "
" ----------------------- "

" airline settings
let g:airline#extensions#tabline#enabled = 1   " always show tabs at top
let g:airline_powerline_fonts = 1              " user powerline fonts

" chromatica
" let g:chromatica#enable_at_startup=1         " auto start - disabled due to issues

" vim-rainbow
let g:rainbow_active = 1                       " enable rainbow braces everywhere

" startify
" TODO idk something else here
let s:header = [
			\ '             ▗                  ▗            ▖  ',
			\ '  ▗           ▌      ▚           ▌ ▄     ▚   ▐  ',
			\ '   ▀▀▛▘      ▐       ▐ ▗▞▀▙    ▚▄▛▀      ▐ ▖ ▐▄▖',
			\ '    ▝        ▌       ▞   ▝      ▗▘       ▐ ▝▀▜  ',
			\ '            ▐▞▚      ▌          ▐▄▀▀▖    ▌   ▐  ',
			\ ' ▐          ▛ ▐      ▌ ▗        ▛   ▐    ▌   ▐  ',
			\ ' ▝▖   ▗    ▐  ▐  ▞   ▌▖▝▖           ▞    ▙▘▞▀▜▄ ',
			\ '  ▝▀▀▀▘    ▌   ▚▞    ▐  ▝▀▀      ▄▄▀     ▐ ▚▄▞ ▘',]

" function that centers the header, taken from ThinkVim
function! Startify_center(lines) abort
	let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
	let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
	return centered_lines
endfunction

let g:startify_custom_header = Startify_center(s:header)

" ------------------- "
" |    KEYBINDS     | "
" ------------------- "

" bind Ctrl+E to nerd tree
nnoremap <C-e> :NERDTreeToggle<CR>

" bind Ctrl+S to save in insert mode
inoremap <C-s> <esc>:w<CR>
nnoremap <C-s> :w<CR>

" bind Shift+Left/Right to switch buffers
nmap <S-Right> :bn<CR>
nmap <S-Left> :bp<CR>

" bind Ctrl+T to tag list
nmap <C-t> :TlistToggle<CR>
