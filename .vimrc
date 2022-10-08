" ********************************* 插件 *********************************
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'matze/vim-move'       
Plug 'plasticboy/vim-markdown'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " 目录树插件
Plug 'kien/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/indentpython'
Plug 'vim-python/python-syntax'
Plug 'terryma/vim-multiple-cursors'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" NERDTree
noremap <C-n> :NERDTreeToggle<CR>

" vim-move
map <ESC>[1;5B <A-Down>
map <ESC>[1;5A <A-Up>
map! <ESC>[1;5B <A-Down>
map! <ESC>[1;5A <A-Up>
 
let g:move_map_keys = 0
 
vmap <A-Up>   <Plug>MoveBlockUp
vmap <A-Down> <Plug>MoveBlockDown
nmap <A-Up>   <Plug>MoveLineUp
nmap <A-Down> <Plug>MoveLineDown

" YouCompleteMe
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
"python解释器路径"
let g:ycm_path_to_python_interpreter='/usr/bin/python3'
"是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项"
let g:ycm_cache_omnifunc=0
"字符串中也开启补全"
let g:ycm_complete_in_strings = 1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项"
inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'     
"上下左右键行为"
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

" ********************************* 公共配置 ********************************* 

" 基础  
syntax on  " 开启代码高亮  
set number " 显示行号
set ruler  " 开启标尺  
set cursorline " 开启高亮光标所在行  
set showmatch " 显示匹配括号
set encoding=utf-8 "设置vim内部编码

" 性能  
set viminfo= " 关闭 viminfo (用于加快 vim 启动速度)  

" 功能填补  
set clipboard=unnamed " 开启系统剪贴板支持
set backspace=indent,eol,start " 开启 Backspace 键支持(否则 Backspace 无法删除字符)  

" 鼠标支持  
set mouse=a " 开启鼠标支持  
set selection=inclusive " 指定在选择文本时光标所在位置也属于被选中的范围  
set selectmode=mouse,key " 使鼠标和键盘都可以控制光标选择文本  

" tab键  
set ts=4 " 指定制表符(tab)等于的空格数  
set tabstop=4 " tab 键相当于 4 个空格 
set softtabstop=4 " 开启软制表(如果这4个空格是用tab键打出来的删除会一起删除)  
set shiftwidth=4 " 指定自动缩进时缩进4个空格  
set smarttab " 开启智能 tab

" 缩进  
set smartindent " 开启智能缩进  
set autoindent " 开启自动缩进  
set cindent " 开启C缩进(对C、C++语言文件有效)  
::
" 其它配置   
set viminfo='1000,<500 " 复制粘贴扩大到500行 
set backupcopy=yes " 开启备份时行为为覆盖  
set cmdheight=1 " 设置命令行的高度为1

" 代码
set foldenable " 打开折叠

" 搜索
set ignorecase " 设置默认进行大小写不敏感查找
set smartcase " 如果有一个大写字母，则切换到大小写敏感查找 
set hlsearch " 高亮搜索，如果需要清除屏幕搜索高亮，可以在Vim命令行模式使用命令 :noh
set incsearch " 递进搜索
set paste " 取消自动注释#后所有行

noremap s :noh<CR> " 按下s取消高亮结果显示,本来按下s删除当前字符并进入插入模式

"设置代码折叠,映射空格键来折叠和取消折叠
set foldenable 		    "开始折叠
set foldmethod=indent   "设置indent折叠方式
set foldcolumn=0        "设置折叠区域的宽度
setlocal foldlevel=1    "设置折叠层数
set foldlevelstart=99   "打开文件默认不折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc': 'zo')<CR>

"map F5 to run files
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'java'
	exec "!javac %"
	exec "!java %<"
    elseif &filetype == 'python'
	exec "!python3 %"
    endif
endfunc

"PEP8风格设置,python代码风格标准
au BufNewFile,BufRead *.py
	    \ set tabstop=4 |
	    \ set softtabstop=4 |
	    \ set shiftwidth=4 |
	    \ set textwidth=79 |
	    \ set expandtab |
	    \ set autoindent |
	    \ set fileformat=unix
" ********************************* 快捷键 *********************************

" -- Control + a to select all file
inoremap <C-a> ggVG 
nnoremap <C-a> ggVG 
vnoremap <C-a> ggVG 
			
" -- Control + s to save
inoremap <C-s> <Esc>:w<CR>i
nnoremap <C-s> :w<CR>
vnoremap <C-s> :w<CR>

noremap R :source $MYVIMRC<CR>    
" ********************************* 主题 *********************************

" color schema
" 从 https://github.com/tomasr/molokai 获取molokai.vim 放到～/.vim/colors 
colorscheme molokai
set t_Co=256

