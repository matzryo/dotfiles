scriptencoding utf-8
""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
" vim-plugがなければ自動でインストールする
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup InstallVimPlug
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.vim/plugged')

" ファイルオープンを便利に
Plug 'kien/ctrlp.vim'
" ファイルをtree表示してくれる | NERDTree上でgitステータスを表示
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
" Gitを便利に使う
Plug 'tpope/vim-fugitive'
" Rails向けのコマンドを提供する
Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'
" シングルクオートとダブルクオートの入れ替え等
Plug 'tpope/vim-surround'
" インデントに色を付けて見やすくする
Plug 'nathanaelkane/vim-indent-guides'
" ログファイルを色づけしてくれる
Plug 'vim-scripts/AnsiEsc.vim'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" FZF
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run install script if you use fzf only in Vim.
Plug 'junegunn/fzf.vim'
" color scheme
Plug 'morhetz/gruvbox'
" シンタックスチェック
Plug 'vim-syntastic/syntastic'

call plug#end()

" 未インストールのプラグインがあれば、自動でインストールする
" Automatically install missing plugins on startup
" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
augroup SyncPlugins
  autocmd!
  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif
augroup END
""""""""""""""""""""""""""""""

" 一旦ファイルタイプ関連を無効化する
filetype off

""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
" タグファイルの指定(でもタグジャンプは使ったことがない)
set tags=~/.tags
" スワップファイルの保存先
set directory=~/.vim/.swp//
" アンドゥファイルの保存先
set undodir=~/.vim/.undo//
" バックアップファイルの保存先
set backupdir=$HOME/.vim/.backup//
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" コマンドラインに使われる画面上の行数
set cmdheight=2
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ステータス行に表示させる情報の指定(どこからかコピペしたので細かい意味はわかっていない)
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" fugitiveがインストールされていれば、ステータス行に現在のgitブランチを表示する
" チェックしないとfugitive#statusline()関数がないとのエラーが出てしまう
if isdirectory(expand('~/.vim/plugged/vim-fugitive'))
  set statusline+=%{fugitive#statusline()}
endif
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" バッファで開いているファイルのディレクトリでエクスクローラを開始する(でもエクスプローラって使ってない)
set browsedir=buffer
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" 暗い背景色に合わせた配色にする
set background=dark
" タブ入力を複数の空白入力に置き換える
set expandtab
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 構文毎に文字色を変化させる
syntax on
" カラースキーマの指定
" gruvboxをインストール済みならgruvbox,未インストールならdesertを適用
colorscheme desert
silent! colorscheme gruvbox

" 行番号の色
highlight LineNr ctermfg=darkyellow
""""""""""""""""""""""""""""""

" jキーを２回連続で入力するとインサートモードからエスケープできるようバインド
inoremap <silent> jj <ESC>

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" grep検索の実行後にQuickFix Listを表示する
augroup ShowList
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has('autocmd')
    augroup RestoreCursorPosition
      autocmd!
      autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
    augroup END
endif
""""""""""""""""""""""""""""""

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" NERDTreeToggle設定
""""""""""""""""""""""""""""""
noremap <C-n> :NERDTreeToggle<CR>
" ツリービュー以外にウインドウがなければvimを終了する
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""

" 参考: https://github.com/vim-syntastic/syntastic#3-recommended-settings
" 参考: https://qiita.com/yuku_t/items/0ac33cea18e10f14e185
""""""""""""""""""""""""""""""
" syntastic設定
""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
" syntasticがインストールされていれば、ステータス行に現在のgitブランチを表示する
" チェックしないとSyntasticStatuslineFlag()がないとのエラーが出てしまう
if isdirectory(expand('~/.vim/plugged/syntastic'))
  set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" デフォルトではチェックしない、rubyファイルはチェックする
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['ruby', 'vim'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_vim_checkers = ['vint']
""""""""""""""""""""""""""""""

" matchitを読み込み。doとendを対応付けられる
source $VIMRUNTIME/macros/matchit.vim

" filetypeの自動検出(最後の方に書いた方がいいらしい)
filetype on
