# dotfiles

## requirements

### fish shell

<https://fishshell.com/>

### asdf

<https://github.com/asdf-vm/asdf>

### The Silver Searcher

<https://github.com/ggreer/the_silver_searcher>

fzf.vimのAgコマンドで必要

### tmux

<https://github.com/tmux/tmux>

### vim 8

<http://www.vim.org/>

[ale](https://github.com/w0rp/ale)および[deoplete.nvim](https://github.com/Shougo/deoplete.nvim)を使うため、バージョン8以上が必要

#### deoplede.nvimの各種Requirements

<https://github.com/Shougo/deoplete.nvim#requirements>

python3 および neovimパッケージなど。

### Linux

#### xsel

<http://www.kfish.org/software/xsel/>

### macOS

#### Homebrew

<https://brew.sh/>

## install

```shell
cd $HOME
git clone git@github.com:matzryo/dotfiles.git
cd dotfiles
bash setup.sh
```

## マシン固有のシェル設定

Git管理しないシェル設定(PC固有の設定など)は、以下に記述して下さい。

```shell
$HOME/.bash.d/*.sh
```
