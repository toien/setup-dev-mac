set number          " 显示行号
set nowrap          " 不换行

set cursorline      " highlight
set cursorcolumn    " highlight

" indent
set autoindent      " 自动缩进

set smarttab        " Use the "shiftwidth" setting for inserting <TAB>s instead
                    " of the "tabstop" setting, when at the beginning of a
                    " line. This may be redundant for most people, but some
                    " poeple like to keep their tabstop=8 for compatability
                    " when loading files, but setting shiftwidth=4 for nicer
                    " coding style.

set shiftwidth=4    " This allows you to use the < and > keys from VIM's visual
                    " (marking) mode to block indent/unindent regions

set softtabstop=4   " 使用 tab 时 tab 空格数
set tabstop=4       " A four-space tab indent width is the prefered coding style
                    " for Python (and everything else!), although of course some
                    " disagree. This page generally assumes you want 4-space
                    " indents.

set laststatus=2    " 总是显示状态行

" backspace 键
" indent 删除自动缩进的值
" eol 删除上一行行末尾的回车，两行合并
" start 除了刚输入的，还删除原来的字符
set backspace=indent,eol,start

" 使用空格替换tab
set expandtab

" chars when display list
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·

" 搜索忽略大小写
set ignorecase
set smartcase

" netrw file explore
let g:netrw_liststyle = 3

" Color schema
syntax enable
let g:solarized_termcolors=256
colorscheme solarized
" set background=light

if has('gui_running')
    set background=light
else
    set background=dark
endif


filetype on         " 文件类型

set encoding=utf-8  " 编码为utf8

set hlsearch

set pastetoggle=<F10>

set nrformats= "设置10进制"

" Change cursor shape on different mode
if empty($TMUX)
  " Vertical bar in insert mode
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  " Block in normal mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " Underline in replace mode
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  " Vertical bar in insert mode
  let &t_SI = "\e[5 q"
  " Block in normal mode
  let &t_SR = "\e[4 q"
  " Underline in replace mode
  let &t_EI = "\e[1 q"
endif


" Sync remote register '"' to local clipboard when: '""y' explicitly
function! Osc52Yank()
    " 注意：如果你的 Vim 不支持 clipboard，复制时需要使用 " 寄存器
    if v:event.regname !=# '"'
        return
    endif

    " 自动获取最后一次复制的内容（使用 v:event.regcontents 避免寄存器偏移）
    let l:content = join(v:event.regcontents, "\n")
    if empty(l:content) | return | endif

    " 进行 Base64 编码
    let l:b64 = system("base64 | tr -d '\n'", l:content)
    let l:osc = "\e]52;c;" . l:b64 . "\x07"

    " Tmux 穿透处理
    if !empty($TMUX)
        let l:osc = "\ePtmux;\e" . substitute(l:osc, "\e", "\e\e", "g") . "\e\\"
    endif

    " 使用直接写入 tty 的方式，这比 echon 在自动命令中更稳定
    call writefile([l:osc], "/dev/tty", "b")
endfunction

" 只要发生 y 操作就触发同步
augroup Osc52
    autocmd!
    autocmd TextYankPost * call Osc52Yank()
augroup END


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'wincent/terminus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


"
" Fzf Plug Config
" let g:fzf_command_prefix = 'Fzf'
" let g:fzf_prefer_tmux = 0
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-x': 'vsplit' }

let mapleader = " "
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>b :Buffers<CR>
" nnoremap <leader>h :History<CR>

"
" Airline Plug Config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

"
" Tagbar Plug Config
set tags=./tags;,tags;

nnoremap <F8> :TagbarToggle<CR>

let g:tagbar_width = 100
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1

" 使用 universal-ctags
let g:tagbar_ctags_bin = 'ctags'
