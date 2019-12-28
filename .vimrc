" ----------------------------------------------------------------------------
" tips
" ----
" * リロータブルな vimrc の記述
"   * http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
"   * +=, -= で設定を追加する場合、set option& で一度デフォルトに戻す
" * オプションの設定方法
"   * http://vim-users.jp/2009/05/hack5/
" * map (キーマップ変更) はタブや空白が意味を持つので"|"で終端させる
" * autocmd は augroup vimrc で適用範囲を限定する
" * option を参照するときは &option
" * 変数で '~/' を HOME に展開したい場合、expand('~/') で記述
" * <C-u> で範囲(:'<,'>)キャンセル
" ----------------------------------------------------------------------------
set nocompatible			" vi 非互換(宣言)
scriptencoding utf-8			" vimrcのエンコーディング
set encoding=utf-8			" vim 内部のエンコーディグ
set fileencoding=utf-8			" 既定のファイル保存エンコーディング
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,euc-jisx0213,euc-jp,cp932
" ----------------------------------------------------------------------------
" reset vimrc autocmd group
" ----------------------------------------------------------------------------
augroup vimrc
  autocmd!
augroup END
" ----------------------------------------------------------------------------
" effective vim customize
" ----------------------------------------------------------------------------
nnoremap [vimrc] <Nop>|				" vim 設定ショートカット
nmap     <Space>v [vimrc]|			" <Space>v で prefix
nnoremap [vimrc]e :<C-u>edit $MYVIMRC<CR>|	" <Space>ve で vimrc を開く
nnoremap [vimrc]s :<C-u>source $MYVIMRC<CR>|	" <Space>vs で vimrc を再読込
nnoremap [vimrc]h :<C-u>helpgrep<Space>|	" <Space>vh で help を検索する
" ----------------------------------------------------------------------------
" search
" ----------------------------------------------------------------------------
set ignorecase					" 大文字/小文字を区別しない
set smartcase					" 大文字があるときだけ区別
set incsearch					" インクリメンタルサーチ
set wrapscan					" ファイルの先頭へループする
set hlsearch					" 検索文字をハイライトする
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>|	" Esc 連打でハイライト無効
nnoremap <C-c><C-c> :<C-u>nohlsearch<CR><Esc>|	" C-c 連打でハイライト無効
" ----------------------------------------------------------------------------
" display
" ----------------------------------------------------------------------------
set showmatch				" 対応する括弧をハイライト表示
set matchpairs& matchpairs+=<:>		" 対応する括弧に<>を追加
set matchtime=3				" 対応括弧のハイライト表示を3秒にする
set wrap				" 文字を折り返す
set scrolloff=4				" スクロール時に上下4行を見える様にする
" ----------------------------------------------------------------------------
" edit
" ----------------------------------------------------------------------------
set shiftround				" インデント時にshiftwidth倍に丸める
set infercase				" 補完で大文字小文字を区別しない
set hidden				" バッファを閉じずに隠す(Undo履歴を残す)
set switchbuf=useopen			" 新しく開く代わりに既存バッファを開く
set backspace=indent,eol,start		" バックスペースで何でも消せるようにする
set textwidth=0				" 自動的に改行が入るのを無効化
set formatoptions=q			" (textwidthが設定されても)自動改行しない
if has("unix")
  cnoremap w!! w !sudo tee % >/dev/null|" sudo root して保存 (for unix only)
endif
" インサートモード時は emacs like なキーバインド (あまり使わない)
inoremap <C-f> <Right>|			" C-f で左へ移動
inoremap <C-b> <Left>|			" C-b で右へ移動
inoremap <C-p> <Up>|			" C-p で上へ移動
inoremap <C-n> <Down>|			" C-n で下へ移動
inoremap <C-a> <Home>|			" C-a で行頭へ移動
inoremap <C-e> <End>|			" C-e で行末へ移動
inoremap <C-h> <BS>|			" C-h でバックスペース
inoremap <C-d> <Del>|			" C-d でデリート
inoremap <C-m> <CR>|			" C-m で改行
" ----------------------------------------------------------------------------
" undo/backup/swap/book/hist
" ----------------------------------------------------------------------------
if has("persistent_undo")
  set undofile				" 可能なら undo 履歴を永続的に保存する
  set undodir=~/.vim_undo		" undoファイルを.vim_undoににまとめる
  if !isdirectory(&undodir)		" ディレクトリがなかったら作成する
    call mkdir(&undodir, "p")
  endif
endif
set backupdir=~/.vim_backup		" ~xxxを.vim_backupにまとめる
if !isdirectory(&backupdir)		" ディレクトリがなかったら作成する
  call mkdir(&backupdir, "p")
endif
set directory=~/.vim_swapfile		" .xxx.swpを.vim_swapfileにまとめる
if !isdirectory(&directory)		" ディレクトリがなかったら作成する
  call mkdir(&directory, "p")
endif
let g:netrw_home=expand('~/')		" .netrw{book,hist} を HOME に保存する
" ----------------------------------------------------------------------------
" ascii escape provision
" ----------------------------------------------------------------------------
nnoremap OA gi<Up>|			" 上矢印を有効に
nnoremap OB gi<Down>|			" 下矢印を有効に
nnoremap OC gi<Right>|			" 右矢印を有効に
nnoremap OD gi<Left>|			" 左矢印を有効に
" ----------------------------------------------------------------------------
" statusline
" ----------------------------------------------------------------------------
set laststatus=2			" 常にステータスラインを表示
set showcmd				" コマンドをステータスラインに表示
" ----------------------------------------------------------------------------
" CJK multibyte
" ----------------------------------------------------------------------------
set ambiwidth=double			" 曖昧な幅の文字(○や□)を全角と判断する
" ----------------------------------------------------------------------------
" mouse
" ----------------------------------------------------------------------------
set mouse=a				" 全モードでマウスを有効にする
set ttymouse=xterm2			" xterm 風 + ドラッグ対応
" ----------------------------------------------------------------------------
" window
" ----------------------------------------------------------------------------
set splitbelow				" ウィンドウ分割を(上でなく)下側に変更
set splitright				" ウィンドウ分割を(左でなく)右側に変更
nnoremap <C-h> <C-w>h|			" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-j> <C-w>j|			" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-k> <C-w>k|			" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-l> <C-w>l|			" Ctrl + hjkl でウィンドウ間を移動
nnoremap - <C-u>:sp<CR>|		" - で横分割
nnoremap <Bar> <C-u>:vsp<CR>|		" | で縦分割
" ----------------------------------------------------------------------------
" buffer
" ----------------------------------------------------------------------------
nnoremap < :bp<CR>|			" < でバッファを戻る
nnoremap > :bn<CR>|			" > でバッファを進む
" ----------------------------------------------------------------------------
" menu
" ----------------------------------------------------------------------------
set wildmenu				" メニューの補完
set wildmode=list:longest		" 全マッチを列挙し最長の文字列まで補完
" ----------------------------------------------------------------------------
" indent
" ----------------------------------------------------------------------------
set tabstop=8				" 互換のためタブは8文字のままにしておく
autocmd vimrc FileType c          setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType sh         setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType awk        setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType xml        setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType html       setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType python     setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType fortran    setlocal expandtab shiftwidth=4 softtabstop=4
autocmd vimrc FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
" ----------------------------------------------------------------------------
" fortran specific
" ----------------------------------------------------------------------------
let fortran_free_source=1		" 自由形式を有効にする
let fortran_do_enddo=1			" doループのインデント
let fortran_indent_less=1		" プログラム単位のインデントを無効化
" ----------------------------------------------------------------------------
" appearance
" ----------------------------------------------------------------------------
syntax on				" カラー表示
set t_Co=256				" ターミナルで256色に対応
set background=dark			" 背景は暗め
highlight Normal  ctermbg=NONE		" 背景透過
highlight Visual  ctermbg=darkgray	" 選択範囲を明るく
highlight Comment ctermfg=gray		" コメントを明るく
set listchars=tab:>\ ,trail:_,nbsp:@	" 不可視文字を可視化
highlight CursorLine gui=underline guifg=NONE guibg=NONE
highlight CursorLine term=underline cterm=underline ctermfg=NONE ctermbg=None
" ----------------------------------------------------------------------------
" True Color (also supports tmux)
" ----------------------------------------------------------------------------
" https://qiita.com/yami_beta/items/ef535d3458addd2e8fbb
set termguicolors
if $TERM == "screen-256color"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" ----------------------------------------------------------------------------
" color scheme
" ----------------------------------------------------------------------------
colorscheme molokai
let g:molokai_original=0
let g:rehash256=1
" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------
let g:airline_left_sep=''		" fontパッチを当ててないので
let g:airline_right_sep=''		" 左右のセパレータを削除する
let g:airline_theme='molokai'		" カラースキーマ

