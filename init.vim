if has("syntax")
	syntax on
endif

filetype on                 "파일종류 자동인식
filetype indent on          "파일 종류에 따른 구문강조

set nu  "줄 번호 보이기
set rnu
set autoindent              "스마트한 들여쓰기
set cindent
set showmatch
set shiftwidth=4
set tabstop=4               "탭 칸수
set hlsearch                "검색 하이라이트
set clipboard=unnamed
set mouse=a
set ruler
set vb
set nocompatible            " 방향키로 이동 가능

set termguicolors

let mapleader = ","

syntax enable
nmap <END> :nohl<CR>

call plug#begin('~/.vim/plugged')
Plug 'puremourning/vimspector'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdtree'
Plug 'pbondoer/vim-42header'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Raimondi/delimitMate'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


nnoremap <F2> :NERDTreeToggle<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
let g:NERDTreeWinSize=22
let g:NERDTreeMinimalMenu=1


let g:hdr42user = 'dahkang'
let g:hdr42mail = 'dahkang@student.42seoul.kr'
nmap <F1> :Stdheader

"Opening newtab on the right side
set splitright

"-----------------------------coc auto_select-----------------------------"
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
	imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif
  "
  inoremap <expr> <CR> InsertMapForEnter()
  function! InsertMapForEnter()
	  if coc#pum#visible()
		  return coc#pum#confirm()
	  elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
		  return "\<CR>\<Esc>O"
	  elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
		  return "\<CR>\<Esc>O"
	  else
		  return "\<CR>"
	  endif
  endfunction
"---------------------------------------------------------------"

"------------------------------coc config-------------------------------"
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> J :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"------------------------------------------------------------------"



"-----------------neovim theme-------------------"
" neovim theme <dracula> 테마 적용
" show the '~' characters after the end of buffers
colo dracula
let g:dracula_show_end_of_buffer = 1
" use transparent background
let g:dracula_transparent_bg = 1
" set custom lualine background color
let g:dracula_lualine_bg_color = "#44475a"
"-------------------------------------------------"
"

"vim-airline
" let g:airline_theme='dracula'
let g:airline#extensions#gutentags#enabled = 1

"vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0
" let g:better_whitespace_ctermcolor='Violet'
let g:better_whitespace_guicolor='Skyblue'



"---------------------syntastic---------------------------"
nmap <Home> :SyntasticToggleMode<CR>
let g:syntastic_c_checkers = ['norminette', 'gcc']
let g:syntastic_aggregate_errors = 1
let g:syntastic_c_norminette_exec = '/usr/local/bin/norminette'
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']
let g:syntastic_c_norminette_args = '-R CheckForbiddenSourceHeaer'
let g:syntastic_check_on_open = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'c++'
let g:syntastic_cpp_compiler_options = "-std=c++98 -Wall -Wextra -Werror -Wpedantic"
"--------------------------------------------------------"
"
"Jump to function definition
"ctags"
nnoremap <leader>jj <C-]>
nnoremap <leader>bb <C-t>
"<C-o> go back
"---------------"
"
"-------------------gutentags------------------------"
let g:gutentags_project_root = ['Makefile']
set statusline+=%{gutentags#statusline()}
"-------------------------------------------------"

"Opening floaterm in vim
"---------------------floaterm---------------------"
let g:floaterm_keymap_toggle = '<Leader>tt'
tnoremap <Esc> <C-\><C-n>
"--------------------------------------------------
"
"auto pranthesis
" delmitMate-----------------------------------"
let delimitMate_expand_cr=1
let delimitMate_matchpairs = "(:),[:],{:}"
"-----------------------------------------------"

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {"cpp", "c"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
	enable = true,              -- false will disable the whole extension
	disable = { "" },  -- list of language that will be disabled
	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false,
  },
}
EOF


"-------------------vimspector-----------------------"
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>nl <Plug>VimspectorStepInto
nmap <Leader>di <Plug>VimspectorBalloonEval
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput
nmap <leader>dc :!cc -g -I./libft/libft.h -L./libft/ -lft % -o main<CR>
nmap <leader>aa <Plug>VimspectorUpFrame
nmap <leader>ss <Plug>VimspectorDownFrame
"--------------------------------------------------"
