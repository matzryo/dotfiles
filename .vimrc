scriptencoding utf-8

if !has('nvim')
  " モダンなデフォルト設定を読み込む
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" 一旦ファイルタイプ関連を無効化する
" http://d.hatena.ne.jp/wiredool/20120618/1340019962
filetype off
filetype plugin indent off

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
Plug 'ctrlpvim/ctrlp.vim'
""""""""""""""""""""""""""""""
" ctrlp設定
""""""""""""""""""""""""""""""
" 高速化
" https://postd.cc/how-to-boost-your-vim-productivity/
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" ファイルをtree表示してくれる | NERDTree上でgitステータスを表示
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
""""""""""""""""""""""""""""""
" nerdtree設定
""""""""""""""""""""""""""""""
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
noremap <C-n> :NERDTreeToggle<CR>
" ツリービュー以外にウインドウがなければvimを終了する
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
""""""""""""""""""""""""""""""

" Rails向けのコマンドを提供する
Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'

" シングルクオートとダブルクオートの入れ替え等
Plug 'tpope/vim-surround'
" vim-surround含む特定のプラグインの機能をリピート可能にする
Plug 'tpope/vim-repeat'
""""""""""""""""""""""""""""""
" vim-repeat設定
""""""""""""""""""""""""""""""
" https://github.com/tpope/vim-repeat#repeatvim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
""""""""""""""""""""""""""""""

" インデントに色を付けて見やすくする
Plug 'nathanaelkane/vim-indent-guides'
""""""""""""""""""""""""""""""
" vim-indent-guides設定
""""""""""""""""""""""""""""""
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
""""""""""""""""""""""""""""""

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

" emmet
Plug 'mattn/emmet-vim'
""""""""""""""""""""""""""""""
" emmet設定
""""""""""""""""""""""""""""""
" https://github.com/mattn/emmet-vim#enable-just-for-htmlcss
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
""""""""""""""""""""""""""""""

" color scheme
Plug 'morhetz/gruvbox'
" シンタックスチェック
Plug 'w0rp/ale'
""""""""""""""""""""""""""""""
" ale設定
""""""""""""""""""""""""""""""
" https://github.com/w0rp/ale#5ix-how-can-i-navigate-between-errors-quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
""""""""""""""""""""""""""""""

" Gitを便利に使う
Plug 'tpope/vim-fugitive'
" ファイルの変更状況を表示
Plug 'airblade/vim-gitgutter'
" ステータスラインを格好よくする
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
""""""""""""""""""""""""""""""
" airline設定
""""""""""""""""""""""""""""""
" ステータスバーのカラースキーマ
let g:airline_theme='powerlineish'
""""""""""""""""""""""""""""""

" 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'

" バッファを素早く実行する
Plug 'thinca/vim-quickrun'

" vimでGitHub Copolotを使う
" プラグインインストール後、 :Copilot setupで設定
Plug 'github/copilot.vim'

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

""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
" スワップファイルの保存先
set directory=~/.vim/.swp//
" アンドゥファイルの保存先
set undodir=~/.vim/.undo//
" バックアップファイルの保存先
set backupdir=$HOME/.vim/.backup//
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
" vim-gitgutterでの記号の更新を早める
" 以下の時間(ミリ秒)の間入力がなければ更新。デフォルト4000
" https://github.com/airblade/vim-gitgutter#when-signs-take-a-few-seconds-to-appear
set updatetime=100
" ヘルプ探索の優先順位を明示
set helplang=ja,en
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
" http://inari.hatenablog.com/entry/2014/05/05/231307
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
" vimならば上でdefaults.vimを読み込んでいるので不要
if has("nvim")
  augroup RestoreCursorPosition
    autocmd!
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" a" を指定したときに、周囲の空白を巻き込まなくする
""""""""""""""""""""""""""""""
xnoremap a" 2i"
xnoremap a' 2i'
xnoremap a` 2i`
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" その他設定
""""""""""""""""""""""""""""""
" 構文毎に文字色を変化させる
syntax enable

" カラースキーマの指定
" gruvboxをインストール済みならgruvbox,未インストールならdesertを適用
colorscheme desert
silent! colorscheme gruvbox

" jキーを２回連続で入力するとインサートモードからエスケープできるようバインド
inoremap <silent> jj <ESC>

" grep検索の実行後にQuickFix Listを表示する
augroup ShowList
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" 行番号の色
highlight LineNr ctermfg=darkyellow

" 対応する要素へ'%'で移動
if has('nvim')
  runtime! macros/matchit.vim
else
  packadd! matchit
endif

" 検索結果ハイライトをESCキーの連打でリセットする
" vimテクニックバイブル4-16
nnoremap <ESC><ESC> :nohlsearch<CR>
""""""""""""""""""""""""""""""

" filetype関連を有効にする
filetype plugin indent on
