# dotfiles

## requirements

### mise

<https://github.com/jdx/mise>

### sheldon

<https://github.com/rossmacarthur/sheldon>

zshのプラグインマネージャー。

### The Silver Searcher

<https://github.com/ggreer/the_silver_searcher>

fzf.vimのAgコマンドで必要。

### starship

<https://github.com/starship/starship>

プロンプト設定ツール。

### herdr

<https://github.com/ogulcancelik/herdr>

AIエージェントマルチプレクサ。

### vim 8

<http://www.vim.org/>

[ale](https://github.com/w0rp/ale)を使うため、バージョン8以上が必要

### Neovim

<https://neovim.io/>

`.config/nvim`（LazyVim構成）で使用します。

### Linux

#### xsel

<http://www.kfish.org/software/xsel/>

### macOS

#### Homebrew

<https://brew.sh/>

## recommendations

### yabai, skhd

<https://github.com/koekeishiya/yabai>

Macで使える、タイル型ウィンドウマネージャー。

<https://github.com/koekeishiya/skhd>

Macで使える、ホットキーデーモン。
yabaiと連携させる。

### z

<https://github.com/rupa/z>

頻繁に使うディレクトリに素早く移動するためのツール。

## install

```shell
cd $HOME
git clone git@github.com:matzryo/dotfiles.git
cd dotfiles
zsh setup.sh
```

## .config/nvim について

LazyVim/starter (<https://github.com/LazyVim/starter>, Apache License 2.0) をベースに改変しています。
LICENSE は `.config/nvim/LICENSE` に保持しています。

## マシン固有のシェル設定

Git管理しないシェル設定(PC固有の設定など)は、以下に記述して下さい。

```shell
$HOME/.zsh.d/*.zsh
```
